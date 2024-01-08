IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AY2007]') AND OBJECTPROPERTY(ID, N'IsTrigger') = 1)
DROP TRIGGER [DBO].[AY2007]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/****** Object:  Trigger [dbo].[AY2007]    Script Date: 7/9/2020 7:14:39 PM ******/
/********************************************
'* Edited by: [GS] [Hoàng Phước] [30/07/2010]
'********************************************/
--Edit by: Trần Lê Thiên Huỳnh; Date: 06/06/2012: Bổ sung 5 Khoản mục Ana06ID - Ana10ID
--- Edited by Bao Anh	Date: 21/08/2012
--- Purpose: Bo sung ReVoucherID, ReTransactionID de cap nhat AT0114 doi voi kho nhap khi xuat VCNB
--- Edited by Bao Anh	Date: 21/08/2012
--- Purpose: Them quy cach va so luong mark (yeu cau cua 2T)
--- Edited by Bao Anh	Date: 08/11/2012
--- Purpose: Bo sung DVT quy doi, sl quy doi va dg quy doi vao AT9000 (2T)
--- Edited by Bao Anh	Date: 15/11/2012
--- Purpose: Sua loi kg len Chung tu nhap khi kg dung DVT quy doi (neu ConvertedQuantity NULL thi lay ActualQuantity)
--- Edited by Bao Anh	Date: 20/11/2012
--- Purpose: Lay dung gia tri cho @ConvertedQuantity = ConvertedQuantity
---- Modified on 29/07/2013 by Lê Thị Thu Hiền : Bổ sung RefNo01, RefNo02
---- Modified on 23/07/2014 by Thanh Sơn: Kiểm tra khách hàng nào có thiết lập "Cập nhật giá cho phiếu nhập khi lưu phiếu mua hàng" (AF0002): nhập kho trước tạo hóa đơn mua hàng sau thì gọi AP0599TL
---- Modified on 01/03/2016 by Tiểu Mai: Bổ sung IsProduct (Nhập từ sản xuất) - ANGEL
---- Modified by Tiểu Mai on 17/08/2016: Bổ sung kiểm tra phiếu lắp ráp, tháo dỡ của ANGEL
---- Modified by Phương Thảo on 24/11/2016: Bổ sung customize Phúc Long: Chuyển dữ liệu qua POST
---- Modified by Bảo Thy on 10/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Trọng Kiên on 22/10/2020 : Fix lỗi Ambiguous column name 'IsLedger'
---- Modified by Văn Tài	on 01/02/2021 : Fix lỗi thiếu Division cho bảng kho.

CREATE TRIGGER [dbo].[AY2007] ON [dbo].[AT2007]
FOR INSERT 
AS

