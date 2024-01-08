IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7004]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV7004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- View chet. Xu ly so du hang ton kho (chỉ lấy các cột của phiếu nhập xuất và mã quy cách)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 02/05/2019 by Kim Thư 
-- <Example>
---- 

CREATE VIEW [dbo].[AV7004] AS 
--- So du No cua tai khoan ton kho
SELECT  D17.DivisionID, D17.TranMonth, D17.TranYear,
	D16.WareHouseID, D17.InventoryID, D17.DebitAccountID, D17.CreditAccountID,
	'BD' AS D_C,  --- So du No
	'' AS RefNo01, '' AS RefNo02, 	D17.Notes,
	D16.VoucherID, D16.VoucherDate, D16.VoucherNo, 
	D16.ObjectID,
	ActualQuantity AS SignQuantity, 
	ConvertedQuantity AS SignConvertedQuantity, 
	ConvertedAmount AS SignAmount,	
	D17.Ana01ID,D17.Ana02ID,D17.Ana03ID, D17.Ana04ID,D17.Ana05ID,
	D17.Ana06ID,D17.Ana07ID,D17.Ana08ID, D17.Ana09ID,D17.Ana10ID,
	D16.VoucherTypeID,
	0 AS KindVoucherID, D17.SourceNo,
	D17.ConvertedUnitID,
	NULL AS ProductID, NULL AS MOrderID,
	D16.Description AS VoucherDesc,
    D17.Parameter01, D17.Parameter02, D17.Parameter03, D17.Parameter04, D17.Parameter05,
	D17.Notes01, D17.Notes02, D17.Notes03, D17.Notes04, D17.Notes05, D17.Notes06, D17.Notes07, D17.Notes08,
	D17.Notes09, D17.Notes10, D17.Notes11, D17.Notes12, D17.Notes13, D17.Notes14, D17.Notes15, D17.MarkQuantity, D17.MarkQuantity as SignMarkQuantity,
	D17.DebitAccountID as InventoryAccountID,
	ISNULL(W89.S01ID,'') AS S01ID, ISNULL(W89.S02ID,'') AS S02ID, ISNULL(W89.S03ID,'') AS S03ID, ISNULL(W89.S04ID,'') AS S04ID, ISNULL(W89.S05ID,'') AS S05ID, 
	ISNULL(W89.S06ID,'') AS S06ID, ISNULL(W89.S07ID,'') AS S07ID, ISNULL(W89.S08ID,'') AS S08ID, ISNULL(W89.S09ID,'') AS S09ID, ISNULL(W89.S10ID,'') AS S10ID,
	ISNULL(W89.S11ID,'') AS S11ID, ISNULL(W89.S12ID,'') AS S12ID, ISNULL(W89.S13ID,'') AS S13ID, ISNULL(W89.S14ID,'') AS S14ID, ISNULL(W89.S15ID,'') AS S15ID, 
	ISNULL(W89.S16ID,'') AS S16ID, ISNULL(W89.S17ID,'') AS S17ID, ISNULL(W89.S18ID,'') AS S18ID, ISNULL(W89.S19ID,'') AS S19ID, ISNULL(W89.S20ID,'') AS S20ID,
	D17.LimitDate, D16.OrderID  
From AT2017 AS D17 WITH (NOLOCK)
INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID = D17.DivisionID
LEFT JOIN WT8899 W89 WITH (NOLOCK) ON W89.DivisionID = D17.DivisionID AND W89.TransactionID = D17.TransactionID AND  W89.VoucherID = D17.VoucherID
Where isnull(DebitAccountID,'') <>''

UNION ALL --- So du co hang ton kho

