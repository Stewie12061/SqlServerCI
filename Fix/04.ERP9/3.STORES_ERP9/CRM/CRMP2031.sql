IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2031]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2031]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Import Excel nghiệp vụ Đầu mối module CRM
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Đình Ly on 10/03/2020
---- Modified by Trọng Kiên 08/09/2020: Bổ sung tính năng tăng mã tự động
---- Modified by ĐÌnh hòa 23/12/2020: Bổ sung lưu chi tiết khi import đầu mối(CBD)
---- Modified by ĐÌnh Hòa 19/03/2020: Bổ sung kiểm tra chứng từ trong data(CBD)
---- Modified by Hoài Bảo 06/09/2022: Cập nhật lấy mã chứng từ tự động theo version 2
-- <Example>

CREATE PROCEDURE CRMP2031
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


SELECT  X.Data.query('OrderNo').value('.', 'INT') AS [Row],
        X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
        X.Data.query('LeadID').value('.','VARCHAR(50)') AS LeadID,
        X.Data.query('CampaignID').value('.','VARCHAR(50)') AS CampaignID,
        X.Data.query('LeadName').value('.','NVARCHAR(250)') AS LeadName,
        X.Data.query('LeadTypeID').value('.','VARCHAR(50)') AS LeadTypeID,
        X.Data.query('AssignedToUserID').value('.','VARCHAR(50)') AS AssignedToUserID,
        X.Data.query('Address').value('.','NVARCHAR(250)') AS Address,
        X.Data.query('LeadMobile').value('.','VARCHAR(50)') AS LeadMobile,
        X.Data.query('LeadTel').value('.','VARCHAR(50)') AS LeadTel,
        X.Data.query('Email').value('.','VARCHAR(50)') AS Email,
        X.Data.query('JobID').value('.','NVARCHAR(100)') AS JobID,
        X.Data.query('TitleID').value('.','NVARCHAR(50)') AS TitleID,
        X.Data.query('LeadStatusID').value('.','VARCHAR(50)') AS LeadStatusID,
        X.Data.query('CompanyName').value('.','NVARCHAR(250)') AS CompanyName,
        X.Data.query('BirthDate').value('.','VARCHAR(50)') AS BirthDate,
        X.Data.query('Hobbies').value('.','NVARCHAR(250)') AS Hobbies,
        X.Data.query('Website').value('.','VARCHAR(50)') AS Website,
        X.Data.query('Description').value('.','NVARCHAR(250)') AS Description,
        X.Data.query('IsCommon').value('.','INT') AS IsCommon,
		X.Data.query('Prefix').value('.','NVARCHAR(50)') AS Prefix,
		X.Data.query('TradeMarkID').value('.','VARCHAR(50)') AS TradeMarkID,
		X.Data.query('GenderID').value('.','INT') AS GenderID,
		X.Data.query('PlaceOfBirth').value('.','NVARCHAR(255)') AS PlaceOfBirth,
		X.Data.query('MaritalStatusID').value('.','INT') AS MaritalStatusID,
		X.Data.query('BankAccountNo01').value('.','NVARCHAR(100)') AS BankAccountNo01,
		X.Data.query('BankIssueName01').value('.','NVARCHAR(250)') AS BankIssueName01,
		X.Data.query('NotesPrivate').value('.','NVARCHAR(MAX)') AS NotesPrivate,
		X.Data.query('CompanyDate').value('.','VARCHAR(50)') AS CompanyDate,
		X.Data.query('BusinessMobile').value('.','NVARCHAR(50)') AS BusinessMobile,
		X.Data.query('BusinessFax').value('.','NVARCHAR(50)') AS BusinessFax,
		X.Data.query('NotesCompany').value('.','NVARCHAR(250)') AS NotesCompany,
		X.Data.query('NumOfEmployee').value('.','VARCHAR(25)') AS NumOfEmployee,
		X.Data.query('EnterpriseDefinedID').value('.','VARCHAR(25)') AS EnterpriseDefinedID,
		X.Data.query('VATCode').value('.','VARCHAR(25)') AS VATCode,
		X.Data.query('BusinessEmail').value('.','NVARCHAR(100)') AS BusinessEmail,
		X.Data.query('BusinessAddress').value('.','NVARCHAR(250)') AS BusinessAddress
INTO #CRMP2031
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row], DivisionID, LeadID, CampaignID, LeadName, LeadTypeID, AssignedToUserID, Address, LeadMobile, LeadTel, Email, JobID, TitleID, LeadStatusID, CompanyName, BirthDate, Hobbies, Website, Description, IsCommon
,Prefix, TradeMarkID, GenderID, PlaceOfBirth, MaritalStatusID, BankAccountNo01, BankIssueName01, NotesPrivate, CompanyDate, BusinessMobile, BusinessFax, NotesCompany, NumOfEmployee, EnterpriseDefinedID, VATCode, BusinessEmail, BusinessAddress)
SELECT [Row], DivisionID, LeadID, CampaignID, LeadName, LeadTypeID, AssignedToUserID, Address, LeadMobile, LeadTel, Email, JobID, TitleID, LeadStatusID, CompanyName, BirthDate, Hobbies, Website, Description, IsCommon
,Prefix, TradeMarkID, GenderID, PlaceOfBirth, MaritalStatusID, BankAccountNo01, BankIssueName01, NotesPrivate, CompanyDate, BusinessMobile, BusinessFax, NotesCompany, NumOfEmployee, EnterpriseDefinedID, VATCode, BusinessEmail, BusinessAddress
FROM #CRMP2031

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---- Kiểm tra dữ liệu detail
DECLARE @ColumnName1 VARCHAR(50),
        @ColName1 NVARCHAR(50),
        @Cur CURSOR,
        @LeadID VARCHAR(50)

SELECT TOP 1 @ColumnName1 = DataCol, @ColName1 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'LeadID'


---- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
        UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
                         ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
        WHERE ErrorMessage <> ''
        GOTO LB_RESULT
END

DECLARE 
        @TableBusiness VARCHAR(10) = 'CRMT20301',
        @VoucherNo VARCHAR(50),
        @NewVoucherNo VARCHAR(50),
        @KeyString VARCHAR(50),
        @LastKey INT,
		@ColumnSetting VARCHAR(50),
		@APKMaster VARCHAR(50)

---- BEGIN - Xử lý tăng số chứng từ tự động

SELECT DISTINCT [Row], [Row] AS NewVoucherNo
INTO #VoucherData
FROM #CRMP2031
ORDER BY [Row]

--SET  @ColumnSetting = (SELECT  S1 FROM AT0002 WHERE TableID ='CRMT20301' AND TypeID = 'LEA' AND DivisionID = @DivisionID)

WHILE EXISTS (SELECT TOP 1 1 FROM #VoucherData)
BEGIN
    SELECT @VoucherNo = [Row] FROM #VoucherData

    --EXEC GetVoucherNo_Ver1 @DivisionID, 'CRM', 'AT0002', 'S1', @TableBusiness, @ColumnSetting, @NewVoucherNo OUTPUT, @KeyString OUTPUT, @LastKey OUTPUT
	EXEC GetVoucherNo_Ver2 @DivisionID, 'CRM', 'CRMF2031', @TableBusiness, @NewVoucherNo OUTPUT, @KeyString OUTPUT, @LastKey OUTPUT
	PRINT @NewVoucherNo

	-- [Đình Hòa] - 19/03/2021 - START EDIT
	-- Kiểm tra đã tồn tại VoucherNo trong data 
	IF NOT EXISTS(SELECT TOP 1 1 FROM CRMT20301 WITH (NOLOCK) WHERE LeadID = @NewVoucherNo)
	BEGIN
		-- Cập nhật số chứng từ vào bảng dữ liệu import từ Excel
		UPDATE #CRMP2031 SET LeadID = @NewVoucherNo WHERE [Row] = @VoucherNo
		
		DELETE #VoucherData WHERE [Row] = @VoucherNo
	END
	-- [Đình Hòa] - 19/03/2021 - END EDIT

	-- Cập nhật LastKey cho bảng đăng ký số chứng từ tự động
	UPDATE AT4444 SET LastKey = @LastKey WHERE TableName = @TableBusiness AND KeyString = @KeyString
END
---- END - Xử lý tăng số chứng từ tự động

IF EXISTS(SELECT TOP 1 CustomerName FROM CustomerIndex WHERE CustomerName = 130)
	BEGIN
		-- Thêm APK để lưu Detail
		SELECT NEWID() AS APK, DivisionID, LeadID, CampaignID, LeadName, LeadTypeID, AssignedToUserID, Address, LeadMobile, LeadTel, Email, JobID, TitleID,
			   LeadStatusID, CompanyName, BirthDate, Hobbies, Website, Description, IsCommon ,Prefix, TradeMarkID, GenderID, PlaceOfBirth, MaritalStatusID, 
			   BankAccountNo01, BankIssueName01, NotesPrivate, CompanyDate, BusinessMobile, BusinessFax, NotesCompany, NumOfEmployee, EnterpriseDefinedID
			  , VATCode, BusinessEmail, BusinessAddress
		INTO #CRMT2031_Tmp
		FROM #CRMP2031

		-- Insert dữ liệu vào bảng Đầu mối (CRMT20301)
		INSERT INTO CRMT20301(APK, DivisionID, LeadID, LeadName, LeadTypeID, AssignedToUserID, Address, LeadMobile, LeadTel, Email, JobID, TitleID, LeadStatusID,
							  CompanyName, BirthDate, Hobbies, Website, Description, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate
							  , Prefix, TradeMarkID, GenderID, PlaceOfBirth, MaritalStatusID,  BankAccountNo01, BankIssueName01, NotesPrivate, CompanyDate, BusinessMobile
							  , BusinessFax, NotesCompany, NumOfEmployee, EnterpriseDefinedID, VATCode, BusinessEmail, BusinessAddress)
		SELECT APK, DivisionID, LeadID, LeadName, LeadTypeID, AssignedToUserID, Address, LeadMobile, LeadTel, Email, JobID, TitleID, LeadStatusID,
							  CompanyName, BirthDate, Hobbies, Website, Description, IsCommon, @UserID, GETDATE(), @UserID, GETDATE()
							  , Prefix, TradeMarkID, GenderID, PlaceOfBirth, MaritalStatusID,  BankAccountNo01, BankIssueName01, NotesPrivate, CompanyDate, BusinessMobile
							  , BusinessFax, NotesCompany, NumOfEmployee, EnterpriseDefinedID, VATCode, BusinessEmail, BusinessAddress
		FROM #CRMT2031_Tmp

		INSERT INTO CRMT20302(APKMaster, CampaignDetailID, StatusDetailID)
		SELECT DISTINCT APK, CampaignID, LeadStatusID
		FROM #CRMT2031_Tmp

	END
ELSE
	BEGIN
		-- Insert dữ liệu vào bảng Đầu mối (CRMT20301)
		INSERT INTO CRMT20301(DivisionID, LeadID, CampaignID, LeadName, LeadTypeID, AssignedToUserID, Address, LeadMobile, LeadTel, Email, JobID, TitleID, 
							  LeadStatusID, CompanyName, BirthDate, Hobbies, Website, Description, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate
							  , Prefix, TradeMarkID, GenderID, PlaceOfBirth, MaritalStatusID,  BankAccountNo01, BankIssueName01, NotesPrivate, CompanyDate, BusinessMobile
							  , BusinessFax, NotesCompany, NumOfEmployee, EnterpriseDefinedID, VATCode, BusinessEmail, BusinessAddress)
		SELECT DISTINCT DivisionID, LeadID, CampaignID, LeadName, LeadTypeID, AssignedToUserID, Address, LeadMobile, LeadTel, Email, JobID, TitleID, 
							  LeadStatusID, CompanyName, BirthDate, Hobbies, Website, Description, IsCommon, @UserID, GETDATE(), @UserID, GETDATE()
							  , Prefix, TradeMarkID, GenderID, PlaceOfBirth, MaritalStatusID,  BankAccountNo01, BankIssueName01, NotesPrivate, CompanyDate, BusinessMobile
							  , BusinessFax, NotesCompany, NumOfEmployee, EnterpriseDefinedID, VATCode, BusinessEmail, BusinessAddress
		FROM #CRMP2031
	END
--UPDATE AT4444 
--SET LastKey = (SELECT SUBSTRING(MAX(LeadID), 4, 8) FROM CRMT20301)
--WHERE TableName = 'CRMT20301' AND KEYSTRING = 'DM' 	

LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data
WHERE  ErrorColumn <> ''
ORDER BY [Row]

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
