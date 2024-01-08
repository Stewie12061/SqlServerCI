IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20007]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20007]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
-- Import Excel nghiệp vụ Đơn hàng bán
 --<Param>
-- 
 --<Return>
-- 
 --<Reference>
-- 
 --<History>
-- Created by Minh Hiếu on 23/02/2022
-- Modified by on
 --<Example>

CREATE PROCEDURE SOP20007
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
		@Level INT
		
CREATE TABLE #Data
(
	Row INT,
	Orders INT,
	APK UNIQUEIDENTIFIER DEFAULT (NEWID()),
	SOrderID UNIQUEIDENTIFIER DEFAULT (NEWID()),
	APKDetail UNIQUEIDENTIFIER DEFAULT (NEWID()),
	ErrorMessage NVARCHAR(MAX) DEFAULT (''),
	ErrorColumn NVARCHAR(MAX) DEFAULT (''),
	CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED
	(
		APK ASC
	) ON [PRIMARY]
)

CREATE TABLE #DataM(
	APK UNIQUEIDENTIFIER DEFAULT (NEWID()),
	SOrderID UNIQUEIDENTIFIER DEFAULT (NEWID()),
	DivisionID VARCHAR(50),
	VoucherNo VARCHAR(50),
	VoucherTypeID VARCHAR(50),
	ContractNo VARCHAR(50),
	OrderDate Datetime,
	ContractDate Datetime,
	CurrencyID VARCHAR(50),
	ObjectID VARCHAR(50),
	VATObjectID VARCHAR(50),
	ExchangeRate DECIMAL(28,8),
	OrderStatus DECIMAL(28,8),
	ShipDate Datetime,
	ClassifyID VARCHAR(50),
	InventoryTypeID NVARCHAR(50),
	Contact NVARCHAR(50),
	DeliveryAddress NVARCHAR(250),
	Transport NVARCHAR(100),
	PriceListID VARCHAR(50),
	PaymentID VARCHAR(50),
	PaymentTermID VARCHAR(50),
	DueDate Datetime,
	EmployeeID NVARCHAR(50),
	SalesManID NVARCHAR(50),
	ApprovePerson01 NVARCHAR(50),
	Notes NVARCHAR(500)
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

 --Tạo cấu trúc bảng tạm
FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @sSQL = 'ALTER TABLE #Data ADD ' + @ColID + ' ' + @ColSQLDataType + CASE WHEN @ColSQLDataType LIKE '%char%' THEN ' COLLATE SQL_Latin1_General_CP1_CI_AS' ELSE '' END + ' NULL'
	PRINT @sSQL
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END
CLOSE @cCURSOR

SELECT  X.Data.query('OrderNo').value('.', 'INT') AS [Row],
		X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
		X.Data.query('VoucherNo').value('.', 'INT') AS VoucherNo,
		X.Data.query('VoucherTypeID').value('.', 'NVARCHAR(50)') AS VoucherTypeID,
		CONVERT(DateTime, X.Data.query('OrderDate').value('.','NVARCHAR(50)'), 103) AS OrderDate,
		X.Data.query('ContractNo').value('.','VARCHAR(50)') AS ContractNo,
		CONVERT(DateTime, X.Data.query('ContractDate').value('.','NVARCHAR(50)'), 103) AS ContractDate,
		X.Data.query('CurrencyID').value('.','NVARCHAR(50)') AS CurrencyID,
		X.Data.query('ExchangeRate').value('.','DECIMAL(28,8)') AS ExchangeRate,
		X.Data.query('OrderStatus').value('.','DECIMAL(28,8)') AS OrderStatus,
		CONVERT(DateTime, X.Data.query('ShipDate').value('.','NVARCHAR(50)'), 103) AS ShipDate,
		X.Data.query('ClassifyID').value('.','VARCHAR(50)') AS ClassifyID,
		X.Data.query('InventoryTypeID').value('.','NVARCHAR(50)') AS InventoryTypeID,
		X.Data.query('ObjectID').value('.','NVARCHAR(50)') AS ObjectID,
		X.Data.query('Contact').value('.','NVARCHAR(250)') AS Contact,
		X.Data.query('DeliveryAddress').value('.','NVARCHAR(250)') AS DeliveryAddress,
		X.Data.query('Transport').value('.','NVARCHAR(250)') AS Transport,
		X.Data.query('PriceListID').value('.','VARCHAR(50)') AS PriceListID,
		CONVERT(DateTime, X.Data.query('DueDate').value('.','NVARCHAR(50)'), 103) AS DueDate,
		X.Data.query('PaymentID').value('.','VARCHAR(50)') AS PaymentID,
		X.Data.query('PaymentTermID').value('.','NVARCHAR(500)') AS PaymentTermID,
		X.Data.query('Notes').value('.','NVARCHAR(500)') AS Notes,
		X.Data.query('ApprovePerson01').value('.','NVARCHAR(50)') AS ApprovePerson01,
		X.Data.query('EmployeeID').value('.','NVARCHAR(50)') AS EmployeeID,
		X.Data.query('SalesManID').value('.','NVARCHAR(50)') AS SalesManID,
		X.Data.query('InventoryID').value('.','VARCHAR(50)') AS InventoryID,
		X.Data.query('OrderQuantity').value('.','decimal(28, 8)') AS OrderQuantity,
		X.Data.query('UnitID').value('.','VARCHAR(50)') AS UnitID,
		X.Data.query('SalePrice').value('.','decimal(28, 8)') AS SalePrice,
		X.Data.query('VATPercent').value('.','decimal(28, 8)') AS VATPercent,
		X.Data.query('VATOriginalAmount').value('.','decimal(28, 8)') AS VATOriginalAmount,
		X.Data.query('VATGroupID').value('.','VARCHAR(50)') AS VATGroupID,	
		X.Data.query('Description').value('.','NVARCHAR(500)') AS Description
INTO #SOP20007
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row], DivisionID,VoucherNo, VoucherTypeID,OrderDate, ContractNo, ContractDate,CurrencyID, ExchangeRate, OrderStatus,ShipDate,ClassifyID,InventoryTypeID,ObjectID,Contact,DeliveryAddress,Transport,PriceListID,DueDate,PaymentID,PaymentTermID,Notes,ApprovePerson01,EmployeeID,SalesManID,InventoryID,OrderQuantity,UnitID,SalePrice,VATPercent,VATOriginalAmount,VATGroupID,Description)
SELECT [Row], DivisionID,VoucherNo, VoucherTypeID,OrderDate, ContractNo, ContractDate,CurrencyID, ExchangeRate, OrderStatus,ShipDate,ClassifyID,InventoryTypeID,ObjectID,Contact,DeliveryAddress,Transport,PriceListID,DueDate,PaymentID,PaymentTermID,Notes,ApprovePerson01,EmployeeID,SalesManID,InventoryID,OrderQuantity,UnitID,SalePrice,VATPercent,VATOriginalAmount,VATGroupID,Description
FROM #SOP20007

INSERT INTO #DataM (DivisionID,VoucherNo, VoucherTypeID, ContractNo, OrderDate, ContractDate, CurrencyID, ObjectID, VATObjectID,ExchangeRate, OrderStatus, ShipDate, ClassifyID,InventoryTypeID,Contact,DeliveryAddress,Transport,PriceListID,PaymentID,PaymentTermID,DueDate,EmployeeID,SalesManID,ApprovePerson01,Notes)
SELECT DISTINCT DivisionID,VoucherNo, VoucherTypeID, ContractNo, OrderDate, ContractDate, CurrencyID, ObjectID,ObjectID, ExchangeRate, OrderStatus, ShipDate, ClassifyID,InventoryTypeID,Contact,DeliveryAddress,Transport,PriceListID,PaymentID,PaymentTermID,DueDate,EmployeeID,SalesManID,ApprovePerson01,Notes
FROM #Data DT 
WHERE DT.VoucherNo NOT IN (SELECT Distinct VoucherNo FROM #DataM  WITH (NOLOCK)) and DT.ContractNo NOT IN (SELECT Distinct ContractNo FROM #DataM  WITH (NOLOCK))


----Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

 --Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
		UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
							ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
		WHERE ErrorMessage <> ''
		GOTO LB_RESULT
END

 --Insert master	
INSERT INTO OT2001(APK, SOrderID,DivisionID, VoucherNo, VoucherTypeID, ContractNo, OrderDate, ContractDate, CurrencyID, ObjectID,VATObjectID, ExchangeRate, OrderStatus, ShipDate, ClassifyID,InventoryTypeID,Contact,DeliveryAddress,Transport,PriceListID,PaymentID,PaymentTermID,DueDate,EmployeeID,SalesManID,Notes,CreateDate,CreateUserID,LastModifyUserID,LastModifyDate,TranMonth,TranYear,IsInvoice,IsReceiveAmount)
SELECT DISTINCT APK, SOrderID,DivisionID, VoucherNo, VoucherTypeID, ContractNo, OrderDate, ContractDate, CurrencyID, ObjectID,VATObjectID, ExchangeRate, OrderStatus, ShipDate, ClassifyID,InventoryTypeID,Contact,DeliveryAddress,Transport,PriceListID,PaymentID,PaymentTermID,DueDate,EmployeeID,SalesManID,Notes,GETDATE(),@UserID,@UserID,GETDATE(),@TranMonth,@TranYear,0,0
FROM #DataM DT
WHERE DT.VoucherNo NOT IN (SELECT distinct VoucherNo FROM OT2001  WITH (NOLOCK))

---- INSERT OOT9000
DECLARE @Number3 INT = 1, @APKM VARCHAR(50), @APKP VARCHAR(50);
WHILE @Number3 <= (select count( distinct VoucherNo) from #DataM  WITH (NOLOCK))
BEGIN
	SET @APKM = (select APK from #DataM DT where DT.VoucherNo = @Number3)
	INSERT INTO OOT9000(DivisionID, TranMonth, TranYear, ID,
		    [Description], [Type], DeleteFlag, AppoveLevel, ApprovingLevel,
		    CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	SELECT A.*, 0, @Level, 0, @UserID, GETDATE(), @UserID,GETDATE()
	FROM 
	(
	SELECT DivisionID, TranMonth, TranYear, VoucherNo, MAX([Notes]) [Notes], 'DHB' AS Type
	FROM OT2001
	WHERE APK = @APKM
	GROUP BY DivisionID, TranMonth, TranYear, VoucherNo)A 
	--print @APKM
	SET @Number3 = @Number3 + 1;

END

------ Insert detail
DECLARE @SOrderID_D NVARCHAR(50) = '';
DECLARE @Number INT = (select count( distinct VoucherNo) from #DataM  WITH (NOLOCK));
DECLARE @Number2 INT = 1 ;
WHILE @Number2 <= @Number
BEGIN
    SET @SOrderID_D = (select top 1 SOrderID from OT2001 WITH (Nolock) where VoucherNo = CONVERT(nvarchar(50), @Number2));
	INSERT INTO OT2002(APK, SOrderID,TransactionID,DivisionID,InventoryID,OrderQuantity,SalePrice,OriginalAmount,UnitID,VATPercent,VATOriginalAmount,ConvertedAmount,VATGroupID,Description)
	SELECT DISTINCT NEWID(), @SOrderID_D, NEWID(), DivisionID,InventoryID,OrderQuantity,SalePrice,OrderQuantity*SalePrice,UnitID,VATPercent,VATOriginalAmount,(OrderQuantity*SalePrice) * ExchangeRate,VATGroupID,Description
	from #Data DT
	WHERE DT.VoucherNo = @Number2
	--print @SOrderID_D
	SET @Number2 = @Number2 + 1;
END


 --cập nhật lại các khóa
DECLARE @Number1 INT = 1, @NewKey NVARCHAR(50), @APK9000 VARCHAR(50) , @sSQL1 NVARCHAR(MAX), @sSQL2 NVARCHAR(MAX);
WHILE @Number1 <= (select count( distinct VoucherNo) from #DataM  WITH (NOLOCK))
BEGIN
	EXEC AP0000 @DivisionID, @NewKey OUTPUT, 'OT2001','DHB', @TranMonth, @TranYear, 14,3,1,'/'
	--print @NewKey
	update OT2001
	SET VoucherNo = @NewKey
	where VoucherNo = (select top 1 VoucherNo from #DataM DT where DT.VoucherNo = CONVERT(nvarchar(50), @Number1))

	--select DISTINCT top 1 VoucherNo from #DataM DT where DT.VoucherNo = CONVERT(nvarchar(50), @Number1)
	update OOT9000
	SET ID = @NewKey
	where ID = (select top 1 VoucherNo from #DataM DT where DT.VoucherNo = CONVERT(nvarchar(50), @Number1))

	--print @NewKey
	--select APK from OOT9000 where ID = 'DHB/1/2022/292'
	SET @APK9000 = (select APK from OOT9000 where ID = @NewKey)

	update OT2001
	SET APKMaster_9000 = @APK9000
	where VoucherNo = (select VoucherNo from OT2001 where VoucherNo = @NewKey)

	update OT2002
	SET APKMaster_9000 = @APK9000
	where SOrderID = (select SOrderID from OT2001 where VoucherNo = @NewKey)

	----- Insert người duyệt
	SET @ApprovePersonID = (select top 1 ApprovePerson01 from #DataM DT where DT.VoucherNo = CONVERT(nvarchar(50), @Number1))
	SET @sSQL1='
	INSERT INTO OOT9001 (DivisionID, APKMaster, ApprovePersonID, [Level], DeleteFlag, [Status])
	SELECT A.DivisionID,OOT9.APK,'''+@ApprovePersonID+''', 1, 0, 0
	FROM
	(
		SELECT DivisionID, TranMonth, TranYear, VoucherNo
		FROM OT2001
		WHERE VoucherNo='''+@NewKey+'''
		GROUP BY DivisionID, TranMonth, TranYear, VoucherNo
	)A
	INNER JOIN OOT9000 OOT9 ON OOT9.DivisionID = A.DivisionID AND OOT9.TranMonth = A.TranMonth AND OOT9.TranYear = A.TranYear AND OOT9.ID = A.VoucherNo '
	--PRINT (@sSQL1)
	EXEC (@sSQL1)
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
