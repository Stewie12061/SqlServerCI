IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP20001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP20001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Import dữ liệu Excel nghiệp vụ Đề nghị thanh toán 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Đình Ly on 02/06/2020
---- Modified by Vĩnh Tâm on 09/06/2020
---- Modified by Vĩnh Tâm on 31/07/2020: + Thay đổi cách kiểm tra tồn tại MPT Bộ phận
----									 + Bỏ kiểm tra lỗi trùng cặp số RingiNo và Số hóa đơn tại detail của file
----									 + Xử lý SUM số tiền của các dòng dữ liệu có cùng cặp số RingiNo và Số hóa đơn (bao gồm trường hợp số RingiNo rỗng)
----									 + Kiểm tra Ngày chứng từ có khớp với Kỳ kế toán hay không
---- Modified by Vĩnh Tâm on 17/11/2020: + Custom MEIKO: Bổ sung check Loại đề nghị là DNTT
----									 + Fix lỗi không bắt buộc nhập Phòng ban nhưng vẫn kiểm tra tồn tại và báo lỗi
----									 + Insert bảng OOT9004 cho trường hợp các phiếu import được duyệt cấp 1
---- Modified by Vĩnh Tâm on 03/02/2021: Bổ sung cột Tỉ giá thanh toán, lưu giá trị vào cột ExchangeRate của bảng BEMT2001
-- <Example>

CREATE PROCEDURE BEMP20001
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
	TranMonth INT,
	TranYear INT,
	ExchangeRate DECIMAL(28, 8),
	APKMaster_9000 VARCHAR(50),
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
	SET @sSQL = 'ALTER TABLE #Data ADD ' + @ColID + ' ' + @ColSQLDataType + CASE WHEN @ColSQLDataType LIKE '%CHAR%' THEN ' COLLATE SQL_Latin1_General_CP1_CI_AS' ELSE '' END + ' NULL'
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END
CLOSE @cCURSOR

SELECT  X.Data.query('OrderNo').value('.', 'INT') AS [Row],
		X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
		X.Data.query('Period').value('.', 'VARCHAR(50)') AS Period,
		CONVERT(INT,LEFT(X.Data.query('Period').value('.','VARCHAR(50)'),2)) AS TranMonth,
		CONVERT(INT,RIGHT(X.Data.query('Period').value('.','VARCHAR(50)'),4)) AS TranYear,
		X.Data.query('ID').value('.', 'VARCHAR(50)') AS ID,
		X.Data.query('TypeID').value('.','VARCHAR(50)') AS TypeID,
		X.Data.query('VoucherDate').value('.','VARCHAR(50)') AS VoucherDate,
		X.Data.query('DepartmentID').value('.','VARCHAR(50)') AS DepartmentID,
		X.Data.query('PhoneNumber').value('.','VARCHAR(50)') AS PhoneNumber,
		X.Data.query('ApplicantID').value('.','VARCHAR(50)') AS ApplicantID,
		X.Data.query('MethodPay').value('.','VARCHAR(50)') AS MethodPay,
		X.Data.query('AdvanceUserID').value('.','VARCHAR(50)') AS AdvanceUserID,
		X.Data.query('PaymentTermID').value('.','VARCHAR(50)') AS PaymentTermID,
		X.Data.query('Deadline').value('.','VARCHAR(50)') AS Deadline,
		X.Data.query('FCT').value('.','VARCHAR(10)') AS FCT,
		X.Data.query('ApproveStatus01').value('.','VARCHAR(50)') AS ApproveStatus01,
		X.Data.query('ApprovePerson01').value('.','VARCHAR(50)') AS ApprovePerson01,
		X.Data.query('ApprovePerson02').value('.','VARCHAR(50)') AS ApprovePerson02,
		X.Data.query('CostAnaID').value('.','VARCHAR(50)') AS CostAnaID,
		X.Data.query('DepartmentAnaID').value('.','VARCHAR(50)') AS DepartmentAnaID,
		X.Data.query('Description').value('.','NVARCHAR(MAX)') AS Description,
		X.Data.query('RingiNo').value('.','VARCHAR(50)') AS RingiNo,
		X.Data.query('InvoiceNo').value('.','VARCHAR(50)') AS InvoiceNo,
		X.Data.query('InvoiceDate').value('.','VARCHAR(50)') AS InvoiceDate,
		X.Data.query('RequestAmount').value('.','VARCHAR(50)') AS RequestAmount,
		X.Data.query('CurrencyID').value('.','VARCHAR(50)') AS CurrencyID,
		X.Data.query('PaymentExchangeRate').value('.','VARCHAR(50)') AS PaymentExchangeRate,
		X.Data.query('BankAccountID').value('.','VARCHAR(50)') AS BankAccountID,
		X.Data.query('BankAccountName').value('.','NVARCHAR(250)') AS BankAccountName
