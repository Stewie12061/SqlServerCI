IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP11504]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP11504]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Import Excel Danh mục Đối tượng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Hoài Bảo on 13/06/2022
---- Modified by Hoài Bảo on 22/07/2022 - Bổ sung import thêm cột S1,S2,S3,ObjectTypeID
---- Modified by Hoài Bảo on 25/10/2022 - Fix lỗi convert varchar to decimal
---- Modified by Hoài Bảo on 17/02/2023 - Bổ sung import cột Nhà phân phối
-- <Example>

CREATE PROCEDURE CIP11504
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
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
	ObjectID NVARCHAR(50),
	ObjectName NVARCHAR(250),
	S1 NVARCHAR(50),
	S2 NVARCHAR(50),
	S3 NVARCHAR(50),
	ObjectTypeID NVARCHAR(50),
	[Address] NVARCHAR(250),
	Tel NVARCHAR(100),
	VATNo NVARCHAR(50),
	Email NVARCHAR(MAX),
	Fax NVARCHAR(100),
	Website NVARCHAR(50),
	Contactor NVARCHAR(250),
	Phonenumber NVARCHAR(100),
	IsCustomer TINYINT,
	IsSupplier TINYINT,
	IsUpdateName TINYINT,
	IsDealer TINYINT,
	IsCommon TINYINT,
	[Disabled] TINYINT,
	IsRePayment TINYINT,
	ReCreditLimit DECIMAL(28,8),
	ReDueDays INT,
	IsLockedOver TINYINT,
	ReDays INT,
	DeAddress NVARCHAR(250),
	IsPaPayment TINYINT,
	PaCreditLimit DECIMAL(28,8),
	PaDueDays INT,
	PaDiscountDays INT,
	PaDiscountPercent DECIMAL(28,8),
	ReAddress NVARCHAR(250),
	BankName NVARCHAR(250),
	BankAccountNo NVARCHAR(50),
	LicenseNo NVARCHAR(50),
	LegalCapital DECIMAL(28,8),
	Note NVARCHAR(250),
	Note1 NVARCHAR(250)
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
		X.Data.query('OrderNo').value('.', 'INT') AS [Row],
		X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
		X.Data.query('ObjectID').value('.', 'NVARCHAR(50)') AS ObjectID,
		X.Data.query('ObjectName').value('.', 'NVARCHAR(250)') AS ObjectName,
		X.Data.query('S1').value('.', 'NVARCHAR(50)') AS S1,
		X.Data.query('S2').value('.', 'NVARCHAR(50)') AS S2,
		X.Data.query('S3').value('.', 'NVARCHAR(50)') AS S3,
		X.Data.query('ObjectTypeID').value('.', 'NVARCHAR(50)') AS ObjectTypeID,
		X.Data.query('Address').value('.','NVARCHAR(250)') AS [Address],
		X.Data.query('Tel').value('.','NVARCHAR(100)') AS Tel,
		X.Data.query('VATNo').value('.','NVARCHAR(50)') AS VATNo,
		X.Data.query('Email').value('.','NVARCHAR(MAX)') AS Email,
		X.Data.query('Fax').value('.','NVARCHAR(100)') AS Fax,
		X.Data.query('Website').value('.','NVARCHAR(50)') AS Website,
		X.Data.query('Contactor').value('.','NVARCHAR(250)') AS Contactor,
		X.Data.query('Phonenumber').value('.','NVARCHAR(100)') AS Phonenumber,
		X.Data.query('IsCustomer').value('.','TINYINT') AS IsCustomer,
		X.Data.query('IsSupplier').value('.','TINYINT') AS IsSupplier,
		X.Data.query('IsUpdateName').value('.','TINYINT') AS IsUpdateName,
		X.Data.query('IsDealer').value('.','TINYINT') AS IsDealer,
		X.Data.query('IsCommon').value('.','TINYINT') AS IsCommon,
		X.Data.query('Disabled').value('.','TINYINT') AS [Disabled],
		X.Data.query('IsRePayment').value('.','TINYINT') AS IsRePayment,
		ISNULL(TRY_CAST(X.Data.query('ReCreditLimit').value('.','VARCHAR(50)') AS DECIMAL(28,8)),.0) AS ReCreditLimit,
		X.Data.query('ReDueDays').value('.','INT') AS ReDueDays,
		X.Data.query('IsLockedOver').value('.','TINYINT') AS IsLockedOver,
		X.Data.query('ReDays').value('.','INT') AS ReDays,
		X.Data.query('DeAddress').value('.','NVARCHAR(250)') AS DeAddress,
		X.Data.query('IsPaPayment').value('.','TINYINT') AS IsPaPayment,
		ISNULL(TRY_CAST(X.Data.query('PaCreditLimit').value('.','VARCHAR(50)') AS DECIMAL(28,8)),.0) AS PaCreditLimit,
		X.Data.query('PaDueDays').value('.','INT') AS PaDueDays,
		X.Data.query('PaDiscountDays').value('.','INT') AS PaDiscountDays,
		ISNULL(TRY_CAST(X.Data.query('PaDiscountPercent').value('.','VARCHAR(50)') AS DECIMAL(28,8)),.0) AS PaDiscountPercent,
		X.Data.query('ReAddress').value('.','NVARCHAR(250)') AS ReAddress,
		X.Data.query('BankName').value('.','NVARCHAR(250)') AS BankName,
		X.Data.query('BankAccountNo').value('.','NVARCHAR(50)') AS BankAccountNo,
		X.Data.query('LicenseNo').value('.','NVARCHAR(50)') AS LicenseNo,
		ISNULL(TRY_CAST(X.Data.query('LegalCapital').value('.','VARCHAR(50)') AS DECIMAL(28,8)),.0) AS LegalCapital,
		X.Data.query('Note').value('.','NVARCHAR(250)') AS Note,
		X.Data.query('Note1').value('.','NVARCHAR(250)') AS Note1,
		IDENTITY(int,1,1) AS Orders
