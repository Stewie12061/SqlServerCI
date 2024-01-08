IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1331]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1331]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



--------- Created by Tra Giang on 01/07/2019
--------- Purpose: Lấy các giá trị cần update 
--------- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
/*
      EXEC AP1331  @DivisionID = 'NNP', @TranMonth = 5, @TranYear = 2019
*/

CREATE PROCEDURE [dbo].[AP1331] 
    @DivisionID NVARCHAR(50), 
    @TranMonth NVARCHAR(50), 
    @TranYear NVARCHAR(50)
    
AS
DECLARE @sSQL NVARCHAR(4000),
		@sSQL1 NVARCHAR(4000)
SET @sSQL = N'
		SELECT  AT2007.APK, AT2007.DivisionID , AT2007.TransactionID, AT2007.InventoryID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+
		ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''') +ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''') +ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+
			ISNULL(W89.S12ID,'''') +ISNULL(W89.S13ID,'''')+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+
			ISNULL(W89.S16ID,'''') +ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''') as InventoryID ,
			 AT2006.WareHouseID as Notes,AT2007.ActualQuantity, AT2007.UnitPrice, AT2007.ConvertedPrice, AT2007.OriginalAmount, AT2007.ConvertedAmount
		FROM AT2007 WITH (NOLOCK)
		INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID
		LEFT JOIN WT8899 W89 WITH (NOLOCK) ON AT2006.DivisionID = W89.DivisionID AND AT2006.VoucherID = W89.VoucherID AND AT2007.TransactionID = W89.TransactionID
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT2007.InventoryID =  AT1302.InventoryID
				WHERE AT2006.KindVoucherID IN (2, 4, 6, 8) ---- 2: xuat kho thong thuong, 4: ban hang xuat kho
			AND AT2007.TranMonth = '+@TranMonth+'
			AND AT2007.TranYear = '+@TranYear+'
				AND WareHouseID2 IS NULL and AT1302.MethodID = 4  and AT2006.DivisionID = '''+@DivisionID+'''
			
			UNION ALL 		
		
		SELECT AT2007.APK, AT2007.DivisionID , AT2007.TransactionID, AT2007.InventoryID+ISNULL(W89.S01ID,'''')+ISNULL(W89.S02ID,'''')+ISNULL(W89.S03ID,'''')+ISNULL(W89.S04ID,'''')+
		ISNULL(W89.S05ID,'''')+ISNULL(W89.S06ID,'''') +ISNULL(W89.S07ID,'''')+ISNULL(W89.S08ID,'''') +ISNULL(W89.S09ID,'''')+ISNULL(W89.S10ID,'''')+ISNULL(W89.S11ID,'''')+
			ISNULL(W89.S12ID,'''') +ISNULL(W89.S13ID,'''')+ISNULL(W89.S14ID,'''')+ISNULL(W89.S15ID,'''')+
			ISNULL(W89.S16ID,'''') +ISNULL(W89.S17ID,'''')+ISNULL(W89.S18ID,'''')+ISNULL(W89.S19ID,'''')+ISNULL(W89.S20ID,'''') as InventoryID 
			, AT2006.WareHouseID2 as Notes,AT2007.ActualQuantity , AT2007.UnitPrice, AT2007.ConvertedPrice, AT2007.OriginalAmount, AT2007.ConvertedAmount
		FROM AT2007 WITH (NOLOCK)
		INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID
		LEFT JOIN WT8899 W89 WITH (NOLOCK) ON AT2006.DivisionID = W89.DivisionID AND AT2006.VoucherID = W89.VoucherID AND AT2007.TransactionID = W89.TransactionID
		LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT2007.InventoryID =  AT1302.InventoryID
		WHERE AT2006.KindVoucherID IN (3) ---- 2: xuat kho thong thuong, 4: ban hang xuat kho
			AND AT2007.TranMonth = '+@TranMonth+' 
			AND AT2007.TranYear = '+@TranYear+'
				AND WareHouseID2 IS NOT NULL and AT1302.MethodID = 4   and AT2006.DivisionID = '''+@DivisionID+'''

'
SET @sSQL1 = N'
SELECT AT2008_QC.APK,AT2008_QC.DivisionID,AT2008_QC.InventoryID+ISNULL(S01ID,'''')+ISNULL(S02ID,'''')+ISNULL(S03ID,'''')+ISNULL(S04ID,'''')+
		ISNULL(S05ID,'''')+ISNULL(S06ID,'''') +ISNULL(S07ID,'''')+ISNULL(S08ID,'''') +ISNULL(S09ID,'''')+ISNULL(S10ID,'''')+ISNULL(S11ID,'''')+
			ISNULL(S12ID,'''') +ISNULL(S13ID,'''')+ISNULL(S14ID,'''')+ISNULL(S15ID,'''')+
			ISNULL(S16ID,'''') +ISNULL(S17ID,'''')+ISNULL(S18ID,'''')+ISNULL(S19ID,'''')+ISNULL(S20ID,'''') as InventoryID ,
			 AT2008_QC.WareHouseID, AT2008_QC.BeginQuantity, AT2008_QC.BeginAmount, AT2008_QC.UnitPrice		FROM AT2008_QC WITH (NOLOCK) 
			WHERE AT2008_QC.TranMonth = '+@TranMonth+' 
			AND AT2008_QC.TranYear = '+@TranYear+'
			AND AT2008_QC.DivisionID = '''+@DivisionID+''''
EXEC (@sSQL + @sSQL1)
--Print @sSQL 
--Print @sSQL1



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
