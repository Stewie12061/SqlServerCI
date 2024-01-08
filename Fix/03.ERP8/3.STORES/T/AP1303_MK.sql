IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1303_MK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1303_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Created by Nguyen Van Nhan
----- Created Date 18/10/2005
----- Purpose Tinh gia xuat kho theo PP FIFO
----- Edit by Nguyen Quoc Huy  26/05/2006
----- Modified on 29/03/2012 by Lê Thị Thu Hiền : Sửa LEFT JOIN thành INNER JOIN
----- Modified on 19/11/2012 by Bao Anh		Sua loi cap nhat sai AT0114 khi tinh gia xuat kho lan 1 
											---(do AT0115 rong -> sua lai AT0114 Left join AT0115)
----- Edit by Khanh Van on 16/09/2013 :Ket them dieu kien DivisionID
----- Edit by Mai Duyen on 28/03/2014 :ket them AV3004.InventoryID (Fix lỗi KH EIS)
----- Modified on 08/10/2015 by Tieu Mai: Sửa phần làm tròn số lẻ theo thiết lập đơn vị-chi nhánh
----- Modify on 25/01/2016 by Bảo Anh: khi lọc các phiếu xuất cần tính giá, nếu là VCNB thì lấy WarehouseID2
----- Modify on 25/01/2016 by Bảo Anh: sửa lỗi xóa sai các phiếu nhập rác trong AT0115 nhưng không còn tồn tại trong AT2007
---- Modified by Bảo Thy on 27/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Phương Thảo on 19/07/2016:  Bổ sung WITH(ROWLOCK)
---- Modified by Phương Thảo on 06/09/2016:  Bổ sung thông tin ngày tính giá, user tính giá
---- Modified by Bảo Anh on 21/04/2018:  Sửa cách lấy giá cho trường hợp chốt số liệu bình quân, cải tiến tốc độ, không gọi AP1301 để làm tròn
---- Modified by Huỳnh Thử on 11/07/2020:  Chỉ tính giá những mặt hàng có phát sinh trong kỳ
---- Modified by Huỳnh Thử on 19/08/2020:  Merge Code: MEKIO và MTE
---- Modified on 20/08/2020 by Huỳnh Thử: Fix lỗi chạy all fix
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.


/********************************************
'* Edited by: [GS] [Thanh Nguyen] [29/07/2010]
'********************************************/
--- AP1309 'MK',8,2018,'13070510','13070510','EMA0000','PCB03','152','158','',''

CREATE PROCEDURE  [dbo].[AP1303_MK] 
		@DivisionID  as nvarchar(50), 
		@TranMonth as int , 
		@TranYear as int,
		@FromInventoryID NVARCHAR(50) = '', 
		@ToInventoryID NVARCHAR(50) = '',
		@FromWareHouseID NVARCHAR(50) = '', 
		@ToWareHouseID NVARCHAR(50) = '',
		@UserID NVARCHAR(50) = ''

AS


Declare @InventoryID as  nvarchar(50),
	@FIFO_cur as cursor ,
	@ConvertedAmount as decimal(28,8),
	@ConvertedAmount115 as decimal(28,8),
	@VoucherID as nvarchar(50),
	@TransactionID as nvarchar(50),
	@VoucherDate as Datetime,
	@ActualQuantity as decimal(28,8),
	@WareHouseID nvarchar(50),
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

	-- Mặt hàng trong kỳ
	SELECT DISTINCT InventoryID INTO #InventoryID FROM AT2007 WITH (NOLOCK)
				LEFT JOIN AT2006  WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID 
				WHERE AT2006.TranMonth = @TranMonth AND AT2006.TranYear = @TranYear
				AND InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 
				AND KindVoucherID IN (2,3,4,6,8) 

Select @QuantityDecimals = QuantityDecimals, @UnitCostDecimals = UnitCostDecimals, @ConvertedDecimals = ConvertedDecimals
FROM AT1101 WITH (NOLOCK) where divisionID = @DivisionID
Set @QuantityDecimals =isnull( @QuantityDecimals,2)
Set @UnitCostDecimals = isnull( @UnitCostDecimals,2)
Set @ConvertedDecimals = isnull( @ConvertedDecimals,2)
	
Set @ConvertedAmount  =0 


--- Xoa cac phieu xuat o AT0115 da bi xoa trong AT2007
DELETE AT0115
WHERE DivisionID = @DivisionID And TranMonth + 100*TranYear >= @TranMonth + 100*@TranYear
--AND InventoryID BETWEEN @FromInventoryID AND @ToInventoryID
AND InventoryID IN (SELECT InventoryID FROM #InventoryID) 
AND WareHouseID BETWEEN @FromWareHouseID AND @ToWareHouseID
AND NOT EXISTS (SELECT 1 FROM AT2007 WITH (NOLOCK) WHERE DivisionID = @DivisionID And TransactionID = AT0115.TransactionID)

--- Update Sl xuất và Sl tồn cho các phiếu xuất từ ky này về sau để chuẩn bị tính lại giá
Update AT0114 set 	DeQuantity = DeQuantity - ISNULL(AT0115.PriceQuantity,0),
			EndQuantity = EndQuantity + ISNULL(AT0115.PriceQuantity,0)
FROM AT0114
INNER JOIN (Select DivisionID, ReVoucherID, ReTransactionID, SUM(ISNULL(AT0115.PriceQuantity,0)) AS PriceQuantity From AT0115
			Where DivisionID = @DivisionID And TranMonth + 100*TranYear >= @TranMonth + 100*@TranYear
				--AND InventoryID BETWEEN @FromInventoryID AND @ToInventoryID
				AND InventoryID IN (SELECT InventoryID FROM #InventoryID) 
				AND WareHouseID BETWEEN @FromWareHouseID AND @ToWareHouseID
			Group by DivisionID, ReVoucherID, ReTransactionID) AT0115
ON AT0114.DivisionID = AT0115.DivisionID AND AT0114.ReVoucherID = AT0115.ReVoucherID AND AT0114.ReTransactionID = AT0115.ReTransactionID
WHERE AT0114.DivisionID = @DivisionID AND AT0114.ReTranMonth + 100*AT0114.ReTranYear < @TranMonth + 100*@TranYear
--AND InventoryID BETWEEN @FromInventoryID AND @ToInventoryID
AND InventoryID IN (SELECT InventoryID FROM #InventoryID) 
AND WareHouseID BETWEEN @FromWareHouseID AND @ToWareHouseID

Update AT0114 SET DeQuantity = 0, EndQuantity = ReQuantity
WHERE DivisionID = @DivisionID AND ReTranMonth + 100*ReTranYear >= @TranMonth + 100*@TranYear
--AND InventoryID BETWEEN @FromInventoryID AND @ToInventoryID
AND InventoryID IN (SELECT InventoryID FROM #InventoryID) 
AND WareHouseID BETWEEN @FromWareHouseID AND @ToWareHouseID
	
--- Xóa các phiếu xuất từ ky này về sau để chuẩn bị tính lại giá		
Delete AT0115
Where DivisionID = @DivisionID AND TranMonth + 100*TranYear >= @TranMonth + 100*@TranYear
--AND InventoryID BETWEEN @FromInventoryID AND @ToInventoryID
AND InventoryID IN (SELECT InventoryID FROM #InventoryID) 
AND WareHouseID BETWEEN @FromWareHouseID AND @ToWareHouseID

--COMMIT
--return
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------- Lay ra cac phan tu cua phieu xuat thep PP FIFO-----------------------------------------------------------
	if NOT EXISTS (SELECT top 1 1
		FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
	AND TABLE_NAME = 'Temp_AP1330_MK')
	create table Temp_AP1330_MK (TransactionID nvarchar(50), ConvertedAmount decimal(28,8))

DELETE TEMP_AP1330_MK
DECLARE @INDEX INT
SET @INDEX = 0
SELECT * INTO #TEMP_AP1303_MK FROM AV3004_MK
 --DISABLE TRIGGER UPDATE CỦA BẢNG AT2007
EXEC('DISABLE TRIGGER AZ2007 ON AT2007') 

SET @FIFO_cur = Cursor Scroll KeySet FOR 
	SELECT   (CASE WHEN AT2006.KINDVOUCHERID = 3 THEN AT2006.WareHouseID2 ELSE AT2006.WareHouseID END) as WareHouseID , At2007.VoucherID, TransactionID, 
			At2007.InventoryID , ActualQuantity, VoucherNo, VoucherDate , 
			AT2007.CreditAccountID,
			At2007.TranMonth, At2007.TranYear
	From AT2007  WITH (NOLOCK)	inner join AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID and AT2006.DivisionID = AT2007.DivisionID 
			inner join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (AT2007.DivisionID,'@@@') and AT1302.InventoryID = AT2007.InventoryID and  MethodID =1 
	Where 	AT2007.DivisionID = @DivisionID and
		KindVoucherID in (2,3,4,6,8) and
		At2007.TranMonth + AT2007.TranYear*100 >= @TranMonth +100*@TranYear
		--AND AT2007.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 
		AND AT2007.InventoryID IN (SELECT InventoryID FROM #InventoryID) 
		AND ( (AT2006.KINDVOUCHERID = 3 AND AT2006.WareHouseID2 BETWEEN @FromWareHouseID AND @ToWareHouseID )
			OR (AT2006.KINDVOUCHERID <> 3 AND AT2006.WareHouseID BETWEEN @FromWareHouseID AND @ToWareHouseID )
			)
	Order by AT2006.VoucherDate, AT2006.VoucherNo ---- Cac phieu xuat kho theo thu tu ngay tang dan 
---Print ' TEST'
OPEN	@FIFO_cur
FETCH NEXT FROM @FIFO_cur INTO   @WareHouseID, @VoucherID, @TransactionID, @InventoryID, @ActualQuantity, @VoucherNo, @VoucherDate , @AccountID, @CurrentMonth, @CurrentYear 
WHILE @@Fetch_Status = 0

	Begin	
		Set @ConvertedAmount = 0
		Set @Quantity = 0		
		
		Set @ReFIFO_cur = Cursor Scroll KeySet FOR  ---- Lay cac phieu nhap tuong ung co the xuat kho dc.
		Select	AT0114.ReVoucherID, AT0114.ReTransactionID, AT0114.EndQuantity,
				CASE WHEN AT0114.ReTranMonth + AT0114.ReTranYear*100 <= @TranMonth-1 + @TranYear*100
				THEN (	SELECT CASE WHEN BeginQuantity = 0 THEN 0 ELSE BeginAmount/BeginQuantity END
						From AT2008 WITH (NOLOCK)
						WHERE TranMonth = @TranMonth and TranYear = @TranYear and InventoryID = AT0114.InventoryID and InventoryAccountID = @AccountID
						and WareHouseID =  AT0114.WareHouseID)
				ELSE CASE WHEN ISNULL(AT0114.IsAVGData,0) = 0 THEN isnull((SELECT TOP 1 UnitPrice FROM #temp_AP1303_MK AV3004 where AV3004.TransactionID = AT0114.ReTransactionID and AV3004.DivisionID = AT0114.DivisionID
						and AV3004.InventoryID = AT0114.InventoryID),0) ELSE ISNULL(AT0114.UnitPrice,0) END
				END,
				AT0114.ReVoucherNo, AT0114.ReVoucherDate  
		From AT0114  WITH (NOLOCK)
		--LEFT JOIN #temp_AP1303_MK_02 AV3004 ON AV3004.TransactionID = AT0114.ReTransactionID and AV3004.DivisionID = AT0114.DivisionID
		--				and AV3004.InventoryID = AT0114.InventoryID
			--INNER JOIN AT2006 ON AT2006.VoucherID = AT0114.ReVoucherID
			--INNER JOIN AT2007 ON AT2007.TransactionID = AT0114.ReTransactionID

		Where AT0114.DivisionID = @DivisionID and 
			AT0114.ReVoucherDate<=@VoucherDate and
			--(CASE WHEN AT2006.KINDVOUCHERID = 3 THEN AT2006.WareHouseID2 ELSE AT2006.WareHouseID END) = @WareHouseID and
			AT0114.WareHouseID = @WareHouseID and
			AT0114.InventoryID =@InventoryID and
			AT0114.EndQuantity >0	 AND EXISTS (SELECT TOP 1 1 FROM #temp_AP1303_MK AV3004 where AV3004.TransactionID = AT0114.ReTransactionID and AV3004.DivisionID = AT0114.DivisionID
						and AV3004.InventoryID = AT0114.InventoryID AND AV3004.DebitAccountID = @AccountID)
			
		Order by AT0114.ReVoucherDate, AT0114.ReTransactionID
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

							--Set @ConvertedAmount = @ConvertedAmount+ @UnitPrice*@EndQuantity
							--Set @ConvertedAmount115 = @UnitPrice*@EndQuantity
							--Set @Quantity = @Quantity+ @EndQuantity
							--Set @Quantity115 = @EndQuantity
							--Set @ActualQuantity  =@ActualQuantity - @EndQuantity
												
						 End
						Update AT0114 set 	EndQuantity =  EndQuantity - @Quantity115 ,
									DeQuantity = DeQuantity + @Quantity115
							Where ReVoucherID = @ReVoucherID and
								DivisionID= @DivisionID and
								WareHouseID = @WareHouseID and
								InventoryID = @InventoryID and
								ReTransactionID =@ReTransactionID
					
					
						Insert AT0115 (DivisionID, TranMonth, TranYear, WareHouseID, VoucherDate, VoucherNo,  VoucherID, TransactionID, InventoryID,
									 UnitPrice, PriceQuantity, ConvertedAmount, ReVoucherID, ReTransactionID, ReVoucherDate, ReVoucherNo, CreateDate, CreateUserID)
							Values (@DivisionID, @CurrentMonth, @CurrentYear, @WareHouseID, @VoucherDate, @VoucherNo, @VoucherID, @TransactionID, @InventoryID,
									@UnitPrice,  @Quantity115 , @ConvertedAmount115, @ReVoucherID, @ReTransactionID, @ReVoucherDate, @ReVoucherNo, GetDate(), @UserID)

					


					 FETCH NEXT FROM @ReFIFO_cur  INTO  @ReVoucherID, @ReTransactionID,  @EndQuantity, @UnitPrice, @ReVoucherNo, @ReVoucherDate
				End 

		            Update AT2007 WITH(ROWLOCK)  
					set 	ConvertedAmount = Round(@ConvertedAmount,@ConvertedDecimals),
						OriginalAmount  = Round(@ConvertedAmount,@ConvertedDecimals),
						UnitPrice =Round( ( Case when ActualQuantity <>0 then  round(@ConvertedAmount, @ConvertedDecimals) / ActualQuantity else 0 end ),@UnitCostDecimals),
						--UnitPrice = ( Case when ActualQuantity <>0 then  round(@ConvertedAmount, @ConvertedDecimals) / ActualQuantity else 0 end ),
						IsCalculated = 1
					Where DivisionID = @DivisionID and TransactionID = @TransactionID 
					insert into Temp_AP1330_MK values (@TransactionID,Round(@ConvertedAmount,@ConvertedDecimals))
print '----------------------- ::: ' + str(@index) + '---------------'
set @index = @index +1;
FETCH NEXT FROM @FIFO_cur INTO   @WareHouseID, @VoucherID, @TransactionID, @InventoryID, @ActualQuantity, @VoucherNo, @VoucherDate , @AccountID, @CurrentMonth, @CurrentYear 
	End
CLOSE @FIFO_cur
					Update AT9000 
					set 	ConvertedAmount = Temp_AP1330_MK.ConvertedAmount,
						OriginalAmount  = Temp_AP1330_MK.ConvertedAmount,					
					    OriginalAmountCN  = Temp_AP1330_MK.ConvertedAmount,
						UnitPrice = Round( ( Case when Quantity <>0 then  round(Temp_AP1330_MK.ConvertedAmount, @ConvertedDecimals) / Quantity else 0 end ),@UnitCostDecimals) 
						--UnitPrice = ( Case when ActualQuantity <>0 then  round(@ConvertedAmount, @ConvertedDecimals) / ActualQuantity else 0 end ),
					FROM at9000 
					inner Join Temp_AP1330_MK on Temp_AP1330_MK.TransactionID = AT9000.TransactionID
					Where at9000.DivisionID = @DivisionID and at9000.TransactionID = Temp_AP1330_MK.TransactionID AND TableID = 'AT2006' 
					
					
					 UPDATE AT0114 WITH (ROWLOCK)
					 SET  UnitPrice = Round( ( Case when ReQuantity <>0 then  round(Temp_AP1330_MK.ConvertedAmount, @ConvertedDecimals) / ReQuantity else 0 end ),@UnitCostDecimals) 
					 FROM AT0114
					 inner Join Temp_AP1330_MK on Temp_AP1330_MK.TransactionID = AT0114.ReTransactionID
					 WHERE DivisionID = @DivisionID 
					 AND ReTransactionID = Temp_AP1330_MK.TransactionID


-- ENABLE trigger update của bảng AT2007
		EXEC('ENABLE TRIGGER AZ2007 ON AT2007') 

--return

---Khóa sổ chốt AT2008 khi tính FIFO vì đã tắt trigger Update AT2007 khi tính giá 
 DECLARE @Tranmonth2 INT =  @TranMonth +1,
		@Tranyear2 INT = @TranYear
	IF @tranmonth=12 
	BEGIN 
		SET @Tranmonth2 = 1
		SET @TranYear = @TranYear +1
	END

	IF NOT EXISTS  (SELECT TOP 1 1 FROM AT2008 WHERE TranMonth = @Tranmonth2 AND TranYear = @Tranyear2)
		BEGIN 
			EXEC AP9998 @DivisionID, @TranMonth, @TranYear,  @tranmonth2 , @TranYear2
			DELETE FROM AT2008 WHERE TranMonth = @tranmonth2 AND TranYear = @tranyear2
		END
	ELSE EXEC AP9998 @DivisionID, @TranMonth, @TranYear,  @tranmonth2 , @TranYear2


	---Goi  Store de lam tron phan tinh gia FIFO
	EXEC AP1301_MK @DivisionID, @TranMonth, @TranYear, @FromInventoryID, @ToInventoryID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