INTO #CIP11504
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row], Orders, DivisionID, ObjectID, ObjectName, S1, S2, S3, ObjectTypeID, [Address], Tel, VATNo, Email, Fax, Website, Contactor, Phonenumber, IsCustomer, IsSupplier, IsUpdateName, IsDealer, IsCommon, [Disabled],
				   IsRePayment, ReCreditLimit, ReDueDays, IsLockedOver, ReDays, DeAddress, IsPaPayment, PaCreditLimit, PaDueDays, PaDiscountDays, PaDiscountPercent, ReAddress, BankName, BankAccountNo,
				   LicenseNo, LegalCapital, Note, Note1)
SELECT [Row], Orders, DivisionID, ObjectID, ObjectName, S1, S2, S3, ObjectTypeID, [Address], Tel, VATNo, Email, Fax, Website, Contactor, Phonenumber, ISNULL(IsCustomer, 0), ISNULL(IsSupplier, 0), ISNULL(IsUpdateName, 0), ISNULL(IsDealer, 0), ISNULL(IsCommon, 0), ISNULL([Disabled], 0), ISNULL(IsRePayment, 0), ISNULL(ReCreditLimit, 0),
	   ISNULL(ReDueDays, 0), ISNULL(IsLockedOver, 0), ISNULL(ReDays, 0), DeAddress, ISNULL(IsPaPayment, 0), ISNULL(PaCreditLimit, 0), ISNULL(PaDueDays, 0), ISNULL(PaDiscountDays, 0), ISNULL(PaDiscountPercent, 0), ReAddress, BankName, BankAccountNo, LicenseNo, ISNULL(LegalCapital, 0), Note, Note1
FROM #CIP11504

-- Insert dữ liệu cho bảng tạm phần Master
INSERT INTO #DataM (DivisionID, ObjectID, ObjectName, S1, S2, S3, ObjectTypeID, [Address], Tel, VATNo, Email, Fax, Website, Contactor, Phonenumber, IsCustomer, IsSupplier, IsUpdateName, IsDealer, IsCommon, [Disabled],
				   IsRePayment, ReCreditLimit, ReDueDays, IsLockedOver, ReDays, DeAddress, IsPaPayment, PaCreditLimit, PaDueDays, PaDiscountDays, PaDiscountPercent, ReAddress, BankName, BankAccountNo,
				   LicenseNo, LegalCapital, Note, Note1)
SELECT DISTINCT CASE WHEN ISNULL(IsCommon, 0) = 0 THEN DivisionID ELSE '@@@' END, ObjectID, ObjectName, S1, S2, S3, ObjectTypeID, [Address], Tel, VATNo, Email, Fax, Website, Contactor, Phonenumber, ISNULL(IsCustomer, 0), ISNULL(IsSupplier, 0), ISNULL(IsUpdateName, 0), ISNULL(IsDealer, 0), ISNULL(IsCommon, 0), ISNULL([Disabled], 0), IsRePayment, ReCreditLimit,
	   ReDueDays, ISNULL(IsLockedOver, 0), ReDays, DeAddress, IsPaPayment, PaCreditLimit, PaDueDays, PaDiscountDays, PaDiscountPercent, ReAddress, BankName, BankAccountNo, LicenseNo, LegalCapital, Note, Note1
FROM #Data DT

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

-- Kiểm tra dữ liệu không đồng nhất tại Master
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @ColID = 'ObjectID',
@Param1 = 'DivisionID, ObjectName, [Address], Tel, VATNo, Email, Fax, Website, Contactor, Phonenumber, IsCustomer, IsSupplier, IsUpdateName, IsDealer, IsCommon, [Disabled], IsRePayment, ReCreditLimit, ReDueDays, IsLockedOver, ReDays, DeAddress, IsPaPayment, PaCreditLimit, PaDueDays, PaDiscountDays, PaDiscountPercent, ReAddress, BankName, BankAccountNo, LicenseNo, LegalCapital, Note, Note1'

-- Kiểm tra dữ liệu master
DECLARE @ColumnS1 VARCHAR(50),
		@ColumnS2 VARCHAR(50),
		@ColumnS3 VARCHAR(50),
		@sSQL1 NVARCHAR(MAX),
		@Cur CURSOR

-- Kiểm tra 3 cột phân loại ít nhất phải có 1 cột có giá trị
SET @Cur = CURSOR STATIC FOR
	SELECT TOP 1 S1, S2, S3
	FROM #CIP11504 WITH (NOLOCK)

OPEN @Cur

-- Tạo cấu trúc bảng tạm
FETCH NEXT FROM @Cur INTO @ColumnS1, @ColumnS2, @ColumnS3
WHILE @@FETCH_STATUS = 0
BEGIN
	IF (ISNULL(@ColumnS1, '') = '' AND ISNULL(@ColumnS2, '') = '' AND ISNULL(@ColumnS3, '') = '')
	BEGIN
		--SET @sSQL1 = 
		--'	UPDATE	#Data
		--	SET		ErrorMessage = ErrorMessage + ''C'' + LTRIM(RTRIM(STR([Row]))) +''-CIFML00094,'' + ''D'' + LTRIM(RTRIM(STR([Row]))) +''-CIFML00094,'' + ''E'' + LTRIM(RTRIM(STR([Row]))) +''-CIFML00094,'',
		--			ErrorColumn = ErrorColumn + ''S1,S2,S3'' +'','' '
		UPDATE	#Data
		SET		ErrorMessage = ErrorMessage + 'C' + LTRIM(RTRIM(STR([Row]))) +'-CIFML00094,' + 'D' + LTRIM(RTRIM(STR([Row]))) +'-CIFML00094,' + 'E' + LTRIM(RTRIM(STR([Row]))) +'-CIFML00094,',
				ErrorColumn = ErrorColumn + 'S1,S2,S3' +','
	END
	PRINT (@sSQL1)
	EXEC (@sSQL1)

	FETCH NEXT FROM @Cur INTO @ColumnS1, @ColumnS2, @ColumnS3
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
INSERT INTO AT1202(APK, DivisionID, ObjectID, ObjectName, S1, S2, S3, ObjectTypeID, [Address], Tel, VATNo, Email, Fax, Website, Contactor, Phonenumber, IsCustomer, IsSupplier, IsUpdateName, IsDealer, IsCommon, [Disabled],
				   ReCreditLimit, ReDueDays, IsLockedOver, ReDays, DeAddress, PaCreditLimit, PaDueDays, PaDiscountDays, PaDiscountPercent, ReAddress, BankName, BankAccountNo,
				   LicenseNo, LegalCapital, Note, Note1,  CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT DISTINCT APK, DivisionID, ObjectID, ObjectName, S1, S2, S3, ObjectTypeID, [Address], Tel, VATNo, Email, Fax, Website, Contactor, Phonenumber, IsCustomer, IsSupplier, IsUpdateName, IsDealer, IsCommon, [Disabled],
				ReCreditLimit, ReDueDays, IsLockedOver, ReDays, DeAddress, PaCreditLimit, PaDueDays, PaDiscountDays, PaDiscountPercent, ReAddress, BankName, BankAccountNo,
				LicenseNo, LegalCapital, Note, Note1, @UserID, GETDATE(), @UserID, GETDATE()
FROM #DataM DT
WHERE DT.ObjectID NOT IN (SELECT A02.ObjectID FROM AT1202 A02 WHERE A02.DivisionID = DT.DivisionID)


LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data
WHERE  ErrorColumn <> ''
ORDER BY [Row]


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO