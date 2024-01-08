IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1114]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1114]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Import Excel danh mục đưa đón
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Khánh Đoan on 05/02/2020

-- <Example>
/* 
 EXEC EDMP1114 @DivisionID, @UserID, @ImportTransTypeID, @XML
 */
 
CREATE PROCEDURE EDMP1114
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),	
	@ImportTransTypeID VARCHAR(50),
	@XML XML
) 
AS
DECLARE @cCURSOR CURSOR,
		@sSQL NVARCHAR(MAX),
		@ColID VARCHAR(50), 
		@ColSQLDataType VARCHAR(50)
		
CREATE TABLE #Data
(
	[Row] INT,
	Orders INT,
	ErrorMessage NVARCHAR(MAX) DEFAULT (''),
	ErrorColumn NVARCHAR(MAX) DEFAULT (''),
	CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
	(
		Row ASC
	) ON [PRIMARY]	
)

SET @cCURSOR = CURSOR STATIC FOR
	SELECT A00065.ColID, A00065.ColSQLDataType
	FROM A01065 WITH (NOLOCK) 
	INNER JOIN A00065 WITH (NOLOCK) ON A01065.ImportTemplateID = A00065.ImportTransTypeID
	WHERE A01065.ImportTemplateID = @ImportTransTypeID
	ORDER BY A00065.OrderNum
			
OPEN @cCURSOR									
-- Tạo cấu trúc bảng tạm
FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType	
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @sSQL = 'ALTER TABLE #Data ADD ' + @ColID + ' ' + @ColSQLDataType + CASE WHEN @ColSQLDataType LIKE '%char%' THEN ' COLLATE SQL_Latin1_General_CP1_CI_AS' ELSE '' END + ' NULL'
	PRINT @sSQL
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END 
CLOSE @cCURSOR
PRINT('A') 

SELECT  X.Data.query('OrderNo').value('.', 'INT') AS [Row],
		X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
		X.Data.query('ShuttleID').value('.', 'VARCHAR(50)') AS ShuttleID,
		X.Data.query('PickupPlace').value('.', 'NVARCHAR(MAX)') AS PickupPlace,
		X.Data.query('ArrivedPlace').value('.', 'NVARCHAR(MAX)') AS ArrivedPlace,
		X.Data.query('ReceiptTypeID').value('.', 'VARCHAR(50)') AS ReceiptTypeID,
		X.Data.query('Description').value('.', 'NVARCHAR(MAX)') AS [Description], 
		X.Data.query('PromotionID').value('.', 'VARCHAR(50)') AS PromotionID,	
		X.Data.query('StudentID').value('.', 'VARCHAR(50)') AS StudentID,	
		IDENTITY(int, 1, 1) AS Orders		

INTO #EDMT1110
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row], Orders, DivisionID,ShuttleID, PickupPlace, ArrivedPlace, ReceiptTypeID, [Description],
 PromotionID,StudentID)
SELECT [Row], Orders, DivisionID,ShuttleID, PickupPlace, ArrivedPlace, ReceiptTypeID, [Description],
 PromotionID,StudentID
FROM #EDMT1110

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---- Kiểm tra trùng mã đưa đón
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckDuplicateData', @ColID = 'ShuttleID', @Param1 = 'Orders', @Param2 = 'EDMT1110', 
@Param3 = 'ShuttleID'

---- Kiểm tra dữ liệu không đồng nhất tại phần master 
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckIdenticalValues',@Module = 'ASOFT-EDM', @ColID = 'ShuttleID', 
@Param1 = 'ShuttleID,PickupPlace,ArrivedPlace,ReceiptTypeID,[Description],PromotionID,[Disabled]'

------ Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
		UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
							ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
		WHERE ErrorMessage <> ''

		GOTO LB_RESULT
END
 
---- Đẩy dữ liệu vào danh mục đưa  đón
INSERT INTO EDMT1110 ( DivisionID, ShuttleID, PickupPlace, ArrivedPlace, ReceiptTypeID, [Description],
 PromotionID,CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT DISTINCT	DivisionID, ShuttleID, PickupPlace, ArrivedPlace, ReceiptTypeID, [Description],
 PromotionID,@UserID, GETDATE(), @UserID, GETDATE()
FROM #Data 

INSERT INTO EDMT1111(APKMaster,DivisionID,StudentID,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate)
SELECT DISTINCT T2.APK AS APKMaster,T1.DivisionID,T1.StudentID,@UserID,GETDATE(),@UserID,GETDATE()
FROM #Data T1
INNER JOIN EDMT1110 T2 WITH (NOLOCK) ON T2.ShuttleID = T1.ShuttleID


LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data 
WHERE  ErrorColumn <> ''
ORDER BY [Row]

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO



 
 