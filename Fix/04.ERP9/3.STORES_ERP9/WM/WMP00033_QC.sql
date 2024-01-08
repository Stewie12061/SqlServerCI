IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP00033_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP00033_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Created by Hoài Bảo on 26/07/2022
----- Purpose Tính giá xuất kho FIFO theo quy cách - Kế thừa store AP1303_QC
----- Modified by ... on ...
/*
*/

CREATE PROCEDURE  [dbo].[WMP00033_QC]
	@DivisionID  AS NVARCHAR(50),
	@TranMonth AS INT ,
	@TranYear AS INT,
	@FromInventoryID NVARCHAR(50) = '', 
	@ToInventoryID NVARCHAR(50) = '',
	@WareHouseID NVARCHAR(MAX) = ''
AS

DECLARE @InventoryID AS NVARCHAR(50),
	@FIFO_cur AS CURSOR,
	@ConvertedAmount AS DECIMAL(28,8),
	@ConvertedAmount115 AS DECIMAL(28,8),
	@VoucherID AS NVARCHAR(50),
	@TransactionID AS NVARCHAR(50),
	@VoucherDate AS DATETIME,
	@ActualQuantity AS DECIMAL(28,8),
	@WareHouseID_Cur NVARCHAR(50),
	@ReFIFO_cur AS CURSOR,
	@ReDelete_cur AS CURSOR,
	@ReVoucherID NVARCHAR(50),
	@ReTransactionID NVARCHAR(50),
	@EndQuantity AS DECIMAL(28,8),
	@UnitPrice AS DECIMAL(28,8),
	@CurrentMonth AS INT,
	@CurrentYear AS INT,
	@VoucherNo AS NVARCHAR(50),
	@ReVoucherNo AS NVARCHAR(50),
	@ReVoucherDate DATETIME,
	@Quantity AS DECIMAL(28,8),
	@Quantity115 AS DECIMAL(28,8),		
	@AccountID AS NVARCHAR(50),
	@S01ID VARCHAR(50),@S02ID VARCHAR(50),@S03ID VARCHAR(50),@S04ID VARCHAR(50),@S05ID VARCHAR(50),@S06ID VARCHAR(50),@S07ID VARCHAR(50),@S08ID VARCHAR(50),
	@S09ID VARCHAR(50),@S10ID VARCHAR(50),@S11ID VARCHAR(50),@S12ID VARCHAR(50),@S13ID VARCHAR(50),@S14ID VARCHAR(50),@S15ID VARCHAR(50),@S16ID VARCHAR(50),
	@S17ID VARCHAR(50),@S18ID VARCHAR(50),@S19ID VARCHAR(50),@S20ID VARCHAR(50),
	@S01ID_ReFiFO VARCHAR(50),
	@S02ID_ReFiFO VARCHAR(50),
	@S03ID_ReFiFO VARCHAR(50),
	@S04ID_ReFiFO VARCHAR(50),
	@S05ID_ReFiFO VARCHAR(50),
	@S06ID_ReFiFO VARCHAR(50),
	@S07ID_ReFiFO VARCHAR(50),
	@S08ID_ReFiFO VARCHAR(50),
	@S09ID_ReFiFO VARCHAR(50),
	@S10ID_ReFiFO VARCHAR(50),
	@S11ID_ReFiFO VARCHAR(50),
	@S12ID_ReFiFO VARCHAR(50),
	@S13ID_ReFiFO VARCHAR(50),
	@S14ID_ReFiFO VARCHAR(50),
	@S15ID_ReFiFO VARCHAR(50),
	@S16ID_ReFiFO VARCHAR(50),
	@S17ID_ReFiFO VARCHAR(50),
	@S18ID_ReFiFO VARCHAR(50),
	@S19ID_ReFiFO VARCHAR(50),
	@S20ID_ReFiFO VARCHAR(50),	

--PHAN LAM TRON SO
	@QuantityDecimals  AS TINYINT,
	@UnitCostDecimals  AS TINYINT,
	@ConvertedDecimals AS TINYINT

SELECT @QuantityDecimals = QuantityDecimals, @UnitCostDecimals = UnitCostDecimals, @ConvertedDecimals = ConvertedDecimals
FROM AT1101 WITH (NOLOCK) WHERE divisionID = @DivisionID
SET @QuantityDecimals = ISNULL( @QuantityDecimals,2)
SET @UnitCostDecimals = ISNULL( @UnitCostDecimals,2)
SET @ConvertedDecimals = ISNULL( @ConvertedDecimals,2)
	


Set @ConvertedAmount  =0 
-------- B1: huy bo viec tinh gia cua cac phieu xuat tu ky do tro ve sau
---------- Xu ly cac phieu xuat da Xoa va gia xuat kho da tinh tu ky nay ve sau ---------------------------------------------------------------------------------

Delete AT0115 
Where AT0115.DivisionID = @DivisionID 
AND AT0115.TranMonth = @TranMonth 
AND AT0115.TranYear = @TranYear 
AND AT0115.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 
AND WareHouseID IN (@WareHouseID)
AND 
NOT EXISTS (SELECT TOP 1 1
			From AT2007  WITH (NOLOCK)
			inner join AT2006 WITH (NOLOCK) on AT2007.VoucherID = AT2006.VoucherID AND AT2007.DivisionID = AT2006.DivisionID
			LEFT JOIN WT8899 WITH (NOLOCK) ON AT2007.VoucherID = WT8899.VoucherID AND AT2007.TransactionID = WT8899.TransactionID AND AT2007.DivisionID = WT8899.DivisionID
			where	AT2007.DivisionID = @DivisionID 
					AND AT2007.TranMonth = @TranMonth 
					AND AT2007.TranYear = @TranYear 
					AND AT2007.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 	
					AND AT2006.WareHouseID IN (@WareHouseID)	
					AND AT0115.ReTransactionID + '_' + AT0115.InventoryID  = AT2007.TransactionID + '_' + AT2007.InventoryID
					AND ISNULL(AT0115.S01ID,'') = Isnull(WT8899.S01ID,'')
					AND ISNULL(AT0115.S02ID,'') = isnull(WT8899.S02ID,'')
					AND ISNULL(AT0115.S03ID,'') = isnull(WT8899.S03ID,'')
					AND ISNULL(AT0115.S04ID,'') = isnull(WT8899.S04ID,'')
					AND ISNULL(AT0115.S05ID,'') = isnull(WT8899.S05ID,'')
					AND ISNULL(AT0115.S06ID,'') = isnull(WT8899.S06ID,'')
					AND ISNULL(AT0115.S07ID,'') = isnull(WT8899.S07ID,'')
					AND ISNULL(AT0115.S08ID,'') = isnull(WT8899.S08ID,'')
					AND ISNULL(AT0115.S09ID,'') = isnull(WT8899.S09ID,'')
					AND ISNULL(AT0115.S10ID,'') = isnull(WT8899.S10ID,'')
					AND ISNULL(AT0115.S11ID,'') = isnull(WT8899.S11ID,'')
					AND ISNULL(AT0115.S12ID,'') = isnull(WT8899.S12ID,'')
					AND ISNULL(AT0115.S13ID,'') = isnull(WT8899.S13ID,'')
					AND ISNULL(AT0115.S14ID,'') = isnull(WT8899.S14ID,'')
					AND ISNULL(AT0115.S15ID,'') = isnull(WT8899.S15ID,'')
					AND ISNULL(AT0115.S16ID,'') = isnull(WT8899.S16ID,'')
					AND ISNULL(AT0115.S17ID,'') = isnull(WT8899.S17ID,'')
					AND ISNULL(AT0115.S18ID,'') = isnull(WT8899.S18ID,'')
					AND ISNULL(AT0115.S19ID,'') = isnull(WT8899.S19ID,'')
					AND ISNULL(AT0115.S20ID,'') = isnull(WT8899.S20ID,'') 
				 
			Union all
			Select TOP 1 1
			From AT2017  WITH (NOLOCK)
			inner join AT2016 WITH (NOLOCK) on AT2017.VoucherID = AT2016.VoucherID AND AT2017.DivisionID = AT2016.DivisionID
			LEFT JOIN WT8899 WITH (NOLOCK) ON AT2017.VoucherID = WT8899.VoucherID AND AT2017.TransactionID = WT8899.TransactionID AND AT2017.DivisionID = WT8899.DivisionID
			where	AT2017.DivisionID = @DivisionID 
					AND AT2017.TranMonth = @TranMonth 
					AND AT2017.TranYear = @TranYear 
					AND AT2017.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 	
					AND AT2016.WareHouseID IN (@WareHouseID)
					AND AT0115.ReTransactionID + '_' + AT0115.InventoryID  = AT2017.TransactionID + '_' + AT2017.InventoryID
					AND ISNULL(AT0115.S01ID,'') = Isnull(WT8899.S01ID,'')
					AND ISNULL(AT0115.S02ID,'') = isnull(WT8899.S02ID,'')
					AND ISNULL(AT0115.S03ID,'') = isnull(WT8899.S03ID,'')
					AND ISNULL(AT0115.S04ID,'') = isnull(WT8899.S04ID,'')
					AND ISNULL(AT0115.S05ID,'') = isnull(WT8899.S05ID,'')
					AND ISNULL(AT0115.S06ID,'') = isnull(WT8899.S06ID,'')
					AND ISNULL(AT0115.S07ID,'') = isnull(WT8899.S07ID,'')
					AND ISNULL(AT0115.S08ID,'') = isnull(WT8899.S08ID,'')
					AND ISNULL(AT0115.S09ID,'') = isnull(WT8899.S09ID,'')
					AND ISNULL(AT0115.S10ID,'') = isnull(WT8899.S10ID,'')
					AND ISNULL(AT0115.S11ID,'') = isnull(WT8899.S11ID,'')
					AND ISNULL(AT0115.S12ID,'') = isnull(WT8899.S12ID,'')
					AND ISNULL(AT0115.S13ID,'') = isnull(WT8899.S13ID,'')
					AND ISNULL(AT0115.S14ID,'') = isnull(WT8899.S14ID,'')
					AND ISNULL(AT0115.S15ID,'') = isnull(WT8899.S15ID,'')
					AND ISNULL(AT0115.S16ID,'') = isnull(WT8899.S16ID,'')
					AND ISNULL(AT0115.S17ID,'') = isnull(WT8899.S17ID,'')
					AND ISNULL(AT0115.S18ID,'') = isnull(WT8899.S18ID,'')
					AND ISNULL(AT0115.S19ID,'') = isnull(WT8899.S19ID,'')
					AND ISNULL(AT0115.S20ID,'') = isnull(WT8899.S20ID,'')
			 )

Update AT0114 set DeQuantity = isnull(Quantity,0), EndQuantity = ReQuantity -  isnull(Quantity,0)
From AT0114 WITH (ROWLOCK) 
LEFT join ( Select InventoryID, ReTransactionID, Sum(PriceQuantity) as Quantity, DivisionID, S01ID, S02ID, S03ID, S04ID, S05ID, 
			 S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
             From AT0115  WITH (NOLOCK)
             Group by ReTransactionID,InventoryID, DivisionID, S01ID, S02ID, S03ID, S04ID, S05ID, 
			 S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
			) A
	on	A.ReTransactionID = AT0114.ReTransactionID 
		And A.InventoryID = AT0114.InventoryID And A.DivisionID = AT0114.DivisionID
		AND ISNULL(AT0114.S01ID,'') = Isnull(A.S01ID,'')
		AND ISNULL(AT0114.S02ID,'') = isnull(A.S02ID,'')
		AND ISNULL(AT0114.S03ID,'') = isnull(A.S03ID,'')
		AND ISNULL(AT0114.S04ID,'') = isnull(A.S04ID,'')
		AND ISNULL(AT0114.S05ID,'') = isnull(A.S05ID,'')
		AND ISNULL(AT0114.S06ID,'') = isnull(A.S06ID,'')
		AND ISNULL(AT0114.S07ID,'') = isnull(A.S07ID,'')
		AND ISNULL(AT0114.S08ID,'') = isnull(A.S08ID,'')
		AND ISNULL(AT0114.S09ID,'') = isnull(A.S09ID,'')
		AND ISNULL(AT0114.S10ID,'') = isnull(A.S10ID,'')
		AND ISNULL(AT0114.S11ID,'') = isnull(A.S11ID,'')
		AND ISNULL(AT0114.S12ID,'') = isnull(A.S12ID,'')
		AND ISNULL(AT0114.S13ID,'') = isnull(A.S13ID,'')
		AND ISNULL(AT0114.S14ID,'') = isnull(A.S14ID,'')
		AND ISNULL(AT0114.S15ID,'') = isnull(A.S15ID,'')
		AND ISNULL(AT0114.S16ID,'') = isnull(A.S16ID,'')
		AND ISNULL(AT0114.S17ID,'') = isnull(A.S17ID,'')
		AND ISNULL(AT0114.S18ID,'') = isnull(A.S18ID,'')
		AND ISNULL(AT0114.S19ID,'') = isnull(A.S19ID,'')
		AND ISNULL(AT0114.S20ID,'') = isnull(A.S20ID,'')
Where isnull(A.Quantity,0)<>isnull(DeQuantity,0) and AT0114.DivisionID = @DivisionID 

--select 'sau khi update', * from at0114
--where warehouseid in ('HQ-NVL','HQ-TP','NVL01','NVL02','NVL-CUT','NVL-SUB','SX-CUT','SX-PACK','SX-SEW','TPGC-01','TPGC-02')
--order by warehouseid,inventoryid

SET @ReDelete_cur = Cursor Scroll KeySet FOR 
Select  WareHouseID, ReTransactionID , ReVoucherID, InventoryID,   sum(isnull(PriceQuantity,0)), S01ID, S02ID, S03ID, S04ID, S05ID, 
			 S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
From AT0115 WITH (NOLOCK)
Where DivisionID = @DivisionID 
		AND InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 
		AND WareHouseID IN (@WareHouseID)
		
		and NOT EXISTS (Select TOP 1 1 
						from AT2007 WITH (NOLOCK)
						inner join AT2006 WITH (NOLOCK) on AT2007.VoucherID = AT2006.VoucherID AND AT2007.DivisionID = AT2006.DivisionID 
						LEFT JOIN WT8899 WITH (NOLOCK) ON AT2007.VoucherID = WT8899.VoucherID AND AT2007.TransactionID = WT8899.TransactionID AND AT2007.DivisionID = WT8899.DivisionID
						Where AT2007.DivisionID = @DivisionID
						AND AT2007.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 	
						AND (	(AT2006.KINDVOUCHERID = 3 AND AT2006.WareHouseID2 IN (@WareHouseID))
							OR (AT2006.KINDVOUCHERID <> 3 AND AT2006.WareHouseID IN (@WareHouseID))
							)
						AND AT2007.TransactionID = AT0115.TransactionID
						AND ISNULL(AT0115.S01ID,'') = Isnull(WT8899.S01ID,'')
						AND ISNULL(AT0115.S02ID,'') = isnull(WT8899.S02ID,'')
						AND ISNULL(AT0115.S03ID,'') = isnull(WT8899.S03ID,'')
						AND ISNULL(AT0115.S04ID,'') = isnull(WT8899.S04ID,'')
						AND ISNULL(AT0115.S05ID,'') = isnull(WT8899.S05ID,'')
						AND ISNULL(AT0115.S06ID,'') = isnull(WT8899.S06ID,'')
						AND ISNULL(AT0115.S07ID,'') = isnull(WT8899.S07ID,'')
						AND ISNULL(AT0115.S08ID,'') = isnull(WT8899.S08ID,'')
						AND ISNULL(AT0115.S09ID,'') = isnull(WT8899.S09ID,'')
						AND ISNULL(AT0115.S10ID,'') = isnull(WT8899.S10ID,'')
						AND ISNULL(AT0115.S11ID,'') = isnull(WT8899.S11ID,'')
						AND ISNULL(AT0115.S12ID,'') = isnull(WT8899.S12ID,'')
						AND ISNULL(AT0115.S13ID,'') = isnull(WT8899.S13ID,'')
						AND ISNULL(AT0115.S14ID,'') = isnull(WT8899.S14ID,'')
						AND ISNULL(AT0115.S15ID,'') = isnull(WT8899.S15ID,'')
						AND ISNULL(AT0115.S16ID,'') = isnull(WT8899.S16ID,'')
						AND ISNULL(AT0115.S17ID,'') = isnull(WT8899.S17ID,'')
						AND ISNULL(AT0115.S18ID,'') = isnull(WT8899.S18ID,'')
						AND ISNULL(AT0115.S19ID,'') = isnull(WT8899.S19ID,'')
						AND ISNULL(AT0115.S20ID,'') = isnull(WT8899.S20ID,'') 
						)    --- Nhung phieu da xoa roi					
Group by   WareHouseID, ReTransactionID , ReVoucherID, InventoryID, S01ID, S02ID, S03ID, S04ID, S05ID, 
		S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID

UNION ALL

Select  WareHouseID, ReTransactionID , ReVoucherID, InventoryID,  sum(isnull(PriceQuantity,0)), S01ID, S02ID, S03ID, S04ID, S05ID, 
			 S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
From AT0115 WITH (NOLOCK)
Where DivisionID = @DivisionID 
	AND InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 
	AND WareHouseID IN (@WareHouseID)
	AND EXISTS (Select TOP 1 1 
						from AT2007 WITH (NOLOCK)
						inner join AT2006 WITH (NOLOCK) on AT2007.VoucherID = AT2006.VoucherID AND AT2007.DivisionID = AT2006.DivisionID 
						LEFT JOIN WT8899 WITH (NOLOCK) ON AT2007.VoucherID = WT8899.VoucherID AND AT2007.TransactionID = WT8899.TransactionID AND AT2007.DivisionID = WT8899.DivisionID
						Where AT2007.DivisionID = @DivisionID
						AND AT2007.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 	
						AND ( (AT2006.KINDVOUCHERID = 3 AND AT2006.WareHouseID2 IN (@WareHouseID))
							OR (AT2006.KINDVOUCHERID <> 3 AND AT2006.WareHouseID IN (@WareHouseID))
							)
						and AT2007.TranMonth+AT2007.TranYear*100 >= @TranMonth +100*@TranYear
						AND AT2007.TransactionID = AT0115.TransactionID
						AND AT2007.TransactionID = AT0115.TransactionID
						AND ISNULL(AT0115.S01ID,'') = Isnull(WT8899.S01ID,'')
						AND ISNULL(AT0115.S02ID,'') = isnull(WT8899.S02ID,'')
						AND ISNULL(AT0115.S03ID,'') = isnull(WT8899.S03ID,'')
						AND ISNULL(AT0115.S04ID,'') = isnull(WT8899.S04ID,'')
						AND ISNULL(AT0115.S05ID,'') = isnull(WT8899.S05ID,'')
						AND ISNULL(AT0115.S06ID,'') = isnull(WT8899.S06ID,'')
						AND ISNULL(AT0115.S07ID,'') = isnull(WT8899.S07ID,'')
						AND ISNULL(AT0115.S08ID,'') = isnull(WT8899.S08ID,'')
						AND ISNULL(AT0115.S09ID,'') = isnull(WT8899.S09ID,'')
						AND ISNULL(AT0115.S10ID,'') = isnull(WT8899.S10ID,'')
						AND ISNULL(AT0115.S11ID,'') = isnull(WT8899.S11ID,'')
						AND ISNULL(AT0115.S12ID,'') = isnull(WT8899.S12ID,'')
						AND ISNULL(AT0115.S13ID,'') = isnull(WT8899.S13ID,'')
						AND ISNULL(AT0115.S14ID,'') = isnull(WT8899.S14ID,'')
						AND ISNULL(AT0115.S15ID,'') = isnull(WT8899.S15ID,'')
						AND ISNULL(AT0115.S16ID,'') = isnull(WT8899.S16ID,'')
						AND ISNULL(AT0115.S17ID,'') = isnull(WT8899.S17ID,'')
						AND ISNULL(AT0115.S18ID,'') = isnull(WT8899.S18ID,'')
						AND ISNULL(AT0115.S19ID,'') = isnull(WT8899.S19ID,'')
						AND ISNULL(AT0115.S20ID,'') = isnull(WT8899.S20ID,'')
						)   --- phieu xuat ky nay ve  sau			
Group by   WareHouseID, ReTransactionID , ReVoucherID, InventoryID, S01ID, S02ID, S03ID, S04ID, S05ID, 
		   S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID

OPEN @ReDelete_cur
FETCH NEXT FROM @ReDelete_cur INTO  @WareHouseID_Cur, @ReTransactionID , @ReVoucherID, @InventoryID, @ActualQuantity, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, 
			 @S06ID, @S07ID, @S08ID, @S09ID, @S10ID, @S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID
WHILE @@Fetch_Status = 0
 Begin
		--Print ' @ReTransactionID ='+@ReTransactionID+' so tien : '+str(@ActualQuantity)
	
	Update AT0114 WITH (ROWLOCK) set 	DeQuantity = DeQuantity - @ActualQuantity,
				EndQuantity = EndQuantity + @ActualQuantity
	Where 	DivisionID = @DivisionID and 
		WareHouseID = @WareHouseID_Cur and
		InventoryID = @InventoryID and
		ReVoucherID = @ReVoucherID and
		ReTransactionID = @ReTransactionID 
		AND ISNULL(AT0114.S01ID,'') = Isnull(@S01ID,'')
		AND ISNULL(AT0114.S02ID,'') = isnull(@S02ID,'')
		AND ISNULL(AT0114.S03ID,'') = isnull(@S03ID,'')
		AND ISNULL(AT0114.S04ID,'') = isnull(@S04ID,'')
		AND ISNULL(AT0114.S05ID,'') = isnull(@S05ID,'')
		AND ISNULL(AT0114.S06ID,'') = isnull(@S06ID,'')
		AND ISNULL(AT0114.S07ID,'') = isnull(@S07ID,'')
		AND ISNULL(AT0114.S08ID,'') = isnull(@S08ID,'')
		AND ISNULL(AT0114.S09ID,'') = isnull(@S09ID,'')
		AND ISNULL(AT0114.S10ID,'') = isnull(@S10ID,'')
		AND ISNULL(AT0114.S11ID,'') = isnull(@S11ID,'')
		AND ISNULL(AT0114.S12ID,'') = isnull(@S12ID,'')
		AND ISNULL(AT0114.S13ID,'') = isnull(@S13ID,'')
		AND ISNULL(AT0114.S14ID,'') = isnull(@S14ID,'')
		AND ISNULL(AT0114.S15ID,'') = isnull(@S15ID,'')
		AND ISNULL(AT0114.S16ID,'') = isnull(@S16ID,'')
		AND ISNULL(AT0114.S17ID,'') = isnull(@S17ID,'')
		AND ISNULL(AT0114.S18ID,'') = isnull(@S18ID,'')
		AND ISNULL(AT0114.S19ID,'') = isnull(@S19ID,'')
		AND ISNULL(AT0114.S20ID,'') = isnull(@S20ID,'')
FETCH NEXT FROM @ReDelete_cur INTO  @WareHouseID_Cur, @ReTransactionID , @ReVoucherID, @InventoryID, @ActualQuantity, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, 
			@S06ID, @S07ID, @S08ID, @S09ID, @S10ID, @S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID
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
			LEFT JOIN WT8899 WITH (NOLOCK) ON AT2007.VoucherID = WT8899.VoucherID AND AT2007.TransactionID = WT8899.TransactionID AND AT2007.DivisionID = WT8899.DivisionID
			Where AT2007.DivisionID = @DivisionID
			AND AT2007.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 	
				AND ( (AT2006.KINDVOUCHERID = 3 AND AT2006.WareHouseID2 IN (@WareHouseID))
					OR (AT2006.KINDVOUCHERID <> 3 AND AT2006.WareHouseID IN (@WareHouseID))
					)
			AND AT2007.TransactionID = AT0115.TransactionID
			AND ISNULL(AT0115.S01ID,'') = Isnull(WT8899.S01ID,'')
			AND ISNULL(AT0115.S02ID,'') = isnull(WT8899.S02ID,'')
			AND ISNULL(AT0115.S03ID,'') = isnull(WT8899.S03ID,'')
			AND ISNULL(AT0115.S04ID,'') = isnull(WT8899.S04ID,'')
			AND ISNULL(AT0115.S05ID,'') = isnull(WT8899.S05ID,'')
			AND ISNULL(AT0115.S06ID,'') = isnull(WT8899.S06ID,'')
			AND ISNULL(AT0115.S07ID,'') = isnull(WT8899.S07ID,'')
			AND ISNULL(AT0115.S08ID,'') = isnull(WT8899.S08ID,'')
			AND ISNULL(AT0115.S09ID,'') = isnull(WT8899.S09ID,'')
			AND ISNULL(AT0115.S10ID,'') = isnull(WT8899.S10ID,'')
			AND ISNULL(AT0115.S11ID,'') = isnull(WT8899.S11ID,'')
			AND ISNULL(AT0115.S12ID,'') = isnull(WT8899.S12ID,'')
			AND ISNULL(AT0115.S13ID,'') = isnull(WT8899.S13ID,'')
			AND ISNULL(AT0115.S14ID,'') = isnull(WT8899.S14ID,'')
			AND ISNULL(AT0115.S15ID,'') = isnull(WT8899.S15ID,'')
			AND ISNULL(AT0115.S16ID,'') = isnull(WT8899.S16ID,'')
			AND ISNULL(AT0115.S17ID,'') = isnull(WT8899.S17ID,'')
			AND ISNULL(AT0115.S18ID,'') = isnull(WT8899.S18ID,'')
			AND ISNULL(AT0115.S19ID,'') = isnull(WT8899.S19ID,'')
			AND ISNULL(AT0115.S20ID,'') = isnull(WT8899.S20ID,'')
		)		
		

Delete AT0115 Where DivisionID = @DivisionID 
	AND InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 
	AND WareHouseID IN (@WareHouseID)
	and EXISTS
	(	 Select TOP 1 1 from AT2007 WITH (NOLOCK) 
		 inner join AT2006 WITH (NOLOCK) on AT2007.VoucherID = AT2006.VoucherID AND AT2007.DivisionID = AT2006.DivisionID 
		 LEFT JOIN WT8899 WITH (NOLOCK) ON AT2007.VoucherID = WT8899.VoucherID AND AT2007.TransactionID = WT8899.TransactionID AND AT2007.DivisionID = WT8899.DivisionID
		 Where AT2007.DivisionID = @DivisionID
				AND AT2007.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 	
				AND ( (AT2006.KINDVOUCHERID = 3 AND AT2006.WareHouseID2 IN (@WareHouseID))
					OR (AT2006.KINDVOUCHERID <> 3 AND AT2006.WareHouseID IN (@WareHouseID)))
				and AT2007.TranMonth+AT2007.TranYear*100 >=@TranMonth +100*@TranYear  --- phieu xuat ky nay ve  sau	
				AND AT2007.TransactionID = AT0115.TransactionID
				AND AT2007.TransactionID = AT0115.TransactionID
				AND ISNULL(AT0115.S01ID,'') = Isnull(WT8899.S01ID,'')
				AND ISNULL(AT0115.S02ID,'') = isnull(WT8899.S02ID,'')
				AND ISNULL(AT0115.S03ID,'') = isnull(WT8899.S03ID,'')
				AND ISNULL(AT0115.S04ID,'') = isnull(WT8899.S04ID,'')
				AND ISNULL(AT0115.S05ID,'') = isnull(WT8899.S05ID,'')
				AND ISNULL(AT0115.S06ID,'') = isnull(WT8899.S06ID,'')
				AND ISNULL(AT0115.S07ID,'') = isnull(WT8899.S07ID,'')
				AND ISNULL(AT0115.S08ID,'') = isnull(WT8899.S08ID,'')
				AND ISNULL(AT0115.S09ID,'') = isnull(WT8899.S09ID,'')
				AND ISNULL(AT0115.S10ID,'') = isnull(WT8899.S10ID,'')
				AND ISNULL(AT0115.S11ID,'') = isnull(WT8899.S11ID,'')
				AND ISNULL(AT0115.S12ID,'') = isnull(WT8899.S12ID,'')
				AND ISNULL(AT0115.S13ID,'') = isnull(WT8899.S13ID,'')
				AND ISNULL(AT0115.S14ID,'') = isnull(WT8899.S14ID,'')
				AND ISNULL(AT0115.S15ID,'') = isnull(WT8899.S15ID,'')
				AND ISNULL(AT0115.S16ID,'') = isnull(WT8899.S16ID,'')
				AND ISNULL(AT0115.S17ID,'') = isnull(WT8899.S17ID,'')
				AND ISNULL(AT0115.S18ID,'') = isnull(WT8899.S18ID,'')
				AND ISNULL(AT0115.S19ID,'') = isnull(WT8899.S19ID,'')
				AND ISNULL(AT0115.S20ID,'') = isnull(WT8899.S20ID,'')
		)--- phieu xuat ky nay ve  sau		

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------- Lay ra cac phan tu cua phieu xuat thep PP FIFO-----------------------------------------------------------

SET @FIFO_cur = Cursor Scroll KeySet FOR 
	SELECT (CASE WHEN AT2006.KINDVOUCHERID = 3 THEN AT2006.WareHouseID2 ELSE AT2006.WareHouseID END) as WareHouseID , AT2007.VoucherID, AT2007.TransactionID, 
			AT2007.InventoryID , ActualQuantity, VoucherNo, VoucherDate , 
			AT2007.CreditAccountID, AT2007.TranMonth, AT2007.TranYear, WT8899.S01ID, WT8899.S02ID, WT8899.S03ID, WT8899.S04ID, WT8899.S05ID, 
		    WT8899.S06ID, WT8899.S07ID, WT8899.S08ID, WT8899.S09ID, WT8899.S10ID, WT8899.S11ID, WT8899.S12ID, WT8899.S13ID, WT8899.S14ID, WT8899.S15ID, WT8899.S16ID, WT8899.S17ID, WT8899.S18ID, WT8899.S19ID, WT8899.S20ID
	FROM AT2007 WITH (NOLOCK)	
	INNER JOIN AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID 
	INNER JOIN AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (AT2007.DivisionID,'@@@') AND AT1302.InventoryID = AT2007.InventoryID AND MethodID = 1 
	LEFT JOIN WT8899 WITH (NOLOCK) ON AT2007.VoucherID = WT8899.VoucherID AND AT2007.TransactionID = WT8899.TransactionID AND AT2007.DivisionID = WT8899.DivisionID
	WHERE 	AT2007.DivisionID = @DivisionID
		AND KindVoucherID in (2,3,4,6,8)
		AND AT2007.TranMonth + AT2007.TranYear*100 >= @TranMonth +100*@TranYear
		AND AT2007.InventoryID BETWEEN @FromInventoryID AND @ToInventoryID 
		AND ( (AT2006.KINDVOUCHERID = 3 AND AT2006.WareHouseID2 IN (@WareHouseID))
			OR (AT2006.KINDVOUCHERID <> 3 AND AT2006.WareHouseID IN (@WareHouseID))
			)
	--ORDER BY AT2006.VoucherDate, AT2007.VoucherID, Orders ---- Cac phieu xuat kho theo thu tu ngay tang dan 
	ORDER BY AT2006.VoucherDate, AT2007.ActualQuantity
---Print ' TEST'
OPEN	@FIFO_cur
FETCH NEXT FROM @FIFO_cur INTO   @WareHouseID_Cur, @VoucherID, @TransactionID, @InventoryID, @ActualQuantity, @VoucherNo, @VoucherDate , @AccountID, @CurrentMonth, 
@CurrentYear, @S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID, @S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, 
@S17ID, @S18ID, @S19ID, @S20ID
WHILE @@Fetch_Status = 0

	BEGIN	
		SET @ConvertedAmount = 0
		SET @Quantity = 0		
		
		SET @ReFIFO_cur = CURSOR SCROLL KEYSET FOR  ---- Lay cac phieu nhap tuong ung co the xuat kho dc.

		SELECT AT0114.ReVoucherID, AT0114.ReTransactionID, AT0114.EndQuantity , isnull(AV3004.UnitPrice,0), AT0114.ReVoucherNo, AT0114.ReVoucherDate,
		AT0114.S01ID, AT0114.S02ID, AT0114.S03ID, AT0114.S04ID, AT0114.S05ID, AT0114.S06ID, AT0114.S07ID, AT0114.S08ID, AT0114.S09ID, AT0114.S10ID, AT0114.S11ID, 
		AT0114.S12ID, AT0114.S13ID, AT0114.S14ID, AT0114.S15ID, AT0114.S16ID, AT0114.S17ID, AT0114.S18ID, AT0114.S19ID, AT0114.S20ID
		FROM AT0114  WITH (NOLOCK)	
		INNER JOIN AV3004 ON AV3004.TransactionID = AT0114.ReTransactionID AND AV3004.DivisionID = AT0114.DivisionID AND AV3004.InventoryID = AT0114.InventoryID
		WHERE AT0114.DivisionID = @DivisionID 
			AND AT0114.ReVoucherDate <= @VoucherDate 
			AND AV3004.WareHouseID = @WareHouseID_Cur
			AND AT0114.InventoryID = @InventoryID
			AND AT0114.EndQuantity > 0
			AND AV3004.DebitAccountID = @AccountID
			AND ISNULL(AT0114.S01ID,'') = Isnull(@S01ID,'')
			AND ISNULL(AT0114.S02ID,'') = isnull(@S02ID,'')
			AND ISNULL(AT0114.S03ID,'') = isnull(@S03ID,'')
			AND ISNULL(AT0114.S04ID,'') = isnull(@S04ID,'')
			AND ISNULL(AT0114.S05ID,'') = isnull(@S05ID,'')
			AND ISNULL(AT0114.S06ID,'') = isnull(@S06ID,'')
			AND ISNULL(AT0114.S07ID,'') = isnull(@S07ID,'')
			AND ISNULL(AT0114.S08ID,'') = isnull(@S08ID,'')
			AND ISNULL(AT0114.S09ID,'') = isnull(@S09ID,'')
			AND ISNULL(AT0114.S10ID,'') = isnull(@S10ID,'')
			AND ISNULL(AT0114.S11ID,'') = isnull(@S11ID,'')
			AND ISNULL(AT0114.S12ID,'') = isnull(@S12ID,'')
			AND ISNULL(AT0114.S13ID,'') = isnull(@S13ID,'')
			AND ISNULL(AT0114.S14ID,'') = isnull(@S14ID,'')
			AND ISNULL(AT0114.S15ID,'') = isnull(@S15ID,'')
			AND ISNULL(AT0114.S16ID,'') = isnull(@S16ID,'')
			AND ISNULL(AT0114.S17ID,'') = isnull(@S17ID,'')
			AND ISNULL(AT0114.S18ID,'') = isnull(@S18ID,'')
			AND ISNULL(AT0114.S19ID,'') = isnull(@S19ID,'')
			AND ISNULL(AT0114.S20ID,'') = isnull(@S20ID,'')
		--ORDER BY AT0114.ReVoucherDate, AT0114.ReTransactionID
		ORDER BY AT0114.ReVoucherDate, AT0114.ReQuantity

		OPEN @ReFIFO_cur
		FETCH NEXT FROM @ReFIFO_cur  INTO  @ReVoucherID, @ReTransactionID,  @EndQuantity, @UnitPrice, @ReVoucherNo, @ReVoucherDate, 
		@S01ID_ReFiFO, @S02ID_ReFiFO, @S03ID_ReFiFO, @S04ID_ReFiFO, @S05ID_ReFiFO, @S06ID_ReFiFO, @S07ID_ReFiFO, @S08ID_ReFiFO, @S09ID_ReFiFO, @S10ID_ReFiFO, @S11ID_ReFiFO, 
		@S12ID_ReFiFO, @S13ID_ReFiFO, @S14ID_ReFiFO, @S15ID_ReFiFO, @S16ID_ReFiFO, @S17ID_ReFiFO, @S18ID_ReFiFO, @S19ID_ReFiFO, @S20ID_ReFiFO
			WHILE @@Fetch_Status = 0 and @ActualQuantity>0 
				BEGIN
					SET @Quantity115 =0
					IF @EndQuantity > @ActualQuantity
						BEGIN
							
							SET @ConvertedAmount = ROUND(ROUND(@ConvertedAmount,@ConvertedDecimals)+ ROUND(@UnitPrice,@UnitCostDecimals)*ROUND(@ActualQuantity,@QuantityDecimals) ,@ConvertedDecimals)
							SET @ConvertedAmount115 = ROUND(ROUND(@UnitPrice,@UnitCostDecimals)*ROUND(@ActualQuantity,@QuantityDecimals) ,@ConvertedDecimals)
							SET @Quantity = ROUND(@Quantity+ @ActualQuantity,@QuantityDecimals)	
							SET @Quantity115 =ROUND(@ActualQuantity,@QuantityDecimals)	
							SET @ActualQuantity = 0 
								
						 END
						ELSE
						 BEGIN
							SET @ConvertedAmount = ROUND(ROUND(@ConvertedAmount,@ConvertedDecimals)+ ROUND(@UnitPrice,@UnitCostDecimals)*ROUND(@EndQuantity,@QuantityDecimals) ,@ConvertedDecimals)
							SET @ConvertedAmount115 = ROUND(ROUND(@UnitPrice,@UnitCostDecimals)*ROUND(@EndQuantity,@QuantityDecimals) ,@ConvertedDecimals)
							SET @Quantity = ROUND(@Quantity+ @EndQuantity  ,@QuantityDecimals)
							SET @Quantity115 = ROUND(@EndQuantity ,@QuantityDecimals) 	
							SET @ActualQuantity  =ROUND( ROUND(@ActualQuantity,@QuantityDecimals) - ROUND(@EndQuantity,@QuantityDecimals),@QuantityDecimals)
												
						 END
						 
						UPDATE AT0114 WITH (ROWLOCK) 
						SET 	EndQuantity =  EndQuantity - @Quantity115,
								DeQuantity = DeQuantity + @Quantity115
						WHERE ReVoucherID = @ReVoucherID 
							 AND DivisionID= @DivisionID 
							 AND WareHouseID = @WareHouseID_Cur 
							 AND InventoryID = @InventoryID 
							 AND ReTransactionID =@ReTransactionID
							 AND ISNULL(AT0114.S01ID,'') = Isnull(@S01ID_ReFiFO,'')
							 AND ISNULL(AT0114.S02ID,'') = isnull(@S02ID_ReFiFO,'')
							 AND ISNULL(AT0114.S03ID,'') = isnull(@S03ID_ReFiFO,'')
							 AND ISNULL(AT0114.S04ID,'') = isnull(@S04ID_ReFiFO,'')
							 AND ISNULL(AT0114.S05ID,'') = isnull(@S05ID_ReFiFO,'')
							 AND ISNULL(AT0114.S06ID,'') = isnull(@S06ID_ReFiFO,'')
							 AND ISNULL(AT0114.S07ID,'') = isnull(@S07ID_ReFiFO,'')
							 AND ISNULL(AT0114.S08ID,'') = isnull(@S08ID_ReFiFO,'')
							 AND ISNULL(AT0114.S09ID,'') = isnull(@S09ID_ReFiFO,'')
							 AND ISNULL(AT0114.S10ID,'') = isnull(@S10ID_ReFiFO,'')
							 AND ISNULL(AT0114.S11ID,'') = isnull(@S11ID_ReFiFO,'')
							 AND ISNULL(AT0114.S12ID,'') = isnull(@S12ID_ReFiFO,'')
							 AND ISNULL(AT0114.S13ID,'') = isnull(@S13ID_ReFiFO,'')
							 AND ISNULL(AT0114.S14ID,'') = isnull(@S14ID_ReFiFO,'')
							 AND ISNULL(AT0114.S15ID,'') = isnull(@S15ID_ReFiFO,'')
							 AND ISNULL(AT0114.S16ID,'') = isnull(@S16ID_ReFiFO,'')
							 AND ISNULL(AT0114.S17ID,'') = isnull(@S17ID_ReFiFO,'')
							 AND ISNULL(AT0114.S18ID,'') = isnull(@S18ID_ReFiFO,'')
							 AND ISNULL(AT0114.S19ID,'') = isnull(@S19ID_ReFiFO,'')
							 AND ISNULL(AT0114.S20ID,'') = isnull(@S20ID_ReFiFO,'')
					
					
						INSERT AT0115 (DivisionID, TranMonth, TranYear, WareHouseID, VoucherDate, VoucherNo,  VoucherID, TransactionID, InventoryID,
									 UnitPrice, PriceQuantity, ConvertedAmount, ReVoucherID, ReTransactionID, ReVoucherDate, ReVoucherNo,
									 S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, 
									 S16ID, S17ID, S18ID, S19ID, S20ID)
						Values (@DivisionID, @CurrentMonth, @CurrentYear, @WareHouseID_Cur, @VoucherDate, @VoucherNo, @VoucherID, @TransactionID, @InventoryID,
								@UnitPrice,  @Quantity115 , @ConvertedAmount115, @ReVoucherID, @ReTransactionID, @ReVoucherDate, @ReVoucherNo,
								@S01ID_ReFiFO, @S02ID_ReFiFO, @S03ID_ReFiFO, @S04ID_ReFiFO, @S05ID_ReFiFO, @S06ID_ReFiFO, @S07ID_ReFiFO, @S08ID_ReFiFO, 
								@S09ID_ReFiFO, @S10ID_ReFiFO, @S11ID_ReFiFO, @S12ID_ReFiFO, @S13ID_ReFiFO, @S14ID_ReFiFO, @S15ID_ReFiFO, @S16ID_ReFiFO, 
								@S17ID_ReFiFO, @S18ID_ReFiFO, @S19ID_ReFiFO, @S20ID_ReFiFO)

			 FETCH NEXT FROM @ReFIFO_cur INTO  @ReVoucherID, @ReTransactionID,  @EndQuantity, @UnitPrice, @ReVoucherNo, @ReVoucherDate,
			 @S01ID_ReFiFO, @S02ID_ReFiFO, @S03ID_ReFiFO, @S04ID_ReFiFO, @S05ID_ReFiFO, @S06ID_ReFiFO, @S07ID_ReFiFO, @S08ID_ReFiFO, @S09ID_ReFiFO, @S10ID_ReFiFO, 
			 @S11ID_ReFiFO, @S12ID_ReFiFO, @S13ID_ReFiFO, @S14ID_ReFiFO, @S15ID_ReFiFO, @S16ID_ReFiFO, @S17ID_ReFiFO, @S18ID_ReFiFO, @S19ID_ReFiFO, @S20ID_ReFiFO
			 END 

	UPDATE AT2007 WITH (ROWLOCK) 
	SET ConvertedAmount = ROUND(@ConvertedAmount, @ConvertedDecimals),
		OriginalAmount  = ROUND(@ConvertedAmount, @ConvertedDecimals),
		UnitPrice = ROUND((CASE WHEN ActualQuantity <>0 THEN round(@ConvertedAmount, @ConvertedDecimals) / ActualQuantity ELSE 0 END), @UnitCostDecimals)
	FROM AT2007
	LEFT JOIN WT8899 WITH (NOLOCK) ON AT2007.VoucherID = WT8899.VoucherID AND AT2007.TransactionID = WT8899.TransactionID AND AT2007.DivisionID = WT8899.DivisionID
	WHERE AT2007.DivisionID = @DivisionID AND AT2007.TransactionID = @TransactionID 
	AND ISNULL(WT8899.S01ID,'') = Isnull(@S01ID,'')
	AND ISNULL(WT8899.S02ID,'') = isnull(@S02ID,'')
	AND ISNULL(WT8899.S03ID,'') = isnull(@S03ID,'')
	AND ISNULL(WT8899.S04ID,'') = isnull(@S04ID,'')
	AND ISNULL(WT8899.S05ID,'') = isnull(@S05ID,'')
	AND ISNULL(WT8899.S06ID,'') = isnull(@S06ID,'')
	AND ISNULL(WT8899.S07ID,'') = isnull(@S07ID,'')
	AND ISNULL(WT8899.S08ID,'') = isnull(@S08ID,'')
	AND ISNULL(WT8899.S09ID,'') = isnull(@S09ID,'')
	AND ISNULL(WT8899.S10ID,'') = isnull(@S10ID,'')
	AND ISNULL(WT8899.S11ID,'') = isnull(@S11ID,'')
	AND ISNULL(WT8899.S12ID,'') = isnull(@S12ID,'')
	AND ISNULL(WT8899.S13ID,'') = isnull(@S13ID,'')
	AND ISNULL(WT8899.S14ID,'') = isnull(@S14ID,'')
	AND ISNULL(WT8899.S15ID,'') = isnull(@S15ID,'')
	AND ISNULL(WT8899.S16ID,'') = isnull(@S16ID,'')
	AND ISNULL(WT8899.S17ID,'') = isnull(@S17ID,'')
	AND ISNULL(WT8899.S18ID,'') = isnull(@S18ID,'')
	AND ISNULL(WT8899.S19ID,'') = isnull(@S19ID,'')
	AND ISNULL(WT8899.S20ID,'') = isnull(@S20ID,'')

	UPDATE WT8899 WITH (ROWLOCK) 
	SET QC_ConvertedQuantity = ROUND(@ConvertedAmount, @ConvertedDecimals),
		QC_OriginalAmount  = ROUND(@ConvertedAmount, @ConvertedDecimals)
	WHERE WT8899.DivisionID = @DivisionID AND WT8899.TransactionID = @TransactionID 
	AND ISNULL(WT8899.S01ID,'') = Isnull(@S01ID,'')
	AND ISNULL(WT8899.S02ID,'') = isnull(@S02ID,'')
	AND ISNULL(WT8899.S03ID,'') = isnull(@S03ID,'')
	AND ISNULL(WT8899.S04ID,'') = isnull(@S04ID,'')
	AND ISNULL(WT8899.S05ID,'') = isnull(@S05ID,'')
	AND ISNULL(WT8899.S06ID,'') = isnull(@S06ID,'')
	AND ISNULL(WT8899.S07ID,'') = isnull(@S07ID,'')
	AND ISNULL(WT8899.S08ID,'') = isnull(@S08ID,'')
	AND ISNULL(WT8899.S09ID,'') = isnull(@S09ID,'')
	AND ISNULL(WT8899.S10ID,'') = isnull(@S10ID,'')
	AND ISNULL(WT8899.S11ID,'') = isnull(@S11ID,'')
	AND ISNULL(WT8899.S12ID,'') = isnull(@S12ID,'')
	AND ISNULL(WT8899.S13ID,'') = isnull(@S13ID,'')
	AND ISNULL(WT8899.S14ID,'') = isnull(@S14ID,'')
	AND ISNULL(WT8899.S15ID,'') = isnull(@S15ID,'')
	AND ISNULL(WT8899.S16ID,'') = isnull(@S16ID,'')
	AND ISNULL(WT8899.S17ID,'') = isnull(@S17ID,'')
	AND ISNULL(WT8899.S18ID,'') = isnull(@S18ID,'')
	AND ISNULL(WT8899.S19ID,'') = isnull(@S19ID,'')
	AND ISNULL(WT8899.S20ID,'') = isnull(@S20ID,'')

FETCH NEXT FROM @FIFO_cur INTO @WareHouseID_Cur, @VoucherID, @TransactionID, @InventoryID, @ActualQuantity, @VoucherNo, @VoucherDate , @AccountID, @CurrentMonth, @CurrentYear,
@S01ID, @S02ID, @S03ID, @S04ID, @S05ID, @S06ID, @S07ID, @S08ID, @S09ID, @S10ID, @S11ID, @S12ID, @S13ID, @S14ID, @S15ID, @S16ID, @S17ID, @S18ID, @S19ID, @S20ID
END
CLOSE @FIFO_cur
--return
---Goi  Store de lam tron phan tinh gia FIFO
EXEC AP1301 @DivisionID, @TranMonth, @TranYear


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
