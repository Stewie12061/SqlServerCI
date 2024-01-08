IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1330_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1330_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




----- Created by Trà Giang
----- Created Date 26/06/2019
----- Purpose: Lấy dữ liệu tính giá xuất kho  cho MH có quy cách 
----- Modified by Huỳnh Thử on 09/07/2020 : CONCAT(InventoryID,AccountID) tính giá mặt hàng theo tài khoản
----- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
----- Modified by Huỳnh Thử on 01/12/2020: Đổi Amount bằng thành tiền -- Không lấy số lượng * đơn giá, bị lỗi khi có phiếu điều chỉnh hoặc sửa giá thành tiền phiếu nhập; 
-----									   Thêm điều kiên Amount <> 0 vì sẽ sai khi trường hợp xuất kho âm
----- Modified by Văn Tài	on 06/05/2022: Điều chỉnh số lượng * đơn giá cho trường hợp theo kho do không có cột Amount.
/*
exec AP1330_QC  @DivisionID = 'NNP',@TranMonth =5,@TranYear = 2019,@FromInventoryID ='AP161-P176',@ToInventoryID ='AP161-P176',	@FromWareHouseID = 'KHOBTP001', 	@ToWareHouseID ='KHOVL003',@FromAccountID=N'152',@ToAccountID=N'158',@UserID=N'ASOFTADMIN',@GroupID=N'ADMIN',@TransProcessesID=N'',@IsAllWareHouse = 0
exec AP1330_QC @DivisionID=N'NNP',@TranMonth=N'5',@TranYear=N'2019',@FromInventoryID=N'AP161-P176',@ToInventoryID=N'AP161-P176',@FromWareHouseID=N'KHOBTP001',@ToWareHouseID=N'KHOVL003',@FromAccountID=N'152',@ToAccountID=N'158',@UserID=N'ASOFTADMIN',@GroupID=N'ADMIN',@TransProcessesID=N'',@IsAllWareHouse = 0
*/

CREATE PROCEDURE  [dbo].[AP1330_QC] 
		@DivisionID  as nvarchar(50), 
		@TranMonth as nvarchar(50) , 
		@TranYear as nvarchar(50),
		@FromInventoryID NVARCHAR(50) = '', 
		@ToInventoryID NVARCHAR(50) = '',
		@FromWareHouseID NVARCHAR(50) = '', 
		@ToWareHouseID NVARCHAR(50) = '',
		@FromAccountID NVARCHAR(50) = '',
		@ToAccountID NVARCHAR(50) = '',
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
			    SELECT InventoryID,  ISNULL(SUM(ActualQuantity),0) as ActualQuantity, ''ALL'' as WareHouseID from (
				Select   AT2008_QC.InventoryID+InventoryAccountID+ISNULL(S01ID,'''')+ISNULL(S02ID,'''')+ISNULL(S03ID,'''')+ISNULL(S04ID,'''')+ISNULL(S05ID,'''')+ISNULL(S06ID,'''')+ISNULL(S07ID,'''')+ISNULL(S08ID,'''')+ISNULL(S09ID,'''')+ISNULL(S10ID,'''') 
				 +ISNULL(S11ID,'''')+ISNULL(S12ID,'''')+ISNULL(S13ID,'''')+ISNULL(S14ID,'''')+ISNULL(S15ID,'''')+ISNULL(S16ID,'''')+ISNULL(S17ID,'''')+ISNULL(S18ID,'''')+ISNULL(S19ID,'''')+ISNULL(S20ID,'''') as InventoryID,
				 BeginQuantity as ActualQuantity
				From AT2008_QC  WITH (NOLOCK)
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2008_QC.DivisionID,''@@@'') AND AT2008_QC.InventoryID =  AT1302.InventoryID
			    WHERE	AT2008_QC.DivisionID = '''+@DivisionID+''' and AT2008_QC.InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''' 
				 and AT2008_QC.TranMonth = '+@TranMonth+' and AT2008_QC.TranYear= '+@TranYear+' and AT1302.MethodID = 4 	
				UNION ALL
				SELECT AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''') AS InventoryID
				,  SUM(AT2007.ActualQuantity) as ActualQuantity
				From AT2007  WITH (NOLOCK)	inner join AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID and AT2006.DivisionID = AT2007.DivisionID 
				LEFT JOIN WT8899 W89 WITH (NOLOCK) ON AT2006.DivisionID = W89.DivisionID AND AT2006.VoucherID = W89.VoucherID AND AT2007.TransactionID = W89.TransactionID
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT2007.InventoryID =  AT1302.InventoryID
				WHERE	AT2007.DivisionID = '''+@DivisionID+''' and AT2007.InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''' 
				and AT2006.TranMonth = '+@TranMonth+' and AT2006.TranYear= '+@TranYear+' and AT1302.MethodID = 4
				and KindVoucherID IN (1,5,7,9) 
				GROUP BY   AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''')
					 ) A where ActualQuantity <> 0  GROUP BY  InventoryID  '
 SET @sSQL1 = N'	  -- Chuyển kho
				select ''ALL'' as WareHouseID2,''ALL'' as WareHouseID , AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''') AS InventoryID,  0 as ActualQuantity
				From AT2007  WITH (NOLOCK)	inner join AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID and AT2006.DivisionID = AT2007.DivisionID 
				LEFT JOIN WT8899 W89 WITH (NOLOCK) ON AT2006.DivisionID = W89.DivisionID AND AT2006.VoucherID = W89.VoucherID AND AT2007.TransactionID = W89.TransactionID
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT2007.InventoryID =  AT1302.InventoryID
				WHERE	AT2007.DivisionID = '''+@DivisionID+''' and AT2007.InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''' and AT2006.TranMonth = '+@TranMonth+' and AT2006.TranYear= '+@TranYear+'
				and KindVoucherID = 3 and AT1302.MethodID = 4
				and ActualQuantity <> 0 
				GROUP BY AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''')		'
SET @sSQL2 = N'		
				--- Giá trị nhập kho + giá trị tồn 
				Select InventoryID, ISNULL(sum(Amount),0) AS Amount ,''ALL'' as  WareHouseID INTO #Tranfer from (
				Select   AT2008_QC.InventoryID+InventoryAccountID+ISNULL(S01ID,'''')+ISNULL(S02ID,'''')+ISNULL(S03ID,'''')+ISNULL(S04ID,'''')+ISNULL(S05ID,'''')+ISNULL(S06ID,'''')+ISNULL(S07ID,'''')+ISNULL(S08ID,'''')+ISNULL(S09ID,'''')+ISNULL(S10ID,'''') 
				 +ISNULL(S11ID,'''')+ISNULL(S12ID,'''')+ISNULL(S13ID,'''')+ISNULL(S14ID,'''')+ISNULL(S15ID,'''')+ISNULL(S16ID,'''')+ISNULL(S17ID,'''')+ISNULL(S18ID,'''')+ISNULL(S19ID,'''')+ISNULL(S20ID,'''') as InventoryID
				 , BeginAmount AS Amount,'''' as  WareHouseID
				From AT2008_QC  WITH (NOLOCK)
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2008_QC.DivisionID,''@@@'') AND AT2008_QC.InventoryID =  AT1302.InventoryID
				WHERE	AT2008_QC.DivisionID = '''+@DivisionID+''' and AT2008_QC.InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+'''
					 and AT2008_QC.TranMonth = '+@TranMonth+' and AT2008_QC.TranYear= '+@TranYear+' and AT1302.MethodID = 4
				GROUP BY  WareHouseID, AT2008_QC.InventoryID+InventoryAccountID+ISNULL(S01ID,'''')+ISNULL(S02ID,'''')+ISNULL(S03ID,'''')+ISNULL(S04ID,'''')+ISNULL(S05ID,'''')+ISNULL(S06ID,'''')+ISNULL(S07ID,'''')+ISNULL(S08ID,'''')+ISNULL(S09ID,'''')+ISNULL(S10ID,'''') 
				 +ISNULL(S11ID,'''')+ISNULL(S12ID,'''')+ISNULL(S13ID,'''')+ISNULL(S14ID,'''')+ISNULL(S15ID,'''')+ISNULL(S16ID,'''')+ISNULL(S17ID,'''')+ISNULL(S18ID,'''')+ISNULL(S19ID,'''')+ISNULL(S20ID,'''') ,BeginAmount
							UNION ALL
				SELECT AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''') AS InventoryID
				, ISNULL(sum(Amount),0) AS Amount,'''' as WareHouseID
				From AT2007  WITH (NOLOCK)	inner join AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID and AT2006.DivisionID = AT2007.DivisionID 
				LEFT JOIN WT8899 W89 WITH (NOLOCK) ON AT2006.DivisionID = W89.DivisionID AND AT2006.VoucherID = W89.VoucherID AND AT2007.TransactionID = W89.TransactionID
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT2007.InventoryID =  AT1302.InventoryID
				WHERE	AT2007.DivisionID = '''+@DivisionID+''' and AT2007.InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''' and AT2006.TranMonth = '+@TranMonth+' and AT2006.TranYear= '+@TranYear+'
				and KindVoucherID IN (1,5,7,9)   and AT1302.MethodID = 4
				 GROUP BY  AT2006.WareHouseID, AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''') ,AT2007.UnitPrice,ActualQuantity
				 ) A where Amount <> 0 GROUP BY WareHouseID, InventoryID
				 SELECT * FROM #Tranfer
				  ---- DS mặt hàng 
				 SELECT DISTINCT InventoryID FROM #Tranfer  where Amount != 0
 ' 
END 
 ELSE

BEGIN
	SET @sSQL = N'	--- Lấy số lượng phiếu nhập đầu kỳ + số lượng nhập kho + số lượng chuyển kho trong 1 kỳ
			    SELECT InventoryID,  ISNULL(SUM(ActualQuantity),0) as ActualQuantity, WareHouseID from (
				Select  AT2008_QC.InventoryID+InventoryAccountID+ISNULL(S01ID,'''')+ISNULL(S02ID,'''')+ISNULL(S03ID,'''')+ISNULL(S04ID,'''')+ISNULL(S05ID,'''')+ISNULL(S06ID,'''')+ISNULL(S07ID,'''')+ISNULL(S08ID,'''')+ISNULL(S09ID,'''')+ISNULL(S10ID,'''') 
				 +ISNULL(S11ID,'''')+ISNULL(S12ID,'''')+ISNULL(S13ID,'''')+ISNULL(S14ID,'''')+ISNULL(S15ID,'''')+ISNULL(S16ID,'''')+ISNULL(S17ID,'''')+ISNULL(S18ID,'''')+ISNULL(S19ID,'''')+ISNULL(S20ID,'''') as InventoryID
				 ,BeginQuantity as ActualQuantity, WareHouseID
				From AT2008_QC  WITH (NOLOCK)
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2008_QC.DivisionID,''@@@'') AND AT2008_QC.InventoryID =  AT1302.InventoryID
			    WHERE	AT2008_QC.DivisionID = '''+@DivisionID+''' and AT2008_QC.InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+'''  
				and AT2008_QC.TranMonth = '+@TranMonth+' and AT2008_QC.TranYear= '+@TranYear+'
				and AT2008_QC.WareHouseID between '''+@FromWareHouseID+''' and '''+@ToWareHouseID+'''  and AT1302.MethodID = 4
					UNION ALL
				SELECT AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''') AS InventoryID
				, SUM(AT2007.ActualQuantity) as ActualQuantity, AT2006.WareHouseID
				From AT2007  WITH (NOLOCK)	inner join AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID and AT2006.DivisionID = AT2007.DivisionID 
				LEFT JOIN WT8899 W89 WITH (NOLOCK) ON AT2006.DivisionID = W89.DivisionID AND AT2006.VoucherID = W89.VoucherID AND AT2007.TransactionID = W89.TransactionID
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT2007.InventoryID =  AT1302.InventoryID
				WHERE	AT2007.DivisionID = '''+@DivisionID+''' and AT2007.InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''' and AT2006.TranMonth = '+@TranMonth+' and AT2006.TranYear= '+@TranYear+'
				and KindVoucherID IN (1,5,7,9) and AT2006.WareHouseID between '''+@FromWareHouseID+''' and '''+@ToWareHouseID+''' and AT1302.MethodID = 4
				GROUP BY   AT2006.WareHouseID,AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''')								 
				UNION ALL '
 SET @sSQL1 = N'SELECT AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''') AS InventoryID
				,sum(AT2007.ActualQuantity) AS ActualQuantity, AT2006.WareHouseID
				From AT2007  WITH (NOLOCK)	inner join AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID and AT2006.DivisionID = AT2007.DivisionID 
				LEFT JOIN WT8899 W89 WITH (NOLOCK) ON AT2006.DivisionID = W89.DivisionID AND AT2006.VoucherID = W89.VoucherID AND AT2007.TransactionID = W89.TransactionID
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT2007.InventoryID =  AT1302.InventoryID
				WHERE	AT2007.DivisionID = '''+@DivisionID+''' and AT2007.InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''' and AT2006.TranMonth = '+@TranMonth+' and AT2006.TranYear= '+@TranYear+'
				and KindVoucherID  = 3  and AT2006.WareHouseID between '''+@FromWareHouseID+''' and '''+@ToWareHouseID+''' and AT1302.MethodID = 4
				GROUP BY   AT2006.WareHouseID,AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''') 
				 ) A where ActualQuantity <> 0  GROUP BY WareHouseID, InventoryID  
		  -- CHuyển kho
				select AT2006.WareHouseID2,AT2006.WareHouseID , AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''') AS InventoryID,  SUM(AT2007.ActualQuantity) as ActualQuantity
				From AT2007  WITH (NOLOCK)	inner join AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID and AT2006.DivisionID = AT2007.DivisionID 
				LEFT JOIN WT8899 W89 WITH (NOLOCK) ON AT2006.DivisionID = W89.DivisionID AND AT2006.VoucherID = W89.VoucherID AND AT2007.TransactionID = W89.TransactionID
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT2007.InventoryID =  AT1302.InventoryID
				WHERE	AT2007.DivisionID = '''+@DivisionID+''' and AT2007.InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''' and AT2006.TranMonth = '+@TranMonth+' and AT2006.TranYear= '+@TranYear+'
				and KindVoucherID = 3 and AT2006.WareHouseID2 between '''+@FromWareHouseID+''' and '''+@ToWareHouseID+'''
				and ActualQuantity <> 0  and AT1302.MethodID = 4
				GROUP BY AT2006.WareHouseID, AT2006.WareHouseID2 , AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''')'
 SET @sSQL2 = N'	--- Giá trị nhập kho + giá trị tồn 
				Select InventoryID, ISNULL(sum(Amount),0) AS Amount , WareHouseID INTO #Tranfer from (
				Select   AT2008_QC.InventoryID+InventoryAccountID+ISNULL(S01ID,'''')+ISNULL(S02ID,'''')+ISNULL(S03ID,'''')+ISNULL(S04ID,'''')+ISNULL(S05ID,'''')+ISNULL(S06ID,'''')+ISNULL(S07ID,'''')+ISNULL(S08ID,'''')+ISNULL(S09ID,'''')+ISNULL(S10ID,'''') 
				 +ISNULL(S11ID,'''')+ISNULL(S12ID,'''')+ISNULL(S13ID,'''')+ISNULL(S14ID,'''')+ISNULL(S15ID,'''')+ISNULL(S16ID,'''')+ISNULL(S17ID,'''')+ISNULL(S18ID,'''')+ISNULL(S19ID,'''')+ISNULL(S20ID,'''') as InventoryID
				, BeginAmount AS Amount, WareHouseID
				From AT2008_QC  WITH (NOLOCK)
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2008_QC.DivisionID,''@@@'') AND AT2008_QC.InventoryID =  AT1302.InventoryID
				WHERE	AT2008_QC.DivisionID = '''+@DivisionID+''' and AT2008_QC.InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''' and AT2008_QC.TranMonth = '+@TranMonth+' and AT2008_QC.TranYear= '+@TranYear+'
				and AT2008_QC.WareHouseID between '''+@FromWareHouseID+''' and '''+@ToWareHouseID+''' and AT1302.MethodID = 4
				GROUP BY  WareHouseID, AT2008_QC.InventoryID+InventoryAccountID+ISNULL(S01ID,'''')+ISNULL(S02ID,'''')+ISNULL(S03ID,'''')+ISNULL(S04ID,'''')+ISNULL(S05ID,'''')+ISNULL(S06ID,'''')+ISNULL(S07ID,'''')+ISNULL(S08ID,'''')+ISNULL(S09ID,'''')+ISNULL(S10ID,'''') 
				 +ISNULL(S11ID,'''')+ISNULL(S12ID,'''')+ISNULL(S13ID,'''')+ISNULL(S14ID,'''')+ISNULL(S15ID,'''')+ISNULL(S16ID,'''')+ISNULL(S17ID,'''')+ISNULL(S18ID,'''')+ISNULL(S19ID,'''')+ISNULL(S20ID,'''')
				 ,BeginAmount				
					UNION ALL
				SELECT AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''') AS InventoryID
				, ISNULL(sum(UnitPrice*ActualQuantity),0) AS Amount, AT2006.WareHouseID
				From AT2007  WITH (NOLOCK)	inner join AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID and AT2006.DivisionID = AT2007.DivisionID 
				LEFT JOIN WT8899 W89 WITH (NOLOCK) ON AT2006.DivisionID = W89.DivisionID AND AT2006.VoucherID = W89.VoucherID AND AT2007.TransactionID = W89.TransactionID
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT2007.InventoryID =  AT1302.InventoryID
				WHERE	AT2007.DivisionID = '''+@DivisionID+''' and AT2007.InventoryID between '''+@FromInventoryID+''' and '''+@ToInventoryID+''' and AT2006.TranMonth = '+@TranMonth+' and AT2006.TranYear= '+@TranYear+'
				and KindVoucherID IN (1,5,7,9) and AT2006.WareHouseID between '''+@FromWareHouseID+''' and '''+@ToWareHouseID+'''  and AT1302.MethodID = 4
				 GROUP BY  AT2006.WareHouseID, AT2007.InventoryID+DebitAccountID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''')
				+ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''')+ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+ISNULL(W89.S12ID,'''')+ISNULL(W89.S13ID,'''')
				+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+ISNULL(W89.S16ID,'''')+ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''') ,AT2007.UnitPrice,ActualQuantity
				 ) A where Amount <> 0 GROUP BY WareHouseID, InventoryID
				 SELECT * FROM #Tranfer
				  ---- DS mặt hàng 
				 SELECT DISTINCT InventoryID FROM #Tranfer 
				 '
	

END
EXEC (@sSQL + @sSQL1 + @sSQL2)
  Print (@sSQL)
  Print (@sSQL1)
  Print (@sSQL2)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
