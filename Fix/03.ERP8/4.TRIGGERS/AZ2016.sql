IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AZ2016]') AND OBJECTPROPERTY(ID, N'IsTrigger') = 1)
DROP TRIGGER [DBO].[AZ2016]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


    

---- Created by Tiểu Mai on 24/08/2016 
---- Purpose: Nếu thay đổi kho tồn đầu thì cập nhật lại số dư  
---- Modified by Tiểu Mai on 20/09/2016: Fix bug tồn kho đầu kỳ sai khi sửa phiếu 
---- Modified by Tiểu Mai on 06/10/2016: Fix bug tồn kho chưa đúng
---- Modified by Tiểu Mai on 26/05/2017: Chỉnh sửa danh mục dùng chung và bổ sung WITH (NOLOCK)
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung

CREATE TRIGGER [dbo].[AZ2016] ON [dbo].[AT2016]     
FOR  UPDATE    
AS    

Declare  @AT2016_cur as cursor,    
	@DivisionID as nvarchar(50),    
	@WareHouseID_Old  as nvarchar(50),    
	@WareHouseID_New  as nvarchar(50),    
	@WareHouseID2_Old  as nvarchar(50),    
	@WareHouseID2_New  as nvarchar(50),    
	@KindVoucherID  as nvarchar(50),    
	@VoucherID as nvarchar(50),    
	@RDVoucherID as nvarchar (50),
	@BatchID as nvarchar(50),
	@TransactionID as nvarchar(50),
	@TableID as nvarchar(50),
	@TranMonth int,    
	@TranYear int,    
	@CurrencyID NVARCHAR(50), 
	@ObjectID NVARCHAR(50), 
	@ExchangeRate DECIMAL(28, 8), 
	@OriginalAmount DECIMAL(28, 8), 
	@RDVoucherDate DATETIME, 
	@VoucherTypeID NVARCHAR(50), 
	@RDVoucherNo NVARCHAR(50), 
	@EmployeeID NVARCHAR(50), 
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
	@ActualQuantity DECIMAL(28, 8), 
	@Description NVARCHAR(255), 
	@CreateUserID NVARCHAR(50), 
	@CreateDate DATETIME, 
	@WareHouseID NVARCHAR(50),
	@WareHouseID2 NVARCHAR(50), 
	@UnitPrice DECIMAL(28, 8),
	@Status TINYINT, 
	@UnitID NVARCHAR(50),
	@ConvertedQuantity DECIMAL(28, 8), 
	@ConvertedUnitPrice DECIMAL(28, 8), 
	@ProductID NVARCHAR(50), 
	@OrderID NVARCHAR(50), 
	@SourceNo NVARCHAR(50), 
	@LimitDate DATETIME, 
	@PeriodID NVARCHAR(50), 
	@OTransactionID NVARCHAR(50), 
	@MOrderID NVARCHAR(50), 
	@SOrderID NVARCHAR(50),
	@IsGoodsFirstVoucher AS TINYINT,
	@ReVoucherID AS NVARCHAR(50),
	@MarkQuantity AS DECIMAL(28,8),
    @ReTransactionID NVARCHAR(50),
	@ConvertedUnitID NVARCHAR(50),
	
	@AT2017_cur as cursor,    
	@InventoryID as nvarchar(50),    
	@DebitAccountID as nvarchar(50),    
	@CreditAccountID as nvarchar(50),    
	@Quantity as Decimal(28,8),    
	@ConvertedAmount as decimal(28,8),    
	@MethodID as tinyint,    
	@IsSource as tinyint,    
	@IsLimitDate as tinyint,    
	@VoucherNo as nvarchar(50),    
	@Parameter01 as decimal(28,8),    
	@Parameter02 as decimal(28,8),    
	@Parameter03 as decimal(28,8),    
	@Parameter04 as decimal(28,8),    
	@Parameter05 as decimal(28,8),    
	@CustomerName INT,
	@Istemp int,    
	@Istemp_Old int,
	@S01ID VARCHAR(50), @S02ID VARCHAR(50), @S03ID VARCHAR(50), @S04ID VARCHAR(50),
	@S05ID VARCHAR(50), @S06ID VARCHAR(50), @S07ID VARCHAR(50), @S08ID VARCHAR(50), @S09ID VARCHAR(50), @S10ID VARCHAR(50),
	@S11ID VARCHAR(50), @S12ID VARCHAR(50), @S13ID VARCHAR(50), @S14ID VARCHAR(50), @S15ID VARCHAR(50), @S16ID VARCHAR(50),
	@S17ID VARCHAR(50), @S18ID VARCHAR(50), @S19ID VARCHAR(50), @S20ID VARCHAR(50),
	@VoucherDate DATETIME, @Orders INT 
	
--Tao bang tam de kiem tra day co phai la khach hang 2T khong (CustomerName = 15)    
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)    
INSERT #CustomerName EXEC AP4444    
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)    

 
Set @Istemp = (Select Istemp from AT1303 WITH (NOLOCK) inner join inserted ins on AT1303.WareHouseID =ins.WareHouseID and AT1303.DivisionID IN (ins.DivisionID,'@@@'))
Set @Istemp_old = (Select Istemp from AT1303 WITH (NOLOCK) inner join deleted del on AT1303.WareHouseID =del.WareHouseID and AT1303.DivisionID IN (del.DivisionID,'@@@'))

Set @AT2016_cur = Cursor Scroll KeySet For    
 Select Ins.KindVoucherID,  Ins.VoucherID, Ins.DivisionID, Ins.TranMonth, Ins.TranYear, Del.WareHouseID, isnull(Del.WareHouseID2,''), Ins.WareHouseID, isnull(Ins.WareHouseID2,''),Ins.VoucherNo    
 From   inserted Ins  inner join Deleted  Del on Ins.VoucherID = Del.VoucherID and Ins.DivisionID = Del.DivisionID    
        
 --Where  (Del.WareHouseID <> Ins.WareHouseID) Or    
 -- (isnull(Del.WareHouseID2,'')<> isnull(Ins.WareHouseID2,'') and Ins.KindVoucherID =3)    
 -- and Ins.DivisionID = Del.DivisionID    
    
Open @AT2016_cur    
Fetch Next From @AT2016_cur Into @KindVoucherID, @VoucherID, @DivisionID ,@TranMonth, @TranYear,  @WareHouseID_Old, @WareHouseID2_Old, @WareHouseID_New, @WareHouseID2_New, @VoucherNo    
While @@FETCH_STATUS = 0    
Begin    
	
 Set @AT2017_cur = Cursor Scroll KeySet For    
        Select AT2017.InventoryID, ActualQuantity, ConvertedAmount, DebitAccountID, CreditAccountID, MethodID, IsSource, IsLimitDate,    
          AT2017.Parameter01, AT2017.Parameter02, AT2017.Parameter03, AT2017.Parameter04, AT2017.Parameter05,
          O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID, 
          O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID    
  From AT2017 WITH (NOLOCK) inner join AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN ('@@@', AT2017.DivisionID) AND AT1302.InventoryID = AT2017.InventoryID
  LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = AT2017.DivisionID AND O99.TransactionID = AT2017.TransactionID AND O99.VoucherID = AT2017.VoucherID   
 Where AT2017.DivisionID = @DivisionID and TranMonth = @TranMonth and TranYear = @TranYear and AT2017.VoucherID = @VoucherID    
    
 Open @AT2017_cur    
 Fetch Next From @AT2017_cur Into @InventoryID, @Quantity, @ConvertedAmount, @DebitAccountID, @CreditAccountID , @MethodID, @IsSource, @IsLimitDate,    
			@Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
			@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID
    
 While @@FETCH_STATUS = 0                
 Begin    
	If @KindVoucherID in (1,3,5,7,9,15,17)   --- Nhap kho     
		 If @MethodID in (1, 2, 3) Or @IsSource<>0 or @IsLimitDate <>0    
			Update AT0114 set WareHouseID =@WareHouseID_New, ReVoucherNo = @VoucherNo    
			Where  ReVoucherID =@VoucherID and    
			InventoryID = @InventoryID and DivisionID = @DivisionID 
	
	---- Cập nhật tồn không theo quy cách		
	IF NOT EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	BEGIN 
		EXEC AP0612 @DivisionID, @WareHouseID_Old, @TranMonth, @TranYear, @InventoryID, @ConvertedAmount, @Quantity, @DebitAccountID,
			@CreditAccountID, 0, @Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @MarkQuantity -- (1) la cap nhat tang,(0 ) la cap nhat giam
	END 	
		
	Fetch Next From @AT2017_cur Into @InventoryID, @Quantity, @ConvertedAmount, @DebitAccountID, @CreditAccountID , @MethodID, @IsSource, @IsLimitDate,    
			@Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
			@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID       
 End     
 Close @AT2017_cur    
        
Fetch Next From @AT2016_cur Into @KindVoucherID, @VoucherID, @DivisionID ,@TranMonth, @TranYear,  @WareHouseID_Old, @WareHouseID2_Old, @WareHouseID_New, @WareHouseID2_New, @VoucherNo    
End    
     
Close @AT2016_cur 

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
