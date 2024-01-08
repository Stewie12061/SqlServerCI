IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AX2007]') AND OBJECTPROPERTY(ID, N'IsTrigger') = 1)
DROP TRIGGER [DBO].[AX2007]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--Edit by: Dang Le Bao Quynh; Date: 16/01/2009
--Purpose: Bo sung truong hop xuat hang mua tra lai
--Edit by: Nguyen Quoc Huy, Date: 06.08.2009
--Edit by: Dang Le Bao Quynh; Date: 23/02/2010
--Purpose: Them kindvoucherID cho cac truong hop nhap kho mua hang, xuat kho ban hang
--- Edited by Bao Anh	Date: 05/08/2012
--- Purpose: Them quy cach va so luong mark (yeu cau cua 2T)
--- Edited by Bao Anh	Date: 20/11/2012	
--- Purpose:	1. Lay dung gia tri cho @ConvertedQuantity = ConvertedQuantity
---				2. Dung @ActualQuantity cap nhat vao AT2008 va AT0114 (truoc day dung @ConvertedQuantity)
--- Edit by Tiểu Mai, Date 02/11/2015, Purpose: bổ sung trường hợp quản lý theo quy cách.
--- Modified by Tiểu Mai on 02/03/2016: Bổ sung trường IsProduct và điều kiện vào store AP0513 (ANGEL)
--- Modified by Tiểu Mai on 12/08/2016: Chuyển xử lý quy cách qua trigger WX8899
--- Modified by Tiểu Mai on 05/10/2016: Fix bug tồn kho đầu kỳ chưa đúng, bỏ trigger WX8899
--- Modified by Tiểu Mai on 18/10/2016: Sửa lại fix update tồn kho, chuyển về WX8899 khi thiết lập quy cách
--- Modified by Bảo Thy on 20/04/2017: Nếu không theo quy cách thì delete AT0114 tại đây, ngược lại thì delete tại WX8899 (TUNGTEX)
--- Modified by Kim Vũ on 20/04/2017: Bổ sung xóa dữ liệu trung gian khi xóa phiếu Customize PL
--- Modified by Bảo Anh on 03/05/2017: Sửa lỗi không update AT2008 đối với phiếu nhập/xuất kho khu mua/bán hàng (TableID = 'AT9000')
--- Modified by Bảo Thy on 10/05/2017: Sửa danh mục dùng chung
--- Modified by Bảo Thy on 30/05/2017: Nếu sửa/xóa phiếu giảm giá xuất kho => đơn giá mặt hàng cộng lại số tiền đã được giảm
--- Modified by Bảo Anh on 04/04/2018: Update SL xuất và tồn cuối cho AT0114 khi xóa phiếu xuất/chuyển kho
--- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
--- Modified by Lê Hoàng on 04/10/2021 : Bổ sung custom NamHoa - khi vận chuyển nội bộ
--- Modified by Lê Hoàng on 14/10/2021 : Stored AP0516 bổ sung biến DebitAccountID, CreditAccountID

/********************************************
'* Edited by: [GS] [Hoàng Phước] [30/07/2010]
'********************************************/


CREATE TRIGGER [dbo].[AX2007] ON [dbo].[AT2007] 
FOR DELETE 
AS

Declare		@D07_Cursor		Cursor
Declare  	
	@KindVoucherID  	TinyInt ,
	@TransactionID		nvarchar(50),
	@DivisionID		nvarchar(50),		
	@RDVoucherID		nvarchar(50), 	
	@InventoryID		nvarchar(50), 	
	@MethodID		tinyint,
	@TranYear		Int,		
	@TranMonth		int,
	@ActualQuantity	Decimal(28,8),	
	@ConvertedQuantity	Decimal(28,8),	
	@ConvertedAmount	decimal(28,8),		
	@OriginalAmount	decimal(28,8),
	@DebitAccountID	nvarchar(50), 	
	@CreditAccountID	nvarchar(50),
	@WareHouseID		nvarchar(50),	
	@WareHouseID2	nvarchar(50),
	@IsLimitDate 		tinyint,
	@IsSource		tinyint,
	@TableID		nvarchar(50),
	@Parameter01 AS DECIMAL(28,8),
	@Parameter02 AS DECIMAL(28,8),
	@Parameter03 AS DECIMAL(28,8),
	@Parameter04 AS DECIMAL(28,8),
	@Parameter05 AS DECIMAL(28,8),
	@MarkQuantity AS DECIMAL(28,8),
	@S01ID VARCHAR(50),
	@S02ID VARCHAR(50),
    @S03ID VARCHAR(50),
    @S04ID VARCHAR(50),
    @S05ID VARCHAR(50),
    @S06ID VARCHAR(50),
    @S07ID VARCHAR(50),
    @S08ID VARCHAR(50),
    @S09ID VARCHAR(50),
    @S10ID VARCHAR(50),
    @S11ID VARCHAR(50),
    @S12ID VARCHAR(50),
    @S13ID VARCHAR(50),
    @S14ID VARCHAR(50),
    @S15ID VARCHAR(50),
    @S16ID VARCHAR(50),
    @S17ID VARCHAR(50),
    @S18ID VARCHAR(50),
    @S19ID VARCHAR(50),
    @S20ID VARCHAR(50),
    @IsProduct TINYINT,
    @OrderID VARCHAR(50),
    @OTransactionID VARCHAR(50),
    @ReTransactionID NVARCHAR(50),
    @ReVoucherID NVARCHAR(50),
	@UnitPrice DECIMAL(28,8)