SELECT  D17.DivisionID, D17.TranMonth, D17.TranYear,
	D16.WareHouseID, D17.InventoryID, D17.DebitAccountID, D17.CreditAccountID,
	'BC' AS D_C,  --- So du Co
	'' AS RefNo01, '' AS RefNo02, 	D17.Notes,
	D16.VoucherID, D16.VoucherDate, D16.VoucherNo, 
	D16.ObjectID,
	-ActualQuantity AS SignQuantity, 
	-ConvertedQuantity AS SignConvertedQuantity, 
	-ConvertedAmount AS SignAmount,	
	D17.Ana01ID,D17.Ana02ID,D17.Ana03ID, D17.Ana04ID,D17.Ana05ID,
	D17.Ana06ID,D17.Ana07ID,D17.Ana08ID, D17.Ana09ID,D17.Ana10ID,
	D16.VoucherTypeID,
	0 AS KindVoucherID, D17.SourceNo,
	D17.ConvertedUnitID,
	NULL AS ProductID, NULL AS MOrderID,
	D16.Description AS VoucherDesc,
    D17.Parameter01, D17.Parameter02, D17.Parameter03, D17.Parameter04, D17.Parameter05,
	D17.Notes01, D17.Notes02, D17.Notes03, D17.Notes04, D17.Notes05, D17.Notes06, D17.Notes07, D17.Notes08,
	D17.Notes09, D17.Notes10, D17.Notes11, D17.Notes12, D17.Notes13, D17.Notes14, D17.Notes15, D17.MarkQuantity, -D17.MarkQuantity as SignMarkQuantity,
	D17.CreditAccountID as InventoryAccountID,
    ISNULL(W89.S01ID,'') AS S01ID, ISNULL(W89.S02ID,'') AS S02ID, ISNULL(W89.S03ID,'') AS S03ID, ISNULL(W89.S04ID,'') AS S04ID, ISNULL(W89.S05ID,'') AS S05ID, 
	ISNULL(W89.S06ID,'') AS S06ID, ISNULL(W89.S07ID,'') AS S07ID, ISNULL(W89.S08ID,'') AS S08ID, ISNULL(W89.S09ID,'') AS S09ID, ISNULL(W89.S10ID,'') AS S10ID,
	ISNULL(W89.S11ID,'') AS S11ID, ISNULL(W89.S12ID,'') AS S12ID, ISNULL(W89.S13ID,'') AS S13ID, ISNULL(W89.S14ID,'') AS S14ID, ISNULL(W89.S15ID,'') AS S15ID, 
	ISNULL(W89.S16ID,'') AS S16ID, ISNULL(W89.S17ID,'') AS S17ID, ISNULL(W89.S18ID,'') AS S18ID, ISNULL(W89.S19ID,'') AS S19ID, ISNULL(W89.S20ID,'') AS S20ID,
	D17.LimitDate, D16.OrderID
FROM AT2017 AS D17 WITH (NOLOCK) 
INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID = D17.DivisionID 
LEFT JOIN WT8899 W89 WITH (NOLOCK) ON W89.DivisionID = D17.DivisionID AND W89.TransactionID = D17.TransactionID AND  W89.VoucherID = D17.VoucherID
WHERE ISNULL(CreditAccountID,'') <>''

UNION ALL  -- Nhap kho

SELECT  D07.DivisionID, D07.TranMonth, D07.TranYear,
	D06.WareHouseID, D07.InventoryID, D07.DebitAccountID, D07.CreditAccountID,
	'D' AS D_C,  --- Phat sinh No
	RefNo01 AS RefNo01, RefNo02, 	D07.Notes,
	D06.VoucherID, D06.VoucherDate, D06.VoucherNo, 
	D06.ObjectID,
	ActualQuantity AS SignQuantity, 
	ConvertedQuantity AS SignConvertedQuantity, 
	ConvertedAmount AS SignAmount,	
	D07.Ana01ID, D07.Ana02ID, D07.Ana03ID, D07.Ana04ID, D07.Ana05ID,
	D07.Ana06ID, D07.Ana07ID, D07.Ana08ID, D07.Ana09ID, D07.Ana10ID,
	D06.VoucherTypeID,
	CASE WHEN  KindVoucherID = 3 then 3 else 0 end AS KindVoucherID,
	D07.SourceNo,
	D07.ConvertedUnitID,
    D07.ProductID, D07.MOrderID,
    D06.Description AS VoucherDesc,
    D07.Parameter01, D07.Parameter02, D07.Parameter03, D07.Parameter04, D07.Parameter05,
	D07.Notes01, D07.Notes02, D07.Notes03, D07.Notes04, D07.Notes05, D07.Notes06, D07.Notes07, D07.Notes08,
	D07.Notes09, D07.Notes10, D07.Notes11, D07.Notes12, D07.Notes13, D07.Notes14, D07.Notes15, D07.MarkQuantity, D07.MarkQuantity as SignMarkQuantity,
	D07.DebitAccountID as InventoryAccountID,
    ISNULL(W89.S01ID,'') AS S01ID, ISNULL(W89.S02ID,'') AS S02ID, ISNULL(W89.S03ID,'') AS S03ID, ISNULL(W89.S04ID,'') AS S04ID, ISNULL(W89.S05ID,'') AS S05ID, 
	ISNULL(W89.S06ID,'') AS S06ID, ISNULL(W89.S07ID,'') AS S07ID, ISNULL(W89.S08ID,'') AS S08ID, ISNULL(W89.S09ID,'') AS S09ID, ISNULL(W89.S10ID,'') AS S10ID,
	ISNULL(W89.S11ID,'') AS S11ID, ISNULL(W89.S12ID,'') AS S12ID, ISNULL(W89.S13ID,'') AS S13ID, ISNULL(W89.S14ID,'') AS S14ID, ISNULL(W89.S15ID,'') AS S15ID, 
	ISNULL(W89.S16ID,'') AS S16ID, ISNULL(W89.S17ID,'') AS S17ID, ISNULL(W89.S18ID,'') AS S18ID, ISNULL(W89.S19ID,'') AS S19ID, ISNULL(W89.S20ID,'') AS S20ID,
	D07.LimitDate, D06.OrderID
    
FROM AT2007 AS D07 WITH (NOLOCK)
INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
LEFT JOIN WT8899 W89 WITH (NOLOCK) ON W89.DivisionID = D07.DivisionID AND W89.TransactionID = D07.TransactionID AND  W89.VoucherID = D07.VoucherID
WHERE D06.KindVoucherID in (1,3,5,7,9,15,17) AND Isnull(D06.TableID,'') <> 'AT0114' ------- Phiếu nhập bù của ANGEL

UNION ALL  -- xuat kho

SELECT  D07.DivisionID, D07.TranMonth, D07.TranYear,
	CASE WHEN D06.KindVoucherID = 3 then D06.WareHouseID2 Else  D06.WareHouseID End AS WareHouseID, 
	D07.InventoryID, D07.DebitAccountID, D07.CreditAccountID,
	'C' AS D_C,  --- So du Co
	RefNo01 AS RefNo01, RefNo02, 	D07.Notes,
	D06.VoucherID, D06.VoucherDate, D06.VoucherNo, 
	D06.ObjectID,
	-ActualQuantity AS SignQuantity, 
	-ConvertedQuantity AS SignConvertedQuantity, 
	-ConvertedAmount AS SignAmount,	
	D07.Ana01ID,D07.Ana02ID,D07.Ana03ID, D07.Ana04ID,D07.Ana05ID,
	D07.Ana06ID,D07.Ana07ID,D07.Ana08ID, D07.Ana09ID,D07.Ana10ID,
	D06.VoucherTypeID,
	CASE WHEN  KindVoucherID = 3 then 3 else 0 end AS KindVoucherID,
	D07.SourceNo,
	D07.ConvertedUnitID,
	D07.ProductID, D07.MOrderID,
	D06.Description AS VoucherDesc,
	D07.Parameter01, D07.Parameter02, D07.Parameter03, D07.Parameter04, D07.Parameter05,
	D07.Notes01, D07.Notes02, D07.Notes03, D07.Notes04, D07.Notes05, D07.Notes06, D07.Notes07, D07.Notes08,
	D07.Notes09, D07.Notes10, D07.Notes11, D07.Notes12, D07.Notes13, D07.Notes14, D07.Notes15, D07.MarkQuantity, -D07.MarkQuantity as SignMarkQuantity,
	D07.CreditAccountID as InventoryAccountID,
	ISNULL(W89.S01ID,'') AS S01ID, ISNULL(W89.S02ID,'') AS S02ID, ISNULL(W89.S03ID,'') AS S03ID, ISNULL(W89.S04ID,'') AS S04ID, ISNULL(W89.S05ID,'') AS S05ID, 
	ISNULL(W89.S06ID,'') AS S06ID, ISNULL(W89.S07ID,'') AS S07ID, ISNULL(W89.S08ID,'') AS S08ID, ISNULL(W89.S09ID,'') AS S09ID, ISNULL(W89.S10ID,'') AS S10ID,
	ISNULL(W89.S11ID,'') AS S11ID, ISNULL(W89.S12ID,'') AS S12ID, ISNULL(W89.S13ID,'') AS S13ID, ISNULL(W89.S14ID,'') AS S14ID, ISNULL(W89.S15ID,'') AS S15ID, 
	ISNULL(W89.S16ID,'') AS S16ID, ISNULL(W89.S17ID,'') AS S17ID, ISNULL(W89.S18ID,'') AS S18ID, ISNULL(W89.S19ID,'') AS S19ID, ISNULL(W89.S20ID,'') AS S20ID,
	D07.LimitDate, D06.OrderID

From AT2007 AS D07 WITH (NOLOCK)
INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
LEFT JOIN WT8899 W89 WITH (NOLOCK) ON W89.DivisionID = D07.DivisionID AND W89.TransactionID = D07.TransactionID AND  W89.VoucherID = D07.VoucherID
Where D06.KindVoucherID in (2,3,4,6,8,10,14,20)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
