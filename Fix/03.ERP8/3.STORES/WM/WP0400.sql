IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0400]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0400]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
--- Customize ANGEL: Tự động tạo phiếu nhập kho SELL OUT khi lưu phiếu xuất kho SELL IN theo đối tượng Dealer.
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Nhựt Trường on 26/01/2022
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
/*
    EXEC WP0400 'ANGEL-SELLIN','ASOFTADMIN','AD20220000000001','00200'
*/

 CREATE PROCEDURE WP0400
(
     @DivisionID NVARCHAR(50),
     @UserID VARCHAR(50),
     @VoucherID VARCHAR(50),	
	 @ObjectID VARCHAR(50)
)
AS

DECLARE @IsCreateExVoucher TINYINT,
		@ExVoucherID VARCHAR(50),
		@ExVoucherNo VARCHAR(50)='',
		@VoucherTypeID VARCHAR(50),
		@S1 VARCHAR(50), @S2 VARCHAR(50), @S3 VARCHAR(50),
		@TranMonth INT = 0 , @TranYear INT = 0,
		@OutputLenght TINYINT, @OutputOrder TINYINT,
		@Seperated TINYINT, @Seperator VARCHAR(50),
		@TransactionID UNIQUEIDENTIFIER,
		@WareHouseID VARCHAR(50),
		@DealerDivision VARCHAR(50),
		@IsDealer TINYINT,
		@CustomerName int

SET @customerName = (select CustomerName from CustomerIndex)
SET @ExVoucherID = NEWID()
SELECT @DealerDivision = KeyValue FROM ST2101 WHERE KeyName = 'DealerDivisionID'
SELECT @IsDealer = IsDealer FROM AT1202 WHERE DivisionID IN (@DivisionID, '@@@') AND ObjectID = @ObjectID

SELECT @TranMonth = TranMonth, @TranYear = TranYear, @WareHouseID = WareHouseID
FROM AT2006 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID
CREATE TABLE #ExVoucherNo (ExVoucherNo VARCHAR(50))

INSERT INTO #ExVoucherNo
		EXEC AP0000 @DivisionID, @ExVoucherNo OUTPUT, 'AT2006', 'NK', @TranYear, @TranMonth, 15, 3, 0, ''
		SELECT @ExVoucherNo = ExVoucherNo FROM #ExVoucherNo