DECLARE 
    @D07_Cursor CURSOR, 
	@BaseCurrencyID AS NVARCHAR(50),
	@KindVoucherID TINYINT, 
	@TransactionID NVARCHAR(50), 
	@DivisionID NVARCHAR(50), 
	@ModuleID NVARCHAR(50), 
	@VoucherTypeID NVARCHAR(50), 
	@RDVoucherID NVARCHAR(50), 
	@RDVoucherNo NVARCHAR(50), 
	@BatchID NVARCHAR(50), 
	@RDVoucherDate DATETIME, 
	@TranYear INT, 
	@TranMonth INT, 
	@InventoryID NVARCHAR(50), 
	@UnitID NVARCHAR(50),
	@ActualQuantity DECIMAL(28, 8), 
	@UnitPrice DECIMAL(28, 8),
	@ConvertedQuantity DECIMAL(28, 8), 
	@ConvertedUnitPrice DECIMAL(28, 8), 
	@CurrencyID NVARCHAR(50), 
	@ExchangeRate DECIMAL(28, 8), 
	@ConvertedAmount DECIMAL(28, 8), 
	@OriginalAmount DECIMAL(28, 8), 
	@DebitAccountID NVARCHAR(50), 
	@CreditAccountID NVARCHAR(50), 
	@WareHouseID NVARCHAR(50),
	@WareHouseID2 NVARCHAR(50), 
	@Description NVARCHAR(255), 
	@SourceNo NVARCHAR(50), 
	@WarrantyNo NVARCHAR(250), 
	@ShelvesID NVARCHAR(50), 
	@FloorID NVARCHAR(50), 

	@CreateUserID NVARCHAR(50), 
	@CreateDate DATETIME, 
	@EmployeeID NVARCHAR(50), 
	@MethodID TINYINT, 
	@ObjectID NVARCHAR(50), 
	@Status TINYINT, 
	@IsLimitDate TINYINT, 
	@IsSource TINYINT, 
	@LimitDate DATETIME, 
	@TableID NVARCHAR(50), 
	@Ana01ID NVARCHAR(50), 
	@Ana02ID NVARCHAR(50), 
	@Ana03ID NVARCHAR(50), 
	@Ana04ID NVARCHAR(50), 
	@Ana05ID NVARCHAR(50), 
	@Ana06ID NVARCHAR(50), 
	@Ana07ID NVARCHAR(50), 
	@Ana08ID NVARCHAR(50), 
	@Ana09ID NVARCHAR(50), 
	@Ana10ID NVARCHAR(50), 
	@Notes NVARCHAR(250), 
	@PeriodID NVARCHAR(50), 
	@ProductID NVARCHAR(50), 
	@OrderID NVARCHAR(50), 
	@IsTemp TINYINT, 
	@OTransactionID NVARCHAR(50), 
	@MOrderID NVARCHAR(50), 
	@SOrderID NVARCHAR(50),
	@IsGoodsFirstVoucher AS TINYINT,
	@ReVoucherID AS NVARCHAR(50),
    @ReTransactionID NVARCHAR(50),
	@Parameter01 AS DECIMAL(28,8),
	@Parameter02 AS DECIMAL(28,8),
	@Parameter03 AS DECIMAL(28,8),
	@Parameter04 AS DECIMAL(28,8),
	@Parameter05 AS DECIMAL(28,8),
	@MarkQuantity AS DECIMAL(28,8),
	@ConvertedUnitID NVARCHAR(50),
	@RefNo01 NVARCHAR(100),
	@RefNo02 NVARCHAR(100),
	@IsUpdatePrice TINYINT,
	@IsProduct TINYINT,
	@KITID NVARCHAR(50),
	@KITQuantity DECIMAL(28,8),
	@IsLedger TINYINT,
	@Type TINYINT,
	@CustomerName INT,
	@DepartmentCode Nvarchar(250)

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)      

SET @D07_Cursor = CURSOR SCROLL KEYSET FOR
	SELECT Inserted.TransactionID, Inserted.DivisionID, Inserted.VoucherID, Inserted.TranYear, Inserted.TranMonth, ---- Thong tin chung
	AT2006.VoucherDate, AT2006.VoucherNo, AT2006.EmployeeID, AT2006.ObjectID, AT2006.CreateUserID, AT2006.CreateDate, AT2006.[Description], 
	AT2006.WareHouseID, AT2006.WareHouseID2, 0, AT2006.KindVoucherID, Inserted.CurrencyID, Inserted.ExchangeRate, 
	Inserted.InventoryID, Inserted.UnitID, AT1302.MethodID, Inserted.ActualQuantity, Inserted.UnitPrice, ISNULL(Inserted.ConvertedQuantity, 0),
	ISNULL(Inserted.ConvertedPrice,0), Inserted.OriginalAmount, Inserted.ConvertedAmount, Inserted.DebitAccountID, Inserted.CreditAccountID, Inserted.SourceNo,  Inserted.WarrantyNo, Inserted.ShelvesID, Inserted.FloorID, 
	AT1302.IsLimitDate, AT1302.IsSource, Inserted.LimitDate, AT2006.TableID, AT2006.BatchID, Inserted.Ana01ID, Inserted.Ana02ID, Inserted.Ana03ID, Inserted.Ana04ID, Inserted.Ana05ID, 
	Inserted.Ana06ID, Inserted.Ana07ID, Inserted.Ana08ID, Inserted.Ana09ID, Inserted.Ana10ID, Inserted.Notes, AT2006.VoucherTypeID, Inserted.PeriodID, Inserted.ProductID, 
	AT1303.IsTemp, Inserted.OrderID, Inserted.OTransactionID, Inserted.MOrderID, Inserted.SOrderID, AT2006.IsGoodsFirstVoucher,
	INSERTED.ReVoucherID, INSERTED.ReTransactionID, ISNULL(INSERTED.Parameter01, 0), ISNULL(INSERTED.Parameter02, 0),
	ISNULL(INSERTED.Parameter03, 0), ISNULL(INSERTED.Parameter04, 0), ISNULL(INSERTED.Parameter05, 0), INSERTED.MarkQuantity,
	Inserted.ConvertedUnitID, AT2006.RefNo01, AT2006.RefNo02, AT2006.IsProduct, INSERTED.KITID, INSERTED.KITQuantity, AT2006.IsLedger, AT0112.[Type]	
	FROM Inserted
	INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = Inserted.DivisionID AND Inserted.VoucherID = AT2006.VoucherID AND Inserted.TranMonth = AT2006.TranMonth AND Inserted.TranYear = AT2006.TranYear 
	INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN ('@@@',Inserted.DivisionID) AND Inserted.InventoryID = AT1302.InventoryID 
	---LEFT JOIN AT1309 ON AT1309.DivisionID = Inserted.DivisionID AND Inserted.UnitID = AT1309.UnitID AND Inserted.InventoryID = AT1309.InventoryID
	LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN ('@@@', Inserted.DivisionID) AND AT1303.WareHouseID = AT2006.WareHouseID
	LEFT JOIN AT0113 WITH (NOLOCK) ON AT0113.DivisionID = Inserted.DivisionID AND AT0113.VoucherID = Inserted.InheritVoucherID AND AT0113.TransactionID = Inserted.InheritTransactionID
	LEFT JOIN AT0112 WITH (NOLOCK) ON AT0112.DivisionID = AT0113.DivisionID AND AT0112.VoucherID = AT0113.VoucherID

OPEN @D07_Cursor
FETCH NEXT FROM @D07_Cursor INTO @TransactionID, @DivisionID, @RDVoucherID, @TranYear, @TranMonth, ---- Thong tin chung
@RDVoucherDate, @RDVoucherNo, @EmployeeID, @ObjectID, @CreateUserID, @CreateDate, @Description, @WareHouseID, @WareHouseID2,
@Status, @KindVoucherID, @CurrencyID, @ExchangeRate, @InventoryID, @UnitID, @MethodID, @ActualQuantity, @UnitPrice,
@ConvertedQuantity, @ConvertedUnitPrice, @OriginalAmount, @ConvertedAmount, @DebitAccountID, @CreditAccountID, @SourceNo, @WarrantyNo, @ShelvesID, @FloorID,
@IsLimitDate, @IsSource, @LimitDate, @TableID, @BatchID, @Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, 
@Ana06ID, @Ana07ID, @Ana08ID, @Ana09ID, @Ana10ID, @Notes, @VoucherTypeID, @PeriodID, @ProductID, @IsTemp, @OrderID,
@OTransactionID, @MOrderID, @SOrderID, @IsGoodsFirstVoucher, @ReVoucherID, @ReTransactionID, @Parameter01, @Parameter02,
@Parameter03, @Parameter04, @Parameter05, @MarkQuantity, @ConvertedUnitID, @RefNo01, @RefNo02, @IsProduct, @KITID, @KITQuantity, @IsLedger, @Type

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @IsUpdatePrice = (SELECT TOP 1 IsUpdatePrice FROM AT0000 WHERE DefDivisionID = @DivisionID)

	IF @IsUpdatePrice = 0	
		EXEC AP0599 @TransactionID, @DivisionID, @RDVoucherID, @TranYear, @TranMonth, @RDVoucherDate, @RDVoucherNo, 
				@EmployeeID, @ObjectID, @CreateUserID, @CreateDate, @Description, @WareHouseID, @WareHouseID2, @Status,
				@KindVoucherID, @CurrencyID, @ExchangeRate, @InventoryID, @UnitID, @MethodID, @ActualQuantity, @UnitPrice, 
				@ConvertedQuantity, @ConvertedUnitPrice, @OriginalAmount, @ConvertedAmount, @DebitAccountID, @CreditAccountID,
				@SourceNo,@WarrantyNo, @ShelvesID, @FloorID, @IsLimitDate, @IsSource, @LimitDate, @TableID, @BatchID,	@Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, 
				@Ana06ID, @Ana07ID, @Ana08ID, @Ana09ID, @Ana10ID, @Notes, @VoucherTypeID, @PeriodID, @ProductID, @IsTemp, 
				@OrderID, @OTransactionID, @MOrderID, @SOrderID, @IsGoodsFirstVoucher, @ReVoucherID, @ReTransactionID,
				@Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @MarkQuantity, @ConvertedUnitID, @RefNo01, @RefNo02, @IsProduct, @KITID, @KITQuantity, @IsLedger, @Type
	ELSE 
		EXEC AP0599TL @TransactionID, @DivisionID, @RDVoucherID, @TranYear, @TranMonth, @RDVoucherDate, @RDVoucherNo, 
				@EmployeeID, @ObjectID, @CreateUserID, @CreateDate, @Description, @WareHouseID, @WareHouseID2, @Status,
				@KindVoucherID, @CurrencyID, @ExchangeRate, @InventoryID, @UnitID, @MethodID, @ActualQuantity, @UnitPrice, 
				@ConvertedQuantity, @ConvertedUnitPrice, @OriginalAmount, @ConvertedAmount, @DebitAccountID, @CreditAccountID,
				@SourceNo, @IsLimitDate, @IsSource, @LimitDate, @TableID, @BatchID,	@Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, 
				@Ana06ID, @Ana07ID, @Ana08ID, @Ana09ID, @Ana10ID, @Notes, @VoucherTypeID, @PeriodID, @ProductID, @IsTemp, 
				@OrderID, @OTransactionID, @MOrderID, @SOrderID, @IsGoodsFirstVoucher, @ReVoucherID, @ReTransactionID,
				@Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @MarkQuantity, @ConvertedUnitID, @RefNo01, @RefNo02, @IsProduct, @KITID, @KITQuantity, @IsLedger, @Type	

	
		

FETCH NEXT FROM @D07_Cursor INTO @TransactionID, @DivisionID, @RDVoucherID, @TranYear, @TranMonth, ---- Thong tin chung
@RDVoucherDate, @RDVoucherNo, @EmployeeID, @ObjectID, @CreateUserID, @CreateDate, @Description, @WareHouseID, @WareHouseID2,
@Status, @KindVoucherID, @CurrencyID, @ExchangeRate, @InventoryID, @UnitID, @MethodID, @ActualQuantity, @UnitPrice,
@ConvertedQuantity, @ConvertedUnitPrice, @OriginalAmount, @ConvertedAmount, @DebitAccountID, @CreditAccountID, @SourceNo, @WarrantyNo, @ShelvesID, @FloorID,
@IsLimitDate, @IsSource, @LimitDate, @TableID, @BatchID, @Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, 
@Ana06ID, @Ana07ID, @Ana08ID, @Ana09ID, @Ana10ID, @Notes, @VoucherTypeID, @PeriodID, @ProductID, @IsTemp, @OrderID,
@OTransactionID, @MOrderID, @SOrderID, @IsGoodsFirstVoucher, @ReVoucherID, @ReTransactionID, @Parameter01, @Parameter02,
@Parameter03, @Parameter04, @Parameter05, @MarkQuantity, @ConvertedUnitID, @RefNo01, @RefNo02, @IsProduct, @KITID, @KITQuantity, @IsLedger, @Type

END
CLOSE @D07_Cursor
DEALLOCATE @D07_Cursor

--- KET CHUYEN DU LIEU QUA POS
--IF (@CustomerName = 32) -- KH PhucLong
--BEGIN
--	SET @D07_Cursor = CURSOR SCROLL KEYSET FOR
--		SELECT Inserted.TransactionID, Inserted.DivisionID, Inserted.VoucherID, Inserted.TranYear, Inserted.TranMonth, ---- Thong tin chung
--		AT2006.VoucherDate, AT2006.VoucherNo, AT2006.EmployeeID, AT2006.ObjectID, AT2006.CreateUserID, AT2006.CreateDate, [Description], 
--		AT2006.WareHouseID, AT2006.WareHouseID2, 0, AT2006.KindVoucherID, Inserted.CurrencyID, Inserted.ExchangeRate, 
--		Inserted.InventoryID, Inserted.UnitID, AT1302.MethodID, Inserted.ActualQuantity, Inserted.UnitPrice, ISNULL(Inserted.ConvertedQuantity, 0),
--		ISNULL(Inserted.ConvertedPrice,0), Inserted.OriginalAmount, Inserted.ConvertedAmount, Inserted.DebitAccountID, Inserted.CreditAccountID, Inserted.SourceNo, 
--		AT1302.IsLimitDate, AT1302.IsSource, Inserted.LimitDate, AT2006.TableID, AT2006.BatchID, Inserted.Ana01ID, Inserted.Ana02ID, Inserted.Ana03ID, Inserted.Ana04ID, Inserted.Ana05ID, 
--		Inserted.Ana06ID, Inserted.Ana07ID, Inserted.Ana08ID, Inserted.Ana09ID, Inserted.Ana10ID, Inserted.Notes, VoucherTypeID, Inserted.PeriodID, Inserted.ProductID, 
--		AT1303.IsTemp, Inserted.OrderID, Inserted.OTransactionID, Inserted.MOrderID, Inserted.SOrderID, AT2006.IsGoodsFirstVoucher,
--		INSERTED.ReVoucherID, INSERTED.ReTransactionID, ISNULL(INSERTED.Parameter01, 0), ISNULL(INSERTED.Parameter02, 0),
--		ISNULL(INSERTED.Parameter03, 0), ISNULL(INSERTED.Parameter04, 0), ISNULL(INSERTED.Parameter05, 0), INSERTED.MarkQuantity,
--		Inserted.ConvertedUnitID, AT2006.RefNo01, AT2006.RefNo02, AT2006.IsProduct, INSERTED.KITID, INSERTED.KITQuantity, IsLedger,
--		AT1202.Note 	
--		FROM Inserted
--		INNER JOIN AT2006 ON AT2006.DivisionID = Inserted.DivisionID AND Inserted.VoucherID = AT2006.VoucherID AND Inserted.TranMonth = AT2006.TranMonth AND Inserted.TranYear = AT2006.TranYear 
--		INNER JOIN AT1302 ON Inserted.InventoryID = AT1302.InventoryID 
--		---LEFT JOIN AT1309 ON AT1309.DivisionID = Inserted.DivisionID AND Inserted.UnitID = AT1309.UnitID AND Inserted.InventoryID = AT1309.InventoryID
--		LEFT JOIN AT1303 ON AT1303.WareHouseID = AT2006.WareHouseID
--		LEFT JOIN AT0113 ON AT0113.DivisionID = Inserted.DivisionID AND AT0113.VoucherID = Inserted.InheritVoucherID AND AT0113.TransactionID = Inserted.InheritTransactionID
--		LEFT JOIN AT1202 ON AT1202.ObjectID = AT2006.ObjectID
--		WHERE (ISNULL(Note,'') <> '' OR AT2006.VoucherTypeID = 'N11')
--	OPEN @D07_Cursor
--	FETCH NEXT FROM @D07_Cursor INTO @TransactionID, @DivisionID, @RDVoucherID, @TranYear, @TranMonth, ---- Thong tin chung
--	@RDVoucherDate, @RDVoucherNo, @EmployeeID, @ObjectID, @CreateUserID, @CreateDate, @Description, @WareHouseID, @WareHouseID2,
--	@Status, @KindVoucherID, @CurrencyID, @ExchangeRate, @InventoryID, @UnitID, @MethodID, @ActualQuantity, @UnitPrice,
--	@ConvertedQuantity, @ConvertedUnitPrice, @OriginalAmount, @ConvertedAmount, @DebitAccountID, @CreditAccountID, @SourceNo, 
--	@IsLimitDate, @IsSource, @LimitDate, @TableID, @BatchID, @Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, 
--	@Ana06ID, @Ana07ID, @Ana08ID, @Ana09ID, @Ana10ID, @Notes, @VoucherTypeID, @PeriodID, @ProductID, @IsTemp, @OrderID,
--	@OTransactionID, @MOrderID, @SOrderID, @IsGoodsFirstVoucher, @ReVoucherID, @ReTransactionID, @Parameter01, @Parameter02,
--	@Parameter03, @Parameter04, @Parameter05, @MarkQuantity, @ConvertedUnitID, @RefNo01, @RefNo02, @IsProduct, @KITID, @KITQuantity, @IsLedger, @DepartmentCode

--	WHILE @@FETCH_STATUS = 0
--	BEGIN
--		EXEC AP0799 @TransactionID, @DivisionID, @RDVoucherID, @TranYear, @TranMonth, @RDVoucherDate, @RDVoucherNo, 
--					@EmployeeID, @ObjectID, @CreateUserID, @CreateDate, @Description, @WareHouseID, @WareHouseID2, @Status,
--					@KindVoucherID, @CurrencyID, @ExchangeRate, @InventoryID, @UnitID, @MethodID, @ActualQuantity, @UnitPrice, 
--					@ConvertedQuantity, @ConvertedUnitPrice, @OriginalAmount, @ConvertedAmount, @DebitAccountID, @CreditAccountID,
--					@SourceNo, @IsLimitDate, @IsSource, @LimitDate, @TableID, @BatchID,	@Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, 
--					@Ana06ID, @Ana07ID, @Ana08ID, @Ana09ID, @Ana10ID, @Notes, @VoucherTypeID, @PeriodID, @ProductID, @IsTemp, 
--					@OrderID, @OTransactionID, @MOrderID, @SOrderID, @IsGoodsFirstVoucher, @ReVoucherID, @ReTransactionID,
--					@Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @MarkQuantity, @ConvertedUnitID, 
--					@RefNo01, @RefNo02, @IsProduct, @KITID, @KITQuantity, @IsLedger, @DepartmentCode	
	

--	FETCH NEXT FROM @D07_Cursor INTO @TransactionID, @DivisionID, @RDVoucherID, @TranYear, @TranMonth, ---- Thong tin chung
--	@RDVoucherDate, @RDVoucherNo, @EmployeeID, @ObjectID, @CreateUserID, @CreateDate, @Description, @WareHouseID, @WareHouseID2,
--	@Status, @KindVoucherID, @CurrencyID, @ExchangeRate, @InventoryID, @UnitID, @MethodID, @ActualQuantity, @UnitPrice,
--	@ConvertedQuantity, @ConvertedUnitPrice, @OriginalAmount, @ConvertedAmount, @DebitAccountID, @CreditAccountID, @SourceNo, 
--	@IsLimitDate, @IsSource, @LimitDate, @TableID, @BatchID, @Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, 
--	@Ana06ID, @Ana07ID, @Ana08ID, @Ana09ID, @Ana10ID, @Notes, @VoucherTypeID, @PeriodID, @ProductID, @IsTemp, @OrderID,
--	@OTransactionID, @MOrderID, @SOrderID, @IsGoodsFirstVoucher, @ReVoucherID, @ReTransactionID, @Parameter01, @Parameter02,
--	@Parameter03, @Parameter04, @Parameter05, @MarkQuantity, @ConvertedUnitID, @RefNo01, @RefNo02, @IsProduct, @KITID, @KITQuantity, @IsLedger, @DepartmentCode

--	END
--	CLOSE @D07_Cursor
--	DEALLOCATE @D07_Cursor
--END

