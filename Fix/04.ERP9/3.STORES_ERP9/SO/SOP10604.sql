IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP10604]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP10604]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Import Excel Danh mục chỉ tiêu doanh số nhân viên bán sỉ (Sale In)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Hồng Thắm on 29/12/2023
-- <Example>

CREATE PROCEDURE SOP10604
(
	 @DivisionID VARCHAR(50),
     @UserID VARCHAR(50),
     @TranMonth INT,
     @TranYear INT,   
     @Mode TINYINT, --0 chưa hết dữ liệu, 1: hết dữ liệu
     @ImportTransTypeID NVARCHAR(250),
     @TransactionKey NVARCHAR(50),
     @XML XML
) 
AS
DECLARE @cCURSOR CURSOR,
		@sSQL NVARCHAR(MAX),
		@TransactionID UNIQUEIDENTIFIER,
		@ColID VARCHAR(50), 
		@ColSQLDataType VARCHAR(50),
		@ErrorFlag TINYINT = 0,
		@ErrorColumn NVARCHAR(MAX)='',
		@ErrorMessage NVARCHAR(MAX)=''
		
CREATE TABLE #DataM(
	APK UNIQUEIDENTIFIER DEFAULT (NEWID()),
	Row INT,
	DivisionID VARCHAR(50),
	FromDate  DateTime,
	ToDate	  DateTime,
	TargetsID VARCHAR(50),
	Description		 VARCHAR(250),
	ObjectID		 VARCHAR(50),
	EmployeeLevel	 VARCHAR(50),
	EmployeeID		 VARCHAR(50),
	DepartmentID	 VARCHAR(50),
	TeamID			 VARCHAR(50),
	InventoryTypeID	 VARCHAR(50),
	InventoryTypeID2 VARCHAR(50),
	SalesMonth		 VARCHAR(50),
	SalesQuarter	 VARCHAR(50),
	SalesYear		 VARCHAR(50),
	S01				 VARCHAR(50),
	S02				 VARCHAR(50),
	S03				 VARCHAR(50),
	S04				 VARCHAR(50),
	S05				 VARCHAR(50),
	TransactionID NVARCHAR(50),
	ImportMessage NVARCHAR(500) DEFAULT (''),
	ErrorMessage NVARCHAR(MAX) DEFAULT (''),
	ErrorColumn NVARCHAR(MAX) DEFAULT (''),
	CONSTRAINT [PK_#DataM]
    		PRIMARY KEY CLUSTERED (APK ASC) ON [PRIMARY]
)
SET @TransactionID = NEWID()
SET @cCURSOR = CURSOR STATIC FOR
	SELECT A00065.ColID, A00065.ColSQLDataType
	FROM A01065 WITH (NOLOCK)
	INNER JOIN A00065 WITH (NOLOCK) ON A01065.ImportTemplateID = A00065.ImportTransTypeID
	WHERE A01065.ImportTemplateID = @ImportTransTypeID
	ORDER BY A00065.OrderNum

OPEN @cCURSOR

SELECT  
		X.Data.query('OrderNo').value('.', 'INT') AS [Row],
		X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
		CONVERT(DateTime, X.Data.query('FromDate').value('.','VARCHAR(50)'), 103) AS FromDate,
		CONVERT(DateTime, X.Data.query('ToDate').value('.','VARCHAR(50)'), 103) AS ToDate,
		X.Data.query('TargetsID').value('.', 'VARCHAR(50)') AS TargetsID,
		X.Data.query('Description').value('.', 'VARCHAR(250)') AS [Description],
		X.Data.query('ObjectID').value('.','VARCHAR(50)') AS ObjectID,
		X.Data.query('EmployeeLevel').value('.','VARCHAR(50)') AS EmployeeLevel,
		X.Data.query('EmployeeID').value('.','VARCHAR(50)') AS EmployeeID,
		X.Data.query('DepartmentID').value('.','VARCHAR(500)') AS DepartmentID,
		X.Data.query('TeamID').value('.','VARCHAR(50)') AS TeamID,
		X.Data.query('InventoryTypeID').value('.','VARCHAR(50)') AS InventoryTypeID,
		X.Data.query('InventoryTypeID2').value('.','VARCHAR(50)') AS InventoryTypeID2,
		X.Data.query('SalesMonth').value('.','VARCHAR(50)')   AS SalesMonth,
		X.Data.query('SalesQuarter').value('.','VARCHAR(50)') AS SalesQuarter,
		X.Data.query('SalesYear').value('.', 'VARCHAR(50)')   AS SalesYear,
		X.Data.query('S01').value('.','VARCHAR(50)') AS S01,
		X.Data.query('S02').value('.','VARCHAR(50)') AS S02,
		X.Data.query('S03').value('.','VARCHAR(50)') AS S03,
		X.Data.query('S04').value('.','VARCHAR(50)') AS S04,
		X.Data.query('S05').value('.','VARCHAR(50)') AS S05,
		@TransactionID as TransactionID
INTO #SOP10604
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

-- Insert dữ liệu cho bảng tạm phần Master
INSERT INTO #DataM (Row, DivisionID, FromDate, ToDate, TargetsID, [Description], ObjectID,EmployeeLevel, EmployeeID, DepartmentID, TeamID, InventoryTypeID, InventoryTypeID2, 
					SalesMonth, SalesQuarter, SalesYear, S01, S02, S03, S04, S05, TransactionID, ImportMessage, ErrorMessage ,	ErrorColumn )
SELECT DISTINCT [Row], DivisionID, FromDate, ToDate, TargetsID, [Description], ObjectID,EmployeeLevel, EmployeeID, DepartmentID, TeamID, InventoryTypeID, InventoryTypeID2, 
					SalesMonth, SalesQuarter, SalesYear, S01, S02, S03, S04, S05, @TransactionID, '','',''
FROM #SOP10604
---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---- Kiểm tra trùng mã chỉ tiêu 
UPDATE T1
SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + '00ML000053 {0}='''+ T1.TargetsID +''''
					,ErrorMessage = CONCAT(ErrorMessage
										,(SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'TargetsID')
										,'-00ML000053,')
					, ErrorColumn = ErrorColumn + 'TargetsID,'
FROM #DataM T1
INNER JOIN AT0161 ON T1.TargetsID = AT0161.TargetsID


-- select errormessage from #Data 
-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS (SELECT TOP 1 1 FROM #DataM WHERE ImportMessage <> '')
    GOTO LB_RESULT;
CLOSE @cCURSOR

IF @Mode = 1 -- nếu dữ liệu truyền xuống đã hết
BEGIN
-- Insert dữ liệu vào bảng 
INSERT INTO AT0161 (APK,DivisionID, FromDate, ToDate, TargetsID,TransactonID, [Description], ObjectID,EmployeeLevel, EmployeeID, DepartmentID, TeamID, InventoryTypeID, InventoryTypeID2, 
					SalesMonth, SalesQuarter, SalesYear, SOAna01ID, SOAna02ID, SOAna03ID, SOAna04ID, SOAna05ID,
					CreateUserID,CreateDate,LastModifyUserID,LastModifyDate) 
SELECT NEWID(),DivisionID, FromDate, ToDate, TargetsID,NEWID() ,[Description], ObjectID,EmployeeLevel, EmployeeID, DepartmentID, TeamID, InventoryTypeID, InventoryTypeID2, 
					Case SalesMonth when '' then '0' else Convert(decimal(28,8), SalesMonth,10) END,
					Case SalesQuarter when '' then '0' else Convert(decimal(28,8), SalesQuarter,10) END ,
					Case SalesYear when '' then '0' else Convert(decimal(28,8), SalesYear,10) END,
					S01, S02, S03, S04, S05,
					@UserID,GETDATE(),@UserID,GETDATE()
FROM #DataM
END

-- Trả về kết quả thực hiện Import
-- Trường hợp không có lỗi sẽ trả về bảng dữ liệu rỗng 

LB_RESULT:
SELECT [Row],ImportMessage, ErrorColumn, ErrorMessage 
FROM #DataM
WHERE TransactionID = @TransactionID AND ErrorColumn <> ''
ORDER BY [Row]

IF @Mode = 1
BEGIN 
	DROP Table #DataM
END 

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