INTO #BEMP20001
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row], DivisionID, Period, TranMonth, TranYear, ID, TypeID, VoucherDate, DepartmentID, PhoneNumber, ApplicantID, MethodPay, AdvanceUserID, PaymentTermID, Deadline,
	FCT, ApproveStatus01, ApprovePerson01, ApprovePerson02, CostAnaID, DepartmentAnaID, Description, RingiNo, InvoiceNo, InvoiceDate, RequestAmount, CurrencyID, PaymentExchangeRate, BankAccountID, BankAccountName)
SELECT [Row], DivisionID, Period, TranMonth, TranYear, ID, TypeID, IIF(ISNULL(VoucherDate, '') != '', CONVERT(DATETIME, VoucherDate, 103), NULL), DepartmentID, PhoneNumber, ApplicantID, MethodPay, AdvanceUserID, PaymentTermID, IIF(ISNULL(Deadline, '') != '', CONVERT(DATETIME, Deadline, 103), NULL),
	IIF(ISNULL(FCT, '') != '', CONVERT(INT, FCT), NULL), ApproveStatus01, ApprovePerson01, ApprovePerson02, CostAnaID, DepartmentAnaID, Description, RingiNo, InvoiceNo, IIF(ISNULL(InvoiceDate, '') != '', CONVERT(DATETIME, InvoiceDate, 103), NULL),
	IIF(ISNULL(RequestAmount, '') != '', CONVERT(DECIMAL(28,8), RequestAmount), NULL), CurrencyID, IIF(ISNULL(RequestAmount, '') != '', CONVERT(DECIMAL(28,8), PaymentExchangeRate), NULL), BankAccountID, BankAccountName
FROM #BEMP20001

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

------ Kiểm tra dữ liệu không đồng nhất ở Master
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckIdenticalValues', @Module = 'ASOFT-BEM', @ColID = 'ID',
@Param1 = 'ID, TypeID, VoucherDate, DepartmentID, PhoneNumber, ApplicantID, MethodPay, AdvanceUserID, PaymentTermID, Deadline, FCT, ApproveStatus01, ApprovePerson01, ApprovePerson02, CurrencyID'

------ Kiểm tra dữ liệu không đồng nhất ở Details
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckIdenticalValues', @Module = 'ASOFT-BEM', @ColID = 'RingiNo, InvoiceNo',
@Param1 = 'CostAnaID, DepartmentAnaID, Description, RingiNo, InvoiceNo, InvoiceDate, RequestAmount, BankAccountID, BankAccountName'

---- Kiểm tra dữ liệu detail
DECLARE @DataCol1 VARCHAR(50),
		@ColID1 NVARCHAR(50),
		@DataCol2 VARCHAR(50),
		@ColID2 NVARCHAR(50),
		@DataCol3 VARCHAR(50),
		@ColID3 NVARCHAR(50),
		@DataCol4 VARCHAR(50),
		@ColID4 NVARCHAR(50),
		@Cur CURSOR,
		@RowColumn VARCHAR(10),
		@TypeID VARCHAR(50),
		@DepartmentID VARCHAR(50),
		@RingiNo VARCHAR(50),
		@InvoiceNo VARCHAR(50),
		@CustomerIndex INT

-- Lấy CustomerIndex của khách hàng hiện tại
SELECT @CustomerIndex = CustomerName
FROM CustomerIndex

SELECT TOP 1 @DataCol1 = DataCol, @ColID1 = ColID
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'RingiNo'

SELECT TOP 1 @DataCol2 = DataCol, @ColID2 = ColID
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'InvoiceNo'

SELECT TOP 1 @DataCol3 = DataCol, @ColID3 = ColID
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'DepartmentID'

SELECT TOP 1 @DataCol4 = DataCol, @ColID4 = ColID
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'TypeID'

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT [Row], TypeID, DepartmentID, RingiNo, InvoiceNo FROM #Data

