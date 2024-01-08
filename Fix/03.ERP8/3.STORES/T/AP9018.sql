IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP9018]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP9018]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Sinh tự động phiếu xuất kho từ hóa đơn bán hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 16/10/2018 by Kim Thư
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
-- <Example> EXEC AP9018 @DivisionID='SH', @UserID='ASOFTADMIN', @VoucherID=N'AV499793b9-8fdb-4598-89d5-971598c88d49', @WarehouseID='K02', @DEVoucherTypeID='BH2', @Mode=1
CREATE PROCEDURE  [dbo].[AP9018] 
				@DivisionID VARCHAR (50), 
				@UserID VARCHAR (50),
				@VoucherID VARCHAR (50),
				@WarehouseID VARCHAR (50),
				@DEVoucherTypeID VARCHAR(10),
				@Mode TINYINT -- 1: Kiểm tra tồn kho / 2: Sinh phiếu xuất kho		
 AS

IF @Mode=1
BEGIN
	-- Kiểm tra nếu có mặt hàng xuất thực tế đích danh thì không tự động sinh phiếu xuất
	IF EXISTS (SELECT TOP 1 1 FROM AT9000 INNER JOIN AT1302 ON AT9000.InventoryID = AT1302.InventoryID WHERE AT9000.VoucherID = @VoucherID AND AT1302.MethodID=3)
	SELECT 1 AS Status, 'AFML000507' AS Message, AT9000.InventoryID
	FROM AT9000 INNER JOIN AT1302 ON AT1302.DivisionID IN (AT9000.DivisionID,'@@@') AND AT9000.InventoryID = AT1302.InventoryID 
	WHERE AT9000.VoucherID = @VoucherID AND AT1302.MethodID=3

	-- Kiểm tra tồn kho / xuất kho âm trước khi sinh phiếu
	EXEC AP7003 @DivisionID, @UserID, @VoucherID, '', @WarehouseID, NULL
	Select * from AT7777 WITH (NOLOCK) Where UserID = @UserID and DivisionID = @DivisionID
	Select * from AT7778 WITH (NOLOCK) Where UserID = @UserID and DivisionID = @DivisionID

