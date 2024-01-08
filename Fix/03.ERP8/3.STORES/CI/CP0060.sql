IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CP0060]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CP0060]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Import danh mục phân loại mã hàng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Cao Thị Phượng on 26/07/2017
---- Modified on 
-- <Example>
/*
    EXEC CP0060,0, 1
*/

 CREATE PROCEDURE CP0060
(
     @DivisionID VARCHAR(50),
     @UserID VARCHAR(50),
     @TranMonth INT,
     @TranYear INT,   
     @ImportTransTypeID NVARCHAR(250),
     @XML XML
)
AS
DECLARE @Cur CURSOR,
		@Row INT,
		@STypeID VARCHAR(50),
		@S NVARCHAR(50),
		@SName NVARCHAR(250),
		@ErrorFlag TINYINT = 0,
		@ErrorColumn NVARCHAR(MAX)='',
		@ErrorMessage NVARCHAR(MAX),
		@CustomerName as int

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

---------INSERT dữ liệu từ file excel vào bảng tạm---------------------------------------
If @CustomerName = 79 --Customize MINH SANG
BEGIN

---------INSERT dữ liệu từ file excel vào bảng tạm---------------------------------------
Create Table #AT1310
(
	Row INT,
	DivisionID NVARCHAR(50),
	STypeID NVARCHAR(50),
	S NVARCHAR(50) NULL,
	SName NVARCHAR(250) NULL,
	Shifts Decimal(28,8) NULL, 
	Disabled Tinyint DEFAULT (0), 
	IsCommon Tinyint DEFAULT (0),
	ErrorColumn NVARCHAR(MAX) NULL,
	ErrorMessage NVARCHAR(MAX) NULL
)	
INSERT INTO #AT1310([Row], DivisionID, STypeID, S, SName, Shifts, Disabled, IsCommon, ErrorColumn, ErrorMessage)												
SELECT	X.Data.query('Row').value('.','INT') AS [Row],
		X.Data.query('DivisionID').value('.','NVARCHAR(50)') AS DivisionID,
		X.Data.query('STypeID').value('.','VARCHAR(50)') AS STypeID,
		X.Data.query('S').value('.','VARCHAR(50)') AS S,
		X.Data.query('SName').value('.', 'NVARCHAR(250)') AS SName,
		X.Data.query('Shifts').value('.', 'DECIMAL(28,8)') AS Shifts,
		X.Data.query('Disabled').value('.','Tinyint') AS Disabled,
		X.Data.query('IsCommon').value('.','Tinyint') AS IsCommon,
		'',''
FROM @XML.nodes('//Data') AS X (Data)
--------------Test dữ liệu import---------------------------------------------------
IF (SELECT TOP 1 DivisionID FROM #AT1310 ) <> @DivisionID    -- Kiểm tra đơn vị hiện tại
BEGIN
	UPDATE #AT1310 SET ErrorMessage = (SELECT TOP 1 DataCol + '-CRMFML000008' FROM A00065 WHERE ImportTransTypeID = 'ListType' AND ColID = 'DivisionID'),
					   ErrorColumn = 'DivisionID'
			 
	GOTO EndMessage
END
	
SET @ErrorMessage =''
SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT [Row], STypeID,  S, SName FROM #AT1310 
	
OPEN @Cur
FETCH NEXT FROM @Cur INTO @Row, @STypeID, @S, @SName
WHILE @@FETCH_STATUS = 0
BEGIN
---- Kiểm tra tồn tại mã phân loại
	IF EXISTS (SELECT TOP 1 1 FROM AT1310 WHERE (STypeID=@STypeID AND S = @S))		
	BEGIN
		
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WHERE ImportTransTypeID = 'ListType' AND ColID = 'S') + Cast(@Row as NVARCHAR(10)) + '-CRMFML000011,'
		SET @ErrorColumn = @ErrorColumn + 'S,'				
		SET @ErrorFlag = 1
	END

	IF @ErrorColumn <>''
	BEGIN
		UPDATE #AT1310 SET ErrorMessage = LEFT(@ErrorMessage, LEN(@ErrorMessage) -1),
							ErrorColumn = LEFT(@ErrorColumn, LEN(@ErrorColumn) -1)
		WHERE S = @S
	END
	
	FETCH NEXT FROM @Cur INTO @Row, @STypeID, @S, @SName
END
CLOSE @Cur
	
	IF NOT EXISTS (SELECT TOP 1 1 FROM #AT1310 WHERE  ErrorColumn <> '') --- nếu không có lỗi
	BEGIN
		INSERT INTO AT1310 ( DivisionID, STypeID, S, SName, Shifts, IsCommon, Disabled,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT A.*, @UserID, GETDATE(), @UserID, GETDATE()
		FROM 
		(
			SELECT  Case when IsCommon = 1 then '@@@' else DivisionID end DivisionID ,
					STypeID, S, SName, Shifts, IsCommon, Disabled
			FROM #AT1310
		)A
	
		END

EndMessage:;
SELECT [Row], ErrorColumn, ErrorMessage FROM #AT1310 
WHERE  ErrorColumn <> ''
ORDER BY [Row]

Drop table #AT1310
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
