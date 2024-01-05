IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP22603]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP22603]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Import Excel Danh mục Số dư đầu hàng tồn kho
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Hoài Bảo on 09/06/2022
---- Modified by Hoài Bảo on 24/11/2022 - Fix lỗi import dữ liệu số dư đầu kỳ
---- Modified ... by ... on
-- <Example>

CREATE PROCEDURE WMP22603
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TranMonth INT,
    @TranYear INT,
	@ImportTransTypeID VARCHAR(50),
	@ImportTemplateID AS NVARCHAR(50),
	@XML XML
) 
AS
DECLARE @cCURSOR CURSOR,
		@sSQL NVARCHAR(MAX),
		@ColID VARCHAR(50), 
		@ColSQLDataType VARCHAR(50),
		@ErrorFlag TINYINT = 0
		
CREATE TABLE #Data
(
	Row INT,
	Orders INT,
	APK UNIQUEIDENTIFIER DEFAULT (NEWID()),
	TransactionID NVARCHAR(50) DEFAULT (NEWID()),
	ErrorMessage NVARCHAR(MAX) DEFAULT (''),
	ErrorColumn NVARCHAR(MAX) DEFAULT (''),
	CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED
	(
		APK ASC
	) ON [PRIMARY]
)

CREATE TABLE #DataM(
	APK UNIQUEIDENTIFIER DEFAULT (NEWID()),
	DivisionID VARCHAR(50),
	VoucherID VARCHAR(50) DEFAULT (NEWID()),
	VoucherNo VARCHAR(50),
	VoucherTypeID VARCHAR(50),
	TranMonth INT,
    TranYear INT,
	VoucherDate Datetime,
	WareHouseID VARCHAR(50),
	ObjectID VARCHAR(50),
	EmployeeID VARCHAR(50),
	[Description] NVARCHAR(500)
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

SELECT  
		X.Data.query('OrdersNo').value('.', 'INT') AS [Row],
		X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
		X.Data.query('VoucherNo').value('.', 'VARCHAR(50)') AS VoucherNo,
		X.Data.query('VoucherTypeID').value('.', 'VARCHAR(50)') AS VoucherTypeID,
		CONVERT(DATETIME, X.Data.query('VoucherDate').value('.', 'VARCHAR(50)'), 103) AS VoucherDate,
		X.Data.query('WareHouseID').value('.','VARCHAR(50)') AS WareHouseID,
		X.Data.query('ObjectID').value('.','VARCHAR(50)') AS ObjectID,
		X.Data.query('EmployeeID').value('.','VARCHAR(50)') AS EmployeeID,
		X.Data.query('Description').value('.','NVARCHAR(500)') AS [Description],
		X.Data.query('InventoryID').value('.','VARCHAR(50)') AS InventoryID,
		X.Data.query('UnitID').value('.','NVARCHAR(50)') AS UnitID,
		X.Data.query('ActualQuantity').value('.','DECIMAL(28,8)') AS ActualQuantity,
		X.Data.query('UnitPrice').value('.','DECIMAL(28,8)') AS UnitPrice,
		X.Data.query('OriginalAmount').value('.','DECIMAL(28,8)') AS OriginalAmount,
		X.Data.query('DebitAccountID').value('.', 'VARCHAR(50)') AS DebitAccountID,
		X.Data.query('SourceNo').value('.','NVARCHAR(50)') AS SourceNo,
		(CASE WHEN X.Data.query('LimitDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE CONVERT(DATETIME, X.Data.query('LimitDate').value('.','VARCHAR(50)'), 103) END) AS LimitDate,
		X.Data.query('Notes').value('.','NVARCHAR(500)') AS Notes,
		IDENTITY(int,1,1) AS Orders
INTO #WMP22603
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row], DivisionID, VoucherTypeID, VoucherNo, VoucherDate, WareHouseID, ObjectID, EmployeeID, [Description], InventoryID, UnitID, ActualQuantity, UnitPrice, OriginalAmount, DebitAccountID, SourceNo, LimitDate, Notes)
SELECT [Row], DivisionID, VoucherTypeID, VoucherNo, VoucherDate, WareHouseID, ObjectID, EmployeeID, [Description], InventoryID, UnitID, ActualQuantity, UnitPrice, OriginalAmount, DebitAccountID, SourceNo,  LimitDate, Notes
FROM #WMP22603

DECLARE @TableBusiness VARCHAR(10) = 'AT9000',
        @VoucherNo VARCHAR(50),
        @NewVoucherNo VARCHAR(50),
		@NewVoucherTypeID VARCHAR(50),
        @KeyString VARCHAR(50),
        @LastKey INT,
		@ParamDefinition NVARCHAR(500)

---- BEGIN - Xử lý tăng số chứng từ tự động
SELECT DISTINCT [Row], [Row] AS NewVoucherNo
INTO #VoucherData
FROM #Data
ORDER BY [Row]

WHILE EXISTS (SELECT TOP 1 1 FROM #VoucherData)
BEGIN
    SELECT @VoucherNo = [Row] FROM #VoucherData

	SET @ParamDefinition = N'@DivisionID VARCHAR(50), @NewVoucherTypeID VARCHAR(50) OUTPUT'
    SET @sSQL = 'SELECT @NewVoucherTypeID = VoucherTypeID
                FROM AT1007 WITH (NOLOCK)
                WHERE DivisionID = @DivisionID AND ModuleID = ''WM'' AND ScreenID = ''WMF2261'''
    EXEC SP_EXECUTESQL @sSQL, @ParamDefinition, @DivisionID = @DivisionID, @NewVoucherTypeID = @NewVoucherTypeID OUTPUT

	EXEC GetVoucherNo_Ver2 @DivisionID, 'WM', 'WMF2261', @TableBusiness, @NewVoucherNo OUTPUT, @KeyString OUTPUT, @LastKey OUTPUT
	PRINT @NewVoucherNo

	IF (ISNULL(@NewVoucherNo, '') != '')
	BEGIN
		-- Cập nhật số chứng từ vào bảng dữ liệu import từ Excel
		UPDATE #Data
		SET VoucherNo = @NewVoucherNo,
			VoucherTypeID = @NewVoucherTypeID
		WHERE [Row] = @VoucherNo

		-- Cập nhật LastKey cho bảng đăng ký số chứng từ tự động
		UPDATE AT4444 SET LastKey = @LastKey WHERE TableName = @TableBusiness AND KeyString = @KeyString
	END
    
    DELETE #VoucherData WHERE [Row] = @VoucherNo
END

-- Insert dữ liệu cho bảng tạm phần Master
INSERT INTO #DataM (DivisionID, VoucherTypeID, TranMonth, TranYear, VoucherNo, VoucherDate, WareHouseID, ObjectID, EmployeeID, [Description])
SELECT DISTINCT DivisionID, VoucherTypeID, @TranMonth, @TranYear, VoucherNo, VoucherDate, WareHouseID, ObjectID, EmployeeID, [Description]
FROM #Data DT

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

-- Kiểm tra dữ liệu không đồng nhất tại Master
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @ColID = 'VoucherNo',
@Param1 = 'DivisionID, VoucherTypeID, VoucherDate, WareHouseID, ObjectID, EmployeeID, Description'

--Kiểm tra dữ liệu không đồng nhất tại Detail
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @ColID = 'InventoryID, UnitID, ActualQuantity,UnitPrice, OriginalAmount, DebitAccountID, SourceNo, LimitDate, Notes',
@Param1 = 'DivisionID, VoucherTypeID, VoucherNo, VoucherDate, WareHouseID, ObjectID, EmployeeID, [Description], InventoryID, UnitID, ActualQuantity, UnitPrice, OriginalAmount, DebitAccountID, SourceNo, LimitDate, Notes'


-- Kiểm tra dữ liệu detail
DECLARE @ColumnName1 VARCHAR(50),
		@ColName1 NVARCHAR(50),
		@Cur CURSOR,
		@VoucherTypeID VARCHAR(50),
		@InventoryID VARCHAR(50)

-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
	UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
						ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
	WHERE ErrorMessage <> ''
	GOTO LB_RESULT
END

-- Insert master
INSERT INTO AT2016(APK, DivisionID, VoucherID, TranMonth, TranYear, VoucherNo, VoucherTypeID, VoucherDate, WareHouseID, ObjectID, EmployeeID, [Description],  CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT DISTINCT APK, DivisionID, VoucherID, @TranMonth, @TranYear, VoucherNo, VoucherTypeID, VoucherDate, WareHouseID, ObjectID, EmployeeID, [Description], @UserID, GETDATE(), @UserID, GETDATE()
FROM #DataM DT
WHERE DT.VoucherNo NOT IN (SELECT A16.VoucherNo FROM AT2016 A16 WHERE A16.DivisionID = DT.DivisionID)

-- Insert Người theo dõi mặc định
DECLARE @APK VARCHAR(50) = NEWID()
INSERT INTO WMT9020 (APK, DivisionID, APKMaster, TableID, FollowerID01, FollowerName01, TypeFollow, RelatedToTypeID, CreateDate, CreateUserID)
SELECT DISTINCT @APK, DT.DivisionID, DT.APK, 'AT2016', DT.EmployeeID, AT1103.FullName, 0, 0, GETDATE(), @UserID
FROM #DataM DT
LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = DT.EmployeeID
WHERE EXISTS (SELECT TOP 1 1 FROM AT2016 A16 WHERE A16.DivisionID = DT.DivisionID AND A16.APK = DT.APK)

-- Insert detail
DECLARE @VoucherID VARCHAR(50)

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT VoucherID, VoucherNo FROM #DataM

OPEN @Cur
FETCH NEXT FROM @Cur INTO @VoucherID, @VoucherNo

WHILE @@FETCH_STATUS = 0
BEGIN
	-- Insert Chi tiết
	INSERT INTO AT2017(APK, DivisionID, TransactionID, VoucherID, InventoryID, UnitID, ActualQuantity, UnitPrice, OriginalAmount, ConvertedQuantity, ConvertedPrice, ConvertedAmount, ConvertedUnitID, DebitAccountID, SourceNo, LimitDate, Notes)
	SELECT NEWID(), @DivisionID, TransactionID, @VoucherID, InventoryID, UnitID, ActualQuantity, UnitPrice, OriginalAmount, ActualQuantity, UnitPrice, OriginalAmount, UnitID, DebitAccountID, SourceNo, LimitDate, Notes
	FROM #Data DT
	WHERE DT.VoucherNo = @VoucherNo

	-- Insert quy cách WT8899
	IF EXISTS (SELECT 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	BEGIN
		INSERT INTO WT8899(DivisionID, TransactionID, VoucherID, TableID)
		SELECT @DivisionID, TransactionID, @VoucherID, 'AT2016'
		FROM #Data DT
		WHERE DT.VoucherNo = @VoucherNo
	END
	FETCH NEXT FROM @Cur INTO @VoucherID, @VoucherNo
END

CLOSE @Cur




LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data
WHERE  ErrorColumn <> ''
ORDER BY [Row]


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
