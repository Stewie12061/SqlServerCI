IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP22000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP22000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
-- Import Excel nghiệp vụ Tài khoản D/T Card ERP9
 --<Param>
-- 
 --<Return>
-- 
 --<Reference>
-- 
 --<History>
-- Created by Hoàng Long on 14/12/2023
-- Modified by on
 --<Example>
CREATE PROCEDURE SOP22000
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
DECLARE @cCURSOR AS CURSOR,
		@sSQL AS VARCHAR(1000),
		@ApprovePersonID NVARCHAR(50)
		
DECLARE @ColID AS NVARCHAR(50), 
		@ColSQLDataType AS NVARCHAR(50)

CREATE TABLE #Data
(
	Row INT,
	Orders INT,
	APK UNIQUEIDENTIFIER DEFAULT (NEWID()),
	ErrorMessage NVARCHAR(MAX) DEFAULT (''),
	ErrorColumn NVARCHAR(MAX) DEFAULT (''),
	CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED
	(
		APK ASC
	) ON [PRIMARY]
)

		
CREATE TABLE #DataM
(
	APK UNIQUEIDENTIFIER DEFAULT(NEWID()), 
	DivisionID VARCHAR(50),
	AccountNo NVARCHAR(50),
	AccountName NVARCHAR(250),
	Tel NVARCHAR(10),
	Type INT,
	AccountType INT,
	CCCD NVARCHAR(50),
	BirthDay Date,
	Address NVARCHAR(250),
	Province NVARCHAR(50),
	District NVARCHAR(50),
	MstNumber NVARCHAR(50),
	AccountDate Date,
	Status INT,
	CompanyName NVARCHAR(250),
	Representative NVARCHAR(50),
	MstCompany NVARCHAR(50),
	ApartmentCompany NVARCHAR(50),
	RoadCompany NVARCHAR(50),
	WardCompany NVARCHAR(50),
	DistrictCompany NVARCHAR(50),
	ProvinceCompany NVARCHAR(50),
	ApartmentShop NVARCHAR(50),
	RoadShop NVARCHAR(50),
	WardShop NVARCHAR(50),
	DistrictShop NVARCHAR(50),
	ProvinceShop NVARCHAR(50),
	EmailShop NVARCHAR(50),
	TypeStore NVARCHAR(50),
	AreaStore NVARCHAR(50),
	TotalRevenue NVARCHAR(50),
	AirConditionerSales NVARCHAR(50),
	CustomerClassification NVARCHAR(50),
	FinancialCapacity NVARCHAR(50),
	StrongSelling1 NVARCHAR(50),
	StrongSelling2 NVARCHAR(50),
	StrongSelling3 NVARCHAR(50),
	ImportSource1 NVARCHAR(50),
	ImportSource2 NVARCHAR(50),
	ImportSource3 NVARCHAR(50),
	SellGree NVARCHAR(50),
	GreeDisplay NVARCHAR(50),
	SellingCapacity NVARCHAR(50),
	ClassificationCustomer NVARCHAR(50)
)


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

