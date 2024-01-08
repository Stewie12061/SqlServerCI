IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP20041]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP20041]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Import Excel nghiệp vụ Báo giá nhà cung cấp PO
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Minh Hiếu on 17/12/2021
---- Modified on 21/03/2023 by Anh Đô: Bổ sung lấy mã chứng từ tự động từ thiết lập
---- Modified on 30/05/2023 by Văn Tài: [2023/04/IS/0206] - Bổ sung trường hợp import và hệ thống thiết lập không có cấp duyệt.
-- <Example>

CREATE PROCEDURE POP20041
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TranMonth int,
	@TranYear int,
	@ImportTransTypeID VARCHAR(50),
	@ImportTemplateID AS NVARCHAR(50),
	@XML XML						
) 
AS
DECLARE @cCURSOR CURSOR,
		@sSQL NVARCHAR(MAX),
		@ColID VARCHAR(50), 
		@ColSQLDataType VARCHAR(50),
		@VoucherNo VARCHAR(50),	
		@APKMaster UNIQUEIDENTIFIER,
		@APK1 VARCHAR(50),
		@ApprovePersonID NVARCHAR(50),
		@ErrorFlag TINYINT = 0,
		@Level INT,
		@Levels INT = (SELECT TOP 1 ISNULL(ST10.Levels, 0) FROM ST0010 ST10 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND TypeID = 'BGNCC')
		
CREATE TABLE #Data
(
	Row INT,
	Orders INT,
	APK UNIQUEIDENTIFIER DEFAULT (NEWID()),
	APKDetail UNIQUEIDENTIFIER DEFAULT (NEWID()),
	ErrorMessage NVARCHAR(MAX) DEFAULT (''),
	ErrorColumn NVARCHAR(MAX) DEFAULT (''),
	CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED
	(
		APK ASC
	) ON [PRIMARY]
)

CREATE TABLE #DataM(
	Orders INT NULL,
	APK UNIQUEIDENTIFIER DEFAULT (NEWID()),
	DivisionID VARCHAR(50),
	VoucherNo VARCHAR(50),
	VoucherTypeID VARCHAR(50),
	VoucherDate Datetime,
	CurrencyID VARCHAR(50),
	ObjectID VARCHAR(50),
	OverDate Datetime,
	EmployeeID VARCHAR(50),
	ExchangeRate DECIMAL(28,8),
	ApprovePersonID VARCHAR(50),
	Description NVARCHAR(500)
)

SET @APK1 = NEWID()
SET @APKMaster = NEWID()
SET @Level = 1
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
		X.Data.query('OrderNo').value('.', 'INT') AS Row,
		X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
		X.Data.query('VoucherNo').value('.', 'VARCHAR(50)') AS VoucherNo,		
		X.Data.query('VoucherTypeID').value('.', 'VARCHAR(50)') AS VoucherTypeID,
		(CASE WHEN X.Data.query('VoucherDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE CONVERT(DATETIME, X.Data.query('VoucherDate').value('.', 'VARCHAR(50)'), 103) END) AS VoucherDate,
		X.Data.query('CurrencyID').value('.','VARCHAR(50)') AS CurrencyID,
		X.Data.query('ObjectID').value('.','NVARCHAR(50)') AS ObjectID,
		(CASE WHEN X.Data.query('OverDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE CONVERT(DATETIME, X.Data.query('OverDate').value('.', 'VARCHAR(50)'), 103) END) AS OverDate,
		X.Data.query('EmployeeID').value('.','VARCHAR(50)') AS EmployeeID,
		X.Data.query('ExchangeRate').value('.','DECIMAL(28,8)') AS ExchangeRate,
		X.Data.query('Description').value('.','NVARCHAR(500)') AS Description,
		X.Data.query('InventoryID').value('.','VARCHAR(50)') AS InventoryID,
		X.Data.query('TechnicalSpecifications').value('.','NVARCHAR(MAX)') AS TechnicalSpecifications,
		X.Data.query('Quantity').value('.','DECIMAL(28,8)') AS Quantity,
		X.Data.query('UnitPrice').value('.','DECIMAL(28,8)') AS UnitPrice,
		X.Data.query('RequestPrice').value('.','DECIMAL(28,8)') AS RequestPrice,
		X.Data.query('Notes').value('.','NVARCHAR(500)') AS Notes,
		X.Data.query('ApprovePersonID01').value('.','NVARCHAR(50)') AS ApprovePersonID01,
		IDENTITY(int,1,1) AS Orders
INTO #POP20041
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row], DivisionID, VoucherNo, VoucherTypeID, VoucherDate, CurrencyID, ObjectID, OverDate, EmployeeID, ExchangeRate, Description, InventoryID, TechnicalSpecifications, Quantity,UnitPrice, RequestPrice, Notes, ApprovePersonID01)
SELECT [Row], DivisionID, VoucherNo, VoucherTypeID, VoucherDate, CurrencyID, ObjectID, OverDate, EmployeeID, ExchangeRate, Description, InventoryID, TechnicalSpecifications, Quantity,UnitPrice, RequestPrice, Notes, ApprovePersonID01
FROM #POP20041

INSERT INTO #DataM (Orders, DivisionID, VoucherNo, VoucherTypeID, VoucherDate, CurrencyID, ObjectID, OverDate, EmployeeID, ExchangeRate, Description, ApprovePersonID)
SELECT MIN(Orders), DivisionID, VoucherNo, VoucherTypeID, VoucherDate, CurrencyID, ObjectID, OverDate, EmployeeID, ExchangeRate, Description, ApprovePersonID01
FROM #Data DT
GROUP BY DivisionID, VoucherNo, VoucherTypeID, VoucherDate, CurrencyID, ObjectID, OverDate, EmployeeID, ExchangeRate, Description, ApprovePersonID01


---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

-- Kiểm tra dữ liệu không đồng nhất tại Master
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @ColID = 'VoucherNo',
@Param1 = 'VoucherTypeID, VoucherDate, DivisionID, VoucherTypeID, CurrencyID, ObjectID, OverDate, EmployeeID, ExchangeRate, Description'

--Kiểm tra dữ liệu không đồng nhất tại Detail
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @ColID = 'InventoryID,TechnicalSpecifications, Quantity,UnitPrice, RequestPrice, Notes',
@Param1 = 'VoucherTypeID, VoucherDate, DivisionID, VoucherTypeID, CurrencyID, ObjectID, OverDate, EmployeeID, ExchangeRate, Description, InventoryID, TechnicalSpecifications, Quantity,UnitPrice, RequestPrice, Notes'


-- Kiểm tra dữ liệu detail
DECLARE @ColumnName1 VARCHAR(50),
		@ColName1 NVARCHAR(50),
		@Cur CURSOR,
		@VoucherTypeID VARCHAR(50),
		@InventoryID VARCHAR(50)

SELECT TOP 1 @ColumnName1 = DataCol, @ColName1 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'InventoryID'


SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT InventoryID FROM #Data

OPEN @Cur
FETCH NEXT FROM @Cur INTO @InventoryID

--WHILE @@FETCH_STATUS = 0
--BEGIN

--	---- Kiểm tra trùng mã 
--	IF EXISTS (SELECT TOP  1 1 FROM POT2021 WITH (NOLOCK) WHERE VoucherNo = @VoucherNo)
--	BEGIN
--		UPDATE #Data 
--		SET	ErrorMessage = @ColumnName1 + LTRIM(RTRIM(STR([Row]))) +'-SFML000077,',
--				ErrorColumn = @ColName1 + ','
--	END

--	FETCH NEXT FROM @Cur INTO @VoucherNo
--END

--CLOSE @Cur

-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
		UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
							ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
		WHERE ErrorMessage <> ''
		GOTO LB_RESULT
END


-- Insert master
IF(@Levels = 0) -- Không có cấp duyệt thì chắc chắn trạng thái duyệt của PGB
BEGIN

	INSERT INTO POT2021
	(
		APK
		, DivisionID
		, TranMonth
		, TranYear
		, VoucherNo
		, VoucherTypeID
		, VoucherDate
		, CurrencyID
		, ObjectID
		, OverDate
		, EmployeeID
		, ExchangeRate
		, Description
		, CreateUserID
		, CreateDate
		, LastModifyUserID
		, LastModifyDate
		, [Status]
	)
	SELECT DISTINCT APK
		, DivisionID
		, @TranMonth
		, @TranYear
		, VoucherNo
		, VoucherTypeID
		, VoucherDate
		, CurrencyID
		, ObjectID
		, OverDate
		, EmployeeID
		, ExchangeRate
		, Description
		, @UserID
		, GETDATE()
		, @UserID
		, GETDATE()
		, 1 AS [Status]
	FROM #DataM DT
	WHERE DT.VoucherNo NOT IN (SELECT OT21.VoucherNo FROM POT2021 OT21 WHERE OT21.DivisionID = DT.DivisionID)

END
ELSE
BEGIN

	INSERT INTO POT2021
	(
		APK
		, DivisionID
		, TranMonth
		, TranYear
		, VoucherNo
		, VoucherTypeID
		, VoucherDate
		, CurrencyID
		, ObjectID
		, OverDate
		, EmployeeID
		, ExchangeRate
		, Description
		, CreateUserID
		, CreateDate
		, LastModifyUserID
		, LastModifyDate
	)
	SELECT DISTINCT APK
		, DivisionID
		, @TranMonth
		, @TranYear
		, VoucherNo
		, VoucherTypeID
		, VoucherDate
		, CurrencyID
		, ObjectID
		, OverDate
		, EmployeeID
		, ExchangeRate
		, Description
		, @UserID
		, GETDATE()
		, @UserID
		, GETDATE()
	FROM #DataM DT
	WHERE DT.VoucherNo NOT IN (SELECT OT21.VoucherNo FROM POT2021 OT21 WHERE OT21.DivisionID = DT.DivisionID)

END


-- INSERT OOT9000
DECLARE @Number INT = 1, @APKM VARCHAR(50), @APKP VARCHAR(50);

WHILE @Number <= (select count(*) FROM #DataM)
BEGIN
	SET @APKM = (select APK from #DataM DT where DT.Orders = @Number)

	IF(@Levels > 0)
	BEGIN

		INSERT INTO OOT9000(DivisionID, TranMonth, TranYear, ID,
				[Description], [Type], DeleteFlag, AppoveLevel, ApprovingLevel,
				CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT A.*, 0, @Level, 0, @UserID, GETDATE(), @UserID,GETDATE()
		FROM 
		(
		SELECT DivisionID, TranMonth, TranYear, VoucherNo, MAX([Description]) [Description], 'BGNCC' AS Type
		FROM POT2021
		WHERE APK = @APKM
		GROUP BY DivisionID, TranMonth, TranYear, VoucherNo)A 

	END

	SET @Number = @Number + 1;
END

-- Insert detail
DECLARE @Number2 INT = 1 ;

WHILE @Number2 <= (select count(*) FROM #DataM)
BEGIN
	SET @APK1 = (select APK from #DataM DT where DT.Orders = @Number2)
	INSERT INTO POT2022(APK, DivisionID, InventoryID, TechnicalSpecifications, Quantity, UnitPrice, RequestPrice, Notes, APKMaster, ApproveLevel)
	SELECT APKDetail,DivisionID, InventoryID, TechnicalSpecifications, Quantity, UnitPrice, RequestPrice, Notes, @APK1, @Level	
	FROM #Data DT	
	WHERE DT.Orders = @Number2

	SET @Number2 = @Number2 + 1;
END

 --cập nhật lại các khóa
DECLARE @Number1 INT = 1, @NewKey NVARCHAR(50), @APK9000 VARCHAR(50) , @sSQL1 NVARCHAR(MAX), @sSQL2 NVARCHAR(MAX);
WHILE @Number1 <= (select count(*) FROM #DataM)
BEGIN
	
	DECLARE @TableBusiness VARCHAR(50) = 'POT2021'
	DECLARE @KeyString VARCHAR(50)
	DECLARE @LastKey VARCHAR(50)

	EXEC GetVoucherNo_Ver2 @DivisionID, 'PO', 'POF2041', @TableBusiness, @NewKey OUTPUT, @KeyString OUTPUT, @LastKey OUTPUT

	update POT2021
	SET VoucherNo = @NewKey
	where VoucherNo = (select VoucherNo from #DataM DT where DT.Orders = @Number1)
	
	-- Cập nhật LastKey cho bảng đăng ký số chứng từ tự động
    UPDATE AT4444 SET LastKey = @LastKey WHERE TableName = @TableBusiness AND KeyString = @KeyString

	IF (@Levels > 0)
	BEGIN

		update OOT9000
		SET ID = @NewKey
		where ID = (select VoucherNo from #DataM DT WITH (NOLOCK) where DT.VoucherNo = @Number1)

		SET @APK9000 = (select APK from OOT9000 WITH (NOLOCK) where ID = @NewKey)
	
		update POT2021
		SET APKMaster_9000 = @APK9000
		where VoucherNo = (select VoucherNo from POT2021 WITH (NOLOCK) where VoucherNo = @NewKey)

		update POT2022
		SET APKMaster_9000 = @APK9000
		where APKMaster = (select APK from POT2021 WITH (NOLOCK) where VoucherNo = @NewKey)

		--- Insert người duyệt
		SET @ApprovePersonID = (select ApprovePersonID from #DataM DT WITH (NOLOCK) where DT.VoucherNo = @Number1)
		SET @sSQL1='
		INSERT INTO OOT9001 (DivisionID, APKMaster, ApprovePersonID, [Level], DeleteFlag, [Status])
		SELECT A.DivisionID,OOT9.APK,'''+@ApprovePersonID+''', 1, 0, 0
		FROM
		(
			SELECT DivisionID, TranMonth, TranYear, VoucherNo
			FROM POT2021 WITH (NOLOCK)
			WHERE VoucherNo='''+@NewKey+'''
			GROUP BY DivisionID, TranMonth, TranYear, VoucherNo
		)A
		INNER JOIN OOT9000 OOT9 WITH (NOLOCK) ON OOT9.DivisionID = A.DivisionID AND OOT9.TranMonth = A.TranMonth AND OOT9.TranYear = A.TranYear AND OOT9.ID = A.VoucherNo '
		--PRINT (@sSQL1)
		EXEC (@sSQL1)

	END

	SET @Number1 = @Number1 + 1;
END
		

LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data
WHERE  ErrorColumn <> ''
ORDER BY [Row]

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
