IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AY2017]') AND OBJECTPROPERTY(ID, N'IsTrigger') = 1)
DROP TRIGGER [DBO].[AY2017]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/********************************************
'* Edited by: [GS] [Hoàng Phước] [30/07/2010]
'********************************************/
--Edit by: Trần Lê Thiên Huỳnh; Date: 06/06/2012: Bổ sung 5 Khoản mục Ana06ID - Ana10ID
--- Edited by Bao Anh	Date: 05/08/2012
--- Purpose: Cap nhat du lieu cho AT2888 (so du ton kho co quy cach va so luong mark - yeu cau 2T)
--- Edited by Bao Anh	Date: 30/10/2012
--- Purpose: Cap nhat du lieu cho AT0114 (so luong mark - yeu cau 2T)
--- Edited by Bao Anh	Date: 20/11/2012	
--- Purpose:	1. Lay dung gia tri cho @ConvertedQuantity = ConvertedQuantity
---				2. Dung @ActualQuantity cap nhat vao AT2008 va AT0114 (truoc day dung @ConvertedQuantity)
--- Modified by Bảo Thy on 21/04/2017: Nếu ko quản lý theo quy cách thì INSERT AT0114 tại đây. Ngược lại thì insert trong WY8899
--- Modified by Bảo Thy on 10/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Nhựt Trường on 25/01/2021: Bổ sung điều kiện DivisionID IN khi join các bảng có sử dụng nhiều DivisionID.
CREATE TRIGGER [dbo].[AY2017]  ON [dbo].[AT2017]
FOR INSERT As
Declare		@D07_Cursor		Cursor,
		@BaseCurrencyID as nvarchar(50)

Declare  	
	@KindVoucherID  	TinyInt ,
	@TransactionID		nvarchar(50),
	@DivisionID		nvarchar(50),	@ModuleID		nvarchar(50),
	@VoucherTypeID	nvarchar(50),			
	@RDVoucherID		nvarchar(50), 	@RDVoucherNo	nvarchar(50),	
	@RDVoucherDate	Datetime,			
	@TranYear		Int,		@TranMonth		int,
	@InventoryID		nvarchar(50),	@UnitID		nvarchar(50),
	@ActualQuantity	Decimal(28,8),	
	@MarkQuantity Decimal(28,8),	
	@UnitPrice		Decimal(28,8),
	@ConvertedQuantity	Decimal(28,8),	@ConvertedUnitPrice	Decimal(28,8),
	@CurrencyID		nvarchar(50),	@ExchangeRate	Decimal(28,8),		
	@ConvertedAmount	Decimal(28,8),		@OriginalAmount	Decimal(28,8),
	@DebitAccountID	nvarchar(50), 	@CreditAccountID	nvarchar(50),
	@WareHouseID		nvarchar(50),	@WareHouseID2	nvarchar(50),
	@Description		nvarchar(255),	@SourceNo		nvarchar(50),
	@CreateUserID		nvarchar(50),	@CreateDate		Datetime,
	@EmployeeID		nvarchar(50),	@MethodID		tinyint,
	@ObjectID		nvarchar(50),
	@Status		tinyint,
	@IsLimitDate 		tinyint,
	@IsSource		tinyint,		
	@LimitDate		Datetime,
	@Orders as int ,
	@LastModifyUserID as nvarchar(50),
	@LastModifyDate as nvarchar(20),
	@Notes as nvarchar(250),
	@Ana01ID as nvarchar(50), @Ana02ID as nvarchar(50),	@Ana03ID as nvarchar(50), @Ana04ID as nvarchar(50),	@Ana05ID as nvarchar(50),
	@Ana06ID as nvarchar(50), @Ana07ID as nvarchar(50),	@Ana08ID as nvarchar(50), @Ana09ID as nvarchar(50),	@Ana10ID as nvarchar(50),
	@IsTemp as TINYINT,  --- Xy ly kho tam
	@Parameter01 AS DECIMAL(28,8),
	@Parameter02 AS DECIMAL(28,8),
	@Parameter03 AS DECIMAL(28,8),
	@Parameter04 AS DECIMAL(28,8),
	@Parameter05 AS DECIMAL(28,8)

Set @D07_Cursor = Cursor Scroll KeySet For
Select 		Ins.TransactionID, ins.DivisionID, ins.VoucherID, ins.TranYear, ins.TranMonth,   ---- Thong tin chung
		T09.VoucherDate,  T09.VoucherNo, 
		EmployeeID,  ObjectID,   T09.CreateUserID, T09.CreateDate,  Description,		
		T09.WareHouseID, T09.WareHouseID2,  0 , KindVoucherID,
		ins.CurrencyID, ins.ExchangeRate,
		ins.InventoryID, ins.UnitID,  T02.MethodID as MethodID, 
		ActualQuantity, MarkQuantity, UnitPrice,
		Isnull(ConvertedQuantity,0),---ActualQuantity*isnull(T04.ConversionFactor,1),		
		UnitPrice/isnull(T04.ConversionFactor,1),
		OriginalAmount, ConvertedAmount,
		DebitAccountID,CreditAccountID,    ins.SourceNo,
		T02.IsLimitDate, T02.IsSource, Ins.LimitDate,
		Ins.Orders , T09.LastModifyUserID, T09.LastModifyDate, Ins.Notes,
		Ins.Ana01ID, Ins.Ana02ID,Ins.Ana03ID, Ins.Ana04ID, Ins.Ana05ID,
		Ins.Ana06ID, Ins.Ana07ID,Ins.Ana08ID, Ins.Ana09ID, Ins.Ana10ID,
		T03.IsTemp,
		Isnull(ins.Parameter01,0), Isnull(ins.Parameter02,0), Isnull(ins.Parameter03,0), Isnull(ins.Parameter04,0), Isnull(ins.Parameter05,0),
		T09.VoucherTypeID

From 	inserted ins 	Inner Join AT2016 T09 WITH (NOLOCK)
						On 	ins.VoucherID = T09.VoucherID And 
							ins.DivisionID = T09.DivisionID And
							ins.TranMonth = T09.TranMonth And 
							ins.TranYear = T09.TranYear
			inner join AT1302 T02 WITH (NOLOCK) on T02.DivisionID IN ('@@@', ins.DivisionID) AND ins.InventoryID = T02.InventoryID
			Left  join AT1309 T04 WITH (NOLOCK) On	T04.DivisionID In ('@@@', ins.DivisionID) AND ins.UnitID 	= T04.UnitID and ins.InventoryID 	= T04.InventoryID
			Inner join AT1303 T03 WITH (NOLOCK)	on 	T03.DivisionID In ('@@@', ins.DivisionID) AND T03.WareHouseID = T09.WareHouseID

Open @D07_Cursor
Fetch Next From @D07_Cursor Into @TransactionID, @DivisionID, @RDVoucherID, @TranYear, @TranMonth,   ---- Thong tin chung
		@RDVoucherDate,  @RDVoucherNo, 
		@EmployeeID,  @ObjectID,   @CreateUserID, @CreateDate,  @Description,
		@WareHouseID, @WareHouseID2,  @Status, @KindVoucherID,
		@CurrencyID, @ExchangeRate,	
		@InventoryID, @UnitID,  @MethodID, 
		@ActualQuantity, @MarkQuantity, @UnitPrice,
		@ConvertedQuantity, @ConvertedUnitPrice,	@OriginalAmount, @ConvertedAmount,
		@DebitAccountID,@CreditAccountID,    @SourceNo,
		@IsLimitDate, @IsSource, @LimitDate,@Orders ,@LastModifyUserID,@LastModifyDate,@Notes, 
		@Ana01ID,@Ana02ID,@Ana03ID,@Ana04ID,@Ana05ID,
		@Ana06ID,@Ana07ID,@Ana08ID,@Ana09ID,@Ana10ID,
		@IsTemp, @Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @VoucherTypeID
                                         

While @@FETCH_STATUS = 0
Begin	

If (@IsSource<>0 or @IsLimitDate <>0 or @MethodID in (1,2,3) ) 	--- and    @KindVoucherID in (1,3)
AND (SELECT ISNULL(IsSpecificate,0) FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID) = 0	

	Begin
		---print 'Insert vao bang tinh gia xuat kho: AT0114'	
		Insert AT0114 (InventoryID, DivisionID, WareHouseID, ReVoucherID, ReTransactionID,   ReVoucherNo,
	                                	ReVoucherDate,  ReTranMonth,ReTranYear, ReSourceNo,    ReQuantity,  DeQuantity,
		                 	EndQuantity,    UnitPrice  ,  Status, LimitDate, ReMarkQuantity,  DeMarkQuantity, EndMarkQuantity)
		Values (@InventoryID, @DivisionID, @WareHouseID, @RDVoucherID, @TransactionID,   @RDVoucherNo, 
			@RDVoucherDate,  @TranMonth, @TranYear, @SourceNo, @ActualQuantity, 0, 
			@ActualQuantity, 
			Case when @ActualQuantity<>0 then @ConvertedAmount/@ActualQuantity else @ConvertedUnitPrice End,
			0, @LimitDate, @MarkQuantity, 0, @MarkQuantity)
	End

	IF NOT EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	BEGIN 
		EXEC AP0699  @TransactionID, @DivisionID, @RDVoucherID, @TranYear, @TranMonth,   
			@RDVoucherDate,  @RDVoucherNo, 
			@EmployeeID,  @ObjectID,  @VoucherTypeID, @CreateUserID, @CreateDate,  @Description,
			@WareHouseID, @WareHouseID2,  @Status, @KindVoucherID,
			@CurrencyID, @ExchangeRate,	@InventoryID, @UnitID,  @MethodID, @ActualQuantity, @UnitPrice,
			@ConvertedQuantity,@ConvertedUnitPrice,	@OriginalAmount, @ConvertedAmount,
			@DebitAccountID,@CreditAccountID,    @SourceNo,
			@IsLimitDate, @IsSource, @LimitDate ,@Orders ,@LastModifyUserID,@LastModifyDate,@Notes,
			@Ana01ID,@Ana02ID,@Ana03ID,@Ana04ID,@Ana05ID,
			@Ana06ID,@Ana07ID,@Ana08ID,@Ana09ID,@Ana10ID,
			@IsTemp,@Parameter01,@Parameter02,@Parameter03,@Parameter04,@Parameter05, @MarkQuantity
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
				(@RDVoucherID, @RDVoucherID, @TransactionID, N'AT2017',
				@DivisionID, @TranMonth, @TranYear, N'T00',  --- So Du 
				@CurrencyID, @ObjectID, @DebitAccountID, 
				@ExchangeRate,          @OriginalAmount, @ConvertedAmount,
				@RDVoucherDate, @VoucherTypeID, @RDVoucherNo,                        
				@Orders, @EmployeeID, @Description, @Description, @Notes, @ActualQuantity,                       
				@InventoryID, @UnitID, 0, @CreateDate, @CreateUserID, @LastModifyDate, @LastModifyUserID, 
				@Ana01ID, @Ana02ID, @Ana03ID, @Ana04ID, @Ana05ID, @Ana06ID, @Ana07ID, @Ana08ID, @Ana09ID, @Ana10ID,
				@Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @MarkQuantity, @ConvertedQuantity)
		END
Fetch Next From @D07_Cursor Into @TransactionID, @DivisionID, @RDVoucherID, @TranYear, @TranMonth,   ---- Thong tin chung
		@RDVoucherDate,  @RDVoucherNo, 
		@EmployeeID,  @ObjectID,   @CreateUserID, @CreateDate,  @Description,
		@WareHouseID, @WareHouseID2,  @Status, @KindVoucherID,
		@CurrencyID, @ExchangeRate,	
		@InventoryID, @UnitID,  @MethodID, 
		@ActualQuantity, @MarkQuantity, @UnitPrice,
		@ConvertedQuantity, @ConvertedUnitPrice,	@OriginalAmount, @ConvertedAmount,
		@DebitAccountID,@CreditAccountID,    @SourceNo,
		@IsLimitDate, @IsSource, @LimitDate , @Orders ,@LastModifyUserID,@LastModifyDate,@Notes,
		@Ana01ID,@Ana02ID,@Ana03ID,@Ana04ID,@Ana05ID,
		@Ana06ID,@Ana07ID,@Ana08ID,@Ana09ID,@Ana10ID,
		@IsTemp, @Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @VoucherTypeID                               

End
Close @D07_Cursor
DeAllocate @D07_Cursor


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