SELECT  
		X.Data.query('OrderNo').value('.', 'INT') AS [Row],
		X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
		X.Data.query('AccountNo').value('.', 'NVARCHAR(50)') AS AccountNo,
		X.Data.query('AccountName').value('.', 'NVARCHAR(50)') AS AccountName,
		X.Data.query('Tel').value('.','NVARCHAR(10)') AS Tel,
		X.Data.query('Type').value('.','INT') AS Type,
		X.Data.query('AccountType').value('.','INT') AS AccountType,
		X.Data.query('CCCD').value('.','NVARCHAR(10)') AS CCCD,
		CONVERT(DateTime, X.Data.query('BirthDay').value('.','NVARCHAR(50)'), 103) AS BirthDay,
		X.Data.query('Address').value('.','NVARCHAR(250)') AS Address,
		X.Data.query('Province').value('.','NVARCHAR(50)') AS Province,
		X.Data.query('District').value('.','NVARCHAR(50)') AS District,
		X.Data.query('MstNumber').value('.','NVARCHAR(50)') AS MstNumber,
		CONVERT(DateTime, X.Data.query('AccountDate').value('.','NVARCHAR(50)'), 103) AS AccountDate,
		X.Data.query('Status').value('.','INT') AS Status,
		X.Data.query('CompanyName').value('.','NVARCHAR(250)') AS CompanyName,
		X.Data.query('Representative').value('.','NVARCHAR(50)') AS Representative,
		X.Data.query('MstCompany').value('.','NVARCHAR(50)') AS MstCompany,
		X.Data.query('ApartmentCompany').value('.','NVARCHAR(50)') AS ApartmentCompany,
		X.Data.query('RoadCompany').value('.','NVARCHAR(50)') AS RoadCompany,
		X.Data.query('WardCompany').value('.','NVARCHAR(50)') AS WardCompany,
		X.Data.query('DistrictCompany').value('.','NVARCHAR(50)') AS DistrictCompany,
		X.Data.query('ProvinceCompany').value('.','NVARCHAR(50)') AS ProvinceCompany,
		X.Data.query('ApartmentShop').value('.','NVARCHAR(50)') AS ApartmentShop,
		X.Data.query('RoadShop').value('.','NVARCHAR(50)') AS RoadShop,
		X.Data.query('WardShop').value('.','NVARCHAR(50)') AS WardShop,
		X.Data.query('DistrictShop').value('.','NVARCHAR(50)') AS DistrictShop,
		X.Data.query('ProvinceShop').value('.','NVARCHAR(50)') AS ProvinceShop,
		X.Data.query('EmailShop').value('.','NVARCHAR(50)') AS EmailShop,
		X.Data.query('TypeStore').value('.','NVARCHAR(50)') AS TypeStore,
		X.Data.query('AreaStore').value('.','NVARCHAR(50)') AS AreaStore,
		X.Data.query('TotalRevenue').value('.','NVARCHAR(50)') AS TotalRevenue,
		X.Data.query('AirConditionerSales').value('.','NVARCHAR(50)') AS AirConditionerSales,
		X.Data.query('CustomerClassification').value('.','NVARCHAR(50)') AS CustomerClassification,
		X.Data.query('FinancialCapacity').value('.','NVARCHAR(50)') AS FinancialCapacity,
		X.Data.query('StrongSelling1').value('.','NVARCHAR(50)') AS StrongSelling1,
		X.Data.query('StrongSelling2').value('.','NVARCHAR(50)') AS StrongSelling2,
		X.Data.query('StrongSelling3').value('.','NVARCHAR(50)') AS StrongSelling3,
		X.Data.query('ImportSource1').value('.','NVARCHAR(50)') AS ImportSource1,
		X.Data.query('ImportSource2').value('.','NVARCHAR(50)') AS ImportSource2,
		X.Data.query('ImportSource3').value('.','NVARCHAR(50)') AS ImportSource3,
		X.Data.query('SellGree').value('.','NVARCHAR(50)') AS SellGree,
		X.Data.query('GreeDisplay').value('.','NVARCHAR(50)') AS GreeDisplay,
		X.Data.query('SellingCapacity').value('.','NVARCHAR(50)') AS SellingCapacity,
		X.Data.query('ClassificationCustomer').value('.','NVARCHAR(50)') AS ClassificationCustomer

INTO #SOP22000
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row],DivisionID,AccountNo,AccountName,Tel, Type, AccountType,CCCD, BirthDay, Address, Province, District, MstNumber, AccountDate, Status, CompanyName, Representative, MstCompany, ApartmentCompany, RoadCompany, WardCompany, DistrictCompany, ProvinceCompany, ApartmentShop, RoadShop, WardShop, DistrictShop, ProvinceShop, EmailShop, TypeStore, AreaStore, TotalRevenue, AirConditionerSales, CustomerClassification, FinancialCapacity, StrongSelling1, StrongSelling2, StrongSelling3, ImportSource1, ImportSource2, ImportSource3, SellGree, GreeDisplay, SellingCapacity, ClassificationCustomer)

SELECT [Row], DivisionID,AccountNo,AccountName,Tel, Type, AccountType,CCCD, BirthDay, Address, Province, District, MstNumber, AccountDate, Status, CompanyName, Representative, MstCompany, ApartmentCompany, RoadCompany, WardCompany, DistrictCompany, ProvinceCompany, ApartmentShop, RoadShop, WardShop, DistrictShop, ProvinceShop, EmailShop, TypeStore, AreaStore, TotalRevenue, AirConditionerSales, CustomerClassification, FinancialCapacity, StrongSelling1, StrongSelling2, StrongSelling3, ImportSource1, ImportSource2, ImportSource3, SellGree, GreeDisplay, SellingCapacity, ClassificationCustomer
FROM #SOP22000
ORDER BY [Row]