OPEN @Cur
FETCH NEXT FROM @Cur INTO @RowColumn, @TypeID, @DepartmentID, @RingiNo, @InvoiceNo
WHILE @@FETCH_STATUS = 0
BEGIN

	-- 1. Kiểm tra Bộ phận có tồn tại trong MPT Bộ phận hay không
	IF ISNULL(@DepartmentID, '') != '' AND NOT EXISTS(SELECT TOP 1 1 FROM AT1011 AS A1 WITH (NOLOCK)
					INNER JOIN BEMT0000 B1 WITH (NOLOCK) ON A1.DivisionID = B1.DivisionID AND A1.AnaTypeID = B1.SubsectionAnaID
				WHERE A1.DivisionID = @DivisionID AND A1.AnaID = @DepartmentID)
	BEGIN
		UPDATE #Data
		SET	ErrorMessage = CONCAT(ErrorMessage, @DataCol3, LTRIM(RTRIM(STR([Row]))), '-00ML000152,'),
				ErrorColumn = CONCAT(ErrorColumn, @ColID3, ',')
		WHERE [Row] = @RowColumn
	END

	-- 2.Kiểm tra tồn tại cặp mã RingiNo và InvoiceNo trong bảng BEMT2001
	IF  EXISTS(SELECT TOP 1 1 FROM BEMT2001 WITH (NOLOCK) WHERE RingiNo = @RingiNo AND InvoiceNo = @InvoiceNo)
	BEGIN
		UPDATE #Data 
		SET	ErrorMessage =  CONCAT(ErrorMessage, @DataCol1, LTRIM(RTRIM(STR([Row]))), ' và ', @DataCol2, LTRIM(RTRIM(STR([Row]))), '-SFML000077,'),
				ErrorColumn = CONCAT(ErrorColumn, @ColID1, ',', @ColID2, ',')
		WHERE [Row] = @RowColumn
	END

	-- Customize MEIKO: Chỉ được import phiếu DNTT
	IF @CustomerIndex = 50 AND @TypeID != 'DNTT'
	BEGIN
		UPDATE #Data
		-- Giá trị không hợp lệ
		SET	ErrorMessage = CONCAT(ErrorMessage, @DataCol4, LTRIM(RTRIM(STR([Row]))), '-00ML000151,'),
				ErrorColumn = CONCAT(ErrorColumn, @ColID4, ',')
		WHERE [Row] = @RowColumn
	END
	
	FETCH NEXT FROM @Cur INTO @RowColumn, @TypeID, @DepartmentID, @RingiNo, @InvoiceNo
END

CLOSE @Cur

---- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
		UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
							ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
		WHERE ErrorMessage <> ''
		GOTO LB_RESULT
END

DECLARE @Level INT = 2,
		@TableBusiness VARCHAR(10) = 'BEMT2000',
		@VoucherNo VARCHAR(50),
		@NewVoucherNo VARCHAR(50),
		@KeyString VARCHAR(50),
		@LastKey INT,
		@APKMaster_9000 VARCHAR(50),
		@APKMaster_9001 VARCHAR(50)

---- Xử lý GROUP BY các dữ liệu detail có cùng cặp số RingiNo và Số hóa đơn
SELECT ROW_NUMBER() OVER (ORDER BY ID) AS [Row], NEWID() AS APK, DivisionID, Period, TranMonth, TranYear, ID, TypeID, VoucherDate, DepartmentID, PhoneNumber, ApplicantID, MethodPay, AdvanceUserID, PaymentTermID, Deadline,
	FCT, IIF(ApproveStatus01 = 1 OR ApproveStatus01 = 2, ApproveStatus01, 0) AS ApproveStatus01, ApprovePerson01, ApprovePerson02, CostAnaID, DepartmentAnaID, Description, RingiNo, InvoiceNo, InvoiceDate, SUM(RequestAmount) AS RequestAmount, CurrencyID, PaymentExchangeRate, BankAccountID, BankAccountName,
	NULL AS Orders, NULL AS ExchangeRate, CONVERT(VARCHAR(50), NULL) AS APKMaster_9000, NULL AS ErrorMessage, NULL AS ErrorColumn
INTO #DataGroupBy
FROM #Data
GROUP BY DivisionID, Period, TranMonth, TranYear, ID, TypeID, VoucherDate, DepartmentID, PhoneNumber, ApplicantID, MethodPay, AdvanceUserID, PaymentTermID, Deadline,
	FCT, ApproveStatus01, ApprovePerson01, ApprovePerson02, CostAnaID, DepartmentAnaID, Description, RingiNo, InvoiceNo, InvoiceDate, CurrencyID, PaymentExchangeRate, BankAccountID, BankAccountName

---- BEGIN - Xử lý tăng số chứng từ tự động và đăng ký dữ liệu xét duyệt

SELECT DISTINCT ID, ID AS NewVoucherNo
INTO #VoucherData
FROM #DataGroupBy
ORDER BY ID

