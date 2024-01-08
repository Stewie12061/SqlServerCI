IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP00033]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP00033]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Created by Hoài Bảo
----- Created Date 26/07/2022
----- Purpose Tính giá xuất kho theo PP FIFO - Kế thừa từ store AP1303
----- Modified on ... by ...
/*
	
*/

CREATE PROCEDURE  [dbo].[WMP00033] 
		@DivisionID  as nvarchar(50), 
		@TranMonth as int , 
		@TranYear as int,
		@FromInventoryID NVARCHAR(50) = '', 
		@ToInventoryID NVARCHAR(50) = '',
		@WareHouseID NVARCHAR(MAX) = ''

AS

IF ISNULL(@WareHouseID, '') != ''
	SET @WareHouseID = '''' + @WareHouseID + ''''

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND ISNULL(IsSpecificate,0) = 1)
	EXEC WMP00033_QC @DivisionID, @TranMonth, @TranYear, @FromInventoryID, @ToInventoryID, @WareHouseID
ELSE
BEGIN
	
	Declare @InventoryID as  nvarchar(50),
		@FIFO_cur as cursor ,
		@ConvertedAmount as decimal(28,8),
		@ConvertedAmount115 as decimal(28,8),
		@VoucherID as nvarchar(50),
		@TransactionID as nvarchar(50),
		@VoucherDate as Datetime,
		@ActualQuantity as decimal(28,8),
		@WareHouseID_Cur nvarchar(50),
		@ReFIFO_cur as cursor,
		@ReDelete_cur as cursor,
		@ReVoucherID nvarchar(50),
		@ReTransactionID nvarchar(50),
		@EndQuantity as decimal(28,8),
		@UnitPrice as decimal(28,8),
		@CurrentMonth as int,
		@CurrentYear as int,
		@VoucherNo as nvarchar(50),
		@ReVoucherNo as nvarchar(50),
		@ReVoucherDate datetime,
		@Quantity as decimal(28,8),
		@Quantity115 as decimal(28,8),		
		@AccountID As NVarchar(50),		
	
	--PHAN LAM TRON SO
		@QuantityDecimals  as tinyint,
		@UnitCostDecimals  as tinyint, 
		@ConvertedDecimals as tinyint
	
	Select @QuantityDecimals = QuantityDecimals, @UnitCostDecimals = UnitCostDecimals, @ConvertedDecimals = ConvertedDecimals
	FROM AT1101 WITH (NOLOCK) where divisionID = @DivisionID
	Set @QuantityDecimals =isnull( @QuantityDecimals,2)
	Set @UnitCostDecimals = isnull( @UnitCostDecimals,2)
	Set @ConvertedDecimals = isnull( @ConvertedDecimals,2)
		
	
	
	Set @ConvertedAmount  =0 
	-------- B1: huy bo viec tinh gia cua cac phieu xuat tu ky do tro ve sau
	---------- Xu ly cac phieu xuat da Xoa va gia xuat kho da tinh tu ky nay ve sau ---------------------------------------------------------------------------------
	
	---------- Xoa du lieu rac: Bao Quynh; 13/02/2009
	---------- Sua loi tu viec xoa du lieu rac do thieu sot cac phieu so du dau: Bao Quynh; 13/02/2009
	Delete AT0115 
	Where AT0115.DivisionID = @DivisionID 
	AND AT0115.TranMonth = @TranMonth 
	AND AT0115.TranYear = @TranYear 
	AND AT0115.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 
	AND WareHouseID IN (@WareHouseID)
	and 
	NOT EXISTS (SELECT TOP 1 1
				From AT2007  WITH (NOLOCK)
				inner join AT2006 WITH (NOLOCK) on AT2007.VoucherID = AT2006.VoucherID AND AT2007.DivisionID = AT2006.DivisionID
				where	AT2007.DivisionID = @DivisionID 
						AND AT2007.TranMonth = @TranMonth 
						AND AT2007.TranYear = @TranYear 
						AND AT2007.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 	
						AND AT2006.WareHouseID IN (@WareHouseID)		
						AND AT0115.ReTransactionID + '_' + AT0115.InventoryID  = AT2007.TransactionID + '_' + AT2007.InventoryID
					 
				Union all
				Select TOP 1 1
				From AT2017  WITH (NOLOCK)
				inner join AT2016 WITH (NOLOCK) on AT2017.VoucherID = AT2016.VoucherID AND AT2017.DivisionID = AT2016.DivisionID
				where	AT2017.DivisionID = @DivisionID 
						AND AT2017.TranMonth = @TranMonth 
						AND AT2017.TranYear = @TranYear 
						AND AT2017.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 	
						--AND ( (AT2016.KINDVOUCHERID = 3 AND AT2016.WareHouseID2 BETWEEN @FromWareHouseID AND @ToWareHouseID )
						--	OR (AT2016.KINDVOUCHERID <> 3 AND AT2016.WareHouseID BETWEEN @FromWareHouseID AND @ToWareHouseID )
						--	)
						AND AT2016.WareHouseID IN (@WareHouseID)
				AND AT0115.ReTransactionID + '_' + AT0115.InventoryID  = AT2017.TransactionID + '_' + AT2017.InventoryID
				 )
	
	Update AT0114 set DeQuantity = isnull(Quantity,0), EndQuantity = ReQuantity -  isnull(Quantity,0)
	From AT0114 WITH (ROWLOCK) 
	LEFT join ( Select InventoryID, ReTransactionID, Sum(PriceQuantity) as Quantity, DivisionID 
	             From AT0115  WITH (NOLOCK)
	             Group by ReTransactionID,InventoryID, DivisionID
				) A
		on	A.ReTransactionID = AT0114.ReTransactionID 
			And A.InventoryID = AT0114.InventoryID And A.DivisionID = AT0114.DivisionID
	Where isnull(A.Quantity,0)<>isnull(DeQuantity,0) and AT0114.DivisionID = @DivisionID 
	
	
	SET @ReDelete_cur = Cursor Scroll KeySet FOR 
	Select  WareHouseID, ReTransactionID , ReVoucherID, InventoryID,   sum(isnull(PriceQuantity,0))
	From AT0115 WITH (NOLOCK)
	Where DivisionID = @DivisionID 
			AND InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 
			AND WareHouseID IN (@WareHouseID)
			
			and NOT EXISTS (Select TOP 1 1 
							from AT2007 WITH (NOLOCK)
							inner join AT2006 WITH (NOLOCK) on AT2007.VoucherID = AT2006.VoucherID AND AT2007.DivisionID = AT2006.DivisionID 
							Where AT2007.DivisionID = @DivisionID
							AND AT2007.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 	
							AND (	(AT2006.KINDVOUCHERID = 3 AND AT2006.WareHouseID2 IN (@WareHouseID))
								OR (AT2006.KINDVOUCHERID <> 3 AND AT2006.WareHouseID IN (@WareHouseID))
								)
							AND AT2007.TransactionID = AT0115.TransactionID
							)    --- Nhung phieu da xoa roi					
	Group by   WareHouseID, ReTransactionID , ReVoucherID, InventoryID
	union All
	Select  WareHouseID, ReTransactionID , ReVoucherID, InventoryID,  sum(isnull(PriceQuantity,0))
	From AT0115 WITH (NOLOCK)
	Where DivisionID = @DivisionID 
		AND InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 
		AND WareHouseID IN (@WareHouseID)
		
			and  EXISTS (Select TOP 1 1 
							from AT2007 WITH (NOLOCK)
							inner join AT2006 WITH (NOLOCK) on AT2007.VoucherID = AT2006.VoucherID AND AT2007.DivisionID = AT2006.DivisionID 
							Where AT2007.DivisionID = @DivisionID
							AND AT2007.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 	
							AND ( (AT2006.KINDVOUCHERID = 3 AND AT2006.WareHouseID2 IN (@WareHouseID))
								OR (AT2006.KINDVOUCHERID <> 3 AND AT2006.WareHouseID IN (@WareHouseID))
								)
							and AT2007.TranMonth+AT2007.TranYear*100 >=@TranMonth +100*@TranYear
							AND AT2007.TransactionID = AT0115.TransactionID
							)   --- phieu xuat ky nay ve  sau			
	Group by   WareHouseID, ReTransactionID , ReVoucherID, InventoryID
	
	OPEN @ReDelete_cur
	FETCH NEXT FROM @ReDelete_cur INTO  @WareHouseID_Cur, @ReTransactionID , @ReVoucherID, @InventoryID, @ActualQuantity
	WHILE @@Fetch_Status = 0
	 Begin
			--Print ' @ReTransactionID ='+@ReTransactionID+' so tien : '+str(@ActualQuantity)
			
		Update AT0114 WITH (ROWLOCK) set 	DeQuantity = DeQuantity - @ActualQuantity,
					EndQuantity = EndQuantity + @ActualQuantity
		Where 	DivisionID = @DivisionID and 
			WareHouseID = @WareHouseID_Cur and
			InventoryID = @InventoryID and
			ReVoucherID = @ReVoucherID and
			ReTransactionID =@ReTransactionID 
	             FETCH NEXT FROM @ReDelete_cur INTO  @WareHouseID_Cur, @ReTransactionID , @ReVoucherID, @InventoryID, @ActualQuantity
	 End 
	CLOSE @ReDelete_cur
	
	Delete AT0115 Where DivisionID = @DivisionID 
			AND InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 
					AND WareHouseID IN (@WareHouseID)
			and NOT EXISTS 		
			(
				Select TOP 1 1 
				from AT2007 WITH (NOLOCK)
				inner join AT2006  WITH (NOLOCK) on AT2007.VoucherID = AT2006.VoucherID AND AT2007.DivisionID = AT2006.DivisionID 
				Where AT2007.DivisionID = @DivisionID
				AND AT2007.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 	
					AND ( (AT2006.KINDVOUCHERID = 3 AND AT2006.WareHouseID2 IN (@WareHouseID))
						OR (AT2006.KINDVOUCHERID <> 3 AND AT2006.WareHouseID IN (@WareHouseID))
						)
				AND AT2007.TransactionID = AT0115.TransactionID
			)		
			
	
	Delete AT0115 Where DivisionID = @DivisionID 
		AND InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 
		AND WareHouseID IN (@WareHouseID)
		and EXISTS
		(	 Select TOP 1 1 from AT2007 WITH (NOLOCK) inner join AT2006 WITH (NOLOCK) on AT2007.VoucherID = AT2006.VoucherID AND AT2007.DivisionID = AT2006.DivisionID 
			 Where AT2007.DivisionID = @DivisionID
					AND AT2007.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 	
					AND ( (AT2006.KINDVOUCHERID = 3 AND AT2006.WareHouseID2 IN (@WareHouseID))
						OR (AT2006.KINDVOUCHERID <> 3 AND AT2006.WareHouseID IN (@WareHouseID)))
					and AT2007.TranMonth+AT2007.TranYear*100 >=@TranMonth +100*@TranYear  --- phieu xuat ky nay ve  sau	
					AND AT2007.TransactionID = AT0115.TransactionID
			)--- phieu xuat ky nay ve  sau		
		
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	----------- Lay ra cac phan tu cua phieu xuat thep PP FIFO-----------------------------------------------------------
	SET @FIFO_cur = Cursor Scroll KeySet FOR 
		Select (CASE WHEN AT2006.KINDVOUCHERID = 3 THEN AT2006.WareHouseID2 ELSE AT2006.WareHouseID END) as WareHouseID , At2007.VoucherID, TransactionID, 
				At2007.InventoryID , ActualQuantity, VoucherNo, VoucherDate , 
				AT2007.CreditAccountID,
				At2007.TranMonth, At2007.TranYear
		From AT2007  WITH (NOLOCK)	inner join AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID and AT2006.DivisionID = AT2007.DivisionID 
				inner join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (AT2007.DivisionID,'@@@') AND AT1302.InventoryID = AT2007.InventoryID AND MethodID =1 
		Where 	AT2007.DivisionID = @DivisionID and
			KindVoucherID in (2,3,4,6,8,10) and -- Bổ sung KindVoucherID=10 (Phiếu Hàng mua trả lại xuất kho)
			At2007.TranMonth + AT2007.TranYear*100 >= @TranMonth +100*@TranYear
			AND AT2007.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 
			AND ( (AT2006.KINDVOUCHERID = 3 AND AT2006.WareHouseID2 IN (@WareHouseID))
				OR (AT2006.KINDVOUCHERID <> 3 AND AT2006.WareHouseID IN (@WareHouseID))
				)
		Order by AT2006.VoucherDate, AT2007.VoucherID, Orders ---- Cac phieu xuat kho theo thu tu ngay tang dan 
	---Print ' TEST'
	OPEN	@FIFO_cur
	FETCH NEXT FROM @FIFO_cur INTO   @WareHouseID_Cur, @VoucherID, @TransactionID, @InventoryID, @ActualQuantity, @VoucherNo, @VoucherDate , @AccountID, @CurrentMonth, @CurrentYear 
	WHILE @@Fetch_Status = 0
	
		Begin	
			Set @ConvertedAmount = 0
			Set @Quantity = 0		
	
			Set @ReFIFO_cur = Cursor Scroll KeySet FOR  ---- Lay cac phieu nhap tuong ung co the xuat kho dc.
	
			Select AT0114.ReVoucherID, AT0114.ReTransactionID, AT0114.EndQuantity , isnull(AV3004.UnitPrice,0),  AT0114.ReVoucherNo, AT0114.ReVoucherDate  
			From AT0114  WITH (NOLOCK)	INNER JOIN AV3004 ON AV3004.TransactionID = AT0114.ReTransactionID and AV3004.DivisionID = AT0114.DivisionID
							and AV3004.InventoryID = AT0114.InventoryID
				LEFT JOIN AT2006 ON AT2006.VoucherID = AT0114.ReVoucherID
				--INNER JOIN AT2007 ON AT2007.TransactionID = AT0114.ReTransactionID
	
			Where AT0114.DivisionID = @DivisionID and 
				AT0114.ReVoucherDate<=@VoucherDate and
				--(CASE WHEN AT2006.KINDVOUCHERID = 3 THEN AT2006.WareHouseID2 ELSE AT2006.WareHouseID END) = @WareHouseID and
				AV3004.WareHouseID= @WareHouseID_Cur and
				AT0114.InventoryID =@InventoryID and
				AT0114.EndQuantity >0	 and
				AV3004.DebitAccountID = @AccountID
			Order by AT0114.ReVoucherDate, AT2006.CreateDate, AT0114.ReTransactionID
			Open @ReFIFO_cur
			FETCH NEXT FROM @ReFIFO_cur  INTO  @ReVoucherID, @ReTransactionID,  @EndQuantity, @UnitPrice, @ReVoucherNo, @ReVoucherDate
				WHILE @@Fetch_Status = 0 and @ActualQuantity>0 
					Begin
						Set @Quantity115 =0
						If @EndQuantity>@ActualQuantity
							Begin
								
								Set @ConvertedAmount = ROUND(ROUND(@ConvertedAmount,@ConvertedDecimals)+ ROUND(@UnitPrice,@UnitCostDecimals)*ROUND(@ActualQuantity,@QuantityDecimals) ,@ConvertedDecimals)
								Set @ConvertedAmount115 = ROUND(ROUND(@UnitPrice,@UnitCostDecimals)*ROUND(@ActualQuantity,@QuantityDecimals) ,@ConvertedDecimals)
								Set @Quantity = ROUND(@Quantity+ @ActualQuantity,@QuantityDecimals)	
								set @Quantity115 =ROUND(@ActualQuantity,@QuantityDecimals)	
								Set @ActualQuantity = 0 	
	
									
							 End
							Else
							 Begin
								Set @ConvertedAmount = ROUND(ROUND(@ConvertedAmount,@ConvertedDecimals)+ ROUND(@UnitPrice,@UnitCostDecimals)*ROUND(@EndQuantity,@QuantityDecimals) ,@ConvertedDecimals)
								Set @ConvertedAmount115 = ROUND(ROUND(@UnitPrice,@UnitCostDecimals)*ROUND(@EndQuantity,@QuantityDecimals) ,@ConvertedDecimals)
								Set @Quantity = ROUND(@Quantity+ @EndQuantity  ,@QuantityDecimals)
								Set @Quantity115 = ROUND(@EndQuantity ,@QuantityDecimals) 	
								Set @ActualQuantity  =ROUND( ROUND(@ActualQuantity,@QuantityDecimals) - ROUND(@EndQuantity,@QuantityDecimals)	,@QuantityDecimals)
	
													
							 End
							Update AT0114 WITH (ROWLOCK) set 	EndQuantity =  EndQuantity - @Quantity115 ,
										DeQuantity = DeQuantity + @Quantity115
								Where ReVoucherID = @ReVoucherID and
									DivisionID= @DivisionID and
									WareHouseID = @WareHouseID_Cur and
									InventoryID = @InventoryID and
									ReTransactionID =@ReTransactionID
						
						
							Insert AT0115 (DivisionID, TranMonth, TranYear, WareHouseID, VoucherDate, VoucherNo,  VoucherID, TransactionID, InventoryID,
										 UnitPrice, PriceQuantity, ConvertedAmount, ReVoucherID, ReTransactionID, ReVoucherDate, ReVoucherNo)
								Values (@DivisionID, @CurrentMonth, @CurrentYear, @WareHouseID_Cur, @VoucherDate, @VoucherNo, @VoucherID, @TransactionID, @InventoryID,
										@UnitPrice,  @Quantity115 , @ConvertedAmount115, @ReVoucherID, @ReTransactionID, @ReVoucherDate, @ReVoucherNo)
	
						
	
	
						 FETCH NEXT FROM @ReFIFO_cur  INTO  @ReVoucherID, @ReTransactionID,  @EndQuantity, @UnitPrice, @ReVoucherNo, @ReVoucherDate
					End 
	
			             Update AT2007 WITH (ROWLOCK) set 	ConvertedAmount = Round(@ConvertedAmount,@ConvertedDecimals),
							OriginalAmount  = Round(@ConvertedAmount,@ConvertedDecimals),
							UnitPrice =Round( ( Case when ActualQuantity <>0 then  round(@ConvertedAmount, @ConvertedDecimals) / ActualQuantity else 0 end ),@UnitCostDecimals)
				Where DivisionID = @DivisionID and TransactionID = @TransactionID 
	
	FETCH NEXT FROM @FIFO_cur INTO   @WareHouseID_Cur, @VoucherID, @TransactionID, @InventoryID, @ActualQuantity, @VoucherNo, @VoucherDate , @AccountID, @CurrentMonth, @CurrentYear 
		End
	CLOSE @FIFO_cur
	--return
	 ---Goi  Store de lam tron phan tinh gia FIFO
	  Exec AP1301 @DivisionID, @TranMonth, @TranYear
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
