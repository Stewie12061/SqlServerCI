IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP8110_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP8110_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



--Created by Tiểu Mai
--Date 14/01/2016
--Purpose: Cập nhật kết quả tính giá thành vào Kết quả sản xuất.
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 09/11/2016: Bổ sung cập nhật thành tiền ở kho


CREATE PROCEDURE [dbo].[MP8110_QC] 	@DivisionID as nvarchar(50),
					@PeriodID as  nvarchar(50)

 AS
Declare @ListMaterial_cur as cursor,
		@ProductID as nvarchar(50),
		@CostUnit as decimal(28,8),
		@ConvertedDecimal as int,
		@ConvertedAmount as decimal(28,8),
		@Delta as decimal(28,8),
		@TransactionID as nvarchar(50),
		@AT2007_cur as cursor,
		@Price as decimal(28,8),
		@Cost as decimal(28,8),
		@Temp as decimal(28,8),
		@EndCost as decimal(28,8),
		@Quantity as decimal(28,8),
		@UnitPriceDecimal DECIMAL(28,8),
		@OriginalDecimal DECIMAL(28,8),
		@PS01ID NVARCHAR(50),
		@PS02ID NVARCHAR(50),
		@PS03ID NVARCHAR(50),
		@PS04ID NVARCHAR(50),
		@PS05ID NVARCHAR(50),
		@PS06ID NVARCHAR(50),
		@PS07ID NVARCHAR(50),
		@PS08ID NVARCHAR(50),
		@PS09ID NVARCHAR(50),
		@PS10ID NVARCHAR(50),
		@PS11ID NVARCHAR(50),
		@PS12ID NVARCHAR(50),
		@PS13ID NVARCHAR(50),
		@PS14ID NVARCHAR(50),
		@PS15ID NVARCHAR(50),
		@PS16ID NVARCHAR(50),
		@PS17ID NVARCHAR(50),
		@PS18ID NVARCHAR(50),
		@PS19ID NVARCHAR(50),
		@PS20ID NVARCHAR(50),
		@VoucherID NVARCHAR(50)

DECLARE @CustomerIndex INT 

SELECT @CustomerIndex = CustomerName FROM dbo.CustomerIndex
IF @CustomerIndex = 142
BEGIN
	EXEC dbo.MP8110_VH_QC @DivisionID = @DivisionID, -- nvarchar(50)
	                   @PeriodID = @PeriodID    -- nvarchar(50)
	
END
ELSE
BEGIN	

	SELECT @ConvertedDecimal = ConvertDecimal, @UnitPriceDecimal = UnitPriceDecimal, @OriginalDecimal = OriginalDecimal  FROM MT0000 WITH (NOLOCK) where DivisionID = @DivisionID
	set @ConvertedDecimal = isnull(@ConvertedDecimal,2)
	set @UnitPriceDecimal = isnull(@UnitPriceDecimal,2)
	set @OriginalDecimal = isnull(@OriginalDecimal,2)

	Set @ListMaterial_cur  = Cursor Scroll KeySet FOR 

	Select ProductID, CostUnit, Cost,  
		isnull(EndInprocessCost,0),
		PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID, 
		PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID 
	From MT1614 WITH (NOLOCK)
	Where 	DivisionID = @DivisionID and periodID = @PeriodID

	Open @ListMaterial_cur 
			FETCH NEXT FROM @ListMaterial_cur INTO  @ProductID , @CostUnit, @Cost, @EndCost, 
													@PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
													@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID 
			WHILE @@Fetch_Status = 0
				Begin	
				
					Update MT1001
					Set  MT1001.Price = @CostUnit,
						  MT1001.OriginalAmount =  Round(MT1001.Quantity*round(@CostUnit, @UnitPriceDecimal), @OriginalDecimal),
		  				 MT1001.ConvertedAmount  = Round(MT1001.Quantity*round(@CostUnit,@UnitPriceDecimal), @ConvertedDecimal)
				
					From MT1001 inner join MT0810 WITH (NOLOCK) on MT0810.VoucherID =MT1001.VoucherID
					LEFT JOIN MT8899 O99 WITH (NOLOCK) ON O99.DivisionID = MT1001.DivisionID AND O99.VoucherID = MT1001.VoucherID AND O99.TransactionID = MT1001.TransactionID
					Where MT0810.DivisionID= @DivisionID AND MT0810.PeriodID =@PeriodID 
						AND MT1001.ProductID = @ProductID AND MT0810.ResultTypeID = 'R01'
						AND ISNULL(O99.S01ID,'') = ISNULL(@PS01ID,'') 
						AND ISNULL(O99.S02ID,'') = ISNULL(@PS02ID,'') 
						AND ISNULL(O99.S03ID,'') = ISNULL(@PS03ID,'') 
						AND ISNULL(O99.S04ID,'') = ISNULL(@PS04ID,'') 
						AND ISNULL(O99.S05ID,'') = ISNULL(@PS05ID,'') 
						AND ISNULL(O99.S06ID,'') = ISNULL(@PS06ID,'') 
						AND ISNULL(O99.S07ID,'') = ISNULL(@PS07ID,'') 
						AND ISNULL(O99.S08ID,'') = ISNULL(@PS08ID,'') 
						AND ISNULL(O99.S09ID,'') = ISNULL(@PS09ID,'') 
						AND ISNULL(O99.S10ID,'') = ISNULL(@PS10ID,'') 
						AND ISNULL(O99.S11ID,'') = ISNULL(@PS11ID,'') 
						AND ISNULL(O99.S12ID,'') = ISNULL(@PS12ID,'') 
						AND ISNULL(O99.S13ID,'') = ISNULL(@PS13ID,'') 
						AND ISNULL(O99.S14ID,'') = ISNULL(@PS14ID,'') 
						AND ISNULL(O99.S15ID,'') = ISNULL(@PS15ID,'') 
						AND ISNULL(O99.S16ID,'') = ISNULL(@PS16ID,'') 
						AND ISNULL(O99.S17ID,'') = ISNULL(@PS17ID,'') 
						AND ISNULL(O99.S18ID,'') = ISNULL(@PS18ID,'') 
						AND ISNULL(O99.S19ID,'') = ISNULL(@PS19ID,'') 
						AND ISNULL(O99.S20ID,'') = ISNULL(@PS20ID,'')
				
				
				Set @Quantity =0
				Set @Quantity = 	(Select sum(Quantity) From MT1001 M1 WITH (NOLOCK) inner join MT0810 M10  WITH (NOLOCK) on M10.VoucherID  = M1.VoucherID
									LEFT JOIN MT8899 O99 WITH (NOLOCK) ON O99.DivisionID = M1.DivisionID AND O99.VoucherID = M1.VoucherID AND O99.TransactionID = M1.TransactionID	
							Where 	M1.DivisionID = @DivisionID and
								PeriodID = @PeriodID and
								M1.ProductID = @ProductID and
								ResultTypeID ='R03'
								AND ISNULL(O99.S01ID,'') = ISNULL(@PS01ID,'') 
								AND ISNULL(O99.S02ID,'') = ISNULL(@PS02ID,'') 
								AND ISNULL(O99.S03ID,'') = ISNULL(@PS03ID,'') 
								AND ISNULL(O99.S04ID,'') = ISNULL(@PS04ID,'') 
								AND ISNULL(O99.S05ID,'') = ISNULL(@PS05ID,'') 
								AND ISNULL(O99.S06ID,'') = ISNULL(@PS06ID,'') 
								AND ISNULL(O99.S07ID,'') = ISNULL(@PS07ID,'') 
								AND ISNULL(O99.S08ID,'') = ISNULL(@PS08ID,'') 
								AND ISNULL(O99.S09ID,'') = ISNULL(@PS09ID,'') 
								AND ISNULL(O99.S10ID,'') = ISNULL(@PS10ID,'') 
								AND ISNULL(O99.S11ID,'') = ISNULL(@PS11ID,'') 
								AND ISNULL(O99.S12ID,'') = ISNULL(@PS12ID,'') 
								AND ISNULL(O99.S13ID,'') = ISNULL(@PS13ID,'') 
								AND ISNULL(O99.S14ID,'') = ISNULL(@PS14ID,'') 
								AND ISNULL(O99.S15ID,'') = ISNULL(@PS15ID,'') 
								AND ISNULL(O99.S16ID,'') = ISNULL(@PS16ID,'') 
								AND ISNULL(O99.S17ID,'') = ISNULL(@PS17ID,'') 
								AND ISNULL(O99.S18ID,'') = ISNULL(@PS18ID,'') 
								AND ISNULL(O99.S19ID,'') = ISNULL(@PS19ID,'') 
								AND ISNULL(O99.S20ID,'') = ISNULL(@PS20ID,'') )
					--Print ' Q: '+Str(@Quantity)+' P: '+@ProductID+' @EndCost: '+str(@EndCost)+' U ='+str(@EndCost/@Quantity)
				
				
					Update MT1001
					Set  MT1001.Price = Case when @Quantity <>0 then @EndCost/@Quantity else 0 end,
						  MT1001.OriginalAmount =  Case when @Quantity <>0 then (Quantity*@EndCost)/@Quantity else 0 end,
		  				  MT1001.ConvertedAmount  = Case when @Quantity <>0 then (Quantity*@EndCost)/@Quantity else 0 end
				
					From MT1001 inner join MT0810 WITH (NOLOCK) on MT0810.VoucherID =MT1001.VoucherID
					LEFT JOIN MT8899 O99 WITH (NOLOCK) ON O99.DivisionID = MT1001.DivisionID AND O99.VoucherID = MT1001.VoucherID AND O99.TransactionID = MT1001.TransactionID
					Where MT0810.DivisionID= @DivisionID and MT0810.PeriodID =@PeriodID 
						and MT1001.ProductID = @ProductID and MT0810.ResultTypeID = 'R03'
						AND ISNULL(O99.S01ID,'') = ISNULL(@PS01ID,'') 
						AND ISNULL(O99.S02ID,'') = ISNULL(@PS02ID,'') 
						AND ISNULL(O99.S03ID,'') = ISNULL(@PS03ID,'') 
						AND ISNULL(O99.S04ID,'') = ISNULL(@PS04ID,'') 
						AND ISNULL(O99.S05ID,'') = ISNULL(@PS05ID,'') 
						AND ISNULL(O99.S06ID,'') = ISNULL(@PS06ID,'') 
						AND ISNULL(O99.S07ID,'') = ISNULL(@PS07ID,'') 
						AND ISNULL(O99.S08ID,'') = ISNULL(@PS08ID,'') 
						AND ISNULL(O99.S09ID,'') = ISNULL(@PS09ID,'') 
						AND ISNULL(O99.S10ID,'') = ISNULL(@PS10ID,'') 
						AND ISNULL(O99.S11ID,'') = ISNULL(@PS11ID,'') 
						AND ISNULL(O99.S12ID,'') = ISNULL(@PS12ID,'') 
						AND ISNULL(O99.S13ID,'') = ISNULL(@PS13ID,'') 
						AND ISNULL(O99.S14ID,'') = ISNULL(@PS14ID,'') 
						AND ISNULL(O99.S15ID,'') = ISNULL(@PS15ID,'') 
						AND ISNULL(O99.S16ID,'') = ISNULL(@PS16ID,'') 
						AND ISNULL(O99.S17ID,'') = ISNULL(@PS17ID,'') 
						AND ISNULL(O99.S18ID,'') = ISNULL(@PS18ID,'') 
						AND ISNULL(O99.S19ID,'') = ISNULL(@PS19ID,'') 
						AND ISNULL(O99.S20ID,'') = ISNULL(@PS20ID,'') 


			FETCH NEXT FROM @ListMaterial_cur INTO  @ProductID ,@CostUnit, @Cost, @EndCost, 
													@PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
													@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID

			End
			Close @ListMaterial_cur

	set @ConvertedAmount = isnull( (Select  sum(isnull(Cost,0)) From MT1614 WITH (NOLOCK) Where  	DivisionID = @DivisionID and 	PeriodID = @PeriodID),0)

	Set @Delta =0 

	Set @Delta = @ConvertedAmount -   isnull((Select  sum(isnull(MT1001.ConvertedAmount,0))  From MT1001  WITH (NOLOCK) inner join MT0810 WITH (NOLOCK) on MT0810.VoucherID =MT1001.VoucherID
											Where MT0810.DivisionID= @DivisionID and MT0810.PeriodID =@PeriodID 
											 and MT0810.ResultTypeID = 'R01'  ),0) 


	If @Delta <>0 
		Begin 
			---Print ' Chenh lech '+str(@Delta,20,4)
			---Print ' Tong gia thanh '+str(@ConvertedAmount,20,4)
		
			Set @TransactionID = (Select top 1 TransactionID From MT1001 WITH (NOLOCK) inner join MT0810 WITH (NOLOCK) on MT0810.VoucherID =MT1001.VoucherID
							Where MT0810.DivisionID= @DivisionID and MT0810.PeriodID =@PeriodID 
								 and MT0810.ResultTypeID = 'R01' 
							Order by MT1001.ConvertedAmount Desc)
			Print ' Tran ' +@TransactionID
			 if @TransactionID is not null
				Update MT1001
				
					set       MT1001.OriginalAmount =  MT1001.OriginalAmount + @Delta,
		  		     		 MT1001.ConvertedAmount  =MT1001.ConvertedAmount  + @Delta
				
					From MT1001 inner join MT0810 WITH (NOLOCK) on MT0810.VoucherID =MT1001.VoucherID
					Where MT0810.DivisionID= @DivisionID and MT0810.PeriodID =@PeriodID and TransactionID = @TransactionID 
						and MT0810.ResultTypeID = 'R01' 



		End



	------ Edit by VAN NHAN
	Set @ListMaterial_cur  = Cursor Scroll KeySet FOR 
	Select ProductID,  Cost,
		PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID, 
		PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID
	From MT1614 WITH (NOLOCK)
	Where 	DivisionID = @DivisionID and
		PeriodID = @PeriodID

	Open @ListMaterial_cur 
			FETCH NEXT FROM @ListMaterial_cur INTO  @ProductID,  @Cost, 
													@PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
													@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID
			WHILE @@Fetch_Status = 0
				Begin	

					Set @Temp =0
					Set @Delta =0
					Set @Temp = 	isnull((Select Sum(MT1001.ConvertedAmount) 
							From MT1001 WITH (NOLOCK)  inner join MT0810 WITH (NOLOCK) on MT0810.VoucherID =MT1001.VoucherID
							LEFT JOIN MT8899 O99 WITH (NOLOCK) ON O99.DivisionID = MT1001.DivisionID AND O99.VoucherID = MT1001.VoucherID AND O99.TransactionID = MT1001.TransactionID
							Where MT0810.DivisionID= @DivisionID and MT0810.PeriodID =@PeriodID 
								and MT1001.ProductID = @ProductID and MT0810.ResultTypeID = 'R01'
								AND ISNULL(O99.S01ID,'') = ISNULL(@PS01ID,'') 
								AND ISNULL(O99.S02ID,'') = ISNULL(@PS02ID,'') 
								AND ISNULL(O99.S03ID,'') = ISNULL(@PS03ID,'') 
								AND ISNULL(O99.S04ID,'') = ISNULL(@PS04ID,'') 
								AND ISNULL(O99.S05ID,'') = ISNULL(@PS05ID,'') 
								AND ISNULL(O99.S06ID,'') = ISNULL(@PS06ID,'') 
								AND ISNULL(O99.S07ID,'') = ISNULL(@PS07ID,'') 
								AND ISNULL(O99.S08ID,'') = ISNULL(@PS08ID,'') 
								AND ISNULL(O99.S09ID,'') = ISNULL(@PS09ID,'') 
								AND ISNULL(O99.S10ID,'') = ISNULL(@PS10ID,'') 
								AND ISNULL(O99.S11ID,'') = ISNULL(@PS11ID,'') 
								AND ISNULL(O99.S12ID,'') = ISNULL(@PS12ID,'') 
								AND ISNULL(O99.S13ID,'') = ISNULL(@PS13ID,'') 
								AND ISNULL(O99.S14ID,'') = ISNULL(@PS14ID,'') 
								AND ISNULL(O99.S15ID,'') = ISNULL(@PS15ID,'') 
								AND ISNULL(O99.S16ID,'') = ISNULL(@PS16ID,'') 
								AND ISNULL(O99.S17ID,'') = ISNULL(@PS17ID,'') 
								AND ISNULL(O99.S18ID,'') = ISNULL(@PS18ID,'') 
								AND ISNULL(O99.S19ID,'') = ISNULL(@PS19ID,'') 
								AND ISNULL(O99.S20ID,'') = ISNULL(@PS20ID,'')  ),0)
					Set @Delta =  @Cost - @Temp
					If @Delta <>0 
						Begin 
						---Print ' Chenh lech '+str(@Delta,20,4)
						---Print ' Tong gia thanh '+str(@ConvertedAmount,20,4)		
					Set @TransactionID = (Select top 1 MT1001.TransactionID From MT1001 WITH (NOLOCK) inner join MT0810 WITH (NOLOCK) on MT0810.VoucherID =MT1001.VoucherID
							LEFT JOIN MT8899 O99 WITH (NOLOCK) ON O99.DivisionID = MT1001.DivisionID AND O99.VoucherID = MT1001.VoucherID AND O99.TransactionID = MT1001.TransactionID
							Where MT0810.DivisionID= @DivisionID and MT0810.PeriodID =@PeriodID  and ProductID =@ProductID
								AND MT0810.ResultTypeID = 'R01'
								AND ISNULL(O99.S01ID,'') = ISNULL(@PS01ID,'') 
								AND ISNULL(O99.S02ID,'') = ISNULL(@PS02ID,'') 
								AND ISNULL(O99.S03ID,'') = ISNULL(@PS03ID,'') 
								AND ISNULL(O99.S04ID,'') = ISNULL(@PS04ID,'') 
								AND ISNULL(O99.S05ID,'') = ISNULL(@PS05ID,'') 
								AND ISNULL(O99.S06ID,'') = ISNULL(@PS06ID,'') 
								AND ISNULL(O99.S07ID,'') = ISNULL(@PS07ID,'') 
								AND ISNULL(O99.S08ID,'') = ISNULL(@PS08ID,'') 
								AND ISNULL(O99.S09ID,'') = ISNULL(@PS09ID,'') 
								AND ISNULL(O99.S10ID,'') = ISNULL(@PS10ID,'') 
								AND ISNULL(O99.S11ID,'') = ISNULL(@PS11ID,'') 
								AND ISNULL(O99.S12ID,'') = ISNULL(@PS12ID,'') 
								AND ISNULL(O99.S13ID,'') = ISNULL(@PS13ID,'') 
								AND ISNULL(O99.S14ID,'') = ISNULL(@PS14ID,'') 
								AND ISNULL(O99.S15ID,'') = ISNULL(@PS15ID,'') 
								AND ISNULL(O99.S16ID,'') = ISNULL(@PS16ID,'') 
								AND ISNULL(O99.S17ID,'') = ISNULL(@PS17ID,'') 
								AND ISNULL(O99.S18ID,'') = ISNULL(@PS18ID,'') 
								AND ISNULL(O99.S19ID,'') = ISNULL(@PS19ID,'') 
								AND ISNULL(O99.S20ID,'') = ISNULL(@PS20ID,'')  
							Order by MT1001.ConvertedAmount Desc)
					Print ' Tran ' +@TransactionID+' Delta '+str(@Delta)
					 if @TransactionID is not null
					Update MT1001
				
					set       MT1001.OriginalAmount =  MT1001.OriginalAmount + @Delta,
		  		     		 MT1001.ConvertedAmount  =MT1001.ConvertedAmount  + @Delta
				
					From MT1001 inner join MT0810  WITH (NOLOCK)on MT0810.VoucherID =MT1001.VoucherID
					LEFT JOIN MT8899 O99 WITH (NOLOCK) ON O99.DivisionID = MT1001.DivisionID AND O99.VoucherID = MT1001.VoucherID AND O99.TransactionID = MT1001.TransactionID				
					Where MT0810.DivisionID= @DivisionID and MT0810.PeriodID =@PeriodID and MT1001.TransactionID = @TransactionID 
						AND MT0810.ResultTypeID = 'R01' AND ProductID =@ProductID
						AND ISNULL(O99.S01ID,'') = ISNULL(@PS01ID,'') 
						AND ISNULL(O99.S02ID,'') = ISNULL(@PS02ID,'') 
						AND ISNULL(O99.S03ID,'') = ISNULL(@PS03ID,'') 
						AND ISNULL(O99.S04ID,'') = ISNULL(@PS04ID,'') 
						AND ISNULL(O99.S05ID,'') = ISNULL(@PS05ID,'') 
						AND ISNULL(O99.S06ID,'') = ISNULL(@PS06ID,'') 
						AND ISNULL(O99.S07ID,'') = ISNULL(@PS07ID,'') 
						AND ISNULL(O99.S08ID,'') = ISNULL(@PS08ID,'') 
						AND ISNULL(O99.S09ID,'') = ISNULL(@PS09ID,'') 
						AND ISNULL(O99.S10ID,'') = ISNULL(@PS10ID,'') 
						AND ISNULL(O99.S11ID,'') = ISNULL(@PS11ID,'') 
						AND ISNULL(O99.S12ID,'') = ISNULL(@PS12ID,'') 
						AND ISNULL(O99.S13ID,'') = ISNULL(@PS13ID,'') 
						AND ISNULL(O99.S14ID,'') = ISNULL(@PS14ID,'') 
						AND ISNULL(O99.S15ID,'') = ISNULL(@PS15ID,'') 
						AND ISNULL(O99.S16ID,'') = ISNULL(@PS16ID,'') 
						AND ISNULL(O99.S17ID,'') = ISNULL(@PS17ID,'') 
						AND ISNULL(O99.S18ID,'') = ISNULL(@PS18ID,'') 
						AND ISNULL(O99.S19ID,'') = ISNULL(@PS19ID,'') 
						AND ISNULL(O99.S20ID,'') = ISNULL(@PS20ID,'')


						End
				
				FETCH NEXT FROM @ListMaterial_cur INTO  @ProductID,  @Cost, 
														@PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
														@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID
			End
			Close @ListMaterial_cur



	---- Day lai ASOFT - T
	Set @AT2007_cur  = Cursor Scroll KeySet FOR 
	Select  	MT1001.TransactionID, 
		ProductID,
		price, 
		MT1001.ConvertedAmount,
		O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
		O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID
	 
	From 	MT1001 WITH (NOLOCK) inner join MT0810 WITH (NOLOCK) on MT0810.VoucherID = MT1001.VoucherID
	LEFT JOIN MT8899 O99 WITH (NOLOCK) ON O99.DivisionID = MT1001.DivisionID AND O99.VoucherID = MT1001.VoucherID AND O99.TransactionID = MT1001.TransactionID
	Where 	MT0810.PeriodID = @PeriodID and MT1001.DivisionID =@DivisionID and
		Mt0810.IsWareHouse =1 and ResultTypeID ='R01'

	Open @AT2007_cur
	FETCH NEXT FROM @AT2007_cur INTO	@TransactionID, @ProductID, @Price , @ConvertedAmount, 
										@PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
										@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID
			WHILE @@Fetch_Status = 0
				Begin	
					SELECT @VoucherID = VoucherID FROM AT2007 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND TransactionID = @TransactionID
				
					Update AT2007 Set	 UnitPrice = @Price,
								OriginalAmount = @ConvertedAmount,
								ConvertedAmount = @ConvertedAmount
					FROM AT2007
					LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = AT2007.DivisionID AND O99.VoucherID = AT2007.VoucherID AND O99.TransactionID = AT2007.TransactionID 		
					Where AT2007.DivisionID =@DivisionID and
						AT2007.TransactionID =@TransactionID and
						InventoryID =@ProductID
						AND ISNULL(O99.S01ID,'') = ISNULL(@PS01ID,'') 
						AND ISNULL(O99.S02ID,'') = ISNULL(@PS02ID,'') 
						AND ISNULL(O99.S03ID,'') = ISNULL(@PS03ID,'') 
						AND ISNULL(O99.S04ID,'') = ISNULL(@PS04ID,'') 
						AND ISNULL(O99.S05ID,'') = ISNULL(@PS05ID,'') 
						AND ISNULL(O99.S06ID,'') = ISNULL(@PS06ID,'') 
						AND ISNULL(O99.S07ID,'') = ISNULL(@PS07ID,'') 
						AND ISNULL(O99.S08ID,'') = ISNULL(@PS08ID,'') 
						AND ISNULL(O99.S09ID,'') = ISNULL(@PS09ID,'') 
						AND ISNULL(O99.S10ID,'') = ISNULL(@PS10ID,'') 
						AND ISNULL(O99.S11ID,'') = ISNULL(@PS11ID,'') 
						AND ISNULL(O99.S12ID,'') = ISNULL(@PS12ID,'') 
						AND ISNULL(O99.S13ID,'') = ISNULL(@PS13ID,'') 
						AND ISNULL(O99.S14ID,'') = ISNULL(@PS14ID,'') 
						AND ISNULL(O99.S15ID,'') = ISNULL(@PS15ID,'') 
						AND ISNULL(O99.S16ID,'') = ISNULL(@PS16ID,'') 
						AND ISNULL(O99.S17ID,'') = ISNULL(@PS17ID,'') 
						AND ISNULL(O99.S18ID,'') = ISNULL(@PS18ID,'') 
						AND ISNULL(O99.S19ID,'') = ISNULL(@PS19ID,'') 
						AND ISNULL(O99.S20ID,'') = ISNULL(@PS20ID,'')
				
					IF NOT EXISTS (SELECT TOP 1 1 FROM WT8899 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND TransactionID = @TransactionID AND TableID = 'AT2007')
					BEGIN 
						INSERT INTO WT8899 (DivisionID, VoucherID, TransactionID, TableID, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
						S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID, QC_OriginalQuantity, QC_OriginalAmount, QC_ConvertedQuantity, QC_ConvertedAmount)
						SELECT DivisionID, VoucherID, TransactionID, 'AT2007', @PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
										@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID, ActualQuantity, OriginalAmount, ConvertedQuantity, ConvertedAmount
						FROM At2007 WITH (NOLOCK) 
						WHERE DivisionID = @DivisionID AND TransactionID = @TransactionID
					END 
					ELSE 
						BEGIN 
							UPDATE WT8899
							SET QC_OriginalQuantity = AT2007.ActualQuantity,
								QC_ConvertedQuantity = AT2007.ConvertedQuantity,
								QC_OriginalAmount = @ConvertedAmount,
								QC_ConvertedAmount = @ConvertedAmount
							FROM WT8899
							LEFT JOIN AT2007 ON AT2007.VoucherID = WT8899.VoucherID AND AT2007.TransactionID = WT8899.TransactionID AND AT2007.DivisionID = WT8899.DivisionID
							WHERE AT2007.DivisionID =@DivisionID and
								AT2007.TransactionID =@TransactionID and
								AT2007.InventoryID =@ProductID
								AND ISNULL(WT8899.S01ID,'') = ISNULL(@PS01ID,'') 
								AND ISNULL(WT8899.S02ID,'') = ISNULL(@PS02ID,'') 
								AND ISNULL(WT8899.S03ID,'') = ISNULL(@PS03ID,'') 
								AND ISNULL(WT8899.S04ID,'') = ISNULL(@PS04ID,'') 
								AND ISNULL(WT8899.S05ID,'') = ISNULL(@PS05ID,'') 
								AND ISNULL(WT8899.S06ID,'') = ISNULL(@PS06ID,'') 
								AND ISNULL(WT8899.S07ID,'') = ISNULL(@PS07ID,'') 
								AND ISNULL(WT8899.S08ID,'') = ISNULL(@PS08ID,'') 
								AND ISNULL(WT8899.S09ID,'') = ISNULL(@PS09ID,'') 
								AND ISNULL(WT8899.S10ID,'') = ISNULL(@PS10ID,'') 
								AND ISNULL(WT8899.S11ID,'') = ISNULL(@PS11ID,'') 
								AND ISNULL(WT8899.S12ID,'') = ISNULL(@PS12ID,'') 
								AND ISNULL(WT8899.S13ID,'') = ISNULL(@PS13ID,'') 
								AND ISNULL(WT8899.S14ID,'') = ISNULL(@PS14ID,'') 
								AND ISNULL(WT8899.S15ID,'') = ISNULL(@PS15ID,'') 
								AND ISNULL(WT8899.S16ID,'') = ISNULL(@PS16ID,'') 
								AND ISNULL(WT8899.S17ID,'') = ISNULL(@PS17ID,'') 
								AND ISNULL(WT8899.S18ID,'') = ISNULL(@PS18ID,'') 
								AND ISNULL(WT8899.S19ID,'') = ISNULL(@PS19ID,'') 
								AND ISNULL(WT8899.S20ID,'') = ISNULL(@PS20ID,'')
						END 
					FETCH NEXT FROM @AT2007_cur INTO	@TransactionID, @ProductID, @Price, @ConvertedAmount, 
														@PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
														@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID			
				End

	ClOSE @AT2007_cur


end


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
