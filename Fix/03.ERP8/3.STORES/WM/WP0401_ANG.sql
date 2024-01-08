IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0401_ANG]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0401_ANG]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
--- Customize ANGEL: Sinh phiếu xuất tự động theo đối tượng Dealer và mặt hàng trong đơn hàng bán khi duyệt đơn hàng.
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Nhựt Trường on 26/01/2022
----Modified by Ngọc Châu on 01/07/2022: Truyền warehouseID là biến @DealerDivisionID
----Modified by Nhựt Trường on 29/07/2022: [2022/07/IS/0173] - Bổ sung kiểm tra trạng thái đã duyệt đơn thì mới sinh phiếu xuất (OrderStatus = 1).
----Modified by Nhựt Trường on 26/08/2022: [2022/07/IS/0133] - Bổ sung xóa các phiếu xuất đã tồn tại trước khi insert phiếu mới.
-- <Example>
/*
    EXEC WP0401_ANG 'ANGEL-SELLIN','ASOFTADMIN','AD20220000000001','00200'
*/

 CREATE PROCEDURE WP0401_ANG
(
     @DivisionID NVARCHAR(50),
	 @UserID NVARCHAR(50),
     @APK VARCHAR(50),
	 @ApprovePersonStatus TINYINT,
	 @TranYear INT,
	 @TranMonth INT
)
AS

CREATE Table #Table (
			 DivisionID VARCHAR(50),
			 VoucherNo VARCHAR(50),
			 VoucherID VARCHAR(50),
			 InventoryID VARCHAR(50),
			 ActualQuantity DECIMAL(28,8),
			 ActualQuantityImport DECIMAL(28,8),
			 VoucherDate DATETIME,
			 IsImport TINYINT)


DECLARE @Cur AS CURSOR,
		@CurImport AS CURSOR,
		@DealerDivisionID VARCHAR(50),
		@InventoryID VARCHAR(50),
		@OrderQuantity DECIMAL(28,8),
		@ActualQuantity DECIMAL(28,8),
		@Quantity DECIMAL(28,8) = 0,
		@VoucherDate DATETIME,
		@VoucherNo VARCHAR(50),
		@VoucherID VARCHAR(50),
		@NewVoucherID VARCHAR(50),
		@SOrderID VARCHAR(50),
		@ObjectID VARCHAR(50),
		@DealerID VARCHAR(50),
		@ExVoucherNo VARCHAR(50),
		@ID VARCHAR(50),
		@IsDealer TINYINT,
		@OrderStatus TINYINT

CREATE TABLE #ExVoucherNo (ExVoucherNo VARCHAR(50))

SELECT @DealerDivisionID = KeyValue FROM ST2101 WHERE KeyName = 'DealerDivisionID'

SELECT @DealerID = DealerID FROM OT2001 WITH(NOLOCK)
								   WHERE VoucherNo IN (SELECT ID FROM OOT9000 WITH(NOLOCK) WHERE APK = @APK)
-- Kiem tra don hang tren APP
IF ISNULL(@DealerID,'') = ''
BEGIN
	SELECT @ObjectID = ObjectID FROM OT2001 WITH(NOLOCK)
								   WHERE VoucherNo IN (SELECT ID FROM OOT9000 WITH(NOLOCK) WHERE APK = @APK)
END
ELSE
BEGIN
	SET @ObjectID = @DealerID
END

SELECT @ID = ID FROM OOT9000 WITH(NOLOCK) WHERE APK = @APK

SELECT TOP 1 @SOrderID = SOrderID, @VoucherNo = VoucherNo, @OrderStatus = OrderStatus FROM OT2001 WITH(NOLOCK)
									   WHERE VoucherNo IN (SELECT ID FROM OOT9000 WITH(NOLOCK) WHERE APK = @APK)

SELECT @IsDealer = IsDealer FROM AT1202 WITH(NOLOCK) WHERE ObjectID = @ObjectID


IF @IsDealer = 1 AND @ApprovePersonStatus = 1 AND @OrderStatus = 1 ---- Duyệt đơn hàng bán Sell Out
BEGIN
	SET @NewVoucherID = NEWID()

	----- Master phiếu xuất
	DELETE AT2006 WHERE ObjectID = @ObjectID AND OrderID = @SOrderID AND ImVoucherID = @VoucherNo

	INSERT INTO AT2006(DivisionID, VoucherID, TableID, TranMonth, TranYear, VoucherTypeID, VoucherDate, VoucherNo, ObjectID, OrderID, WareHouseID, KindVoucherID,
					   [Status], EmployeeID, [Description], CreateDate, CreateUserID, LastModifyUserID, LastModifyDate, InventoryTypeID, ImVoucherID, ContractNo)
	SELECT @DealerDivisionID, @NewVoucherID, 'AT2006', @TranMonth, @TranYear, VoucherTypeID, OrderDate, VoucherNo, @ObjectID, @SOrderID, @DealerDivisionID, 2,
		   Status, EmployeeID, Notes, GETDATE(), @UserID, @UserID, GETDATE(), InventoryTypeID, @VoucherNo, ContractNo
	FROM OT2001 WITH(NOLOCK)
	WHERE SOrderID = @SOrderID

	----- Detail phiếu xuất
	DELETE AT2007 WHERE ReVoucherID = @SOrderID AND SOrderID = @SOrderID

	INSERT INTO AT2007(DivisionID, TransactionID, VoucherID, InventoryID, UnitID, ActualQuantity, UnitPrice,
					   OriginalAmount, ConvertedAmount, Notes, TranMonth, TranYear, CurrencyID, ExchangeRate, SourceNo,
					   DebitAccountID, CreditAccountID,
					   Orders, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
					   Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, ReTransactionID, ReVoucherID, SOrderID,
					   ConvertedQuantity, ConvertedPrice, StandardPrice, StandardAmount, InheritTableID, InheritVoucherID, InheritTransactionID)

	SELECT @DealerDivisionID, NEWID(), @NewVoucherID, InventoryID, UnitID, OrderQuantity, SalePrice,
		   OriginalAmount, ConvertedAmount, Description, @TranMonth, @TranYear, CurrencyID, ExchangeRate, SourceNo,
		   (SELECT TOP 1 AccountID FROM AT1302 WITH (NOLOCK) WHERE DivisionID IN (@DealerDivisionID,'@@@') AND InventoryID = OT2002.InventoryID), '3311',
		   Orders, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
	       Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, TransactionID, @SOrderID, @SOrderID,
	       ConvertedQuantity, ConvertedSalePrice, StandardPrice, StandardAmount, InheritTableID, InheritVoucherID, InheritTransactionID
	FROM OT2002 WITH(NOLOCK)
	WHERE SOrderID = @SOrderID
END
ELSE IF @IsDealer = 1 AND @ApprovePersonStatus = 2 ---- Bỏ duyệt đơn hàng bán Sell Out
BEGIN
	-----------------Xóa master AT2006----------------------------------------------------------------------------------
	IF EXISTS (SELECT TOP 1 1 FROM AT2006 WITH(NOLOCK) WHERE DivisionID = @DealerDivisionID AND OrderID = @SOrderID)
		DELETE AT2006 WHERE DivisionID = @DealerDivisionID AND OrderID = @SOrderID
	-----------------Xóa detail AT2007----------------------------------------------------------------------------------
	IF EXISTS (SELECT TOP 1 1 FROM AT2007 WITH(NOLOCK) WHERE DivisionID = @DealerDivisionID AND SOrderID = @SOrderID)
		DELETE AT2007 WHERE DivisionID = @DealerDivisionID AND SOrderID = @SOrderID

END








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
