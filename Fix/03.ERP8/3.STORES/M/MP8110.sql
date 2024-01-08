IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[MP8110]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[MP8110]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



--Created by Hoang Thi Lan
--Date 28/11/2003
--Purpose:CËp nhËt vµo kÕt qu¶ s¶n xuÊt kÕt qu¶ tÝnh gi¸ thµnh
-- Modified on 27/06/2014 by Thanh Sơn : Cập nhật câu sql lấy số lẻ đơn giá
-- Modified by Tiểu Mai on 14/01/2016: Bổ sung trường hợp thiết lập quản lý quy cách hàng hóa.
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Kim Thư on 21/03/2019: Sắp xếp lại thứ tự where theo index, viết lại phần update vào AT2007 để cải thiện tốc độ. 
---- Modified by Nhựt Trường on 18/10/2021: Bỏ bớt round khi update ConvertedPrice ở MT1001 để fix lỗi lệch tiền.
---- Modified by Nhựt Trường on 03/11/2021: Bổ sung điều kiện DivisionID khi Join bảng.

/********************************************
'* Edited by: [GS] [Hoàng Phước] [02/08/2010]
'********************************************/
---- Modified by Phương Thảo on 11/07/2017: Bổ sung lưu dữ liệu đơn giá quy đổi

CREATE PROCEDURE [dbo].[MP8110] 	@DivisionID as nvarchar(50),
					@PeriodID as  nvarchar(50)

 AS