END
ELSE
BEGIN
	-- Lấy CreateUserID và CreateDate của phiếu cũ nếu là edit
	DECLARE @CreateUserID VARCHAR(50), @CreateDate DATETIME
	SELECT @CreateUserID = CreateUserID, @CreateDate = CreateDate FROM AT2006 WHERE VoucherID=@VoucherID AND KindVoucherID=4

	-- Nếu là edit hóa đơn bán hàng thì xóa phiếu xuất kho cũ
	DELETE AT2007 WHERE VoucherID=@VoucherID
	DELETE AT2006 WHERE VoucherID=@VoucherID

	Declare @DEDebitAccountID NVARCHAR(50),
			@DEVoucherNo NVARCHAR(50),
			@StringKey1T06 nvarchar(50), @StringKey2T06 nvarchar(50), @StringKey3T06 nvarchar(50), 
			@OutputLenT06 int, @OutputOrderT06 int, @SeparatedT06 int, @SeparatorT06 char(1),
			@VDescription NVARCHAR(250), @BDescription NVARCHAR(250), @TDescription NVARCHAR(250),
			@ConvertedDecimals INT, @QuantityDecimals INT, @UnitCostDecimals INT,
			@Enabled1 TINYINT, @Enabled2 TINYINT, @Enabled3 TINYINT,
			@S1 NVARCHAR(50), @S2 NVARCHAR(50), @S3 NVARCHAR(50),
			@S1Type TINYINT, @S2Type TINYINT, @S3Type TINYINT, @TranMonth INT, @TranYear INT
	
	SET @TranMonth = (SELECT TOP 1 TranMonth FROM AT9000 WHERE VoucherID=@VoucherID)
	SET @TranYear = (SELECT TOP 1 TranYear FROM AT9000 WHERE VoucherID=@VoucherID)

	SELECT @ConvertedDecimals = ConvertedDecimals, @QuantityDecimals = QuantityDecimals, @UnitCostDecimals = UnitCostDecimals
	FROM AT1101 WITH (NOLOCK) where DivisionID = @DivisionID

	--Nếu loại chứng từ chưa thiết lập mặc định thì lấy mã loại chứng từ đầu tiên trong table AT1007
	IF ISNULL(@DEVoucherTypeID,'') = ''
		SET @DEVoucherTypeID = (SELECT TOP 1 VoucherTypeID FROM AT1007 WHERE DivisionID = @DivisionID)

	--Lấy chỉ số tăng số chứng từ xuất kho
	Select	@Enabled1=Enabled1,@Enabled2=Enabled2,@Enabled3=Enabled3,@S1=S1,@S2=S2,@S3=S3,@S1Type=S1Type,@S2Type=S2Type,@S3Type=S3Type,
			@OutputLenT06 = OutputLength, @OutputOrderT06=OutputOrder,@SeparatedT06=Separated,@SeparatorT06=Separator,
			@DEDebitAccountID = DebitAccountID, @VDescription = ISNULL(VDescription,''), @TDescription = ISNULL(TDescription,''), @WarehouseID = WarehouseID
	From AT1007 WITH (NOLOCK) Where DivisionID = @DivisionID AND VoucherTypeID = @DEVoucherTypeID

	If @Enabled1 = 1
		SET @StringKey1T06 = 
		Case @S1Type 
		When 1 Then Case When @TranMonth <10 Then '0' + ltrim(@TranMonth) Else ltrim(@TranMonth) End
		When 2 Then ltrim(@TranYear)
		When 3 Then @DEVoucherTypeID
		When 4 Then @DivisionID
		When 5 Then @S1
		Else '' End
	Else
		SET @StringKey1T06 = ''

	If @Enabled2 = 1
		SET @StringKey2T06 = 
		Case @S2Type 
		When 1 Then Case When @TranMonth <10 Then '0' + ltrim(@TranMonth) Else ltrim(@TranMonth) End
		When 2 Then ltrim(@TranYear)
		When 3 Then @DEVoucherTypeID
		When 4 Then @DivisionID
		When 5 Then @S2
		Else '' End
	Else
		SET @StringKey2T06 = ''

	If @Enabled3 = 1
		SET @StringKey3T06 = 
		Case @S3Type 
		When 1 Then Case When @TranMonth <10 Then '0' + ltrim(@TranMonth) Else ltrim(@TranMonth) End
		When 2 Then ltrim(@TranYear)
		When 3 Then @DEVoucherTypeID
		When 4 Then @DivisionID
		When 5 Then @S3
		Else '' End
	Else
		SET @StringKey3T06 = ''

	Recal:
	--- Sinh số chứng từ xuất kho
	Exec AP0000  @DivisionID, @DEVoucherNo OUTPUT, 'AT2006', @StringKey1T06, @StringKey2T06, @StringKey3T06, @OutputLenT06, @OutputOrderT06, @SeparatedT06, @SeparatorT06

	IF EXISTS (SELECT 1 FROM AT2006 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherNo = @DEVoucherNo) -- Nếu trùng số chứng từ thì sinh lại số khác
		GOTO Recal

	-- Tạo phiếu xuất

	INSERT INTO AT2006 (APK, DivisionID, VoucherID, TableID, TranMonth, TranYear, VoucherTypeID, VoucherDate, VoucherNo, ObjectID, WarehouseID, KindVoucherID, Status, EmployeeID,
						Description, CreateDate, CreateUserID, LastModifyUserID, LastModifyDate, RefNo01, RefNo02, RDAddress)
	SELECT NEWID(), @DivisionID, @VoucherID, 'AT2006', TranMonth, TranYear, @DEVoucherTypeID, VoucherDate, @DEVoucherNo, ObjectID, @WarehouseID, 4, 0, @UserID,
					VDescription, @CreateDate, @CreateUserID, @UserID, GETDATE(), VoucherNo, InvoiceNo+'/'+Serial, VATObjectAddress
	FROM AT9000
	WHERE VoucherID = @VoucherID and TransactionTypeID='T04'

	INSERT INTO AT2007 (APK, DivisionID, TransactionID, VoucherID, InventoryID, UnitID, ActualQuantity, UnitPrice, OriginalAmount, ConvertedAmount, Notes, TranMonth, TranYear, CurrencyID,
						ExchangeRate, DebitAccountID, CreditAccountID, Orders, ConversionFactor, ConvertedQuantity, ConvertedPrice, ConvertedUnitID, MarkQuantity, Ana01ID, Ana02ID, 
						Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID)
	SELECT NEWID(), @DivisionID, TransactionID, VoucherID, InventoryID, UnitID, Quantity, UnitPrice, OriginalAmount, ConvertedAmount, TDescription, TranMonth, TranYear, CurrencyID,
			ExchangeRate, @DEDebitAccountID, (Select TOP 1 AccountID From AT1302 WITH (NOLOCK) Where DivisionID IN (@DivisionID,'@@@') AND InventoryID = AT9000.InventoryID) AS AccountID,
			Orders, 1, Quantity, UnitPrice, UnitID, Quantity, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID
	FROM AT9000 
	WHERE VoucherID = @VoucherID and TransactionTypeID='T04'


END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