WHILE EXISTS (SELECT TOP 1 1 FROM #VoucherData)
BEGIN
	SELECT @VoucherNo = ID FROM #VoucherData
	-- Tạo APKMaster_9000 mới cho phiếu DNTT
	SET @APKMaster_9000 = NEWID()
	SET @APKMaster_9001 = NEWID()
	
	EXEC GetVoucherNo @DivisionID, 'BEM', 'BEMT0000', 'ProposalVoucher', @TableBusiness, @NewVoucherNo OUTPUT, @KeyString OUTPUT, @LastKey OUTPUT
	-- Cập nhật số chứng từ vào bảng dữ liệu import từ Excel
	UPDATE #DataGroupBy SET ID = @NewVoucherNo, APKMaster_9000 = @APKMaster_9000 WHERE ID = @VoucherNo
	-- Cập nhật LastKey cho bảng đăng ký số chứng từ tự động
	UPDATE AT4444 SET LastKey = @LastKey WHERE TableName = @TableBusiness AND KeyString = @KeyString

	-- Insert dữ liệu xét duyệt

	INSERT INTO OOT9000(APK, DivisionID, TranMonth, TranYear, ID, Type, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
	SELECT DISTINCT @APKMaster_9000, @DivisionID, TranMonth, TranYear, ID, 'PDN', GETDATE(), @UserID, GETDATE(), @UserID
	FROM #DataGroupBy
	WHERE ID = @NewVoucherNo

	-- Phiếu duyệt cấp 1
	INSERT INTO OOT9001(APK, DivisionID, APKMaster, ApprovePersonID, Level, Status)
	SELECT DISTINCT @APKMaster_9001, @DivisionID, @APKMaster_9000, ApprovePerson01, 1, ApproveStatus01
	FROM #DataGroupBy
	WHERE ID = @NewVoucherNo

	---- Trường hợp phiếu được duyệt cấp 1 thì insert dữ liệu OOT9004 để đánh dấu duyệt cho detail
	INSERT INTO OOT9004(APKDetail, APK9001, DivisionID, ApprovePersonID, Level, Status, ApprovalDate)
	SELECT DISTINCT APK, @APKMaster_9001, @DivisionID, ApprovePerson01, 1, ApproveStatus01, GETDATE()
	FROM #DataGroupBy
	WHERE ID = @NewVoucherNo AND ApproveStatus01 = 1

	-- Phiếu duyệt cấp 2
	INSERT INTO OOT9001(DivisionID, APKMaster, ApprovePersonID, Level, Status)
	SELECT DISTINCT @DivisionID, @APKMaster_9000, ApprovePerson02, 2, 0
	FROM #DataGroupBy
	WHERE ID = @NewVoucherNo

	DELETE #VoucherData WHERE ID = @VoucherNo
END

---- END - Xử lý tăng số chứng từ tự động

CREATE TABLE #ExchangeData (CurrencyID VARCHAR(50), CurrencyName NVARCHAR(250), ExchangeRate DECIMAL(28, 8))
INSERT INTO #ExchangeData
EXEC BEMP2017 @DivisionID

-- Insert dữ liệu vào bảng master BEMT2000
INSERT INTO BEMT2000(DivisionID, TranMonth, TranYear, VoucherNo, VoucherDate, InheritType, TypeID, DepartmentID, PhoneNumber, ApplicantID, MethodPay, AdvanceUserID, DueDate,
		PaymentTermID, Deadline, FCT, CurrencyID, ExchangeRate, Status, Levels, ApprovingLevel, ApproveLevel, APKMaster_9000, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT DISTINCT DivisionID, TranMonth, TranYear, ID, VoucherDate, 'KOUBAI', TypeID, DepartmentID, PhoneNumber, ApplicantID, MethodPay, AdvanceUserID, GETDATE(),
		PaymentTermID, Deadline, FCT, T1.CurrencyID, T2.ExchangeRate, 0 AS Status, @Level AS Levels, IIF(ApproveStatus01 = 1, ApproveStatus01, 0) AS ApprovingLevel, @Level AS ApproveLevel, APKMaster_9000, @UserID, GETDATE(), @UserID, GETDATE()
FROM #DataGroupBy T1 WITH (NOLOCK)
	LEFT JOIN #ExchangeData T2 ON T1.CurrencyID = T2.CurrencyID

-- Insert dữ liệu vào bảng detail BEMT2001
INSERT INTO BEMT2001(APK, APKMaster, DivisionID, CostAnaID, DepartmentAnaID, Description, RingiNo, InvoiceNo, InvoiceDate, RequestAmount, CurrencyID, ExchangeRate,
		 BankAccountID, BankAccountName, ApprovingLevel, ApproveLevel, APKMaster_9000, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT T1.APK, T2.APK AS APKMaster, T1.DivisionID, T1.CostAnaID, T1.DepartmentAnaID, T1.Description, T1.RingiNo, T1.InvoiceNo, T1.InvoiceDate, T1.RequestAmount, T1.CurrencyID, T1.PaymentExchangeRate,
		 T1.BankAccountID, T1.BankAccountName, IIF(ApproveStatus01 = 1, ApproveStatus01, 0) AS ApprovingLevel, @Level AS ApproveLevel, T2.APKMaster_9000, @UserID, GETDATE(), @UserID, GETDATE()
FROM #DataGroupBy T1 WITH (NOLOCK)
	INNER JOIN BEMT2000 T2 WITH (NOLOCK) ON T2.VoucherNo = T1.ID



LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data
WHERE  ErrorColumn <> ''
ORDER BY [Row]







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
