IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP1032]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP1032]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Import Excel Hồ sơ ứng viên
-- <History>
---- Created by Bảo Thy on 27/07/2017
---- Modified by on
-- <Example>
/* 
 EXEC HRMP1032 @DivisionID = 'MK', @UserID = 'ASOFTADMIN', @ImportTransTypeID = 'EmployeeFileID', @XML = '',@SType = 1
 */
 
CREATE PROCEDURE HRMP1032
( 
	@DivisionID VARCHAR(50),
    @UserID VARCHAR(50),
	@ImportTransTypeID AS NVARCHAR(50),
    @XML XML,
	@SType INT =0
) 
AS
DECLARE @cCURSOR CURSOR,
        @sSQL NVARCHAR(MAX),
        @ColID VARCHAR(50), 
        @ColSQLDataType VARCHAR(50)
CREATE TABLE #Data
(
    [Row] INT,
    APK UNIQUEIDENTIFIER,
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
    EXEC (@sSQL)
    FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END
CLOSE @cCURSOR

IF @SType = 1 -- Thong tin ca nhan
BEGIN
SELECT  X.Data.query('OrderNo').value('.', 'INT') AS [Row],
        NEWID() AS APK,
        X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
        X.Data.query('CandidateID').value('.', 'NVARCHAR(50)') AS CandidateID,
			X.Data.query('LastName').value('.', 'NVARCHAR(250)') AS LastName,
			X.Data.query('MiddleName').value('.', 'NVARCHAR(250)') AS MiddleName,
			X.Data.query('FirstName').value('.', 'NVARCHAR(250)') AS FirstName,
		    X.Data.query('Gender').value('.', 'VARCHAR(5)') AS Gender,
			X.Data.query('Birthday').value('.', 'VARCHAR(50)') AS Birthday,
		    X.Data.query('BornPlace').value('.', 'NVARCHAR(1000)') AS BornPlace,
		    X.Data.query('NationalityID').value('.', 'VARCHAR(50)') AS NationalityID,
			X.Data.query('ReligionID').value('.', 'VARCHAR(50)') AS ReligionID,
			X.Data.query('NativeCountry').value('.', 'NVARCHAR(1000)') AS NativeCountry,
		    X.Data.query('IdentifyCardNo').value('.', 'NVARCHAR(50)') AS IdentifyCardNo,
			X.Data.query('IdentifyPlace').value('.', 'NVARCHAR(250)') AS IdentifyPlace,
			(CASE WHEN X.Data.query('IdentifyDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('IdentifyDate').value('.', 'VARCHAR(50)') END) AS IdentifyDate,
			(CASE WHEN X.Data.query('IsSingle').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('IsSingle').value('.', 'TINYINT') END) AS IsSingle,
			X.Data.query('HealthStatus').value('.', 'NVARCHAR(250)') AS HealthStatus,
			X.Data.query('Height').value('.', 'NVARCHAR(50)') AS Height,
			X.Data.query('Weight').value('.', 'NVARCHAR(50)') AS Weight,
			X.Data.query('PassportNo').value('.', 'NVARCHAR(50)') AS PassportNo,
			(CASE WHEN X.Data.query('PassportDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('PassportDate').value('.', 'VARCHAR(50)') END) AS PassportDate,
			(CASE WHEN X.Data.query('PassportEnd').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('PassportEnd').value('.', 'VARCHAR(50)') END) AS PassportEnd,
			X.Data.query('PermanentAddress').value('.', 'NVARCHAR(1000)') AS PermanentAddress,
			X.Data.query('TemporaryAddress').value('.', 'NVARCHAR(1000)') AS TemporaryAddress,
			X.Data.query('EthnicID').value('.', 'NVARCHAR(50)') AS EthnicID,
			X.Data.query('PhoneNumber').value('.', 'NVARCHAR(250)') AS PhoneNumber,
			X.Data.query('Email').value('.', 'NVARCHAR(250)') AS Email,
			X.Data.query('Fax').value('.', 'NVARCHAR(100)') AS Fax,
			X.Data.query('Note').value('.', 'NVARCHAR(250)') AS Note
INTO #HRMP1032
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data([Row], APK, DivisionID, CandidateID, LastName, MiddleName, FirstName, Gender, Birthday, BornPlace, NationalityID, ReligionID,
NativeCountry, IdentifyCardNo, IdentifyPlace, IdentifyDate, IsSingle, HealthStatus, Height, Weight, PassportNo, PassportDate,
PassportEnd, PermanentAddress, TemporaryAddress, EthnicID, PhoneNumber, Email, Fax, Note)
SELECT [Row], APK, DivisionID, CandidateID, LastName, MiddleName, FirstName, Gender, Birthday, BornPlace, NationalityID, ReligionID,
NativeCountry, IdentifyCardNo, IdentifyPlace, IdentifyDate, IsSingle, HealthStatus, Height, Weight, PassportNo, PassportDate,
PassportEnd, PermanentAddress, TemporaryAddress, EthnicID, PhoneNumber, Email, Fax, Note
FROM #HRMP1032

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---- Kiểm tra dữ liệu detail
DECLARE @ColumnName1 VARCHAR(50),
        @ColName1 NVARCHAR(50),
        @Cur CURSOR,
        @CampaignID VARCHAR(50)

SELECT TOP 1 @ColumnName1 = DataCol, @ColName1 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'CandidateID'

---- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
                UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
                                 ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
        WHERE ErrorMessage <> ''
        GOTO LB_RESULT
END

DECLARE 
        @TableBusiness VARCHAR(10) = 'HRMT1030',
        @VoucherNo VARCHAR(50),
        @NewVoucherNo VARCHAR(50),
        @KeyString VARCHAR(50),
        @LastKey INT

---- BEGIN - Xử lý tăng số chứng từ tự động

SELECT DISTINCT [Row], [Row] AS NewVoucherNo
INTO #VoucherData
FROM #HRMP1032
ORDER BY [Row]

WHILE EXISTS (SELECT TOP 1 1 FROM #VoucherData)
BEGIN
    SELECT @VoucherNo = [Row] FROM #VoucherData

    --EXEC GetVoucherNo_Ver1 @DivisionID, 'CRM', 'AT0002', 'S1', @TableBusiness, 'CD', @NewVoucherNo OUTPUT, @KeyString OUTPUT, @LastKey OUTPUT
	EXEC GetVoucherNo_Ver2 @DivisionID, 'HRM', 'HRMF1031', @TableBusiness, @NewVoucherNo OUTPUT, @KeyString OUTPUT, @LastKey OUTPUT
	PRINT @NewVoucherNo

    -- Cập nhật số chứng từ vào bảng dữ liệu import từ Excel
	UPDATE #HRMP1032 SET CandidateID = @NewVoucherNo WHERE [Row] = @VoucherNo

    -- Cập nhật LastKey cho bảng đăng ký số chứng từ tự động
    UPDATE AT4444 SET LastKey = @LastKey WHERE TableName = @TableBusiness AND KeyString = @KeyString

    DELETE #VoucherData WHERE [Row] = @VoucherNo
END

------ END - Xử lý tăng số chứng từ tự động

-- Insert dữ liệu vào bảng Hồ sơ ứng viên (HRMT1030)
INSERT INTO HRMT1030(APK, DivisionID, CandidateID, LastName, MiddleName, FirstName, Gender, Birthday, BornPlace, NationalityID, ReligionID,
NativeCountry, IdentifyCardNo, IdentifyPlace, IdentifyDate, IsSingle, HealthStatus, Height, Weight, PassportNo, PassportDate,
PassportEnd, PermanentAddress, TemporaryAddress, EthnicID, PhoneNumber, Email, Fax, Note, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT DISTINCT APK, DivisionID, CandidateID, LastName, MiddleName, FirstName, Gender, Birthday, BornPlace, NationalityID, ReligionID,
NativeCountry, IdentifyCardNo, IdentifyPlace, IdentifyDate, IsSingle, HealthStatus, Height, Weight, PassportNo, PassportDate,
PassportEnd, PermanentAddress, TemporaryAddress, EthnicID, PhoneNumber, Email, Fax, Note, @UserID, GETDATE(), @UserID, GETDATE()
FROM #HRMP1032
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
