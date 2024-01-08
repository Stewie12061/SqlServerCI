IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP8140]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP8140]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Import Excel Hồ sơ nhân viên - Hồ sơ tuyển dụng
-- <History>
---- Create on 15/07/2015 by Lê Thị Hạnh 
---- Modified on 23/07/2015 by  Nguyễn Thanh Thịnh Update lại SType 1 Insert Những Cột Bắt Buộc Nhập.
---- Modified by Tiểu Mai on 30/03/2016: Bỏ kiểm tra MiddleName và bổ sung import MPT
---- Modified by Bảo Thy on 08/06/2016: Bổ sung kiểm tra dữ liệu import tồn tại trong danh mục
---- Modified on 05/03/2019 by Kim Thư: Tạo khóa chính cho table #Data và #Keys có nối với @@SPID để tránh trùng khóa chính khi nhiều user sử dụng
---- Modified on 20/08/2020 by Huỳnh Thử: Merge Code: MEKIO và MTE: Bổ sung FromApprenticeTime, ToApprenticeTime khi @SType = 2
---- Modified on 20/08/2020 by Huỳnh Thử: Fix lỗi chạy all fix
---- Modified on 13/04/2020 by Văn Tài	: Tách store riêng cho MEIKO, MTE vì luồng chuẩn không sử dụng cột FromApprenticeTime, ToApprenticeTime (Thời gian thử việc) dẫn tới phát sinh lỗi.
---- Modified on 30/06/2022 by Kiều Nga	: Fix lỗi import HSNV
---- Modified on 20/12/2023 by Hồng Thắm: Bổ sung lưu IsAutoCreateUser, AbsentCardNo

-- <Example>
/* 
 EXEC AP8140 @DivisionID = 'MK', @UserID = 'ASOFTADMIN', @ImportTemplateID = 'EmployeeFileID', @XML = '',@SType = 1
 */
 
CREATE PROCEDURE AP8140
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@ImportTemplateID AS NVARCHAR(50),
	@XML AS XML,
	@SType INT
) 
AS
DECLARE @cCURSOR AS CURSOR,
		@sSQL AS VARCHAR(1000)
		
DECLARE @ColID AS NVARCHAR(50), 
		@ColSQLDataType AS NVARCHAR(50),
		@CustomerName INT 

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF (@CustomerName = 50 OR @CustomerName = 115 ) -- MEIKO, MTE
BEGIN
	EXEC AP8140_MTE @DivisionID = @DivisionID
					, @UserID = @UserID
					, @ImportTemplateID = @ImportTemplateID
					, @XML = @XML
					, @SType = @SType
END
ELSE
BEGIN
CREATE TABLE #Data
(
	APK UNIQUEIDENTIFIER DEFAULT(NEWID()),
	Row INT NOT NULL,
	Orders INT,
	SOrderID NVARCHAR(50),
	TransactionID NVARCHAR(50),
	ImportMessage NVARCHAR(MAX) DEFAULT ('')--,
	--CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
	--(
	--	Row ASC
	--) ON [PRIMARY]	
)

CREATE TABLE #Keys
(
	Row INT NOT NULL,	
	Orders INT,
	SOrderID NVARCHAR(50),
	TransactionID NVARCHAR(50),
	VoucherNo NVARCHAR(50),
	Period NVARCHAR(50),
	InventoryID NVARCHAR(50),
	UnitID NVARCHAR(50)
	--CONSTRAINT [PK_#Keys] PRIMARY KEY CLUSTERED 
	--(
	--	Row ASC
	--) ON [PRIMARY]	
)

-- Tạo khóa chính cho table #Data và #Keys
DECLARE @Keys_PK VARCHAR(50), @Data_PK VARCHAR(50),
		@SQL NVARCHAR(MAX);
SET @Data_PK='PK_#Data_' + LTRIM(@@SPID);
SET @Keys_PK='PK_#Keys_' + LTRIM(@@SPID);

--add constraint 
SET @SQL = 'ALTER TABLE #Data ADD CONSTRAINT ' + @Data_PK+ ' PRIMARY KEY(Row)
			ALTER TABLE #Keys ADD CONSTRAINT ' + @Keys_PK+ ' PRIMARY KEY(Row)'

EXEC(@SQL)


SET @cCURSOR = CURSOR STATIC FOR
SELECT TLD.ColID, BTL.ColSQLDataType
FROM A01065 TL
INNER JOIN A01066 TLD ON TL.ImportTemplateID = TLD.ImportTemplateID
INNER JOIN A00065 BTL ON BTL.ImportTransTypeID = TL.ImportTransTypeID AND BTL.ColID = TLD.ColID AND BTL.OrderNum = TLD.OrderNum
WHERE TL.ImportTemplateID = @ImportTemplateID
	  AND ISNULL(BTL.SType,0) IN (0, ISNULL(@SType,0)) -- Add SType Condition
ORDER BY TLD.OrderNum
OPEN @cCURSOR									
-- Tạo cấu trúc bảng tạm
FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType	
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @sSQL = 'ALTER TABLE #Data ADD ' + @ColID + ' ' + @ColSQLDataType + CASE WHEN @ColSQLDataType LIKE '%char%' THEN ' COLLATE SQL_Latin1_General_CP1_CI_AS' ELSE '' END + ' NULL'
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END 
--SELECT * FROM #Data
DECLARE @Cur CURSOR,
		@Row INT,		
		@EmployeeID NVARCHAR(50) 
-- Thêm dữ liệu vào bảng tạm
IF @SType = 1 -- Persional Information
BEGIN
	--- ADD 5 column EmployeeStatus, DepartmentID,PayableAccountID, ExpenseAccountID, PerInTaxID ( Thinh 23/7/2015)
	INSERT INTO #Data([Row], DivisionID, EmployeeID, S1, S2, S3, LastName, MiddleName, FirstName, ShortName, Alias, Birthday, 
	BornPlace, NativeCountry, CountryID, ReligionID, EthnicID, IsMale, IsSingle, HealthStatus, PermanentAddress, 
	TemporaryAddress, HomePhone, HomeFax, MobiPhone, Email, IdentifyCardNo, IdentifyDate, IdentifyPlace, IdentifyCityID, 
	PassportNo, PassportDate, PassportEnd, Notes, EmployeeStatus, DepartmentID,PayableAccountID, ExpenseAccountID, PerInTaxID,
	Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID, IsAutoCreateUser, AbsentCardNo)
	SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
			X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
			X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
			X.Data.query('S1').value('.', 'NVARCHAR(50)') AS S1,
			X.Data.query('S2').value('.', 'NVARCHAR(50)') AS S2,
			X.Data.query('S3').value('.', 'NVARCHAR(50)') AS S3,
			X.Data.query('LastName').value('.', 'NVARCHAR(50)') AS LastName,
			X.Data.query('MiddleName').value('.', 'NVARCHAR(50)') AS MiddleName,
			X.Data.query('FirstName').value('.', 'NVARCHAR(50)') AS FirstName,
			X.Data.query('ShortName').value('.', 'NVARCHAR(50)') AS ShortName,
			X.Data.query('Alias').value('.', 'NVARCHAR(50)') AS Alias,
		   (CASE WHEN X.Data.query('Birthday').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Birthday').value('.', 'DATETIME') END) AS Birthday,
			X.Data.query('BornPlace').value('.', 'NVARCHAR(250)') AS BornPlace,
			X.Data.query('NativeCountry').value('.', 'NVARCHAR(250)') AS NativeCountry,
			X.Data.query('CountryID').value('.', 'NVARCHAR(50)') AS CountryID,
			X.Data.query('ReligionID').value('.', 'NVARCHAR(50)') AS ReligionID,
			X.Data.query('EthnicID').value('.', 'NVARCHAR(50)') AS EthnicID,
		   (CASE WHEN X.Data.query('IsMale').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('IsMale').value('.', 'TINYINT') END) AS IsMale,
		   (CASE WHEN X.Data.query('IsSingle').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('IsSingle').value('.', 'TINYINT') END) AS IsSingle,
			X.Data.query('HealthStatus').value('.', 'NVARCHAR(250)') AS HealthStatus,
			X.Data.query('PermanentAddress').value('.', 'NVARCHAR(250)') AS PermanentAddress,
			X.Data.query('TemporaryAddress').value('.', 'NVARCHAR(250)') AS TemporaryAddress,
			X.Data.query('HomePhone').value('.', 'NVARCHAR(100)') AS HomePhone,
			X.Data.query('HomeFax').value('.', 'NVARCHAR(100)') AS HomeFax,
			X.Data.query('MobiPhone').value('.', 'NVARCHAR(100)') AS MobiPhone,
			X.Data.query('Email').value('.', 'NVARCHAR(100)') AS Email,
			X.Data.query('IdentifyCardNo').value('.', 'NVARCHAR(50)') AS IdentifyCardNo,
		   (CASE WHEN X.Data.query('IdentifyDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('IdentifyDate').value('.', 'DATETIME') END) AS IdentifyDate,
			X.Data.query('IdentifyPlace').value('.', 'NVARCHAR(250)') AS IdentifyPlace,
			X.Data.query('IdentifyCityID').value('.', 'NVARCHAR(50)') AS IdentifyCityID,
			X.Data.query('PassportNo').value('.', 'NVARCHAR(50)') AS PassportNo,
			(CASE WHEN X.Data.query('PassportDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('PassportDate').value('.', 'DATETIME') END) AS PassportDate,
			(CASE WHEN X.Data.query('PassportEnd').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('PassportEnd').value('.', 'DATETIME') END) AS PassportEnd,
			X.Data.query('Notes').value('.', 'NVARCHAR(250)') AS Notes,
			(CASE WHEN X.Data.query('EmployeeStatus').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('EmployeeStatus').value('.', 'TINYINT') END) AS EmployeeStatus,
			X.Data.query('DepartmentID').value('.', 'NVARCHAR(50)') AS DepartmentID,		
			X.Data.query('PayableAccountID').value('.', 'NVARCHAR(50)') AS PayableAccountID,
			X.Data.query('ExpenseAccountID').value('.', 'NVARCHAR(50)') AS ExpenseAccountID,
	   		X.Data.query('PerInTaxID').value('.', 'NVARCHAR(50)') AS PerInTaxID,
	   		X.Data.query('Ana01ID').value('.', 'NVARCHAR(50)') AS Ana01ID,
	   		X.Data.query('Ana02ID').value('.', 'NVARCHAR(50)') AS Ana02ID,
	   		X.Data.query('Ana03ID').value('.', 'NVARCHAR(50)') AS Ana03ID,
	   		X.Data.query('Ana04ID').value('.', 'NVARCHAR(50)') AS Ana04ID,
	   		X.Data.query('Ana05ID').value('.', 'NVARCHAR(50)') AS Ana05ID,
	   		X.Data.query('Ana06ID').value('.', 'NVARCHAR(50)') AS Ana06ID,
	   		X.Data.query('Ana07ID').value('.', 'NVARCHAR(50)') AS Ana07ID,
	   		X.Data.query('Ana08ID').value('.', 'NVARCHAR(50)') AS Ana08ID,
	   		X.Data.query('Ana09ID').value('.', 'NVARCHAR(50)') AS Ana09ID,
	   		X.Data.query('Ana10ID').value('.', 'NVARCHAR(50)') AS Ana10ID,
			X.Data.query('IsAutoCreateUser').value('.', 'TINYINT') AS IsAutoCreateUser,
			X.Data.query('AbsentCardNo').value('.', 'NVARCHAR(50)') AS AbsentCardNo
	   	
	FROM	@XML.nodes('//Data') AS X (Data)
	ORDER BY [Row]
	
	-- Kiểm tra check code mặc định
	EXEC AP8106 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID, @SType = @SType
	
	----- Kiểm tra và lưu dữ liệu bảng giá bán
	EXEC AP8101 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @ColID = 'EmployeeID', @Param1 = 'DivisionID, 
	EmployeeID, LastName, FirstName', @SType = @SType 
	
	----- Kiểm tra EmployeeID đã tồn tại trong HT1400 (DivisionID, EmployeeID)
	EXEC AP8101 @UserID = 'ASOFTADMIN', @ImportTemplateID = 'EmployeeFileID', @CheckCode = 'CheckValueExistsTableList', @ColID = 'EmployeeID', @Param1 = 'HT1400', @Param2 = 'EmployeeID', @SQLFilter = '', @SType = @SType 
	
	---- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
	IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage != '')
		GOTO LB_RESULT
		
	---- Kiểm tra tồn tại dữ liệu trong danh mục
	EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID, @SType = @SType

	---- Thêm dữ liệu vào HT1400 - Thông tin nhân viên
	INSERT INTO HT1400(DivisionID, EmployeeID, S1, S2, S3, LastName, MiddleName, FirstName, ShortName, Alias, Birthday, 
	BornPlace, NativeCountry, CountryID, ReligionID, EthnicID, IsMale, IsSingle, HealthStatus, PermanentAddress, 
	TemporaryAddress, HomePhone, HomeFax, MobiPhone, Email, IdentifyCardNo, IdentifyDate, IdentifyPlace, IdentifyCityID, 
	PassportNo, PassportDate, PassportEnd, Notes, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate,EmployeeStatus,DepartmentID, 
	Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID)
	SELECT DivisionID, EmployeeID, S1, S2, S3, LastName, MiddleName, FirstName, ShortName, Alias, Birthday, BornPlace, 
		   NativeCountry, CountryID, ReligionID, EthnicID, IsMale, IsSingle, HealthStatus, PermanentAddress, 
		   TemporaryAddress, HomePhone, HomeFax, MobiPhone, Email, IdentifyCardNo, IdentifyDate, IdentifyPlace, 
		   IdentifyCityID, PassportNo, PassportDate, PassportEnd, Notes, @UserID, GETDATE(), @UserID, GETDATE(),ISNULL(DT.EmployeeStatus,0),DT.DepartmentID, 
		   Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID
	FROM #Data DT
	
	-- Add 3 column to AT1403 (PayableAccountID, ExpenseAccountID, PerInTaxID) Thinh
	INSERT INTO HT1403 (DivisionID, EmployeeID, EmployeeStatus,DepartmentID,PayableAccountID,ExpenseAccountID,PerInTaxID)
	SELECT DT.DivisionID,DT.EmployeeID,ISNULL(DT.EmployeeStatus,0),DT.DepartmentID,DT.PayableAccountID,DT.ExpenseAccountID,DT.PerInTaxID
	FROM #Data DT
	INNER JOIN HT1400 DET ON DET.DivisionID = DT.DivisionID AND DET.EmployeeID = DT.EmployeeID
	
	IF @CustomerName = 50 
	BEGIN
		UPDATE HT1403 SET
		TeamID = DT.Ana03ID
		FROM HT1403 HT14
		INNER JOIN #Data DT 
		ON DT.DivisionID = HT14.DivisionID 
		AND DT.EmployeeID = HT14.EmployeeID
	END
END

IF @SType = 2 -- Career Information
BEGIN
	-- Move EmployeeStatus, Department, PayableAccountID, ExpenseAccountID, PerInTaxID To Stype = 1 ( Thịnh 23/7/2015)
	INSERT INTO #Data([Row], DivisionID, EmployeeID, RecruitPlace, RecruitDate, Experience, CompanyDate, 
	WorkDate, MidEmployeeID, DutyID, TitleID, TaxObjectID, LoaCondID, SalaryLevel, SalaryLevelDate, TimeCoefficient, 
	DutyCoefficient, SalaryCoefficient, Notes, SuggestSalary, BaseSalary, InsuranceSalary, Salary01, Salary02, Salary03, TeamID
	--, FromApprenticeTime, ToApprenticeTime
	)
	--, PayableAccountID, ExpenseAccountID, PerInTaxID)
	SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
			X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
			X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
		   --(CASE WHEN X.Data.query('EmployeeStatus').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('EmployeeStatus').value('.', 'TINYINT') END) AS EmployeeStatus,
			X.Data.query('RecruitPlace').value('.', 'NVARCHAR(250)') AS RecruitPlace,
		   (CASE WHEN X.Data.query('RecruitDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('RecruitDate').value('.', 'DATETIME') END) AS RecruitDate,
			X.Data.query('Experience').value('.', 'NVARCHAR(100)') AS Experience,
			(CASE WHEN X.Data.query('CompanyDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('CompanyDate').value('.', 'DATETIME') END) AS CompanyDate,
			(CASE WHEN X.Data.query('WorkDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('WorkDate').value('.', 'DATETIME') END) AS WorkDate,
			X.Data.query('MidEmployeeID').value('.', 'NVARCHAR(50)') AS MidEmployeeID,
			X.Data.query('DutyID').value('.', 'NVARCHAR(50)') AS DutyID,
			X.Data.query('TitleID').value('.', 'VARCHAR(50)') AS TitleID,
			X.Data.query('TaxObjectID').value('.', 'NVARCHAR(50)') AS TaxObjectID,
			X.Data.query('LoaCondID').value('.', 'NVARCHAR(50)') AS LoaCondID,
			X.Data.query('SalaryLevel').value('.', 'NVARCHAR(50)') AS SalaryLevel,
		   (CASE WHEN X.Data.query('SalaryLevelDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('SalaryLevelDate').value('.', 'DATETIME') END) AS SalaryLevelDate,
		   (CASE WHEN X.Data.query('TimeCoefficient').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('TimeCoefficient').value('.', 'DECIMAL(28,8)') END) AS TimeCoefficient,
		   (CASE WHEN X.Data.query('DutyCoefficient').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('DutyCoefficient').value('.', 'DECIMAL(28,8)') END) AS DutyCoefficient,
		   (CASE WHEN X.Data.query('SalaryCoefficient').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('SalaryCoefficient').value('.', 'DECIMAL(28,8)') END) AS SalaryCoefficient,
			X.Data.query('Notes').value('.', 'NVARCHAR(250)') AS Notes,
		   (CASE WHEN X.Data.query('SuggestSalary').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('SuggestSalary').value('.', 'DECIMAL(28,8)') END) AS SuggestSalary,
		   (CASE WHEN X.Data.query('BaseSalary').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('BaseSalary').value('.', 'DECIMAL(28,8)') END) AS BaseSalary,
		   (CASE WHEN X.Data.query('InsuranceSalary').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('InsuranceSalary').value('.', 'DECIMAL(28,8)') END) AS InsuranceSalary,
		   (CASE WHEN X.Data.query('Salary01').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('Salary01').value('.', 'DECIMAL(28,8)') END) AS Salary01,
		   (CASE WHEN X.Data.query('Salary02').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('Salary02').value('.', 'DECIMAL(28,8)') END) AS Salary02,
		   (CASE WHEN X.Data.query('Salary03').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('Salary03').value('.', 'DECIMAL(28,8)') END) AS Salary03,
			--X.Data.query('DepartmentID').value('.', 'NVARCHAR(50)') AS DepartmentID,
			X.Data.query('TeamID').value('.', 'NVARCHAR(50)') AS TeamID
			--,
			--X.Data.query('PayableAccountID').value('.', 'NVARCHAR(50)') AS PayableAccountID,
			--X.Data.query('ExpenseAccountID').value('.', 'NVARCHAR(50)') AS ExpenseAccountID,
		 --  	X.Data.query('PerInTaxID').value('.', 'NVARCHAR(50)') AS PerInTaxID
		  --(CASE WHEN X.Data.query('FromApprenticeTime').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('FromApprenticeTime').value('.', 'DATETIME') END) AS FromApprenticeTime,
		  --(CASE WHEN X.Data.query('ToApprenticeTime').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('ToApprenticeTime').value('.', 'DATETIME') END) AS ToApprenticeTime
	FROM	@XML.nodes('//Data') AS X (Data)
	ORDER BY [Row]
	
	-- Kiểm tra check code mặc định
	EXEC AP8106 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID, @SType = @SType
	
	----- Kiểm tra và lưu dữ liệu bảng giá bán
	EXEC AP8101 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @ColID = 'EmployeeID', @Param1 = 'DivisionID, 
	EmployeeID, EmployeeStatus', @SType = @SType 
	
	----- Kiểm tra EmployeeID đã tồn tại trong HT1400 (DivisionID, EmployeeID)
	EXEC AP8101 @UserID = 'ASOFTADMIN', @ImportTemplateID = 'EmployeeFileID', @CheckCode = 'CheckValueInTableList', @ColID = 'EmployeeID', @Param1 = 'HT1400', @Param2 = 'EmployeeID', @SQLFilter = '', @SType = @SType 
	
	-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
	IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage != '')
		GOTO LB_RESULT

	---- Remove EmployeeStatus and DepartmentID to SType 2 Update (Thịnh)	and Only Update 
	IF @CustomerName = 50 
	BEGIN
		UPDATE HT1403 SET				
		RecruitPlace = DT.RecruitPlace,
		RecruitDate = DT.RecruitDate,
		Experience = DT.Experience,
		CompanyDate = DT.CompanyDate,
		WorkDate = DT.WorkDate,
		MidEmployeeID = DT.MidEmployeeID,
		DutyID = DT.TitleID,
		TitleID = DT.TitleID,
		TaxObjectID = DT.TaxObjectID,
		LoaCondID = DT.LoaCondID,
		SalaryLevel = DT.SalaryLevel,
		SalaryLevelDate = DT.SalaryLevelDate,
		TimeCoefficient = DT.TimeCoefficient,
		DutyCoefficient = DT.DutyCoefficient,
		SalaryCoefficient = DT.SalaryCoefficient,
		Notes = DT.Notes,
		SuggestSalary = DT.SuggestSalary,
		BaseSalary = DT.BaseSalary,
		InsuranceSalary = DT.InsuranceSalary,
		Salary01 = DT.Salary01,
		Salary02 = DT.Salary02,
		Salary03 = DT.Salary03,
		FromApprenticeTime = DT.FromApprenticeTime,
		ToApprenticeTime = DT.ToApprenticeTime			
		
		--PayableAccountID = DT.PayableAccountID,
		--ExpenseAccountID = DT.ExpenseAccountID,
		--PerInTaxID = DT.PerInTaxID
	FROM HT1403 HT14
	INNER JOIN #Data DT 
		ON DT.DivisionID = HT14.DivisionID 
			AND DT.EmployeeID = HT14.EmployeeID		
	
	END
	ELSE
		UPDATE HT1403 SET				
		RecruitPlace = DT.RecruitPlace,
		RecruitDate = DT.RecruitDate,
		Experience = DT.Experience,
		CompanyDate = DT.CompanyDate,
		WorkDate = DT.WorkDate,
		MidEmployeeID = DT.MidEmployeeID,
		DutyID = DT.DutyID,
		TitleID = DT.TitleID,
		TaxObjectID = DT.TaxObjectID,
		LoaCondID = DT.LoaCondID,
		SalaryLevel = DT.SalaryLevel,
		SalaryLevelDate = DT.SalaryLevelDate,
		TimeCoefficient = DT.TimeCoefficient,
		DutyCoefficient = DT.DutyCoefficient,
		SalaryCoefficient = DT.SalaryCoefficient,
		Notes = DT.Notes,
		SuggestSalary = DT.SuggestSalary,
		BaseSalary = DT.BaseSalary,
		InsuranceSalary = DT.InsuranceSalary,
		Salary01 = DT.Salary01,
		Salary02 = DT.Salary02,
		Salary03 = DT.Salary03,		
		TeamID = DT.TeamID,
		FromApprenticeTime = DT.FromApprenticeTime,
		ToApprenticeTime = DT.ToApprenticeTime	
		--PayableAccountID = DT.PayableAccountID,
		--ExpenseAccountID = DT.ExpenseAccountID,
		--PerInTaxID = DT.PerInTaxID
	FROM HT1403 HT14
	INNER JOIN #Data DT 
		ON DT.DivisionID = HT14.DivisionID 
			AND DT.EmployeeID = HT14.EmployeeID			
	
	
	UPDATE HT14 SET 	
	HT14.TeamID = DT.TeamID
	FROM HT1400 HT14
	INNER JOIN HT1403 DT ON DT.DivisionID = HT14.DivisionID AND DT.EmployeeID = HT14.EmployeeID
	WHERE HT14.DivisionID = @DivisionID AND HT14.EmployeeID in (SELECT EmployeeID FROM #Data)
	

				   
			--UPDATE HT1400 SET 
			--	EmployeeStatus = ISNULL(DT.EmployeeStatus,0),
			--	DepartmentID = DT.DepartmentID,
			--	TeamID = DT.TeamID
			--FROM HT1400 HT14
			--INNER JOIN #Data DT ON DT.DivisionID = HT14.DivisionID AND DT.EmployeeID = HT14.EmployeeID
			--WHERE DT.DivisionID = @DivisionID AND DT.EmployeeID = @EmployeeID			   
	--ELSE
		--BEGIN 
		--	INSERT INTO HT1403 (DivisionID, EmployeeID, EmployeeStatus, RecruitPlace, RecruitDate, Experience, CompanyDate, 
		--	WorkDate, MidEmployeeID, DutyID, TitleID, TaxObjectID, LoaCondID, SalaryLevel, SalaryLevelDate, TimeCoefficient, 
		--	DutyCoefficient, SalaryCoefficient, Notes, SuggestSalary, BaseSalary, InsuranceSalary, Salary01, Salary02, Salary03, 
		--	DepartmentID, TeamID, PayableAccountID, ExpenseAccountID, PerInTaxID)
		--	SELECT DT.DivisionID, DT.EmployeeID, DET.EmployeeStatus, DT.RecruitPlace, DT.ecruitDate, DT.xperience, DT.CompanyDate, DT.WorkDate, 
		--		   DT.MidEmployeeID, DT.DutyID, DT.TitleID, DT.TaxObjectID, DT.LoaCondID, DT.SalaryLevel, DT.SalaryLevelDate, DT.TimeCoefficient,
		--		   DT.DutyCoefficient, DT.SalaryCoefficient, DT.Notes, DT.SuggestSalary, DT.BaseSalary, DT.InsuranceSalary, DT.Salary01, DT.Salary02, 
		--		   DT.Salary03, DET.DepartmentID, DT.TeamID, DT.PayableAccountID, DT.ExpenseAccountID, DT.PerInTaxID
		--	FROM #Data DT
		--	INNER JOIN HT1400 DET ON DET.DivisionID = DT.DivisionID AND DT.EmployeeID = DET.EmployeeID
		--	WHERE DivisionID = @DivisionID AND EmployeeID = @EmployeeID
		--END	
		
		
		
---- Bổ sung thông tin vào AT1103 nếu IsAutoCreateUser = 1
IF @CustomerName = 57
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM HT1400 LEFT JOIN #Data ON HT1400.EmployeeID = #Data.EmployeeID  WHERE HT1400.IsAutoCreateUser = 1)
	BEGIN
		IF NOT EXISTS(SELECT AT1103.EmployeeID FROM AT1103 INNER JOIN #Data DT ON AT1103.EmployeeID=DT.EmployeeID and AT1103.DivisionID = DT.DivisionID)
		INSERT INTO AT1103 (DivisionID, EmployeeID, FullName, DepartmentID, HireDate, BirthDay,Address,
							Tel, Fax, Email, IsUserID, CreateDate, CreateUserID, LastModifyUserID, LastModifyDate)
		SELECT	H00.DivisionID, H00.EmployeeID, H00.LastName + ' ' + H00.MiddleName + ' ' + H00.FirstName,  H00.DepartmentID, 
				H03.WorkDate, H00.Birthday, H00.PermanentAddress, H00.MobiPhone, H00.HomeFax, H00.Email, 1,
				H00.CreateDate, H00.CreateUserID, H00.LastModifyUserID, H00.LastModifyDate
		FROM	HT1400 H00 WITH (NOLOCK) 
		INNER JOIN HT1403 H03 WITH (NOLOCK) ON H00.EmployeeID = H03.EmployeeID AND H00.DivisionID = H03.DivisionID
		INNER JOIN #Data DT ON H00.EmployeeID=DT.EmployeeID and H00.DivisionID = DT.DivisionID 
	END	
END
END

IF @SType = 3 -- Educational Information
BEGIN
	INSERT INTO #Data([Row], DivisionID, EmployeeID, EducationLevelID, PoliticsID, Language1ID, LanguageLevel1ID, Language2ID, 
	LanguageLevel2ID, Language3ID, LanguageLevel3ID, SchoolID, MajorID, TypeID, FromMonth, FromYear, ToMonth, ToYear, [Description], Notes)
	SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
			X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
			X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
			X.Data.query('EducationLevelID').value('.', 'NVARCHAR(50)') AS EducationLevelID,
			X.Data.query('PoliticsID').value('.', 'NVARCHAR(50)') AS PoliticsID,
			X.Data.query('Language1ID').value('.', 'NVARCHAR(50)') AS Language1ID,
			X.Data.query('LanguageLevel1ID').value('.', 'NVARCHAR(50)') AS LanguageLevel1ID,
			X.Data.query('Language2ID').value('.', 'NVARCHAR(50)') AS Language2ID,
			X.Data.query('LanguageLevel2ID').value('.', 'NVARCHAR(50)') AS LanguageLevel2ID,
			X.Data.query('Language3ID').value('.', 'NVARCHAR(50)') AS Language3ID,
			X.Data.query('LanguageLevel3ID').value('.', 'NVARCHAR(50)') AS LanguageLevel3ID,
			X.Data.query('SchoolID').value('.', 'NVARCHAR(50)') AS SchoolID,
			X.Data.query('MajorID').value('.', 'NVARCHAR(50)') AS MajorID,
		   (CASE WHEN X.Data.query('TypeID').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('TypeID').value('.', 'TINYINT') END) AS TypeID,
		   (CASE WHEN X.Data.query('FromMonth').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('FromMonth').value('.', 'INT') END) AS FromMonth,
		   (CASE WHEN X.Data.query('FromYear').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('FromYear').value('.', 'INT') END) AS FromYear,
		   (CASE WHEN X.Data.query('ToMonth').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('ToMonth').value('.', 'INT') END) AS ToMonth,
		   (CASE WHEN X.Data.query('ToYear').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('ToYear').value('.', 'INT') END) AS ToYear,
			X.Data.query('Description').value('.', 'NVARCHAR(250)') AS [Description],
	   		X.Data.query('Notes').value('.', 'NVARCHAR(250)') AS Notes
	FROM	@XML.nodes('//Data') AS X (Data)
	ORDER BY [Row]

	---- Kiểm tra check code mặc định
	EXEC AP8106 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID, @SType = @SType
	----- Kiểm tra và lưu dữ liệu bảng giá bán
	EXEC AP8101 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @ColID = 'EmployeeID', @Param1 = 'DivisionID, 
	EmployeeID, EducationLevelID, PoliticsID, Language1ID, LanguageLevel1ID, Language2ID, LanguageLevel2ID, Language3ID, 
	LanguageLevel3ID, SchoolID, MajorID, TypeID', @SType = @SType 
	----- Kiểm tra EmployeeID đã tồn tại trong HT1400 (DivisionID, EmployeeID)
	EXEC AP8101 @UserID = 'ASOFTADMIN', @ImportTemplateID = 'EmployeeFileID', @CheckCode = 'CheckValueInTableList', @ColID = 'EmployeeID', @Param1 = 'HT1400', @Param2 = 'EmployeeID', @SQLFilter = '', @SType = @SType 
	--EXEC AP8101 @UserID = 'ASOFTADMIN', @ImportTemplateID = 'EmployeeFileID', @CheckCode = 'CheckValueExistsTableList', @ColID = 'EmployeeID', @Param1 = 'HT1401', @Param2 = 'EmployeeID', @SQLFilter = '', @SType = @SType 
	EXEC AP8101 @UserID = 'ASOFTADMIN', @ImportTemplateID = 'EmployeeFileID', @CheckCode = 'CheckValueExistsTableList', @ColID = 'EmployeeID', @Param1 = 'HT1301', @Param2 = 'EmployeeID', @SQLFilter = '', @SType = @SType 
	-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage != '')
	GOTO LB_RESULT
---- Trình độ học vấn - HT1401
SET @Cur = CURSOR SCROLL KEYSET FOR
		   SELECT Row, DivisionID, EmployeeID
		   FROM #Data
OPEN @Cur
FETCH NEXT FROM @Cur INTO @Row, @DivisionID, @EmployeeID
WHILE @@FETCH_STATUS = 0
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM HT1401 WHERE DivisionID = @DivisionID AND EmployeeID = @EmployeeID)
	BEGIN		
UPDATE HT1401 SET
	EducationLevelID = DT.EducationLevelID,
	PoliticsID = DT.PoliticsID,
	Language1ID = DT.Language1ID,
	LanguageLevel1ID = DT.LanguageLevel1ID,
	Language2ID = DT.Language2ID,
	LanguageLevel2ID = DT.LanguageLevel2ID,
	Language3ID = DT.Language3ID,
	LanguageLevel3ID = DT.LanguageLevel3ID
FROM HT1401 HT14
INNER JOIN #Data DT ON DT.DivisionID = HT14.DivisionID AND DT.EmployeeID = HT14.EmployeeID
WHERE DT.DivisionID = @DivisionID AND DT.EmployeeID = @EmployeeID			
	END 
	ELSE
	BEGIN 
INSERT INTO HT1401(DivisionID, EmployeeID, EducationLevelID, PoliticsID, Language1ID, LanguageLevel1ID, Language2ID, 
LanguageLevel2ID, Language3ID, LanguageLevel3ID)
SELECT DivisionID, EmployeeID, EducationLevelID, PoliticsID, Language1ID, LanguageLevel1ID, Language2ID, 
	   LanguageLevel2ID, Language3ID, LanguageLevel3ID
FROM #Data DT
WHERE DivisionID = @DivisionID AND EmployeeID = @EmployeeID
	END		
	FETCH NEXT FROM @Cur INTO @Row, @DivisionID, @EmployeeID
END
CLOSE @Cur

---- Quá trình học tập - HT1301
INSERT INTO HT1301 (DivisionID, HistoryID, EmployeeID, SchoolID, MajorID, TypeID, FromMonth, FromYear, ToMonth, 
ToYear, [Description], Notes,CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT DivisionID, NEWID(), EmployeeID, SchoolID, MajorID, TypeID, FromMonth, FromYear, ToMonth, ToYear, 
	   [Description], Notes,@UserID, GETDATE(), @UserID, GETDATE()
FROM #Data DT
WHERE Isnull(SchoolID,'') <> ''
END

IF @SType = 4 -- Social Information
BEGIN
INSERT INTO #Data([Row], DivisionID, EmployeeID, SoInsuranceNo, SoInsurBeginDate, HeInsuranceNo, HFromDate, HToDate, HospitalID, 
Height, [Weight], BloodGroup, Hobby, BankID, BankAccountNo, PersonalTaxID, ArmyEndDate, ArmyJoinDate, ArmyLevel, AssociationID, 
StartDate, EndDate, JoinPlace, AssociationNo)
SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
		X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
		X.Data.query('SoInsuranceNo').value('.', 'NVARCHAR(50)') AS SoInsuranceNo,
	   (CASE WHEN X.Data.query('SoInsurBeginDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('SoInsurBeginDate').value('.', 'DATETIME') END) AS SoInsurBeginDate,
	    X.Data.query('HeInsuranceNo').value('.', 'NVARCHAR(50)') AS HeInsuranceNo,
	   (CASE WHEN X.Data.query('HFromDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('HFromDate').value('.', 'DATETIME') END) AS HFromDate,
	   (CASE WHEN X.Data.query('HToDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('HToDate').value('.', 'DATETIME') END) AS HToDate,
	   	X.Data.query('HospitalID').value('.', 'NVARCHAR(50)') AS HospitalID,
	   	X.Data.query('Height').value('.', 'NVARCHAR(100)') AS Height,
	   	X.Data.query('Weight').value('.', 'NVARCHAR(100)') AS [Weight],
	   	X.Data.query('BloodGroup').value('.', 'NVARCHAR(100)') AS BloodGroup,
	   	X.Data.query('Hobby').value('.', 'NVARCHAR(100)') AS Hobby,
	   	X.Data.query('BankID').value('.', 'NVARCHAR(50)') AS BankID,
	   	X.Data.query('BankAccountNo').value('.', 'NVARCHAR(50)') AS BankAccountNo,
	   	X.Data.query('PersonalTaxID').value('.', 'NVARCHAR(50)') AS PersonalTaxID,
	   (CASE WHEN X.Data.query('ArmyEndDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('ArmyEndDate').value('.', 'DATETIME') END) AS ArmyEndDate,
	   (CASE WHEN X.Data.query('ArmyJoinDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('ArmyJoinDate').value('.', 'DATETIME') END) AS ArmyJoinDate,
	   	X.Data.query('ArmyLevel').value('.', 'NVARCHAR(100)') AS ArmyLevel,
	    X.Data.query('AssociationID').value('.', 'NVARCHAR(50)') AS AssociationID,
		(CASE WHEN X.Data.query('StartDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('StartDate').value('.', 'DATETIME') END) AS StartDate,
		(CASE WHEN X.Data.query('EndDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('EndDate').value('.', 'DATETIME') END) AS EndDate,
		X.Data.query('JoinPlace').value('.', 'NVARCHAR(250)') AS JoinPlace,
		X.Data.query('AssociationNo').value('.', 'NVARCHAR(50)') AS AssociationNo
FROM	@XML.nodes('//Data') AS X (Data)
ORDER BY [Row]
---- Kiểm tra check code mặc định
EXEC AP8106 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID, @SType = @SType
----- Kiểm tra và lưu dữ liệu bảng giá bán
EXEC AP8101 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @ColID = 'EmployeeID', @Param1 = 'DivisionID, EmployeeID, AssociationID', @SType = @SType 
----- Kiểm tra EmployeeID đã tồn tại trong HT1400 (DivisionID, EmployeeID)
EXEC AP8101 @UserID = 'ASOFTADMIN', @ImportTemplateID = 'EmployeeFileID', @CheckCode = 'CheckValueInTableList', @ColID = 'EmployeeID', @Param1 = 'HT1400', @Param2 = 'EmployeeID', @SQLFilter = '', @SType = @SType 
EXEC AP8101 @UserID = 'ASOFTADMIN', @ImportTemplateID = 'EmployeeFileID', @CheckCode = 'CheckValueExistsTableList', @ColID = 'EmployeeID', @Param1 = 'HT1402', @Param2 = 'EmployeeID', @SQLFilter = '', @SType = @SType 
EXEC AP8101 @UserID = 'ASOFTADMIN', @ImportTemplateID = 'EmployeeFileID', @CheckCode = 'CheckValueExistsTableList', @ColID = 'EmployeeID', @Param1 = 'HT1405', @Param2 = 'EmployeeID', @SQLFilter = '', @SType = @SType 
-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage != '')
	GOTO LB_RESULT
---- Thông tin bảo hiểm xã hội, tài khoản cá nhân, thông tin nhập ngũ
INSERT INTO HT1402(DivisionID, EmployeeID, SoInsuranceNo, SoInsurBeginDate, HeInsuranceNo, HFromDate, HToDate, HospitalID, 
Height, [Weight], BloodGroup, Hobby, BankID, BankAccountNo, PersonalTaxID, ArmyEndDate, ArmyJoinDate, ArmyLevel)
SELECT DivisionID, EmployeeID, SoInsuranceNo, SoInsurBeginDate, HeInsuranceNo, HFromDate, HToDate, HospitalID,
	   Height, [Weight], BloodGroup, Hobby, BankID, BankAccountNo, PersonalTaxID, ArmyEndDate, ArmyJoinDate, ArmyLevel
FROM #Data DT
---- Thông tin đoàn thể, hiệp hội - HT1405
INSERT INTO HT1405(DivisionID, AssEmID, EmployeeID, AssociationID, StartDate, EndDate, JoinPlace, AssociationNo, 
CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT DivisionID, NEWID(), EmployeeID, AssociationID, StartDate, EndDate, JoinPlace, AssociationNo, @UserID, 
	   GETDATE(), @UserID, GETDATE()
FROM #Data DT
END

IF @SType = 5 -- Familial Information
BEGIN
INSERT INTO #Data([Row], DivisionID, EmployeeID, FatherName, FatherYear, FatherJob, FatherAddress, FatherNote, IsFatherDeath, MotherName, 
MotherYear, MotherJob, MotherAddress, MotherNote, IsMotherDeath, SpouseName, SpouseYear, SpouseJob, SpouseAddress, SpouseNote, IsSpouseDeath, 
RelationType, RelationName, RelationDate, RelationAddress, RelationPhone, Notes)
SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
		X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
		X.Data.query('FatherName').value('.', 'NVARCHAR(250)') AS FatherName,
	   (CASE WHEN X.Data.query('FatherYear').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('FatherYear').value('.', 'INT') END) AS FatherYear,
	    X.Data.query('FatherJob').value('.', 'NVARCHAR(250)') AS FatherJob,
	    X.Data.query('FatherAddress').value('.', 'NVARCHAR(250)') AS FatherAddress,
	    X.Data.query('FatherNote').value('.', 'NVARCHAR(250)') AS FatherNote,
	   (CASE WHEN X.Data.query('IsFatherDeath').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('IsFatherDeath').value('.', 'TINYINT') END) AS IsFatherDeath,
		X.Data.query('MotherName').value('.', 'NVARCHAR(250)') AS MotherName,
	   (CASE WHEN X.Data.query('MotherYear').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('MotherYear').value('.', 'INT') END) AS MotherYear,
	    X.Data.query('MotherJob').value('.', 'NVARCHAR(250)') AS MotherJob,
	    X.Data.query('MotherAddress').value('.', 'NVARCHAR(250)') AS MotherAddress,
	    X.Data.query('MotherNote').value('.', 'NVARCHAR(250)') AS MotherNote,
	   (CASE WHEN X.Data.query('IsMotherDeath').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('IsMotherDeath').value('.', 'TINYINT') END) AS IsMotherDeath,
	    X.Data.query('SpouseName').value('.', 'NVARCHAR(250)') AS SpouseName,
	   (CASE WHEN X.Data.query('SpouseYear').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('SpouseYear').value('.', 'INT') END) AS SpouseYear,
	    X.Data.query('SpouseJob').value('.', 'NVARCHAR(250)') AS SpouseJob,
	    X.Data.query('SpouseAddress').value('.', 'NVARCHAR(250)') AS SpouseAddress,
	    X.Data.query('SpouseNote').value('.', 'NVARCHAR(250)') AS SpouseNote,
	   (CASE WHEN X.Data.query('IsSpouseDeath').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('IsSpouseDeath').value('.', 'TINYINT') END) AS IsSpouseDeath,
	   (CASE WHEN X.Data.query('RelationType').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('RelationType').value('.', 'TINYINT') END) AS RelationType,	
	    X.Data.query('RelationName').value('.', 'NVARCHAR(250)') AS RelationName,
	   (CASE WHEN X.Data.query('RelationDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('RelationDate').value('.', 'DATETIME') END) AS RelationDate,
		X.Data.query('RelationAddress').value('.', 'NVARCHAR(250)') AS RelationAddress,
		X.Data.query('RelationPhone').value('.', 'NVARCHAR(100)') AS RelationPhone,
		X.Data.query('Notes').value('.', 'NVARCHAR(250)') AS Notes
FROM	@XML.nodes('//Data') AS X (Data)
ORDER BY [Row]
---- Kiểm tra check code mặc định
EXEC AP8106 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID, @SType = @SType
----- Kiểm tra và lưu dữ liệu bảng giá bán
EXEC AP8101 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @ColID = 'EmployeeID', @Param1 = 'DivisionID, 
EmployeeID, FatherName, FatherYear, FatherJob, FatherAddress, FatherNote, IsFatherDeath, MotherName, MotherYear, MotherJob, 
MotherAddress, MotherNote, IsMotherDeath, SpouseName, SpouseYear, SpouseJob, SpouseAddress, SpouseNote, IsSpouseDeath, 
RelationType, RelationName, RelationDate', @SType = @SType
----- Kiểm tra EmployeeID đã tồn tại trong HT1400 (DivisionID, EmployeeID)
EXEC AP8101 @UserID = 'ASOFTADMIN', @ImportTemplateID = 'EmployeeFileID', @CheckCode = 'CheckValueInTableList', @ColID = 'EmployeeID', @Param1 = 'HT1400', @Param2 = 'EmployeeID', @SQLFilter = '', @SType = @SType 
EXEC AP8101 @UserID = 'ASOFTADMIN', @ImportTemplateID = 'EmployeeFileID', @CheckCode = 'CheckValueExistsTableList', @ColID = 'EmployeeID', @Param1 = 'HT1404', @Param2 = 'EmployeeID', @SQLFilter = '', @SType = @SType 
-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage != '')
	GOTO LB_RESULT
---- Thông tin gia đình - HT1401 (Nếu đã có thì update, chưa thì insert)
SET @Cur = CURSOR SCROLL KEYSET FOR
		   SELECT Row, DivisionID, EmployeeID
		   FROM #Data
OPEN @Cur
FETCH NEXT FROM @Cur INTO @Row, @DivisionID, @EmployeeID
WHILE @@FETCH_STATUS = 0
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM HT1401 WHERE DivisionID = @DivisionID AND EmployeeID = @EmployeeID)
	BEGIN		
UPDATE HT1401 SET
	FatherName = DT.FatherName,
	FatherYear = DT.FatherYear,
	FatherJob = DT.FatherJob,
	FatherAddress = DT.FatherAddress,
	FatherNote = DT.FatherNote,
	IsFatherDeath = DT.IsFatherDeath,
	MotherName = DT.MotherName,
	MotherYear = DT.MotherYear,
	MotherJob = DT.MotherJob,
	MotherAddress = DT.MotherAddress,
	MotherNote = DT.MotherNote,
	IsMotherDeath = DT.IsMotherDeath,
	SpouseName = DT.SpouseName,
	SpouseYear = DT.SpouseYear,
	SpouseJob = DT.SpouseJob,
	SpouseAddress = DT.SpouseAddress,
	SpouseNote = DT.SpouseNote,
	IsSpouseDeath = DT.IsSpouseDeath
FROM HT1401 HT14
INNER JOIN #Data DT ON DT.DivisionID = HT14.DivisionID AND DT.EmployeeID = HT14.EmployeeID
WHERE DT.DivisionID = @DivisionID AND DT.EmployeeID = @EmployeeID	
	END 
	ELSE
	BEGIN 
INSERT INTO HT1401(DivisionID, EmployeeID, FatherName, FatherYear, FatherJob, FatherAddress, FatherNote, IsFatherDeath, 
MotherName, MotherYear, MotherJob, MotherAddress, MotherNote, IsMotherDeath, SpouseName, SpouseYear, SpouseJob,
SpouseAddress, SpouseNote, IsSpouseDeath)
SELECT DivisionID, EmployeeID, FatherName, FatherYear, FatherJob, FatherAddress, FatherNote, IsFatherDeath, MotherName, 
MotherYear, MotherJob, MotherAddress, MotherNote, IsMotherDeath, SpouseName, SpouseYear, SpouseJob, SpouseAddress, 
SpouseNote, IsSpouseDeath
FROM #Data DT
WHERE DivisionID = @DivisionID AND EmployeeID = @EmployeeID
	END		
	FETCH NEXT FROM @Cur INTO @Row, @DivisionID, @EmployeeID
END
CLOSE @Cur
---- Quan hệ gia đình - HT1404
INSERT INTO HT1404 (DivisionID, RelationID, EmployeeID, RelationType, RelationName, RelationDate, RelationAddress, 
RelationPhone, Notes, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT DivisionID, NEWID(), EmployeeID, RelationType, RelationName, RelationDate, RelationAddress, RelationPhone, 
	   Notes, @UserID, GETDATE(), @UserID, GETDATE()
FROM #Data DT
WHERE ISNULL(RelationName,'') <> ''
END

IF @SType = 6 -- Customized Index Information
BEGIN
INSERT INTO #Data([Row], DivisionID, EmployeeID, C01, C02, C03, C04, C05, C06, C07, C08, C09, C10, C11, C12, C13, C14, C15, C16, 
C17, C18, C19, C20, C21, C22, C23, C24, C25, Target01ID, TargetAmount01, Target02ID, TargetAmount02, Target03ID, TargetAmount03, 
Target04ID, TargetAmount04, Target05ID, TargetAmount05, Target06ID, TargetAmount06, Target07ID, TargetAmount07, Target08ID, 
TargetAmount08, Target09ID, TargetAmount09, Target10ID, TargetAmount10)
SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
		X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
	   (CASE WHEN X.Data.query('C01').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('C01').value('.', 'DECIMAL(28,8)') END) AS C01,
	   (CASE WHEN X.Data.query('C02').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('C02').value('.', 'DECIMAL(28,8)') END) AS C02,
	   (CASE WHEN X.Data.query('C03').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('C03').value('.', 'DECIMAL(28,8)') END) AS C03,
	   (CASE WHEN X.Data.query('C04').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('C04').value('.', 'DECIMAL(28,8)') END) AS C04,
	   (CASE WHEN X.Data.query('C05').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('C05').value('.', 'DECIMAL(28,8)') END) AS C05,
	   (CASE WHEN X.Data.query('C06').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('C06').value('.', 'DECIMAL(28,8)') END) AS C06,
	   (CASE WHEN X.Data.query('C07').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('C07').value('.', 'DECIMAL(28,8)') END) AS C07,
	   (CASE WHEN X.Data.query('C08').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('C08').value('.', 'DECIMAL(28,8)') END) AS C08,
	   (CASE WHEN X.Data.query('C09').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('C09').value('.', 'DECIMAL(28,8)') END) AS C09,
	   (CASE WHEN X.Data.query('C10').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('C10').value('.', 'DECIMAL(28,8)') END) AS C10,
	   (CASE WHEN X.Data.query('C11').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('C11').value('.', 'DECIMAL(28,8)') END) AS C11,
	   (CASE WHEN X.Data.query('C12').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('C12').value('.', 'DECIMAL(28,8)') END) AS C12,
	   (CASE WHEN X.Data.query('C13').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('C13').value('.', 'DECIMAL(28,8)') END) AS C13,
	   (CASE WHEN X.Data.query('C14').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('C14').value('.', 'DECIMAL(28,8)') END) AS C14,
	   (CASE WHEN X.Data.query('C15').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('C15').value('.', 'DECIMAL(28,8)') END) AS C15,
	   (CASE WHEN X.Data.query('C16').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('C16').value('.', 'DECIMAL(28,8)') END) AS C16,
	   (CASE WHEN X.Data.query('C17').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('C17').value('.', 'DECIMAL(28,8)') END) AS C17,
	   (CASE WHEN X.Data.query('C18').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('C18').value('.', 'DECIMAL(28,8)') END) AS C18,
	   (CASE WHEN X.Data.query('C19').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('C19').value('.', 'DECIMAL(28,8)') END) AS C19,
	   (CASE WHEN X.Data.query('C20').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('C20').value('.', 'DECIMAL(28,8)') END) AS C20,
	   (CASE WHEN X.Data.query('C21').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('C21').value('.', 'DECIMAL(28,8)') END) AS C21,
	   (CASE WHEN X.Data.query('C22').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('C22').value('.', 'DECIMAL(28,8)') END) AS C22,
	   (CASE WHEN X.Data.query('C23').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('C23').value('.', 'DECIMAL(28,8)') END) AS C23,
	   (CASE WHEN X.Data.query('C24').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('C24').value('.', 'DECIMAL(28,8)') END) AS C24,
	   (CASE WHEN X.Data.query('C25').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('C25').value('.', 'DECIMAL(28,8)') END) AS C25,
	    X.Data.query('Target01ID').value('.', 'NVARCHAR(50)') AS Target01ID,
	   (CASE WHEN X.Data.query('TargetAmount01').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('TargetAmount01').value('.', 'DECIMAL(28,8)') END) AS TargetAmount01,
	   X.Data.query('Target02ID').value('.', 'NVARCHAR(50)') AS Target02ID,
	   (CASE WHEN X.Data.query('TargetAmount02').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('TargetAmount02').value('.', 'DECIMAL(28,8)') END) AS TargetAmount02,
	   X.Data.query('Target03ID').value('.', 'NVARCHAR(50)') AS Target03ID,
	   (CASE WHEN X.Data.query('TargetAmount03').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('TargetAmount03').value('.', 'DECIMAL(28,8)') END) AS TargetAmount03,
	   X.Data.query('Target04ID').value('.', 'NVARCHAR(50)') AS Target04ID,
	   (CASE WHEN X.Data.query('TargetAmount04').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('TargetAmount04').value('.', 'DECIMAL(28,8)') END) AS TargetAmount04,
	   X.Data.query('Target05ID').value('.', 'NVARCHAR(50)') AS Target05ID,
	   (CASE WHEN X.Data.query('TargetAmount05').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('TargetAmount05').value('.', 'DECIMAL(28,8)') END) AS TargetAmount05,
	   X.Data.query('Target06ID').value('.', 'NVARCHAR(50)') AS Target06ID,
	   (CASE WHEN X.Data.query('TargetAmount06').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('TargetAmount06').value('.', 'DECIMAL(28,8)') END) AS TargetAmount06,
	   X.Data.query('Target07ID').value('.', 'NVARCHAR(50)') AS Target07ID,
	   (CASE WHEN X.Data.query('TargetAmount07').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('TargetAmount07').value('.', 'DECIMAL(28,8)') END) AS TargetAmount07,
	   X.Data.query('Target08ID').value('.', 'NVARCHAR(50)') AS Target08ID,
	   (CASE WHEN X.Data.query('TargetAmount08').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('TargetAmount08').value('.', 'DECIMAL(28,8)') END) AS TargetAmount08,
	   X.Data.query('Target09ID').value('.', 'NVARCHAR(50)') AS Target09ID,
	   (CASE WHEN X.Data.query('TargetAmount09').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('TargetAmount09').value('.', 'DECIMAL(28,8)') END) AS TargetAmount09,
	   X.Data.query('Target10ID').value('.', 'NVARCHAR(50)') AS Target10ID,
	   (CASE WHEN X.Data.query('TargetAmount10').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('TargetAmount10').value('.', 'DECIMAL(28,8)') END) AS TargetAmount10
FROM	@XML.nodes('//Data') AS X (Data)
ORDER BY [Row]
---- Kiểm tra check code mặc định
EXEC AP8106 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID, @SType = @SType
----- Kiểm tra và lưu dữ liệu bảng giá bán
EXEC AP8101 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @ColID = 'EmployeeID', @Param1 = 'DivisionID, EmployeeID', @SType = @SType
----- Kiểm tra EmployeeID đã tồn tại trong HT1400 (DivisionID, EmployeeID)
EXEC AP8101 @UserID = 'ASOFTADMIN', @ImportTemplateID = 'EmployeeFileID', @CheckCode = 'CheckValueInTableList', @ColID = 'EmployeeID', @Param1 = 'HT1400', @Param2 = 'EmployeeID', @SQLFilter = '', @SType = @SType 
-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage != '')
	GOTO LB_RESULT
---- Thông tin chỉ tiêu, chỉ số - HT1403 (kiểm tra nếu chưa có thì insert, đã có thì update)
SET @Cur = CURSOR SCROLL KEYSET FOR
		   SELECT Row, DivisionID, EmployeeID
		   FROM #Data
OPEN @Cur
FETCH NEXT FROM @Cur INTO @Row, @DivisionID, @EmployeeID
WHILE @@FETCH_STATUS = 0
BEGIN	
IF EXISTS (SELECT TOP 1 1 FROM HT1403 WHERE DivisionID = @DivisionID AND EmployeeID = @EmployeeID)
	BEGIN		
UPDATE HT1403 SET
	C01 = DT.C01,
	C02 = DT.C02,
	C03 = DT.C03,
	C04 = DT.C04,
	C05 = DT.C05,
	C06 = DT.C06,
	C07 = DT.C07,
	C08 = DT.C08,
	C09 = DT.C09,
	C10 = DT.C10,
	C11 = DT.C11,
	C12 = DT.C12,
	C13 = DT.C13,
	C14 = DT.C14,
	C15 = DT.C15,
	C16 = DT.C16,
	C17 = DT.C17,
	C18 = DT.C18,
	C19 = DT.C19,
	C20 = DT.C20,
	C21 = DT.C21,
	C22 = DT.C22,
	C23 = DT.C23,
	C24 = DT.C24,
	C25 = DT.C25,
	Target01ID = DT.Target01ID,
	TargetAmount01 = DT.TargetAmount01,
	Target02ID = DT.Target02ID,
	TargetAmount02 = DT.TargetAmount02,
	Target03ID = DT.Target03ID,
	TargetAmount03 = DT.TargetAmount03,
	Target04ID = DT.Target04ID,
	TargetAmount04 = DT.TargetAmount04,
	Target05ID = DT.Target05ID,
	TargetAmount05 = DT.TargetAmount05,
	Target06ID = DT.Target06ID,
	TargetAmount06 = DT.TargetAmount06,
	Target07ID = DT.Target07ID,
	TargetAmount07 = DT.TargetAmount07,
	Target08ID = DT.Target08ID,
	TargetAmount08 = DT.TargetAmount08,
	Target09ID = DT.Target09ID,
	TargetAmount09 = DT.TargetAmount09,
	Target10ID = DT.Target10ID,
	TargetAmount10 = DT.TargetAmount10
FROM HT1403 HT14
INNER JOIN #Data DT ON DT.DivisionID = HT14.DivisionID AND DT.EmployeeID = HT14.EmployeeID
WHERE DT.DivisionID = @DivisionID AND DT.EmployeeID = @EmployeeID		
	END 
	ELSE
	BEGIN 
INSERT INTO HT1403(DivisionID, EmployeeID, C01, C02, C03, C04, C05, C06, C07, C08, C09, C10, C11, C12, C13, C14, C15, C16, 
C17, C18, C19, C20, C21, C22, C23, C24, C25, Target01ID, TargetAmount01, Target02ID, TargetAmount02, Target03ID, TargetAmount03, 
Target04ID, TargetAmount04, Target05ID, TargetAmount05, Target06ID, TargetAmount06, Target07ID, TargetAmount07, Target08ID, 
TargetAmount08, Target09ID, TargetAmount09, Target10ID, TargetAmount10)
SELECT DivisionID, EmployeeID, C01, C02, C03, C04, C05, C06, C07, C08, C09, C10, C11, C12, C13, C14, C15, C16, C17, C18, 
	   C19, C20, C21, C22, C23, C24, C25, Target01ID, TargetAmount01, Target02ID, TargetAmount02, Target03ID, 
	   TargetAmount03, Target04ID, TargetAmount04, Target05ID, TargetAmount05, Target06ID, TargetAmount06, Target07ID, 
	   TargetAmount07, Target08ID, TargetAmount08, Target09ID, TargetAmount09, Target10ID, TargetAmount10
FROM #Data DT
WHERE DivisionID = @DivisionID AND EmployeeID = @EmployeeID
	END		
	FETCH NEXT FROM @Cur INTO @Row, @DivisionID, @EmployeeID
END
CLOSE @Cur
END

IF @SType = 7 -- Residential Information
BEGIN
INSERT INTO #Data([Row], DivisionID, EmployeeID, FromDate, ToDate, ResidentAddress, Notes)
SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
		X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
	   (CASE WHEN X.Data.query('FromDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('FromDate').value('.', 'DATETIME') END) AS FromDate,
	   (CASE WHEN X.Data.query('ToDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('ToDate').value('.', 'DATETIME') END) AS ToDate,
	    X.Data.query('ResidentAddress').value('.', 'NVARCHAR(250)') AS ResidentAddress,
	    X.Data.query('Notes').value('.', 'NVARCHAR(250)') AS Notes
FROM	@XML.nodes('//Data') AS X (Data)
ORDER BY [Row]
---- Kiểm tra check code mặc định
EXEC AP8106 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID, @SType = @SType
----- Kiểm tra và lưu dữ liệu bảng giá bán
EXEC AP8101 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @ColID = 'EmployeeID', @Param1 = 'DivisionID, 
EmployeeID, FromDate, ToDate, ResidentAddress', @SType = @SType 
----- Kiểm tra EmployeeID đã tồn tại trong HT1400 (DivisionID, EmployeeID)
EXEC AP8101 @UserID = 'ASOFTADMIN', @ImportTemplateID = 'EmployeeFileID', @CheckCode = 'CheckValueInTableList', @ColID = 'EmployeeID', @Param1 = 'HT1400', @Param2 = 'EmployeeID', @SQLFilter = '', @SType = @SType 
EXEC AP8101 @UserID = 'ASOFTADMIN', @ImportTemplateID = 'EmployeeFileID', @CheckCode = 'CheckValueExistsTableList', @ColID = 'EmployeeID', @Param1 = 'HT1412', @Param2 = 'EmployeeID', @SQLFilter = '', @SType = @SType 
-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage != '')
	GOTO LB_RESULT
---- Thông tin lưu trú HT1412
INSERT INTO HT1412(DivisionID, ResidentID, EmployeeID, FromDate, ToDate, ResidentAddress, Notes, CreateUserID,
            CreateDate, LastModifyUserID, LastModifyDate)
SELECT DivisionID, NEWID(), EmployeeID, FromDate, ToDate, ResidentAddress, Notes, @UserID, GETDATE(), @UserID, GETDATE()
FROM #Data DT
WHERE ISNULL(ResidentAddress,'') <> ''
END

IF @SType = 8 -- Additional Information
BEGIN
INSERT INTO #Data([Row], DivisionID, EmployeeID, D01, D02, D03, D04, D05, N01, N02, N03, N04, N05, N06, N07, N08, N09, N10)
SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
		X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
	   (CASE WHEN X.Data.query('D01').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('D01').value('.', 'DATETIME') END) AS D01,
	   (CASE WHEN X.Data.query('D02').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('D02').value('.', 'DATETIME') END) AS D02,
	   (CASE WHEN X.Data.query('D03').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('D03').value('.', 'DATETIME') END) AS D03,
	   (CASE WHEN X.Data.query('D04').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('D04').value('.', 'DATETIME') END) AS D04,
	   (CASE WHEN X.Data.query('D05').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('D05').value('.', 'DATETIME') END) AS D05,
	    X.Data.query('N01').value('.', 'NVARCHAR(250)') AS N01,
	    X.Data.query('N02').value('.', 'NVARCHAR(250)') AS N02,
	    X.Data.query('N03').value('.', 'NVARCHAR(250)') AS N03,
	    X.Data.query('N04').value('.', 'NVARCHAR(250)') AS N04,
	    X.Data.query('N05').value('.', 'NVARCHAR(250)') AS N05,
	    X.Data.query('N06').value('.', 'NVARCHAR(250)') AS N06,
	    X.Data.query('N07').value('.', 'NVARCHAR(250)') AS N07,
	    X.Data.query('N08').value('.', 'NVARCHAR(250)') AS N08,
	    X.Data.query('N09').value('.', 'NVARCHAR(250)') AS N09,
	    X.Data.query('N10').value('.', 'NVARCHAR(250)') AS N10
FROM	@XML.nodes('//Data') AS X (Data)
ORDER BY [Row]
---- Kiểm tra check code mặc định
EXEC AP8106 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID, @SType = @SType
----- Kiểm tra và lưu dữ liệu bảng giá bán
EXEC AP8101 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @ColID = 'EmployeeID', @Param1 = 'DivisionID, EmployeeID', @SType = @SType 
----- Kiểm tra EmployeeID đã tồn tại trong HT1400 (DivisionID, EmployeeID)
EXEC AP8101 @UserID = 'ASOFTADMIN', @ImportTemplateID = 'EmployeeFileID', @CheckCode = 'CheckValueInTableList', @ColID = 'EmployeeID', @Param1 = 'HT1400', @Param2 = 'EmployeeID', @SQLFilter = '', @SType = @SType 
EXEC AP8101 @UserID = 'ASOFTADMIN', @ImportTemplateID = 'EmployeeFileID', @CheckCode = 'CheckValueExistsTableList', @ColID = 'EmployeeID', @Param1 = 'HT1413', @Param2 = 'EmployeeID', @SQLFilter = '', @SType = @SType 
-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage != '')
	GOTO LB_RESULT
---- Thông tin bổ sung HT1413
INSERT INTO HT1413(DivisionID, EmployeeID, D01, D02, D03, D04, D05, N01, N02, N03, N04, N05, N06, N07, N08, N09, N10)
SELECT DivisionID, EmployeeID, D01, D02, D03, D04, D05, N01, N02, N03, N04, N05, N06, N07, N08, N09, N10
FROM #Data DT
END

--drop constraint 
SET @SQL = 'IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = ''#Keys'' AND xtype = ''U'')
			BEGIN
				IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = '''+@Keys_PK+''' AND xtype = ''PK'')
					ALTER TABLE #Keys DROP CONSTRAINT ' + @Keys_PK +'
			END
			IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = ''#Data'' AND xtype = ''U'')
			BEGIN
				IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = '''+@Data_PK+''' AND xtype = ''PK'')
					ALTER TABLE #Keys DROP CONSTRAINT ' + @Data_PK +'
			END
			'
EXEC(@SQL)



-----------------------------------------------------------------------------------------
LB_RESULT:
SELECT * FROM #Data

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