DECLARE @CustomerName INT
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
	
Set @D07_Cursor = Cursor Scroll KeySet For
Select 		Del.TransactionID, Del.DivisionID, Del.VoucherID, Del.TranYear, Del.TranMonth,   ---- Thong tin chung				
		T09.WareHouseID, T09.WareHouseID2,    KindVoucherID,	
		Del.InventoryID, 
		T02.MethodID,
		ActualQuantity, 
		Isnull(ConvertedQuantity,0), ---ActualQuantity*isnull(T04.ConversionFactor,1),				
		OriginalAmount, ConvertedAmount,
		DebitAccountID,CreditAccountID,
		T02.IsLimitDate,
		T02.IsSource,
		T09.TableID,
		Isnull(Del.Parameter01,0), Isnull(Del.Parameter02,0), Isnull(Del.Parameter03,0), Isnull(Del.Parameter04,0), Isnull(Del.Parameter05,0), Del.MarkQuantity,
		O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
		O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
		T09.IsProduct, Del.OrderID, Del.OTransactionID, Del.ReTransactionID, Del.ReVoucherID, Del.UnitPrice
From 	Deleted Del 	Inner Join AT2006 T09 WITH (NOLOCK)
						On 	Del.VoucherID = T09.VoucherID And 
							Del.DivisionID = T09.DivisionID And
							Del.TranMonth = T09.TranMonth And 
							Del.TranYear = T09.TranYear
			inner join AT1302 T02 WITH (NOLOCK)	on T02.DivisionID IN ('@@@', Del.DivisionID) AND Del.InventoryID = T02.InventoryID
			Left  join AT1309 T04 WITH (NOLOCK)	On	Del.UnitID 	= T04.UnitID and Del.InventoryID 	= T04.InventoryID
			LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = Del.DivisionID AND O99.VoucherID = Del.VoucherID AND O99.TransactionID = Del.TransactionID
Open @D07_Cursor
Fetch Next From @D07_Cursor Into @TransactionID, @DivisionID, @RDVoucherID, @TranYear, @TranMonth,   ---- Thong tin chung		
		@WareHouseID, @WareHouseID2,   @KindVoucherID,		 	
		@InventoryID,   @MethodID, 	@ActualQuantity, 
		@ConvertedQuantity, @OriginalAmount, @ConvertedAmount,
		@DebitAccountID,@CreditAccountID,
		@IsLimitDate, @IsSource, @TableID,
		@Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @MarkQuantity,
		@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
        @S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID,
        @IsProduct, @OrderID, @OTransactionID, @ReTransactionID, @ReVoucherID, @UnitPrice                          

While @@FETCH_STATUS = 0
Begin	
		----- Xoa bang tinh gia	
		If @KindVoucherID in (1,3,5,7,9,15,17) AND (SELECT ISNULL(IsSpecificate,0) FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID) = 0
			if @IsSource =1 or @IsLimitDate =1 or @MethodID in (1,2,3)
				Delete AT0114 Where 	DivisionID =@DivisionID
							AND WareHouseID =@WareHouseID
							AND ReVoucherID =@RDVoucherID
							AND ReTransactionID = @TransactionID

		If @KindVoucherID<>3 and ( @TableID in ('AT2006','MT0810','AT0112') )
			Delete AT9000
				Where TransactionID = @TransactionID and
					VoucherID = @RDVoucherID and
					TableID = @TableID and
					TranMOnth =@TranMOnth and
					TranYear =@TranYear and DivisionID =@DivisionID

		if @KindVoucherID =3 and (@DebitAccountID <> @CreditAccountID)
			Delete AT9000
				Where TransactionID = @TransactionID and
					VoucherID = @RDVoucherID and
					TableID = @TableID and
					TranMOnth =@TranMOnth and
					TranYear =@TranYear and DivisionID =@DivisionID

		IF NOT EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1) AND ISNULL(@TableID,'') <> 'AT0114'
		BEGIN
			If @KindVoucherID = 3 
				BEGIN 

					IF @CustomerName = 144
					BEGIN
						EXEC AP0516 @DivisionID,@TranYear,@TranMonth,NULL,@KindVoucherID,@RDVoucherID,@TransactionID,
						NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
						NULL,NULL,NULL,NULL,NULL,@InventoryID,NULL,
						NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,@TableID,@DebitAccountID,@CreditAccountID
					END

					Exec AP0513 @DivisionID, @WareHouseID, @TranMonth, @TranYear, @InventoryID, @ConvertedAmount, @ActualQuantity, @DebitAccountID, @CreditAccountID, 1, @Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @MarkQuantity, @RDVoucherID, @TransactionID, @IsProduct -- (1) la cap nhat tang,(0) la cap nhat giam
					Exec AP0513 @DivisionID, @WareHouseID2, @TranMonth, @TranYear, @InventoryID, @ConvertedAmount, @ActualQuantity, @DebitAccountID, @CreditAccountID, 0, @Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @MarkQuantity, @RDVoucherID, @TransactionID, @IsProduct -- (1) la cap nhat tang,(0) la cap nhat giam

					IF EXISTS (SELECT TOP 1 1 FROM OT2002 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND SOrderID = @OrderID AND TransactionID = @OTransactionID)
						UPDATE OT2002
						SET
							Finish = 0
						WHERE DivisionID = @DivisionID AND SOrderID = @OrderID AND TransactionID = @OTransactionID

					--- Update lại SL xuất và tồn cuối cho phiếu nhập trong AT0114
					IF @IsSource =1 or @IsLimitDate =1 or @MethodID in (1,2,3)
					BEGIN
						UPDATE AT0114
						SET DeQuantity = DeQuantity - @ActualQuantity,
							EndQuantity = EndQuantity + @ActualQuantity
						WHERE DivisionID = @DivisionID
							AND ReVoucherID = @ReVoucherID AND ReTransactionID = @ReTransactionID		
					END
				END  
			Else if @KindVoucherID in (1,5,7,9,15,17)		----- truong hop Xoa phieu nhap
				BEGIN
					Exec AP0513 @DivisionID, @WareHouseID, @TranMonth, @TranYear, @InventoryID, @ConvertedAmount, @ActualQuantity,  @DebitAccountID, @CreditAccountID,  1, @Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @MarkQuantity,
								@RDVoucherID, @TransactionID, @IsProduct -- (1) la cap nhat tang,(0) la cap nhat giam
				
				END
			Else if @KindVoucherID in (2,4,6,8,10,14,20)	----- Truong hop Xoa phieu xuat
				BEGIN    
					IF (@IsSource <> 0 OR @IsLimitDate <> 0 OR @MethodID IN (1, 2, 3, 5, 7) ) AND @KindVoucherID = 10 ----Nếu sửa/xóa phiếu giảm giá xuất kho => đơn giá mặt hàng cộng lại số tiền được giảm
					BEGIN
						UPDATE AT0114 SET UnitPrice = UnitPrice + @UnitPrice
	    				WHERE InventoryID = @InventoryID AND DivisionID = @DivisionID AND WareHouseID = @WareHouseID
	    				AND ReVoucherID = @ReVoucherID AND ReTransactionID = @ReTransactionID 

					END

					--- Update lại SL xuất và tồn cuối cho phiếu nhập trong AT0114
					IF @IsSource =1 or @IsLimitDate =1 or @MethodID in (1,2,3)
					BEGIN
						UPDATE AT0114
						SET DeQuantity = DeQuantity - @ActualQuantity,
							EndQuantity = EndQuantity + @ActualQuantity
						WHERE DivisionID = @DivisionID AND WareHouseID = @WareHouseID
							AND ReVoucherID = @ReVoucherID AND ReTransactionID = @ReTransactionID		
					END
					
					Exec AP0513 @DivisionID, @WareHouseID, @TranMonth, @TranYear, @InventoryID, @ConvertedAmount, @ActualQuantity,  @DebitAccountID, @CreditAccountID,  0, @Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @MarkQuantity, 
								@RDVoucherID, @TransactionID, @IsProduct -- (1) la cap nhat tang,(0) la cap nhat giam

					IF @CustomerName = 144
					BEGIN
						EXEC AP0516 @DivisionID,@TranYear,@TranMonth,NULL,@KindVoucherID,@RDVoucherID,@TransactionID,
						NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
						NULL,NULL,NULL,NULL,NULL,@InventoryID,NULL,
						NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,@TableID,@DebitAccountID,@CreditAccountID
					END
				
				END
		END

	Fetch Next From @D07_Cursor Into @TransactionID, @DivisionID, @RDVoucherID, @TranYear, @TranMonth,   ---- Thong tin chung		
			@WareHouseID, @WareHouseID2,   @KindVoucherID,		 	
			@InventoryID,   @MethodID, 	@ActualQuantity, 
			@ConvertedQuantity, @OriginalAmount, @ConvertedAmount,
			@DebitAccountID,@CreditAccountID,
			@IsLimitDate, @IsSource, @TableID,
			@Parameter01, @Parameter02, @Parameter03, @Parameter04, @Parameter05, @MarkQuantity, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID,
			@S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID, @IsProduct, @OrderID, @OTransactionID, @ReTransactionID, @ReVoucherID, @UnitPrice                                      
	END 
Close @D07_Cursor
DeAllocate @D07_Cursor

--IF (@CustomerName = 32) -- KH PhucLong
--BEGIN
--	DELETE TMP FROM  ERP_TO_POS.dbo.WarehouseObject  TMP 
--	INNER JOIN Deleted ON Deleted.VoucherID = TMP.VoucherID AND Deleted.TransactionID = TMP.TransactionID
--END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
