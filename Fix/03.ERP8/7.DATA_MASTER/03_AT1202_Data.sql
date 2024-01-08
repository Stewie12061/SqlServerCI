-- <Summary>
---- Khi thêm mới đối tượng trong màn hình đối tượng, tự động cập nhật mã và tên đối tượng vào mã phân tích số 5
---- Fix Cập nhật những đối tượng hiện tại đã có trước đó vào MPT A05
-- <History>
---- Create on 17/06/2015 by Lê Thị Hạnh [Customize ABA]
---- Modified by Tiểu Mai on 15/04/2016: Bổ sung dữ liệu khách hàng trên web cho khách hàng ANGEL (CustomizeIndex = 57)
---- Modified on ... by ...
-- <Example> 
DECLARE @CustomerName INT 
--Tạo bảng tạm để kiểm tra đây có phải là khách hàng ABA không (CustomerName = 45)
SET @CustomerName = (SELECT TOP 1 CustomerName FROM CustomerIndex) 
DECLARE @DivisionID NVARCHAR(50),
		@AnaTypeID NVARCHAR(50),
		@ObjectID NVARCHAR(50),
		@ObjectName NVARCHAR(250),
		@CreateUserID NVARCHAR(50),
		@CreateDate DATETIME,
		@LastModifyUserID NVARCHAR(50),
		@LastModifyDate DATETIME,
		@IsCustomer INT, 
		@Address NVARCHAR(250), 
		@Tel NVARCHAR(100), 
		@Fax NVARCHAR(100), 
		@Email NVARCHAR(100), 
		@Website NVARCHAR(100), 
		@PaymentID NVARCHAR(50), 
		@BankName NVARCHAR(250), 
		@BankAccountNo NVARCHAR(50),
		@EmployeeID NVARCHAR(50), 
		@PaCreditLimit DECIMAL(28,8), 
		@ReDueDays DECIMAL(28,8), 
		@PaDueDays DECIMAL(28,8), 
		@PaDiscountDays DECIMAL(28,8), 
		@PaDiscountPercent DECIMAL(28,8), 
		@RePaymentTermID NVARCHAR(50), 
		@PaPaymentTermID NVARCHAR(50),
		@ReDays INT, 
		@O01ID NVARCHAR(50), @O02ID NVARCHAR(50), @O03ID NVARCHAR(50), @O04ID NVARCHAR(50), @O05ID NVARCHAR(50), 
		@Note NVARCHAR(250), @Note1 NVARCHAR(250),
		@VATNo NVARCHAR(50), 
		@ReCreditLimit DECIMAL(28,8), 
		@Disabled TINYINT , @RouteID VARCHAR(50),
		@VATObjectID VARCHAR(50), 
		@IsOrganize TINYINT, @IsInvoice TINYINT, @IsUsing TINYINT, @IsCommon TINYINT
DECLARE @Cur CURSOR,
		@TestID NVARCHAR(50) = ''
IF ISNULL(@CustomerName,0) = 45
BEGIN
	SET @AnaTypeID = 'A05'
	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT DISTINCT AT12.DivisionID, AT12.ObjectID, @AnaTypeID, AT12.ObjectName, AT12.CreateUserID,
	       AT12.CreateDate, AT12.LastModifyUserID, AT12.LastModifyDate 
	FROM AT1202 AT12
OPEN @Cur
FETCH NEXT FROM @Cur INTO @DivisionID, @ObjectID, @AnaTypeID, @ObjectName, @CreateUserID,
                          @CreateDate, @LastModifyUserID, @LastModifyDate
WHILE @@FETCH_STATUS = 0
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM AT1011 WHERE DivisionID = @DivisionID AND AnaTypeID = @AnaTypeID AND AnaID = @ObjectID)
	BEGIN
		INSERT INTO AT1011 (DivisionID, AnaID, AnaTypeID, AnaName, [Disabled],
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		VALUES(@DivisionID,@ObjectID,@AnaTypeID,@ObjectName,0,@CreateUserID,@CreateDate,@LastModifyUserID,@LastModifyDate)
	END	
FETCH NEXT FROM @Cur INTO @DivisionID, @ObjectID, @AnaTypeID, @ObjectName, @CreateUserID,
                          @CreateDate, @LastModifyUserID, @LastModifyDate
END
CLOSE @Cur
END

IF ISNULL(@CustomerName,0) = 57 --- ANGEL
	BEGIN
		SET @Cur = CURSOR SCROLL KEYSET FOR
			SELECT DISTINCT DivisionID, ObjectID, ObjectName, IsCustomer, [Address], Tel, Fax, Email, Website, PaymentID, BankName, BankAccountNo,
			EmployeeID, PaCreditLimit, ReDueDays, PaDueDays, PaDiscountDays, PaDiscountPercent, RePaymentTermID, PaPaymentTermID,
			ReDays, O01ID, O02ID, O03ID, O04ID, O05ID, Note, Note1,
			VATNo, ReCreditLimit, [Disabled], RouteID,
			VATObjectID, IsOrganize, IsInvoice, IsUsing, IsCommon,
			CreateDate, CreateUserID, LastModifyDate, LastModifyUserID
			FROM AT1202
			WHERE IsCustomer = 1
		OPEN @Cur
	FETCH NEXT FROM @Cur INTO @DivisionID, @ObjectID, @ObjectName, @IsCustomer, @Address, @Tel, @Fax, @Email, @Website, @PaymentID, @BankName, @BankAccountNo,
			@EmployeeID, @PaCreditLimit, @ReDueDays, @PaDueDays, @PaDiscountDays, @PaDiscountPercent, @RePaymentTermID, @PaPaymentTermID,
			@ReDays, @O01ID, @O02ID, @O03ID, @O04ID, @O05ID, @Note,  @Note1,
			@VATNo, @ReCreditLimit, @Disabled, @RouteID,
			@VATObjectID, @IsOrganize, @IsInvoice, @IsUsing, @IsCommon,
			@CreateDate, @CreateUserID, @LastModifyDate, @LastModifyUserID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT10101 WHERE DivisionID = @DivisionID AND AccountID = @ObjectID)
		BEGIN
			INSERT INTO CRMT10101
			( DivisionID, AccountID, AccountName, IsCustomer, [Address], Tel, Fax, Email, Website, PaymentID, BankName, BankAccountNo,
				EmployeeID, PaCreditLimit, ReDueDays, PaDueDays, PaDiscountDays, PaDiscountPercent, RePaymentTermID, PaPaymentTermID,
				ReDays, O01ID, O02ID, O03ID, O04ID, O05ID, [Description], Note, Note1,
				VATNo, ReCreditLimit, [Disabled], RouteID,
				VATAccountID, IsOrganize, IsInvoice, IsUsing, IsCommon,
				CreateDate, CreateUserID, LastModifyDate, LastModifyUserID
			)
			VALUES(@DivisionID, @ObjectID, @ObjectName, @IsCustomer, @Address, @Tel, @Fax, @Email, @Website, @PaymentID, @BankName, @BankAccountNo,
			@EmployeeID, @PaCreditLimit, @ReDueDays, @PaDueDays, @PaDiscountDays, @PaDiscountPercent, @RePaymentTermID, @PaPaymentTermID,
			@ReDays, @O01ID, @O02ID, @O03ID, @O04ID, @O05ID, @Note, @Note, @Note1,
			@VATNo, @ReCreditLimit, @Disabled, @RouteID,
			@VATObjectID, @IsOrganize, @IsInvoice, @IsUsing, @IsCommon,
			@CreateDate, @CreateUserID, @LastModifyDate, @LastModifyUserID)
		END	
		FETCH NEXT FROM @Cur INTO @DivisionID, @ObjectID, @ObjectName, @IsCustomer, @Address, @Tel, @Fax, @Email, @Website, @PaymentID, @BankName, @BankAccountNo,
			@EmployeeID, @PaCreditLimit, @ReDueDays, @PaDueDays, @PaDiscountDays, @PaDiscountPercent, @RePaymentTermID, @PaPaymentTermID,
			@ReDays, @O01ID, @O02ID, @O03ID, @O04ID, @O05ID, @Note, @Note1,
			@VATNo, @ReCreditLimit, @Disabled, @RouteID,
			@VATObjectID, @IsOrganize, @IsInvoice, @IsUsing, @IsCommon,
			@CreateDate, @CreateUserID, @LastModifyDate, @LastModifyUserID
	END
	CLOSE @Cur
END
