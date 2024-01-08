IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AZ2017]') AND OBJECTPROPERTY(ID, N'IsTrigger') = 1)
DROP TRIGGER [DBO].[AZ2017]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Edit by: Dang Le Bao Quynh; Date: 22/09/2009
---- Purpose: Cap nhat lai ngay chung tu vao bang AT0114 khi co su thay doi
---- Edit by: Trần Lê Thiên Huỳnh; Date: 06/06/2012: Bổ sung 5 Khoản mục Ana06ID - Ana10ID
---- Edited by: [GS] [Hoàng Phước] [30/07/2010]
---- Edited by Bao Anh	Date: 05/08/2012
---- Purpose: Cap nhat du lieu cho AT2888 (so du ton kho co quy cach va so luong mark - yeu cau 2T)
---- Edited by Bao Anh	Date: 30/10/2012
---- Purpose: Cap nhat du lieu cho AT0114 (so du theo mark - yeu cau 2T)
---- Edited by Bao Anh	Date: 20/11/2012	
---- Purpose:	1. Lay dung gia tri cho @ConvertedQuantity = ConvertedQuantity
----			2. Dung @ActualQuantity cap nhat vao AT2008 va AT0114 (truoc day dung @ConvertedQuantity)
---- Modified by Thanh Sơn ON 07/01/2015: Bổ sung cho sửa Lô nhập, ngày hết hạn, kho nhập khi sửa phiếu nhập số dư (SourceNo)
---- Modified by Tiểu Mai on 15/06/2016: Bổ sung update tồn kho theo quy cách
---- Modified by Tiểu Mai on 24/08/2016: Fix bug tồn kho đầu kỳ chưa đúng
---- Modified by Tiểu Mai on 05/10/2016: Fix bug tồn kho đầu kỳ chưa đúng
---- Modified by Bảo Thy on 10/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Nhựt Trường on 30/12/2021 : Bổ sung điều kiện theo DivisionID khi JOIN bảng.

CREATE TRIGGER [dbo].[AZ2017] ON [dbo].[AT2017]
FOR UPDATE AS

DECLARE	@D07_Cursor CURSOR, @BaseCurrencyID NVARCHAR(50), @TEST NVARCHAR(800), @KindVoucherID TINYINT,
		@TransactionID NVARCHAR(50), @DivisionID NVARCHAR(50), @ModuleID NVARCHAR(50), @VoucherTypeID NVARCHAR(50),
		@VoucherID NVARCHAR(50), @VoucherNo NVARCHAR(50), @VoucherDate DATETIME, @TranYear INT, @TranMonth INT,
		@InventoryID NVARCHAR(50), @UnitID NVARCHAR(50), @ActualQuantity DECIMAL(28,8), @MarkQuantity DECIMAL(28,8),
		@UnitPrice DECIMAL(28,8), @ConvertedQuantity DECIMAL(28,8), @ConvertedUnitPrice	DECIMAL(28,8),
		@CurrencyID	NVARCHAR(20), @ExchangeRate	DECIMAL(28,8), @ConvertedAmount	DECIMAL(28,8), @OriginalAmount DECIMAL(28,8),
		@DebitAccountID	NVARCHAR(50), @CreditAccountID NVARCHAR(50), @WareHouseID NVARCHAR(50), @WareHouseID2 NVARCHAR(50),
		@Description NVARCHAR(255), @SourceNo NVARCHAR(50), @CreateUserID NVARCHAR(50), @CreateDate	DATETIME,
		@EmployeeID	NVARCHAR(50), @MethodID TINYINT, @ObjectID NVARCHAR(50), @Status TINYINT, @IsLimitDate TINYINT,
		@IsSource TINYINT, @LimitDate DATETIME, @Orders INT, @LastModIFyUserID NVARCHAR(50), @LastModIFyDate NVARCHAR(20),
		@Notes NVARCHAR(250), @Ana01ID NVARCHAR(50), @Ana02ID NVARCHAR(50), @Ana03ID NVARCHAR(50), @Ana04ID NVARCHAR(50),
		@Ana05ID NVARCHAR(50), @Ana06ID NVARCHAR(50), @Ana07ID NVARCHAR(50), @Ana08ID NVARCHAR(50), @Ana09ID NVARCHAR(50), @Ana10ID NVARCHAR(50),
		@IsTemp TINYINT, @Parameter01 DECIMAL(28,8), @Parameter02 DECIMAL(28,8), @Parameter03 DECIMAL(28,8), @Parameter04 DECIMAL(28,8),
		@Parameter05 DECIMAL(28,8),@S01ID VARCHAR(50), @S02ID VARCHAR(50), @S03ID VARCHAR(50), @S04ID VARCHAR(50),
		@S05ID VARCHAR(50), @S06ID VARCHAR(50), @S07ID VARCHAR(50), @S08ID VARCHAR(50), @S09ID VARCHAR(50), @S10ID VARCHAR(50),
		@S11ID VARCHAR(50), @S12ID VARCHAR(50), @S13ID VARCHAR(50), @S14ID VARCHAR(50), @S15ID VARCHAR(50), @S16ID VARCHAR(50),
		@S17ID VARCHAR(50), @S18ID VARCHAR(50), @S19ID VARCHAR(50), @S20ID VARCHAR(50)

SET @D07_Cursor = CURSOR SCROLL KEYSET FOR 
	SELECT Del.TransactionID, Del.DivisionID, Del.VoucherID, Del.TranYear, Del.TranMonth,   ---- Thong tin chung				
		T09.WareHouseID, T09.WareHouseID2, KindVoucherID, Del.InventoryID, T02.MethodID, ActualQuantity, MarkQuantity,
		ISNULL(ConvertedQuantity,0),---ActualQuantity*isnull(T04.ConversionFactor,1),				
		OriginalAmount, ConvertedAmount, DebitAccountID,CreditAccountID, T02.IsLimitDate, T02.IsSource,
		Isnull(Del.Parameter01, 0), ISNULL(Del.Parameter02,0), ISNULL(Del.Parameter03,0), ISNULL(Del.Parameter04,0), ISNULL(Del.Parameter05,0),
		O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
		O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID		
FROM Deleted Del
	INNER JOIN AT2016 T09 WITH (NOLOCK) ON Del.VoucherID = T09.VoucherID AND Del.DivisionID = T09.DivisionID AND Del.TranMonth = T09.TranMonth AND Del.TranYear = T09.TranYear
	INNER JOIN AT1302 T02 WITH (NOLOCK) ON T02.DivisionID IN ('@@@', Del.DivisionID) AND Del.InventoryID = T02.InventoryID
	LEFT JOIN AT1309 T04 WITH (NOLOCK) On T04.DivisionID IN ('@@@', Del.DivisionID) AND Del.UnitID = T04.UnitID AND Del.InventoryID = T04.InventoryID
	LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = Del.DivisionID AND O99.VoucherID = Del.VoucherID AND O99.TransactionID = Del.TransactionID
OPEN @D07_Cursor
FETCH NEXT FROM @D07_Cursor INTO @TransactionID, @DivisionID, @VoucherID, @TranYear, @TranMonth,   ---- Thong tin chung		
		@WareHouseID, @WareHouseID2, @KindVoucherID, @InventoryID, @MethodID, @ActualQuantity, @MarkQuantity,
		@ConvertedQuantity, @OriginalAmount, @ConvertedAmount, @DebitAccountID, @CreditAccountID, @IsLimitDate, @IsSource,
		@Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
		@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID
WHILE @@FETCH_STATUS = 0
BEGIN	
	----- Xoa bang tinh gia	
	IF @IsSource = 1 OR @IsLimitDate = 1 OR @MethodID IN (1,2,3)
	AND (SELECT ISNULL(IsSpecificate,0) FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID) = 0
	BEGIN
		UPDATE AT0114 SET ReQuantity = ReQuantity - @ActualQuantity,
						  EndQuantity = EndQuantity - @ActualQuantity,
						  ReMarkQuantity = ReMarkQuantity - @MarkQuantity,
						  EndMarkQuantity = EndMarkQuantity - @MarkQuantity
		WHERE DivisionID = @DivisionID
			AND WareHouseID = @WareHouseID
			AND	ReVoucherID = @VoucherID
			AND ReTransactionID = @TransactionID	
			
	END
	DELETE AT9000 WHERE TransactionID = @TransactionID AND TableID = 'AT2017' AND TransactionTypeID = 'T00' AND DivisionID = @DivisionID

	FETCH NEXT FROM @D07_Cursor INTO  @TransactionID, @DivisionID, @VoucherID, @TranYear, @TranMonth,   ---- Thong tin chung		
		@WareHouseID, @WareHouseID2, @KindVoucherID, @InventoryID, @MethodID, @ActualQuantity, @MarkQuantity,
		@ConvertedQuantity, @OriginalAmount, @ConvertedAmount, @DebitAccountID, @CreditAccountID, @IsLimitDate, @IsSource,
		@Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
		@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID

END
CLOSE @D07_Cursor
DEALLOCATE @D07_Cursor


SET @D07_Cursor = CURSOR SCROLL KEYSET FOR
	SELECT Ins.TransactionID, ins.DivisionID, ins.VoucherID, ins.TranYear, ins.TranMonth,   ---- Thong tin chung
		T09.VoucherDate, T09.VoucherNo, EmployeeID, ObjectID, T09.CreateUserID, T09.CreateDate, [Description],		
		T09.WareHouseID, T09.WareHouseID2, 0, KindVoucherID, ins.CurrencyID, ins.ExchangeRate, ins.InventoryID,
		ins.UnitID,  T02.MethodID MethodID, ActualQuantity, MarkQuantity, UnitPrice, ActualQuantity * ISNULL(T04.ConversionFactor, 1),		
		UnitPrice / ISNULL(T04.ConversionFactor, 1), OriginalAmount, ConvertedAmount, DebitAccountID, CreditAccountID, ins.SourceNo,
		T02.IsLimitDate, T02.IsSource, Ins.LimitDate, Ins.Orders, T09.LastModifyUserID, T09.LastModifyDate, Ins.Notes, 
		Ins.Ana01ID, Ins.Ana02ID, Ins.Ana03ID, Ins.Ana04ID, Ins.Ana05ID, Ins.Ana06ID, Ins.Ana07ID, Ins.Ana08ID, Ins.Ana09ID, Ins.Ana10ID,
		T03.IsTemp, ISNULL(ins.Parameter01, 0), ISNULL(ins.Parameter02, 0), ISNULL(ins.Parameter03, 0), ISNULL(ins.Parameter04, 0), ISNULL(ins.Parameter05, 0)
	FROM inserted ins
		INNER JOIN AT2016 T09 WITH (NOLOCK) ON ins.DivisionID = T09.DivisionID AND ins.VoucherID = T09.VoucherID
			AND	ins.TranMonth = T09.TranMonth AND ins.TranYear = T09.TranYear
		INNER JOIN AT1302 T02 WITH (NOLOCK) ON T02.DivisionID IN ('@@@', ins.DivisionID) AND ins.InventoryID = T02.InventoryID
		LEFT JOIN AT1309 T04 WITH (NOLOCK) ON	T04.DivisionID IN (ins.DivisionID,'@@@') AND ins.UnitID = T04.UnitID AND	ins.InventoryID = T04.InventoryID
		INNER JOIN AT1303 T03 WITH (NOLOCK) ON T03.DivisionID IN (ins.DivisionID,'@@@') AND T03.WareHouseID = T09.WareHouseID
				
OPEN @D07_Cursor
FETCH NEXT FROM @D07_Cursor INTO @TransactionID, @DivisionID, @VoucherID, @TranYear, @TranMonth,   ---- Thong tin chung
		@VoucherDate, @VoucherNo, @EmployeeID, @ObjectID, @CreateUserID, @CreateDate, @Description,	@WareHouseID,
		@WareHouseID2, @Status, @KindVoucherID, @CurrencyID, @ExchangeRate, @InventoryID, @UnitID, @MethodID, 
		@ActualQuantity, @MarkQuantity, @UnitPrice, @ConvertedQuantity, @ConvertedUnitPrice, @OriginalAmount,
		@ConvertedAmount, @DebitAccountID, @CreditAccountID, @SourceNo, @IsLimitDate, @IsSource, @LimitDate,
		@Orders, @LastModifyUserID, @LastModifyDate, @Notes, @Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, 
		@Ana06ID, @Ana07ID, @Ana08ID, @Ana09ID, @Ana10ID, @IsTemp, @Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05                                       

WHILE @@FETCH_STATUS = 0
BEGIN
	IF @IsSource = 1 OR @IsLimitDate = 1 OR @MethodID IN (1,2,3)
	AND (SELECT ISNULL(IsSpecificate,0) FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID) = 0
	BEGIN
		UPDATE AT0114 SET UnitPrice = CASE WHEN ReQuantity + @ActualQuantity <> 0 THEN @ConvertedAmount/ (ReQuantity + @ActualQuantity) ELSE @UnitPrice END,
						  ReQuantity = ReQuantity + @ActualQuantity, EndQuantity = EndQuantity +  @ActualQuantity,
						  ReMarkQuantity = ReMarkQuantity + @MarkQuantity, EndMarkQuantity = EndMarkQuantity + @MarkQuantity,
						  ReVoucherNo = @VoucherNo, ReVoucherDate = @VoucherDate, ReSourceNo = @SourceNo, LimitDate = @LimitDate,
						  WareHouseID = @WareHouseID
		WHERE DivisionID = @DivisionID AND ReVoucherID = @VoucherID AND ReTransactionID = @TransactionID
	END	
	
	--- Không thiết lập quy cách
	IF NOT EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	BEGIN 
		EXEC AP0699 @TransactionID, @DivisionID, @VoucherID, @TranYear, @TranMonth, @VoucherDate, @VoucherNo, 
			@EmployeeID, @ObjectID, @VoucherTypeID, @CreateUserID, @CreateDate, @Description, @WareHouseID,
			@WareHouseID2, @Status, @KindVoucherID, @CurrencyID, @ExchangeRate,	@InventoryID, @UnitID, 
			@MethodID, @ActualQuantity, @UnitPrice, @ConvertedQuantity,@ConvertedUnitPrice,	@OriginalAmount, @ConvertedAmount,
			@DebitAccountID, @CreditAccountID, @SourceNo, @IsLimitDate, @IsSource, @LimitDate, @Orders,
			@LastModifyUserID, @LastModifyDate, @Notes, @Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, 
			@Ana06ID, @Ana07ID, @Ana08ID, @Ana09ID, @Ana10ID, @IsTemp, @Parameter01, @Parameter02,
			@Parameter03, @Parameter04, @Parameter05, @MarkQuantity
	END 
	ELSE 
	BEGIN
			If isnull(@IsTemp,0) =0 
				Insert AT9000 (VoucherID, BatchID, TransactionID, TableID, DivisionID, TranMonth, TranYear, TransactionTypeID,
				CurrencyID, ObjectID, DebitAccountID, ExchangeRate, OriginalAmount, ConvertedAmount,
				VoucherDate, VoucherTypeID, VoucherNo, Orders, EmployeeID, VDescription, BDescription, TDescription,
				Quantity, InventoryID, UnitID, Status, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, 
				Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
				UParameter01, UParameter02, UParameter03, UParameter04, UParameter05, MarkQuantity, ConvertedQuantity)    
				Values
				(@VoucherID, @VoucherID, @TransactionID, N'AT2017',
				@DivisionID, @TranMonth, @TranYear, N'T00',  --- So Du 
				@CurrencyID, @ObjectID, @DebitAccountID, 
				@ExchangeRate,          @OriginalAmount, @ConvertedAmount,
				@VoucherDate, @VoucherTypeID, @VoucherNo,                        
				@Orders, @EmployeeID, @Description, @Description, @Notes, @ActualQuantity,                       
				@InventoryID, @UnitID, 0, @CreateDate, @CreateUserID, @LastModifyDate, @LastModifyUserID, 
				@Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, @Ana06ID, @Ana07ID, @Ana08ID, @Ana09ID, @Ana10ID,
				@Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @MarkQuantity, @ConvertedQuantity)
		END	
	FETCH NEXT FROM @D07_Cursor INTO @TransactionID, @DivisionID, @VoucherID, @TranYear, @TranMonth,   ---- Thong tin chung
			@VoucherDate, @VoucherNo, @EmployeeID, @ObjectID, @CreateUserID, @CreateDate, @Description,	@WareHouseID,
			@WareHouseID2, @Status, @KindVoucherID, @CurrencyID, @ExchangeRate, @InventoryID, @UnitID, @MethodID, 
			@ActualQuantity, @MarkQuantity, @UnitPrice, @ConvertedQuantity, @ConvertedUnitPrice, @OriginalAmount,
			@ConvertedAmount, @DebitAccountID, @CreditAccountID, @SourceNo, @IsLimitDate, @IsSource, @LimitDate,
			@Orders, @LastModifyUserID, @LastModifyDate, @Notes, @Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, 
			@Ana06ID, @Ana07ID, @Ana08ID, @Ana09ID, @Ana10ID, @IsTemp, @Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05                                   

END
CLOSE @D07_Cursor
DEALLOCATE @D07_Cursor



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
