IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP8110_VH_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP8110_VH_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




--Created by Tiểu Mai
--Date 14/01/2016
--Purpose: Cập nhật kết quả tính giá thành vào Kết quả sản xuất.
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 02/07/2018: Bỏ đoạn update thừa, làm chậm hệ thống, bổ sung insert quy cách vào kho
---- Modified by Huỳnh Thử on 18/05/2020: Update WT8899, trigger MT1001 Update không xóa WT8899 nửa.
---- Modified by Huỳnh Thử on 18/01/2021: Where @PeriodID, @DivisionID
---- Modified by Huỳnh Thử on 01/06/2021: Cải thiện tốc độ
---- Modified by Huỳnh Thử on 09/08/2021: Tách Store Vĩnh Hưng: Cỉa thiện tốc độ


CREATE PROCEDURE [dbo].[MP8110_VH_QC] 	@DivisionID as nvarchar(50),
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
		@PS20ID NVARCHAR(50)


SELECT @ConvertedDecimal = ConvertDecimal, @UnitPriceDecimal = UnitPriceDecimal, @OriginalDecimal = OriginalDecimal  FROM MT0000 WITH (NOLOCK) where DivisionID = @DivisionID
set @ConvertedDecimal = isnull(@ConvertedDecimal,2)
set @UnitPriceDecimal = isnull(@UnitPriceDecimal,2)
set @OriginalDecimal = isnull(@OriginalDecimal,2)

DECLARE @index INT 
SET @index = 0


				select 
				MT0810.DivisionID,
				 MT1001.Price ,
					 MT1001.TransactionID,
					 ProductID,
					 PeriodID	,
				      MT1001.Quantity ,
				      MT1001.OriginalAmount ,
		  		     MT1001.ConvertedAmount ,
					 ResultTypeID,
					 S01ID,
					 S02ID,
					 S03ID,
					 S04ID,
					 S05ID,
					 S06ID,
					 S07ID,
					 S08ID,
					 S09ID,
					 S10ID,
					 S11ID,
					 S12ID,
					 S13ID,
					 S14ID,
					 S15ID,
					 S16ID,
					 S17ID,
					 S18ID,
					 S19ID,
					 S20ID
				INTO #Thu01 FROM MT1001 inner join MT0810 WITH (NOLOCK) on MT0810.VoucherID =MT1001.VoucherID
				inner JOIN MT8899 O99 WITH (NOLOCK) ON O99.DivisionID = MT1001.DivisionID AND O99.VoucherID = MT1001.VoucherID AND O99.TransactionID = MT1001.TransactionID
				Where MT0810.DivisionID= @DivisionID AND MT0810.PeriodID =@PeriodID 
					
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
				PRINT @Index
				Update #Thu01
				Set  Price = @CostUnit,
				     OriginalAmount =  Round(Quantity*round(@CostUnit, @UnitPriceDecimal), @OriginalDecimal),
		  		    ConvertedAmount  = Round(Quantity*round(@CostUnit,@UnitPriceDecimal), @ConvertedDecimal)
				From  #Thu01 where
					 ProductID = @ProductID AND ResultTypeID = 'R01'
					AND ISNULL(S01ID,'') = ISNULL(@PS01ID,'') 
					AND ISNULL(S02ID,'') = ISNULL(@PS02ID,'') 
					AND ISNULL(S03ID,'') = ISNULL(@PS03ID,'') 
					AND ISNULL(S04ID,'') = ISNULL(@PS04ID,'') 
					AND ISNULL(S05ID,'') = ISNULL(@PS05ID,'') 
					AND ISNULL(S06ID,'') = ISNULL(@PS06ID,'') 
					AND ISNULL(S07ID,'') = ISNULL(@PS07ID,'') 
					AND ISNULL(S08ID,'') = ISNULL(@PS08ID,'') 
					AND ISNULL(S09ID,'') = ISNULL(@PS09ID,'') 
					AND ISNULL(S10ID,'') = ISNULL(@PS10ID,'') 
					AND ISNULL(S11ID,'') = ISNULL(@PS11ID,'') 
					AND ISNULL(S12ID,'') = ISNULL(@PS12ID,'') 
					AND ISNULL(S13ID,'') = ISNULL(@PS13ID,'') 
					AND ISNULL(S14ID,'') = ISNULL(@PS14ID,'') 
					AND ISNULL(S15ID,'') = ISNULL(@PS15ID,'') 
					AND ISNULL(S16ID,'') = ISNULL(@PS16ID,'') 
					AND ISNULL(S17ID,'') = ISNULL(@PS17ID,'') 
					AND ISNULL(S18ID,'') = ISNULL(@PS18ID,'') 
					AND ISNULL(S19ID,'') = ISNULL(@PS19ID,'') 
					AND ISNULL(S20ID,'') = ISNULL(@PS20ID,'')

				set @index = @index + 1
				
			Set @Quantity =0
			Set @Quantity = 	(Select sum(Quantity) From #Thu01 M1 WITH (NOLOCK) 
						Where 	M1.DivisionID = @DivisionID and
							PeriodID = @PeriodID and
							M1.ProductID = @ProductID and
							ResultTypeID ='R03'
							AND ISNULL(S01ID,'') = ISNULL(@PS01ID,'') 
							AND ISNULL(S02ID,'') = ISNULL(@PS02ID,'') 
							AND ISNULL(S03ID,'') = ISNULL(@PS03ID,'') 
							AND ISNULL(S04ID,'') = ISNULL(@PS04ID,'') 
							AND ISNULL(S05ID,'') = ISNULL(@PS05ID,'') 
							AND ISNULL(S06ID,'') = ISNULL(@PS06ID,'') 
							AND ISNULL(S07ID,'') = ISNULL(@PS07ID,'') 
							AND ISNULL(S08ID,'') = ISNULL(@PS08ID,'') 
							AND ISNULL(S09ID,'') = ISNULL(@PS09ID,'') 
							AND ISNULL(S10ID,'') = ISNULL(@PS10ID,'') 
							AND ISNULL(S11ID,'') = ISNULL(@PS11ID,'') 
							AND ISNULL(S12ID,'') = ISNULL(@PS12ID,'') 
							AND ISNULL(S13ID,'') = ISNULL(@PS13ID,'') 
							AND ISNULL(S14ID,'') = ISNULL(@PS14ID,'') 
							AND ISNULL(S15ID,'') = ISNULL(@PS15ID,'') 
							AND ISNULL(S16ID,'') = ISNULL(@PS16ID,'') 
							AND ISNULL(S17ID,'') = ISNULL(@PS17ID,'') 
							AND ISNULL(S18ID,'') = ISNULL(@PS18ID,'') 
							AND ISNULL(S19ID,'') = ISNULL(@PS19ID,'') 
							AND ISNULL(S20ID,'') = ISNULL(@PS20ID,'') )
				--Print ' Q: '+Str(@Quantity)+' P: '+@ProductID+' @EndCost: '+str(@EndCost)+' U ='+str(@EndCost/@Quantity)
				
				
				Update #Thu01
				Set  Price = Case when @Quantity <>0 then @EndCost/@Quantity else 0 end,
				     OriginalAmount =  Case when @Quantity <>0 then (Quantity*@EndCost)/@Quantity else 0 end,
		  		     ConvertedAmount  = Case when @Quantity <>0 then (Quantity*@EndCost)/@Quantity else 0 end
				
				From #Thu01 
				Where DivisionID= @DivisionID and PeriodID =@PeriodID 
					and ProductID = @ProductID AND ResultTypeID = 'R03'
					AND ISNULL(S01ID,'') = ISNULL(@PS01ID,'') 
					AND ISNULL(S02ID,'') = ISNULL(@PS02ID,'') 
					AND ISNULL(S03ID,'') = ISNULL(@PS03ID,'') 
					AND ISNULL(S04ID,'') = ISNULL(@PS04ID,'') 
					AND ISNULL(S05ID,'') = ISNULL(@PS05ID,'') 
					AND ISNULL(S06ID,'') = ISNULL(@PS06ID,'') 
					AND ISNULL(S07ID,'') = ISNULL(@PS07ID,'') 
					AND ISNULL(S08ID,'') = ISNULL(@PS08ID,'') 
					AND ISNULL(S09ID,'') = ISNULL(@PS09ID,'') 
					AND ISNULL(S10ID,'') = ISNULL(@PS10ID,'') 
					AND ISNULL(S11ID,'') = ISNULL(@PS11ID,'') 
					AND ISNULL(S12ID,'') = ISNULL(@PS12ID,'') 
					AND ISNULL(S13ID,'') = ISNULL(@PS13ID,'') 
					AND ISNULL(S14ID,'') = ISNULL(@PS14ID,'') 
					AND ISNULL(S15ID,'') = ISNULL(@PS15ID,'') 
					AND ISNULL(S16ID,'') = ISNULL(@PS16ID,'') 
					AND ISNULL(S17ID,'') = ISNULL(@PS17ID,'') 
					AND ISNULL(S18ID,'') = ISNULL(@PS18ID,'') 
					AND ISNULL(S19ID,'') = ISNULL(@PS19ID,'') 
					AND ISNULL(S20ID,'') = ISNULL(@PS20ID,'') 


		FETCH NEXT FROM @ListMaterial_cur INTO  @ProductID ,@CostUnit, @Cost, @EndCost, 
												@PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
												@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID

		End
		Close @ListMaterial_cur

		UPDATE MT1001 SET
		Price = #Thu01.Price,
		OriginalAmount = #Thu01.OriginalAmount,
		ConvertedAmount = #Thu01.ConvertedAmount
		FROM MT1001 INNER JOIN #Thu01 ON #Thu01.TransactionID = MT1001.TransactionID



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

SELECT  	MT0810.DivisionID,PeriodID,MT1001.ConvertedAmount,MT1001.TransactionID,ResultTypeID,ProductID,
			MT1001.OriginalAmount,
				S01ID,
				S02ID,
				S03ID,
				S04ID,
				S05ID,
				S06ID,
				S07ID,
				S08ID,
				S09ID,
				S10ID,
				S11ID,
				S12ID,
				S13ID,
				S14ID,
				S15ID,
				S16ID,
				S17ID,
				S18ID,
				S19ID,
				S20ID
						INTO #thu02 FROM MT1001 WITH (NOLOCK)  inner join MT0810 WITH (NOLOCK) on MT0810.VoucherID =MT1001.VoucherID
						INNER JOIN MT8899 O99 WITH (NOLOCK) ON O99.DivisionID = MT1001.DivisionID AND O99.VoucherID = MT1001.VoucherID AND O99.TransactionID = MT1001.TransactionID
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
							AND ISNULL(O99.S20ID,'') = ISNULL(@PS20ID,'') 
							
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

				SELECT @Temp = 	isnull( Sum(ConvertedAmount),0), @TransactionID = MAX(TransactionID) 
						From #thu02
						Where DivisionID= @DivisionID AND PeriodID =@PeriodID 
							and ProductID = @ProductID and ResultTypeID = 'R01'
							AND ISNULL(S01ID,'') = ISNULL(@PS01ID,'') 
							AND ISNULL(S02ID,'') = ISNULL(@PS02ID,'') 
							AND ISNULL(S03ID,'') = ISNULL(@PS03ID,'') 
							AND ISNULL(S04ID,'') = ISNULL(@PS04ID,'') 
							AND ISNULL(S05ID,'') = ISNULL(@PS05ID,'') 
							AND ISNULL(S06ID,'') = ISNULL(@PS06ID,'') 
							AND ISNULL(S07ID,'') = ISNULL(@PS07ID,'') 
							AND ISNULL(S08ID,'') = ISNULL(@PS08ID,'') 
							AND ISNULL(S09ID,'') = ISNULL(@PS09ID,'') 
							AND ISNULL(S10ID,'') = ISNULL(@PS10ID,'') 
							AND ISNULL(S11ID,'') = ISNULL(@PS11ID,'') 
							AND ISNULL(S12ID,'') = ISNULL(@PS12ID,'') 
							AND ISNULL(S13ID,'') = ISNULL(@PS13ID,'') 
							AND ISNULL(S14ID,'') = ISNULL(@PS14ID,'') 
							AND ISNULL(S15ID,'') = ISNULL(@PS15ID,'') 
							AND ISNULL(S16ID,'') = ISNULL(@PS16ID,'') 
							AND ISNULL(S17ID,'') = ISNULL(@PS17ID,'') 
							AND ISNULL(S18ID,'') = ISNULL(@PS18ID,'') 
							AND ISNULL(S19ID,'') = ISNULL(@PS19ID,'') 
							AND ISNULL(S20ID,'') = ISNULL(@PS20ID,'')  
				Set @Delta =  @Cost - @Temp
				If @Delta <>0 
					Begin 
					---Print ' Chenh lech '+str(@Delta,20,4)
					---Print ' Tong gia thanh '+str(@ConvertedAmount,20,4)		
			
				Print ' Tran ' +@TransactionID+' Delta '+str(@Delta)
				 if @TransactionID is not null
				Update #thu02
				set       OriginalAmount =  OriginalAmount + @Delta,
		  		     	 ConvertedAmount  = ConvertedAmount  + @Delta
				
				From #thu02 		
				Where DivisionID= @DivisionID and PeriodID =@PeriodID and TransactionID = @TransactionID

					End
				
			FETCH NEXT FROM @ListMaterial_cur INTO  @ProductID,  @Cost, 
													@PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
													@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID
		End
		Close @ListMaterial_cur


			UPDATE MT1001 SET
		OriginalAmount = #Thu02.OriginalAmount,
		ConvertedAmount = #Thu02.ConvertedAmount
		FROM MT1001 INNER JOIN #Thu02 ON #Thu02.TransactionID = MT1001.TransactionID


--INSERT INTO WT8899 (TableID, VoucherID, TransactionID, DivisionID, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
--					S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID, 
--					QC_OriginalQuantity, QC_OriginalAmount, QC_ConvertedQuantity, QC_ConvertedAmount)
					
--SELECT 'AT2007' AS TableID, A07.VoucherID, A07.TransactionID, A07.DivisionID, 
--					M89.S01ID, M89.S02ID, M89.S03ID, M89.S04ID, M89.S05ID, M89.S06ID, M89.S07ID, M89.S08ID, M89.S09ID, M89.S10ID,
--					M89.S11ID, M89.S12ID, M89.S13ID, M89.S14ID, M89.S15ID, M89.S16ID, M89.S17ID, M89.S18ID, M89.S19ID, M89.S20ID,
--					a07.ActualQuantity, a07.OriginalAmount, a07.ConvertedQuantity, a07.ConvertedAmount
--FROM MT1001 M01 WITH (NOLOCK)
--INNER JOIN MT8899 M89 WITH (NOLOCK) ON M89.TransactionID = M01.TransactionID AND M89.VoucherID = M01.VoucherID
--INNER JOIN MT0810 WITH (NOLOCK) ON MT0810.VoucherID = M01.VoucherID AND MT0810.TranMonth = M01.TranMonth AND MT0810.TranYear = M01.TranYear
--INNER JOIN At2007 A07 WITH (NOLOCK) ON A07.TransactionID = M01.TransactionID AND A07.VoucherID = M01.VoucherID
--WHERE MT0810.PeriodID = @PeriodID and M01.DivisionID = @DivisionID 

--UPDATE wt89  SET wt89.TableID = 'AT2007', wt89.VoucherID = A07.VoucherID, TransactionID = A07.TransactionID, 
--					DivisionID = A07.DivisionID, 
--					S01ID = M89.S01ID, 
--					S02ID = M89.S02ID,
--					S03ID = M89.S03ID, 
--					S04ID = M89.S04ID, 
--					S05ID = M89.S05ID, 
--					S06ID = M89.S06ID, 
--					S07ID = M89.S07ID, 
--					S08ID = M89.S08ID, 
--					S09ID = M89.S09ID, 
--					S10ID = M89.S10ID,
--					S11ID = M89.S11ID, 
--					S12ID = M89.S12ID, 
--					S13ID = M89.S13ID, 
--					S14ID = M89.S14ID, 
--					S15ID = M89.S15ID, 
--					S16ID = M89.S16ID, 
--					S17ID = M89.S17ID, 
--					S18ID = M89.S18ID, 
--					S19ID = M89.S19ID, 
--					S20ID = M89.S20ID, 
--					QC_OriginalQuantity = a07.ActualQuantity, QC_OriginalAmount = a07.OriginalAmount, QC_ConvertedQuantity = a07.ConvertedQuantity, QC_ConvertedAmount = a07.ConvertedAmount
--					FROM dbo.WT8899 wt89 
--					LEFT Join
--					MT1001 M01 WITH (NOLOCK) ON M01.TransactionID = wt89.TransactionID
--					INNER JOIN MT8899 M89 WITH (NOLOCK) ON M89.TransactionID = M01.TransactionID AND M89.VoucherID = M01.VoucherID
--					INNER JOIN MT0810 WITH (NOLOCK) ON MT0810.VoucherID = M01.VoucherID AND MT0810.TranMonth = M01.TranMonth AND MT0810.TranYear = M01.TranYear
--					INNER JOIN At2007 A07 WITH (NOLOCK) ON A07.TransactionID = M01.TransactionID AND A07.VoucherID = M01.VoucherID
--					WHERE MT0810.PeriodID = @PeriodID and M01.DivisionID = @DivisionID


					SELECT'AT2007' AS TableID, A07.VoucherID,  A07.TransactionID, 
					 A07.DivisionID
					, M89.S01ID, 
					 M89.S02ID,
					 M89.S03ID, 
					 M89.S04ID, 
					 M89.S05ID, 
					 M89.S06ID, 
					 M89.S07ID, 
					 M89.S08ID, 
					 M89.S09ID, 
					 M89.S10ID,
					 M89.S11ID, 
					 M89.S12ID, 
					 M89.S13ID, 
					 M89.S14ID, 
					 M89.S15ID, 
					 M89.S16ID, 
					 M89.S17ID, 
					 M89.S18ID, 
					 M89.S19ID, 
					 M89.S20ID
					,a07.ActualQuantity,  a07.OriginalAmount,  a07.ConvertedQuantity,  a07.ConvertedAmount
					INTO  #MP8110_QC_Thu FROM MT1001 M01 WITH (NOLOCK) 
				
					INNER JOIN MT8899 M89 WITH (NOLOCK) ON M89.TransactionID = M01.TransactionID AND M89.VoucherID = M01.VoucherID
					INNER JOIN MT0810 WITH (NOLOCK) ON MT0810.VoucherID = M01.VoucherID AND MT0810.TranMonth = M01.TranMonth AND MT0810.TranYear = M01.TranYear
					INNER JOIN At2007 A07 WITH (NOLOCK) ON A07.TransactionID = M01.TransactionID AND A07.VoucherID = M01.VoucherID
					WHERE MT0810.PeriodID =  @PeriodID  and M01.DivisionID = @DivisionID


					
					UPDATE wt89  SET wt89.TableID = M01.TableID, wt89.VoucherID = M01.VoucherID, TransactionID = M01.TransactionID, 
					DivisionID = M01.DivisionID
					,S01ID = M01.S01ID, 
					S02ID = M01.S02ID,
					S03ID = M01.S03ID, 
					S04ID = M01.S04ID, 
					S05ID = M01.S05ID, 
					S06ID = M01.S06ID, 
					S07ID = M01.S07ID, 
					S08ID = M01.S08ID, 
					S09ID = M01.S09ID, 
					S10ID = M01.S10ID,
					S11ID = M01.S11ID, 
					S12ID = M01.S12ID, 
					S13ID = M01.S13ID, 
					S14ID = M01.S14ID, 
					S15ID = M01.S15ID, 
					S16ID = M01.S16ID, 
					S17ID = M01.S17ID, 
					S18ID = M01.S18ID, 
					S19ID = M01.S19ID, 
					S20ID = M01.S20ID
					,QC_OriginalQuantity = M01.ActualQuantity, QC_OriginalAmount = M01.OriginalAmount, QC_ConvertedQuantity = M01.ConvertedQuantity, QC_ConvertedAmount = M01.ConvertedAmount
					FROM dbo.WT8899 wt89 
					INNER Join
					#MP8110_QC_Thu M01 WITH (NOLOCK) ON M01.TransactionID = wt89.TransactionID
				




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
