IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0173]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0173]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
--- Xử lý tính toán tồn kho khi xóa VCNB có thiết lập quy cách
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Kiều Nga on: 20/05/2020
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
-- <Example>
/*
	WP0173 'HD', '','HDVNS-H1506023', 0, 1, 10, '', ''
*/

CREATE PROCEDURE WP0173
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@VoucherID VARCHAR(50)
)
AS

Declare		@D07_Cursor		Cursor
Declare  	
	@KindVoucherID  	TinyInt ,
	@TransactionID		nvarchar(50),
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
Select 		Del.TransactionID, Del.VoucherID, Del.TranYear, Del.TranMonth,   ---- Thong tin chung				
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
From 	AT2007 Del 	Inner Join AT2006 T09 	On 	Del.VoucherID = T09.VoucherID And 
							Del.DivisionID = T09.DivisionID And
							Del.TranMonth = T09.TranMonth And 
							Del.TranYear = T09.TranYear
			inner join AT1302 T02 	on T02.DivisionID IN ('@@@', Del.DivisionID) AND 	Del.InventoryID = T02.InventoryID
			Left  join AT1309 T04 	On	Del.UnitID 	= T04.UnitID and Del.InventoryID 	= T04.InventoryID
			LEFT JOIN WT8899 O99 ON O99.DivisionID = Del.DivisionID AND O99.VoucherID = Del.VoucherID AND O99.TransactionID = Del.TransactionID
		where Del.VoucherID = @VoucherID 

Open @D07_Cursor
Fetch Next From @D07_Cursor Into @TransactionID, @RDVoucherID, @TranYear, @TranMonth,   ---- Thong tin chung		
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
	IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1) AND ISNULL(@TableID,'') <> 'AT0114'
	BEGIN
		If @KindVoucherID = 3 
			BEGIN 
				Exec AP0513_QC @DivisionID, @WareHouseID, @TranMonth, @TranYear, @InventoryID, @ConvertedAmount, @ActualQuantity, @DebitAccountID, @CreditAccountID, 1,@S01ID,@S02ID,@S03ID,@S04ID,@S05ID,@S06ID,@S07ID,@S08ID,@S09ID,@S10ID,@S11ID,@S12ID,@S13ID,@S14ID,@S15ID,@S16ID,@S17ID,@S18ID,@S19ID,@S20ID -- (1) la cap nhat tang,(0) la cap nhat giam
				Exec AP0513_QC @DivisionID, @WareHouseID2, @TranMonth, @TranYear, @InventoryID, @ConvertedAmount, @ActualQuantity, @DebitAccountID, @CreditAccountID, 0,@S01ID,@S02ID,@S03ID,@S04ID,@S05ID,@S06ID,@S07ID,@S08ID,@S09ID,@S10ID,@S11ID,@S12ID,@S13ID,@S14ID,@S15ID,@S16ID,@S17ID,@S18ID,@S19ID,@S20ID -- (1) la cap nhat tang,(0) la cap nhat giam

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
	END
	Fetch Next From @D07_Cursor Into @TransactionID, @RDVoucherID, @TranYear, @TranMonth,   ---- Thong tin chung		
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


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