IF @IsDealer = 1
BEGIN
	
	------------------------thực hiện xóa dữ liệu--------------------------------------------------
	IF EXISTS (SELECT TOP 1 1 FROM AT2006 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND ImVoucherID = @VoucherID)
	BEGIN
		DECLARE @DelExVoucherID NVARCHAR(50)
		SELECT @DelExVoucherID = VoucherID FROM AT2006 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND ImVoucherID = @VoucherID
		DELETE AT2006 WHERE DivisionID = @DivisionID AND VoucherID = @DelExVoucherID
		DELETE AT2007 WHERE DivisionID = @DivisionID AND VoucherID = @DelExVoucherID
	END	
	-----------------Thêm master AT2006----------------------------------------------------------------------------------	
	INSERT INTO AT2006 (DivisionID, VoucherID, TableID, TranMonth, TranYear, VoucherTypeID, VoucherDate, VoucherNo,
				ObjectID, ProjectID, OrderID, BatchID, WareHouseID, ReDeTypeID, KindVoucherID, [Status],
				EmployeeID, [Description], CreateDate, CreateUserID, LastModifyUserID, LastModifyDate, RefNo01, RefNo02,
		        RDAddress, ContactPerson, VATObjectName, InventoryTypeID, IsGoodsFirstVoucher, MOrderID, ApportionID,
		        IsInheritWarranty, EVoucherID, IsGoodsRecycled, IsVoucher, ImVoucherID)
	SELECT @DealerDivision, @ExVoucherID, TableID, TranMonth, TranYear, @VoucherTypeID, VoucherDate, @ExVoucherNo,
				ObjectID, ProjectID, OrderID, BatchID, 'ANGEL-SELLOUT', ReDeTypeID, 1, [Status],
				EmployeeID, [Description], CreateDate, CreateUserID, LastModifyUserID, LastModifyDate, RefNo01, RefNo02,
		        RDAddress, ContactPerson, VATObjectName, InventoryTypeID, IsGoodsFirstVoucher, MOrderID, ApportionID,
		        IsInheritWarranty, EVoucherID, IsGoodsRecycled, IsVoucher, @VoucherID
	FROM AT2006 WITH (NOLOCK)
	WHERE DivisionID = @DivisionID
	AND VoucherID = @VoucherID      
		 
	-----------------Thêm detail AT2007----------------------------------------------------------------------------------
	INSERT INTO AT2007 (DivisionID, TransactionID, VoucherID, BatchID, InventoryID, UnitID, ActualQuantity, UnitPrice,
		OriginalAmount, ConvertedAmount, Notes, TranMonth, TranYear, CurrencyID, ExchangeRate, SaleUnitPrice,
		SaleAmount, DiscountAmount, SourceNo, DebitAccountID, CreditAccountID, LocationID, ImLocationID,
		LimitDate, Orders, ConversionFactor, ReTransactionID, ReVoucherID, Ana01ID, Ana02ID, Ana03ID, PeriodID,
		ProductID, OrderID, InventoryName1, Ana04ID, Ana05ID, OTransactionID, ReSPVoucherID, ReSPTransactionID,
		ETransactionID, MTransactionID, Parameter01, Parameter02, Parameter03, Parameter04, Parameter05,
		ConvertedQuantity, ConvertedPrice, ConvertedUnitID, MOrderID, SOrderID, STransactionID, Ana06ID, Ana07ID,
		Ana08ID, Ana09ID, Ana10ID, LocationCode, Location01ID, Location02ID, Location03ID, Location04ID, Location05ID,
		MarkQuantity, OExpenseConvertedAmount, WVoucherID, RefInfor, Notes01, Notes02, Notes03, Notes04, Notes05,
		Notes06, Notes07, Notes08, Notes09, Notes10, Notes11, Notes12, Notes13, Notes14, Notes15, StandardPrice,
		StandardAmount, InheritTableID, InheritVoucherID, InheritTransactionID)
	SELECT @DealerDivision, NEWID(), @ExVoucherID, BatchID, InventoryID, UnitID, ActualQuantity, UnitPrice,
		OriginalAmount, ConvertedAmount, Notes, TranMonth, TranYear, CurrencyID, ExchangeRate, SaleUnitPrice,
		SaleAmount, DiscountAmount, SourceNo,
		(SELECT AccountID FROM AT1302 WITH (NOLOCK) WHERE DivisionID IN (@DivisionID,'@@@') AND InventoryID = A.InventoryID),
		'3311', LocationID, ImLocationID,
		LimitDate, Orders, ConversionFactor, TransactionID, @VoucherID, Ana01ID, Ana02ID, Ana03ID, PeriodID,
		ProductID, OrderID, InventoryName1, Ana04ID, Ana05ID, OTransactionID, ReSPVoucherID, ReSPTransactionID,
		ETransactionID, MTransactionID, Parameter01, Parameter02, Parameter03, Parameter04, Parameter05,
		ConvertedQuantity, ConvertedPrice, ConvertedUnitID, MOrderID, SOrderID, STransactionID, Ana06ID, Ana07ID,
		Ana08ID, Ana09ID, Ana10ID, LocationCode, Location01ID, Location02ID, Location03ID, Location04ID, Location05ID,
		MarkQuantity, OExpenseConvertedAmount, WVoucherID, RefInfor, Notes01, Notes02, Notes03, Notes04, Notes05,
		Notes06, Notes07, Notes08, Notes09, Notes10, Notes11, Notes12, Notes13, Notes14, Notes15, StandardPrice,
		StandardAmount, InheritTableID, InheritVoucherID, InheritTransactionID
	FROM AT2007 A WITH (NOLOCK)
	WHERE DivisionID = @DivisionID
		  AND VoucherID = @VoucherID

	-----------------Insert bảng AT0114----------------------------------------------------------------------------------
	IF EXISTS (SELECT TOP 1 1 FROM AT0114 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND ReVoucherID = @VoucherID)
	BEGIN
		DELETE AT0114 WHERE DivisionID = @DivisionID AND ReVoucherID = @ExVoucherID
	END
	INSERT INTO AT0114 (DivisionID, InventoryID, WareHouseID, ReVoucherID, ReTransactionID, ReVoucherNo, 
					  ReVoucherDate, ReTranMonth, ReTranYear, ReSourceNo, ReQuantity, DeQuantity, 
					  EndQuantity, UnitPrice, Status, IsLocked, LimitDate, ReMarkQuantity, DeMarkQuantity, EndMarkQuantity)
	SELECT AT2007.DivisionID, AT2007.InventoryID, AT2006.WareHouseID, AT2007.VoucherID, AT2007.TransactionID, AT2006.VoucherNo,
		   AT2006.VoucherDate, AT2006.TranMonth, AT2006.TranYear, NULL, AT2007.ActualQuantity, 0,
		   AT2007.ActualQuantity, UnitPrice, 0, 0, LimitDate, AT2007.MarkQuantity, 0, AT2007.MarkQuantity
	FROM AT2007 WITH(NOLOCK)
	LEFT JOIN AT2006 WITH(NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
	WHERE AT2007.VoucherID = @ExVoucherID
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO