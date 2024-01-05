IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP1001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP1001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO












-- <Summary>
---- Import Excel nghiệp vụ Liên hệ module CRM
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Trọng Kiên: + on 26/08/2020
----                        + on 08/09/2020: Bổ sung tính năng tăng mã tự động
---- Modified by on Đình Hoà : Lưu dữ liệu khách hàng khi import danh mục
---- Modified by Hoài Bảo on 06/09/2022: Cập nhật lấy mã chứng từ tự động theo version 2
-- <Example>

CREATE PROCEDURE CRMP1001
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
		X.Data.query('Prefix').value('.', 'VARCHAR(50)') AS Prefix,
		X.Data.query('FirstName').value('.', 'VARCHAR(50)') AS FirstName,
		X.Data.query('LastName').value('.', 'VARCHAR(50)') AS LastName,
        X.Data.query('ContactID').value('.', 'VARCHAR(50)') AS ContactID,
        X.Data.query('ContactName').value('.',N'NVARCHAR(50)') AS ContactName,
        X.Data.query('Address').value('.',N'NVARCHAR(250)') AS Address,
        X.Data.query('HomeMobile').value('.','VARCHAR(50)') AS HomeMobile,
        X.Data.query('HomeTel').value('.','VARCHAR(50)') AS HomeTel,
        X.Data.query('HomeFax').value('.','VARCHAR(50)') AS HomeFax,
        X.Data.query('HomeEmail').value('.','VARCHAR(50)') AS HomeEmail,
        X.Data.query('BusinessEmail').value('.','VARCHAR(50)') AS BusinessEmail,
        X.Data.query('BusinessTel').value('.','VARCHAR(50)') AS BusinessTel,
        X.Data.query('BusinessFax').value('.','VARCHAR(50)') AS BusinessFax,
        X.Data.query('Title').value('.','NVARCHAR(50)') AS Title,
        X.Data.query('DepartmentName').value('.','NVARCHAR(50)') AS DepartmentName,
		X.Data.query('AccountID').value('.','VARCHAR(MAX)') AS AccountID,
        X.Data.query('BirthDate').value('.','DATETIME') AS BirthDate,
        X.Data.query('Description').value('.',N'NVARCHAR(MAX)') AS Description,
        X.Data.query('IsCommon').value('.','INT') AS IsCommon
INTO #CRMP1001
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row], DivisionID, Prefix, FirstName, LastName, ContactID, ContactName, Address, HomeMobile, HomeTel, HomeFax, HomeEmail, BusinessEmail, BusinessTel, BusinessFax, Title, DepartmentName, AccountID, BirthDate, Description, IsCommon)

SELECT [Row], DivisionID, Prefix, FirstName, LastName, ContactID, ContactName, Address, HomeMobile, HomeTel, HomeFax, HomeEmail, BusinessEmail, BusinessTel, BusinessFax, Title, DepartmentName, AccountID, BirthDate, Description, IsCommon
FROM #CRMP1001

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---- Kiểm tra dữ liệu detail
DECLARE @ColumnName1 VARCHAR(50),
        @ColName1 NVARCHAR(50),
        @Cur CURSOR,
        @ContactID VARCHAR(50)

SELECT TOP 1 @ColumnName1 = DataCol, @ColName1 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ContactID'

---- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
        UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
                         ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
        WHERE ErrorMessage <> ''
        GOTO LB_RESULT
END

DECLARE 
        @TableBusiness VARCHAR(10) = 'CRMT10001',
        @VoucherNo VARCHAR(50),
        @NewVoucherNo VARCHAR(50),
        @KeyString VARCHAR(50),
        @LastKey INT,
		@Account VARCHAR(MAX)

---- BEGIN - Xử lý tăng số chứng từ tự động

SELECT DISTINCT [Row], [Row] AS NewVoucherNo
INTO #VoucherData
FROM #CRMP1001
ORDER BY [Row]

--Tạo bảng giả lưu khách hàng của liên hệ
Declare @CRMT10102_tmp table (DivisionID VARCHAR(50),
							  AccountID VARCHAR(50),
						      ContactID VARCHAR(50))

WHILE EXISTS (SELECT TOP 1 1 FROM #VoucherData)
BEGIN
     SELECT @VoucherNo = [Row] FROM #VoucherData

    --EXEC GetVoucherNo_Ver1 @DivisionID, 'CRM', 'AT0002', 'S1', @TableBusiness, 'LH', @NewVoucherNo OUTPUT, @KeyString OUTPUT, @LastKey OUTPUT
	EXEC GetVoucherNo_Ver2 @DivisionID, 'CRM', 'CRMF1001', @TableBusiness, @NewVoucherNo OUTPUT, @KeyString OUTPUT, @LastKey OUTPUT
	PRINT @NewVoucherNo

    -- Cập nhật số chứng từ vào bảng dữ liệu import từ Excel
    UPDATE #CRMP1001 SET ContactID = @NewVoucherNo WHERE [Row] = @VoucherNo

	-- Thêm dữ liệu khác hàng của Liên hệ vào bảng tạm
	SELECT @Account = AccountID FROM #CRMP1001 WHERE [Row] = @VoucherNo

	INSERT INTO @CRMT10102_tmp(AccountID,ContactID, DivisionID)
	SELECT T1.AccountID, T2.ContactID, T2.DivisionID
	FROM (SELECT TRIM(Value) AS AccountID
		  FROM StringSplit(@Account,',')) T1
		  CROSS JOIN
		  (SELECT DivisionID, ContactID FROM #CRMP1001 WHERE [Row] = @VoucherNo) T2

    -- Cập nhật LastKey cho bảng đăng ký số chứng từ tự động
    UPDATE AT4444 SET LastKey = @LastKey WHERE TableName = @TableBusiness AND KeyString = @KeyString

    DELETE #VoucherData WHERE [Row] = @VoucherNo
END

---- END - Xử lý tăng số chứng từ tự động

-- Insert dữ liệu vào bảng Liên hệ (CRMT10001)
INSERT INTO CRMT10001(DivisionID, Prefix, FirstName, LastName, ContactID, ContactName, Address, HomeMobile, HomeTel, HomeFax, HomeEmail, BusinessEmail, BusinessTel, BusinessFax, 
                      TitleContact, DepartmentName, BirthDate, Description, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT DISTINCT DivisionID, Prefix, FirstName, LastName, ContactID, ContactName, Address, HomeMobile, HomeTel, HomeFax, HomeEmail, BusinessEmail, BusinessTel, BusinessFax, 
                      Title, DepartmentName, BirthDate, Description, IsCommon, @UserID, GETDATE(), @UserID, GETDATE()
FROM #CRMP1001

-- Insert dữ liệu và bảng Liên hệ - Khách hàng
INSERT INTO CRMT10102(DivisionID,ContactID, AccountID, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT DivisionID, ContactID, AccountID,  @UserID, GETDATE(), @UserID, GETDATE()
FROM @CRMT10102_tmp

--DECLARE @StartInd INT,
--		@EndInd INT,
--		@SepratorInd INT



--SELECT @StartInd = LEN(S1), @EndInd = Length,
--@SepratorInd = CASE WHEN IsSeparator = 1 THEN LEN(Separator) ELSE 0 END 
--FROM AT0002 WITH(NOLOCK) WHERE DivisionID = @DivisionID AND TableID = 'CRMT10001'

--UPDATE AT4444 
--SET LastKey = (SELECT SUBSTRING(MAX(ContactID), (@StartInd + @SepratorInd + 1), (@EndInd - (@StartInd +@SepratorInd))) FROM CRMT10001)
--WHERE TableName = 'CRMT10001' AND KEYSTRING = 'LH' 	

LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data
WHERE  ErrorColumn <> ''
ORDER BY [Row]












GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