-- Insert dữ liệu cho bảng tạm phần Master
INSERT INTO #DataM (DivisionID,AccountNo,AccountName,Tel, Type, AccountType,CCCD, BirthDay, Address, Province, District, MstNumber, AccountDate, Status, CompanyName, Representative, MstCompany, ApartmentCompany, RoadCompany, WardCompany, DistrictCompany, ProvinceCompany, ApartmentShop, RoadShop, WardShop, DistrictShop, ProvinceShop, EmailShop, TypeStore, AreaStore, TotalRevenue, AirConditionerSales, CustomerClassification, FinancialCapacity, StrongSelling1, StrongSelling2, StrongSelling3, ImportSource1, ImportSource2, ImportSource3, SellGree, GreeDisplay, SellingCapacity, ClassificationCustomer)

SELECT DivisionID,AccountNo,AccountName,Tel, Type, AccountType,CCCD, BirthDay, Address, Province, District, MstNumber, AccountDate, Status, CompanyName, Representative, MstCompany, ApartmentCompany, RoadCompany, WardCompany, DistrictCompany, ProvinceCompany, ApartmentShop, RoadShop, WardShop, DistrictShop, ProvinceShop, EmailShop, TypeStore, AreaStore, TotalRevenue, AirConditionerSales, CustomerClassification, FinancialCapacity, StrongSelling1, StrongSelling2, StrongSelling3, ImportSource1, ImportSource2, ImportSource3, SellGree, GreeDisplay, SellingCapacity, ClassificationCustomer
FROM #Data DT


----Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

----- Kiểm tra AccountNo đã tồn tại trong SOT2200 
DECLARE @Cur CURSOR,
		@AccountNo NVARCHAR(50),
		@ColumnName VARCHAR(50),
		@ColName VARCHAR(50)

SELECT TOP 1 @ColumnName = DataCol, @ColName = ColName FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'AccountNo'

SET @Cur = CURSOR SCROLL KEYSET FOR
		   SELECT DivisionID, AccountNo
		   FROM #Data
OPEN @Cur
FETCH NEXT FROM @Cur INTO @DivisionID, @AccountNo
WHILE @@FETCH_STATUS = 0
BEGIN
---- Kiểm tra số chứng từ đã tồn tại
	IF EXISTS (SELECT TOP 1 1 FROM SOT2200 WHERE DivisionID = @DivisionID AND AccountNo = @AccountNo)
	BEGIN		
		UPDATE #Data 
		SET ErrorMessage = ErrorMessage +  'A' + LTRIM(RTRIM(STR([Row]))) + '-SOFML0000620', 
		ErrorColumn = ErrorColumn + 'AccountNo' +','
	END
	
	FETCH NEXT FROM @Cur INTO @DivisionID, @AccountNo
END

CLOSE @Cur

-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
	UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
						ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
	WHERE ErrorMessage <> ''
	GOTO LB_RESULT
END

-- Insert master
INSERT INTO SOT2200(APK, DivisionID,AccountNo,AccountName,Tel, Type, AccountType,CCCD, BirthDay, Address, Province, District, MstNumber, AccountDate, Status, CompanyName, Representative, MstCompany, ApartmentCompany, RoadCompany, WardCompany, DistrictCompany, ProvinceCompany, ApartmentShop, RoadShop, WardShop, DistrictShop, ProvinceShop, EmailShop, TypeStore, AreaStore, TotalRevenue, AirConditionerSales, CustomerClassification, FinancialCapacity, StrongSelling1, StrongSelling2, StrongSelling3, ImportSource1, ImportSource2, ImportSource3, SellGree, GreeDisplay, SellingCapacity, ClassificationCustomer, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate,TranMonth,TranYear)
SELECT DISTINCT APK, DivisionID,AccountNo,AccountName,Tel, Type, AccountType,CCCD, BirthDay, Address, Province, District, MstNumber, AccountDate, Status, CompanyName, Representative, MstCompany, ApartmentCompany, RoadCompany, WardCompany, DistrictCompany, ProvinceCompany, ApartmentShop, RoadShop, WardShop, DistrictShop, ProvinceShop, EmailShop, TypeStore, AreaStore, TotalRevenue, AirConditionerSales, CustomerClassification, FinancialCapacity, StrongSelling1, StrongSelling2, StrongSelling3, ImportSource1, ImportSource2, ImportSource3, SellGree, GreeDisplay, SellingCapacity, ClassificationCustomer, @UserID, GETDATE(), @UserID, GETDATE(),@TranMonth,@TranYear
FROM #DataM DT
WHERE DT.AccountNo NOT IN (SELECT A01.AccountNo FROM SOT2200 A01 WHERE A01.DivisionID = DT.DivisionID)

LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data
WHERE  ErrorColumn <> ''
ORDER BY [Row]

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO