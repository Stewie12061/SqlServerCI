IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP00031_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP00031_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




----- Created by Hoài Bảo
----- Created Date 25/07/2022
----- Purpose: Lấy dữ liệu tính giá xuất kho cho MH có quy cách - Kế thừa từ store AP1330_QC
----- Modified by ... ON ...
/*
	EXEC WMP00031_QC @DivisionID=N'NNP',@TranMonth=N'5',@TranYear=N'2019',@FromInventoryID=N'AP161-P176',@ToInventoryID=N'AP161-P176',@FromWareHouseID=N'KHOBTP001',@ToWareHouseID=N'KHOVL003',@FromAccountID=N'152',@ToAccountID=N'158',@UserID=N'ASOFTADMIN',@GroupID=N'ADMIN',@TransProcessesID=N'',@IsAllWareHouse = 0
*/

CREATE PROCEDURE [dbo].[WMP00031_QC]
		@DivisionID  AS nvarchar(50), 
		@TranMonth AS nvarchar(50) , 
		@TranYear AS nvarchar(50),
		@FromInventory NVARCHAR(50) = '',
		@ToInventory NVARCHAR(50) = '',
		@WareHouseID NVARCHAR(MAX) = '',
		@UserID NVARCHAR(50) = '',
		@GroupID NVARCHAR(50) = '',
		@TransProcessesID NVARCHAR(50) = '',
		@IsAllWareHouse TINYINT = 0 --  Tính giá không phân biệt kho ( 1: check, 0: không check) 

AS
DECLARE @sSQL NVARCHAR(4000)  = N'',
		@sSQL1 NVARCHAR(4000)  = N'',
		@sSQL2 NVARCHAR(4000)  = N'',
		@sWhere NVARCHAR(4000) = N'',
		@sWhere1 NVARCHAR(4000) = N'',
		@sWhere2 NVARCHAR(4000) = N''
IF @IsAllWareHouse = 1
BEGIN
 SET @sSQL = N' --- Lấy số lượng phiếu nhập đầu kỳ + số lượng nhập kho + số lượng chuyển kho trong 1 kỳ
			    SELECT InventoryID, ISNULL(SUM(ActualQuantity),0) AS ActualQuantity, ''ALL'' AS WareHouseID FROM (
				SELECT AT2008_QC.InventoryID+InventoryAccountID+ISNULL(S01ID,'''')+ISNULL(S02ID,'''')+ISNULL(S03ID,'''')+ISNULL(S04ID,'''')+ISNULL(S05ID,'''')+ISNULL(S06ID,'''')+ISNULL(S07ID,'''')+ISNULL(S08ID,'''')+ISNULL(S09ID,'''')+ISNULL(S10ID,'''') 
					   +ISNULL(S11ID,'''')+ISNULL(S12ID,'''')+ISNULL(S13ID,'''')+ISNULL(S14ID,'''')+ISNULL(S15ID,'''')+ISNULL(S16ID,'''')+ISNULL(S17ID,'''')+ISNULL(S18ID,'''')+ISNULL(S19ID,'''')+ISNULL(S20ID,'''') AS InventoryID,
					   BeginQuantity AS ActualQuantity
				FROM AT2008_QC WITH (NOLOCK)
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2008_QC.DivisionID,''@@@'') AND AT2008_QC.InventoryID =  AT1302.InventoryID
			    WHERE AT2008_QC.DivisionID = '''+@DivisionID+''' AND (AT2008_QC.InventoryID BETWEEN '''+@FromInventory+''' AND '''+@ToInventory+''')
				AND AT2008_QC.TranMonth = '+@TranMonth+' AND AT2008_QC.TranYear= '+@TranYear+' AND AT1302.MethodID = 4

				UNION ALL

				SELECT AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''') AS InventoryID
				, SUM(AT2007.ActualQuantity) AS ActualQuantity
				FROM AT2007  WITH (NOLOCK) INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID 
				LEFT JOIN WT8899 W89 WITH (NOLOCK) ON AT2006.DivisionID = W89.DivisionID AND AT2006.VoucherID = W89.VoucherID AND AT2007.TransactionID = W89.TransactionID
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT2007.InventoryID =  AT1302.InventoryID
				WHERE AT2007.DivisionID = '''+@DivisionID+''' AND (AT2007.InventoryID BETWEEN '''+@FromInventory+''' AND '''+@ToInventory+''')
				AND AT2006.TranMonth = '+@TranMonth+' AND AT2006.TranYear= '+@TranYear+' AND AT1302.MethodID = 4
				AND KindVoucherID IN (1,5,7,9) 
				GROUP BY AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''')
				) A where ActualQuantity <> 0  GROUP BY  InventoryID  '

 SET @sSQL1 = N'-- Chuyển kho
				SELECT ''ALL'' AS WareHouseID2,''ALL'' AS WareHouseID , AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''') AS InventoryID,  0 AS ActualQuantity
				FROM AT2007  WITH (NOLOCK)	INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID 
				LEFT JOIN WT8899 W89 WITH (NOLOCK) ON AT2006.DivisionID = W89.DivisionID AND AT2006.VoucherID = W89.VoucherID AND AT2007.TransactionID = W89.TransactionID
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT2007.InventoryID =  AT1302.InventoryID
				WHERE AT2007.DivisionID = '''+@DivisionID+''' AND (AT2007.InventoryID BETWEEN '''+@FromInventory+''' AND '''+@ToInventory+''') AND AT2006.TranMonth = '+@TranMonth+' AND AT2006.TranYear= '+@TranYear+'
				AND KindVoucherID = 3 AND AT1302.MethodID = 4
				AND ActualQuantity <> 0
				GROUP BY AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''') '

SET @sSQL2 = N'		
				--- Giá trị nhập kho + giá trị tồn 
				SELECT InventoryID, ISNULL(sum(Amount),0) AS Amount ,''ALL'' AS WareHouseID INTO #Tranfer FROM (
				SELECT AT2008_QC.InventoryID+InventoryAccountID+ISNULL(S01ID,'''')+ISNULL(S02ID,'''')+ISNULL(S03ID,'''')+ISNULL(S04ID,'''')+ISNULL(S05ID,'''')+ISNULL(S06ID,'''')+ISNULL(S07ID,'''')+ISNULL(S08ID,'''')+ISNULL(S09ID,'''')+ISNULL(S10ID,'''') 
				 +ISNULL(S11ID,'''')+ISNULL(S12ID,'''')+ISNULL(S13ID,'''')+ISNULL(S14ID,'''')+ISNULL(S15ID,'''')+ISNULL(S16ID,'''')+ISNULL(S17ID,'''')+ISNULL(S18ID,'''')+ISNULL(S19ID,'''')+ISNULL(S20ID,'''') AS InventoryID
				 , BeginAmount AS Amount,'''' AS WareHouseID
				FROM AT2008_QC  WITH (NOLOCK)
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2008_QC.DivisionID,''@@@'') AND AT2008_QC.InventoryID =  AT1302.InventoryID
				WHERE AT2008_QC.DivisionID = '''+@DivisionID+''' AND (AT2008_QC.InventoryID BETWEEN '''+@FromInventory+''' AND '''+@ToInventory+''')
				AND AT2008_QC.TranMonth = '+@TranMonth+' AND AT2008_QC.TranYear= '+@TranYear+' AND AT1302.MethodID = 4
				GROUP BY WareHouseID, AT2008_QC.InventoryID+InventoryAccountID+ISNULL(S01ID,'''')+ISNULL(S02ID,'''')+ISNULL(S03ID,'''')+ISNULL(S04ID,'''')+ISNULL(S05ID,'''')+ISNULL(S06ID,'''')+ISNULL(S07ID,'''')+ISNULL(S08ID,'''')+ISNULL(S09ID,'''')+ISNULL(S10ID,'''') 
				 +ISNULL(S11ID,'''')+ISNULL(S12ID,'''')+ISNULL(S13ID,'''')+ISNULL(S14ID,'''')+ISNULL(S15ID,'''')+ISNULL(S16ID,'''')+ISNULL(S17ID,'''')+ISNULL(S18ID,'''')+ISNULL(S19ID,'''')+ISNULL(S20ID,'''') ,BeginAmount
				
				UNION ALL
				
				SELECT AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''') AS InventoryID
				, ISNULL(sum(Amount),0) AS Amount,'''' AS WareHouseID
				FROM AT2007 WITH (NOLOCK) INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID 
				LEFT JOIN WT8899 W89 WITH (NOLOCK) ON AT2006.DivisionID = W89.DivisionID AND AT2006.VoucherID = W89.VoucherID AND AT2007.TransactionID = W89.TransactionID
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT2007.InventoryID =  AT1302.InventoryID
				WHERE	AT2007.DivisionID = '''+@DivisionID+''' AND (AT2007.InventoryID BETWEEN '''+@FromInventory+''' AND '''+@ToInventory+''') AND AT2006.TranMonth = '+@TranMonth+' AND AT2006.TranYear = '+@TranYear+'
				AND KindVoucherID IN (1,5,7,9) AND AT1302.MethodID = 4
				 GROUP BY  AT2006.WareHouseID, AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''') ,AT2007.UnitPrice,ActualQuantity
				 ) A where Amount <> 0 GROUP BY WareHouseID, InventoryID
				 SELECT * FROM #Tranfer
				  ---- DS mặt hàng 
				 SELECT DISTINCT InventoryID FROM #Tranfer  where Amount != 0 '

END 
ELSE
BEGIN
	SET @sSQL = N'	--- Lấy số lượng phiếu nhập đầu kỳ + số lượng nhập kho + số lượng chuyển kho trong 1 kỳ
			    SELECT InventoryID, ISNULL(SUM(ActualQuantity),0) AS ActualQuantity, WareHouseID FROM (
				SELECT AT2008_QC.InventoryID+InventoryAccountID+ISNULL(S01ID,'''')+ISNULL(S02ID,'''')+ISNULL(S03ID,'''')+ISNULL(S04ID,'''')+ISNULL(S05ID,'''')+ISNULL(S06ID,'''')+ISNULL(S07ID,'''')+ISNULL(S08ID,'''')+ISNULL(S09ID,'''')+ISNULL(S10ID,'''') 
				 +ISNULL(S11ID,'''')+ISNULL(S12ID,'''')+ISNULL(S13ID,'''')+ISNULL(S14ID,'''')+ISNULL(S15ID,'''')+ISNULL(S16ID,'''')+ISNULL(S17ID,'''')+ISNULL(S18ID,'''')+ISNULL(S19ID,'''')+ISNULL(S20ID,'''') AS InventoryID
				 ,BeginQuantity AS ActualQuantity, WareHouseID
				FROM AT2008_QC  WITH (NOLOCK)
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2008_QC.DivisionID,''@@@'') AND AT2008_QC.InventoryID = AT1302.InventoryID
			    WHERE AT2008_QC.DivisionID = '''+@DivisionID+''' AND (AT2008_QC.InventoryID BETWEEN '''+@FromInventory+''' AND '''+@ToInventory+''')
				AND AT2008_QC.TranMonth = '+@TranMonth+' AND AT2008_QC.TranYear= '+@TranYear+'
				AND AT2008_QC.WareHouseID IN (''' +@WareHouseID+ ''') AND AT1302.MethodID = 4
				
				UNION ALL
				
				SELECT AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''') AS InventoryID
				, SUM(AT2007.ActualQuantity) AS ActualQuantity, AT2006.WareHouseID
				FROM AT2007  WITH (NOLOCK)	INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID 
				LEFT JOIN WT8899 W89 WITH (NOLOCK) ON AT2006.DivisionID = W89.DivisionID AND AT2006.VoucherID = W89.VoucherID AND AT2007.TransactionID = W89.TransactionID
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT2007.InventoryID =  AT1302.InventoryID
				WHERE AT2007.DivisionID = '''+@DivisionID+''' AND (AT2007.InventoryID BETWEEN '''+@FromInventory+''' AND '''+@ToInventory+''') AND AT2006.TranMonth = '+@TranMonth+' AND AT2006.TranYear = '+@TranYear+'
				AND KindVoucherID IN (1,5,7,9) AND AT2006.WareHouseID IN (''' +@WareHouseID+ ''') AND AT1302.MethodID = 4
				GROUP BY AT2006.WareHouseID,AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''')								 
				UNION ALL '

 SET @sSQL1 = N'SELECT AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''') AS InventoryID
				,sum(AT2007.ActualQuantity) AS ActualQuantity, AT2006.WareHouseID
				FROM AT2007  WITH (NOLOCK)	INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID 
				LEFT JOIN WT8899 W89 WITH (NOLOCK) ON AT2006.DivisionID = W89.DivisionID AND AT2006.VoucherID = W89.VoucherID AND AT2007.TransactionID = W89.TransactionID
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT2007.InventoryID =  AT1302.InventoryID
				WHERE AT2007.DivisionID = '''+@DivisionID+''' AND (AT2007.InventoryID BETWEEN '''+@FromInventory+''' AND '''+@ToInventory+''') AND AT2006.TranMonth = '+@TranMonth+' AND AT2006.TranYear = '+@TranYear+'
				AND KindVoucherID = 3 AND AT2006.WareHouseID IN (''' +@WareHouseID+ ''') AND AT1302.MethodID = 4
				GROUP BY AT2006.WareHouseID,AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''') 
				 ) A where ActualQuantity <> 0  GROUP BY WareHouseID, InventoryID  

				-- Chuyển kho
				SELECT AT2006.WareHouseID2,AT2006.WareHouseID , AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''') AS InventoryID,  SUM(AT2007.ActualQuantity) AS ActualQuantity
				FROM AT2007  WITH (NOLOCK)	INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID 
				LEFT JOIN WT8899 W89 WITH (NOLOCK) ON AT2006.DivisionID = W89.DivisionID AND AT2006.VoucherID = W89.VoucherID AND AT2007.TransactionID = W89.TransactionID
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT2007.InventoryID =  AT1302.InventoryID
				WHERE	AT2007.DivisionID = '''+@DivisionID+''' AND (AT2007.InventoryID BETWEEN '''+@FromInventory+''' AND '''+@ToInventory+''') AND AT2006.TranMonth = '+@TranMonth+' AND AT2006.TranYear = '+@TranYear+'
				AND KindVoucherID = 3 AND AT2006.WareHouseID2 IN (''' +@WareHouseID+ ''')
				AND ActualQuantity <> 0  AND AT1302.MethodID = 4
				GROUP BY AT2006.WareHouseID, AT2006.WareHouseID2 , AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''')'
 
 SET @sSQL2 = N'--- Giá trị nhập kho + giá trị tồn
				SELECT InventoryID, ISNULL(sum(Amount),0) AS Amount , WareHouseID INTO #Tranfer FROM (
				SELECT AT2008_QC.InventoryID+InventoryAccountID+ISNULL(S01ID,'''')+ISNULL(S02ID,'''')+ISNULL(S03ID,'''')+ISNULL(S04ID,'''')+ISNULL(S05ID,'''')+ISNULL(S06ID,'''')+ISNULL(S07ID,'''')+ISNULL(S08ID,'''')+ISNULL(S09ID,'''')+ISNULL(S10ID,'''') 
				 +ISNULL(S11ID,'''')+ISNULL(S12ID,'''')+ISNULL(S13ID,'''')+ISNULL(S14ID,'''')+ISNULL(S15ID,'''')+ISNULL(S16ID,'''')+ISNULL(S17ID,'''')+ISNULL(S18ID,'''')+ISNULL(S19ID,'''')+ISNULL(S20ID,'''') AS InventoryID
				, BeginAmount AS Amount, WareHouseID
				FROM AT2008_QC  WITH (NOLOCK)
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2008_QC.DivisionID,''@@@'') AND AT2008_QC.InventoryID =  AT1302.InventoryID
				WHERE	AT2008_QC.DivisionID = '''+@DivisionID+''' AND (AT2008_QC.InventoryID BETWEEN '''+@FromInventory+''' AND '''+@ToInventory+''') AND AT2008_QC.TranMonth = '+@TranMonth+' AND AT2008_QC.TranYear = '+@TranYear+'
				AND AT2008_QC.WareHouseID IN (''' +@WareHouseID+ ''') AND AT1302.MethodID = 4
				GROUP BY  WareHouseID, AT2008_QC.InventoryID+InventoryAccountID+ISNULL(S01ID,'''')+ISNULL(S02ID,'''')+ISNULL(S03ID,'''')+ISNULL(S04ID,'''')+ISNULL(S05ID,'''')+ISNULL(S06ID,'''')+ISNULL(S07ID,'''')+ISNULL(S08ID,'''')+ISNULL(S09ID,'''')+ISNULL(S10ID,'''') 
				 +ISNULL(S11ID,'''')+ISNULL(S12ID,'''')+ISNULL(S13ID,'''')+ISNULL(S14ID,'''')+ISNULL(S15ID,'''')+ISNULL(S16ID,'''')+ISNULL(S17ID,'''')+ISNULL(S18ID,'''')+ISNULL(S19ID,'''')+ISNULL(S20ID,'''')
				 ,BeginAmount
				 			
				UNION ALL

				SELECT AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''') AS InventoryID
				, ISNULL(sum(UnitPrice*ActualQuantity),0) AS Amount, AT2006.WareHouseID
				FROM AT2007  WITH (NOLOCK)	INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID 
				LEFT JOIN WT8899 W89 WITH (NOLOCK) ON AT2006.DivisionID = W89.DivisionID AND AT2006.VoucherID = W89.VoucherID AND AT2007.TransactionID = W89.TransactionID
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT2007.InventoryID =  AT1302.InventoryID
				WHERE AT2007.DivisionID = '''+@DivisionID+''' AND (AT2007.InventoryID BETWEEN '''+@FromInventory+''' AND '''+@ToInventory+''') AND AT2006.TranMonth = '+@TranMonth+' AND AT2006.TranYear= '+@TranYear+'
				AND KindVoucherID IN (1,5,7,9) AND AT2006.WareHouseID IN (''' +@WareHouseID+ ''')  AND AT1302.MethodID = 4
				 GROUP BY AT2006.WareHouseID, AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''') ,AT2007.UnitPrice,ActualQuantity
				 ) A where Amount <> 0 GROUP BY WareHouseID, InventoryID
				 SELECT * FROM #Tranfer
				  ---- DS mặt hàng 
				 SELECT DISTINCT InventoryID FROM #Tranfer 
				 '
	

END

PRINT (@sSQL)
PRINT (@sSQL1)
PRINT (@sSQL2)
EXEC (@sSQL + @sSQL1 + @sSQL2)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