Declare @sSQL  as nvarchar(4000),
	@ListMaterial_cur as cursor,
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
	@OriginalDecimal DECIMAL(28,8)

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	EXEC MP8110_QC @DivisionID, @PeriodID
ELSE
BEGIN
	SELECT @ConvertedDecimal = ConvertDecimal, @UnitPriceDecimal = UnitPriceDecimal, @OriginalDecimal = OriginalDecimal  FROM MT0000 WITH (NOLOCK) where DivisionID = @DivisionID
	set @ConvertedDecimal = isnull(@ConvertedDecimal,2)
	set @UnitPriceDecimal = isnull(@UnitPriceDecimal,2)
	set @OriginalDecimal = isnull(@OriginalDecimal,2)
	
	Select ProductID, CostUnit, Cost,  
		isnull(EndInprocessCost,0) AS EndCost
	INTO #TEMP3
	FROM MT1614 WITH (NOLOCK)
	Where 	DivisionID = @DivisionID and periodID = @PeriodID

	Update MT1001 WITH (ROWLOCK)
	Set  MT1001.Price = #TEMP3.CostUnit,
			MT1001.OriginalAmount =  Round(MT1001.Quantity*round(#TEMP3.CostUnit, @UnitPriceDecimal), @OriginalDecimal),
		  	MT1001.ConvertedAmount  = Round(MT1001.Quantity*round(#TEMP3.CostUnit,@UnitPriceDecimal), @ConvertedDecimal),
			MT1001.ConvertedPrice = Round(Case when ConvertedQuantity <>0 then MT1001.Quantity * #TEMP3.CostUnit/ConvertedQuantity else 0 end,@UnitPriceDecimal)		
	From MT1001 inner join MT0810 WITH (ROWLOCK) on MT0810.DivisionID = MT1001.DivisionID AND MT0810.VoucherID =MT1001.VoucherID
				INNER JOIN #TEMP3 ON MT1001.ProductID = #TEMP3.ProductID
	Where MT0810.DivisionID= @DivisionID and MT0810.PeriodID =@PeriodID 
		and MT0810.ResultTypeID = 'R01'
				

	SELECT * , (Select sum(ISNULL(Quantity,0)) From MT1001 M1 WITH (NOLOCK) inner join MT0810 M10 WITH (NOLOCK)  on M10.VoucherID  = M1.VoucherID
				Where 	M1.DivisionID =@DivisionID and
					PeriodID =@PeriodID and
					M1.ProductID = #TEMP3.ProductID and
					ResultTypeID ='R03' ) AS Quantity
	INTO #TEMP4
	FROM #TEMP3 

	Update MT1001 WITH (ROWLOCK)
	Set  MT1001.Price = Case when #TEMP4.Quantity <>0 then #TEMP4.EndCost/#TEMP4.Quantity else 0 end,
			MT1001.OriginalAmount =  Case when #TEMP4.Quantity <>0 then (MT1001.Quantity*#TEMP4.EndCost)/#TEMP4.Quantity else 0 end,
		  	MT1001.ConvertedAmount  = Case when #TEMP4.Quantity <>0 then (MT1001.Quantity*#TEMP4.EndCost)/#TEMP4.Quantity else 0 END,
			MT1001.ConvertedPrice = Round(Case when ConvertedQuantity <>0 then  Case when #TEMP4.Quantity <>0 then (MT1001.Quantity*#TEMP4.EndCost)/#TEMP4.Quantity else 0 END /ConvertedQuantity else 0 end,@UnitPriceDecimal)
	From MT1001 inner join MT0810 WITH (ROWLOCK) on MT0810.DivisionID = MT1001.DivisionID AND MT0810.VoucherID =MT1001.VoucherID
				INNER JOIN #TEMP4 ON MT1001.ProductID = #TEMP4.ProductID
	Where MT0810.DivisionID= @DivisionID and MT0810.PeriodID =@PeriodID 
		and MT0810.ResultTypeID = 'R03'
							
/*
	Set @ListMaterial_cur  = Cursor Scroll KeySet FOR 

	Select ProductID, CostUnit, Cost,  
		isnull(EndInprocessCost,0) 
	From MT1614 WITH (NOLOCK)
	Where 	DivisionID = @DivisionID and periodID = @PeriodID

	Open @ListMaterial_cur 
			FETCH NEXT FROM @ListMaterial_cur INTO  @ProductID , @CostUnit, @Cost, @EndCost
			WHILE @@Fetch_Status = 0
				Begin	
				
					Update MT1001 WITH (ROWLOCK)
					Set  MT1001.Price = @CostUnit,
						  MT1001.OriginalAmount =  Round(MT1001.Quantity*round(@CostUnit, @UnitPriceDecimal), @OriginalDecimal),
		  				 MT1001.ConvertedAmount  = Round(MT1001.Quantity*round(@CostUnit,@UnitPriceDecimal), @ConvertedDecimal)
				
					From MT1001 inner join MT0810 WITH (ROWLOCK) on MT0810.VoucherID =MT1001.VoucherID
					Where MT0810.DivisionID= @DivisionID and MT0810.PeriodID =@PeriodID 
						and MT0810.ResultTypeID = 'R01' and MT1001.ProductID = @ProductID 
				
					
					Update MT1001 WITH (ROWLOCK)
					Set  MT1001.ConvertedPrice = Round(Case when ConvertedQuantity <>0 then MT1001.OriginalAmount/ConvertedQuantity else 0 end,@UnitPriceDecimal)						
					From MT1001 inner join MT0810 WITH (ROWLOCK) on MT0810.VoucherID =MT1001.VoucherID
					Where MT0810.DivisionID= @DivisionID and MT0810.PeriodID =@PeriodID 
						 and MT0810.ResultTypeID = 'R01' and MT1001.ProductID = @ProductID


				Set @Quantity =0
				Set @Quantity = 	(Select sum(Quantity) From MT1001 M1 WITH (NOLOCK) inner join MT0810 M10 WITH (NOLOCK)  on M10.VoucherID  = M1.VoucherID
							Where 	M1.DivisionID =@DivisionID and
								PeriodID =@PeriodID and
								M1.ProductID = @ProductID and
								ResultTypeID ='R03' )
					--Print ' Q: '+Str(@Quantity)+' P: '+@ProductID+' @EndCost: '+str(@EndCost)+' U ='+str(@EndCost/@Quantity)
				
				
					Update MT1001 WITH (ROWLOCK)
					Set  MT1001.Price = Case when @Quantity <>0 then @EndCost/@Quantity else 0 end,
						  MT1001.OriginalAmount =  Case when @Quantity <>0 then (Quantity*@EndCost)/@Quantity else 0 end,
		  				  MT1001.ConvertedAmount  = Case when @Quantity <>0 then (Quantity*@EndCost)/@Quantity else 0 end
				
					From MT1001 inner join MT0810 WITH (ROWLOCK) on MT0810.VoucherID =MT1001.VoucherID
					Where MT0810.DivisionID= @DivisionID and MT0810.PeriodID =@PeriodID 
						and MT0810.ResultTypeID = 'R03' and MT1001.ProductID = @ProductID 					
					
					--- Tinh don gia QD
					Update MT1001 WITH (ROWLOCK)
					Set  MT1001.ConvertedPrice = Round(Case when ConvertedQuantity <>0 then MT1001.OriginalAmount/ConvertedQuantity else 0 end,@UnitPriceDecimal)				
					From MT1001 inner join MT0810 WITH (ROWLOCK) on MT0810.VoucherID =MT1001.VoucherID
					Where MT0810.DivisionID= @DivisionID and MT0810.PeriodID =@PeriodID 
						and MT0810.ResultTypeID = 'R03' and MT1001.ProductID = @ProductID 


			FETCH NEXT FROM @ListMaterial_cur INTO   @ProductID ,@CostUnit, @Cost, @EndCost

			End
	Close @ListMaterial_cur
	DEALLOCATE @ListMaterial_cur
*/

	set @ConvertedAmount = isnull( (Select  sum(isnull(Cost,0)) From MT1614 WITH (NOLOCK) Where  	DivisionID = @DivisionID and 	PeriodID = @PeriodID),0)

	Set @Delta =0 

	Set @Delta = @ConvertedAmount -   isnull((Select  sum(isnull(MT1001.ConvertedAmount,0))  From MT1001 WITH (NOLOCK)  inner join MT0810 WITH (NOLOCK) on MT0810.DivisionID = MT1001.DivisionID AND MT0810.VoucherID =MT1001.VoucherID
											Where MT0810.DivisionID= @DivisionID and MT0810.PeriodID =@PeriodID 
											 and MT0810.ResultTypeID = 'R01'  ),0) 

	If @Delta <>0 
		Begin 
			---Print ' Chenh lech '+str(@Delta,20,4)
			---Print ' Tong gia thanh '+str(@ConvertedAmount,20,4)
		
			Set @TransactionID = (Select top 1 TransactionID From MT1001 WITH (NOLOCK) inner join MT0810 WITH (NOLOCK) on MT0810.DivisionID = MT1001.DivisionID AND  MT0810.VoucherID =MT1001.VoucherID
							Where MT0810.DivisionID= @DivisionID and MT0810.PeriodID =@PeriodID 
								 and MT0810.ResultTypeID = 'R01' 
							Order by MT1001.ConvertedAmount Desc)
			Print ' Tran ' +@TransactionID
			 if @TransactionID is not null
				Update MT1001 WITH (ROWLOCK)
				
					set       MT1001.OriginalAmount =  MT1001.OriginalAmount + @Delta,
		  		     		 MT1001.ConvertedAmount  =MT1001.ConvertedAmount  + @Delta
				
					From MT1001 inner join MT0810  WITH (ROWLOCK) on MT0810.DivisionID = MT1001.DivisionID AND MT0810.VoucherID =MT1001.VoucherID
					Where MT0810.DivisionID= @DivisionID and MT0810.PeriodID =@PeriodID 
						and MT0810.ResultTypeID = 'R01' and MT1001.TransactionID = @TransactionID 
		End

	-- Làm tròn lần 2 - dư - Kim Thư commented
	/*SELECT *, CASE WHEN X.Delta <> 0 THEN (Select top 1 MT1001.TransactionID From MT1001 WITH (NOLOCK) inner join MT0810 WITH (NOLOCK) on MT0810.VoucherID =MT1001.VoucherID
								Where MT0810.DivisionID= @DivisionID and MT0810.PeriodID =@PeriodID and MT0810.ResultTypeID = 'R01'  and MT1001.ProductID =X.ProductID	 
								Order by MT1001.ConvertedAmount Desc) ELSE NULL END AS TransactionID
	INTO #TEMP2
	FROM (SELECT ProductID,  Cost, 
			Cost - isnull((Select Sum(MT1001.ConvertedAmount) 
					From MT1001 WITH (NOLOCK)  inner join MT0810 WITH (NOLOCK) on MT0810.VoucherID =MT1001.VoucherID
					Where MT0810.DivisionID= @DivisionID and MT0810.PeriodID =@PeriodID
							and MT0810.ResultTypeID = 'R01' and MT1001.ProductID = MT1614.ProductID ),0) AS Delta
		From MT1614 WITH (NOLOCK)
		Where 	DivisionID = @DivisionID and
			PeriodID = @PeriodID
	) X

	Update MT1001		
	set       MT1001.OriginalAmount =  MT1001.OriginalAmount + @Delta,
		  		MT1001.ConvertedAmount  =MT1001.ConvertedAmount  + @Delta
				
	From MT1001  WITH (ROWLOCK) INNER join MT0810 WITH (ROWLOCK) on MT0810.VoucherID =MT1001.VoucherID
								INNER JOIN #TEMP2 ON #TEMP2.TransactionID = MT1001.TransactionID AND ISNULL(MT1001.TransactionID,'')<>'' AND #TEMP2.ProductID = MT1001.ProductID
	Where MT0810.DivisionID= @DivisionID and MT0810.PeriodID =@PeriodID
		and MT0810.ResultTypeID = 'R01' */

/*
	------ Edit by VAN NHAN
	Set @ListMaterial_cur  = Cursor Scroll KeySet FOR 
	Select ProductID,  Cost
	From MT1614 WITH (NOLOCK)
	Where 	DivisionID = @DivisionID and
		PeriodID = @PeriodID

	Open @ListMaterial_cur 
			FETCH NEXT FROM @ListMaterial_cur INTO  @ProductID,  @Cost
			WHILE @@Fetch_Status = 0
				Begin	

					Set @Temp =0
					Set @Delta =0
					Set @Temp = 	isnull((Select Sum(MT1001.ConvertedAmount) 
							From MT1001 WITH (NOLOCK)  inner join MT0810 WITH (NOLOCK) on MT0810.VoucherID =MT1001.VoucherID
							Where MT0810.DivisionID= @DivisionID and MT0810.PeriodID =@PeriodID 
								 and MT0810.ResultTypeID = 'R01' and MT1001.ProductID = @ProductID ),0)
					Set @Delta =  @Cost - @Temp
					If @Delta <>0 
					Begin 
						---Print ' Chenh lech '+str(@Delta,20,4)
						---Print ' Tong gia thanh '+str(@ConvertedAmount,20,4)		
						Set @TransactionID = (Select top 1 TransactionID From MT1001 WITH (NOLOCK) inner join MT0810 WITH (NOLOCK) on MT0810.VoucherID =MT1001.VoucherID
								Where MT0810.DivisionID= @DivisionID and MT0810.PeriodID =@PeriodID and MT0810.ResultTypeID = 'R01'  and ProductID =@ProductID	 
								Order by MT1001.ConvertedAmount Desc)
						Print ' Tran ' +@TransactionID+' Delta '+str(@Delta)
						 if @TransactionID is not null
						Update MT1001
				
						set       MT1001.OriginalAmount =  MT1001.OriginalAmount + @Delta,
		  		     			 MT1001.ConvertedAmount  =MT1001.ConvertedAmount  + @Delta
				
						From MT1001  WITH (ROWLOCK) INNER join MT0810 WITH (ROWLOCK) on MT0810.VoucherID =MT1001.VoucherID
						Where MT0810.DivisionID= @DivisionID and MT0810.PeriodID =@PeriodID and TransactionID = @TransactionID 
							and MT0810.ResultTypeID = 'R01'     and ProductID =@ProductID
					END		
				FETCH NEXT FROM @ListMaterial_cur INTO   @ProductID,  @Cost
			End
			Close @ListMaterial_cur
			DEALLOCATE @ListMaterial_cur
*/


	Select  	MT1001.TransactionID, 
		MT1001.ProductID,
		MT1001.price, 
		MT1001.ConvertedAmount INTO #TEMP
	From 	MT1001 WITH (NOLOCK) inner join MT0810 WITH (NOLOCK) on MT0810.DivisionID = MT1001.DivisionID AND MT0810.VoucherID = MT1001.VoucherID
	Where 	MT1001.DivisionID =@DivisionID and MT0810.PeriodID = @PeriodID and 
		 MT0810.ResultTypeID ='R01' AND Mt0810.IsWareHouse =1

	UPDATE A1  WITH (ROWLOCK) SET	A1.UnitPrice = #TEMP.Price,
								A1.OriginalAmount = #TEMP.ConvertedAmount,
								A1.ConvertedAmount = #TEMP.ConvertedAmount
	FROM AT2007 A1 INNER JOIN #TEMP ON A1.InventoryID = #TEMP.ProductID AND A1.TransactionID =#TEMP.TransactionID
	WHERE A1.DivisionID =@DivisionID

/*
	---- Day lai ASOFT - T
	Set @AT2007_cur  = Cursor Scroll KeySet FOR 
	Select  	TransactionID, 
		ProductID,
		price, 
		MT1001.ConvertedAmount 
	From 	MT1001 WITH (NOLOCK) inner join MT0810 WITH (NOLOCK) on MT0810.VoucherID = MT1001.VoucherID
	Where 	MT0810.PeriodID = @PeriodID and MT1001.DivisionID =@DivisionID and
		 ResultTypeID ='R01' AND Mt0810.IsWareHouse =1

	Open @AT2007_cur
	FETCH NEXT FROM @AT2007_cur INTO  @TransactionID, @ProductID, @Price , @ConvertedAmount
			WHILE @@Fetch_Status = 0
				Begin	
					Update AT2007  WITH (ROWLOCK) SET	 UnitPrice = @Price,
								OriginalAmount = @ConvertedAmount,
								ConvertedAmount = @ConvertedAmount
					Where DivisionID =@DivisionID AND
						InventoryID =@ProductID and
						TransactionID =@TransactionID
						
					FETCH NEXT FROM @AT2007_cur INTO  @TransactionID, @ProductID, @Price, @ConvertedAmount			
				End

	ClOSE @AT2007_cur
*/	
END	 


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

