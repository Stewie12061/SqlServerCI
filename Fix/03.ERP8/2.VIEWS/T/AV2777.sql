IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV2777]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV2777]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---Thuy Tuyen
---date 13/12/2006
---Lay du lieu so du (Detail)
---- Modified by Bảo Thy on 26/04/2017: Bổ sung 20 trường quy cách
---- Modified by Hải Long on 10/07/2017: Bổ sung 5 tham số Parameter01 - Parameter05
---- Modified by Nhựt Trường on 08/09/2023: 2023/08/IS/0335, Bổ sung ConvertedQuantity, ConvertedUnitID.

CREATE VIEW [dbo].[AV2777]
as
Select 
AT2017.TransactionID, AT2017.VoucherID, '' as BatchID, InventoryID, UnitID, 
ActualQuantity, UnitPrice, OriginalAmount, ConvertedAmount,
 Notes, TranMonth, TranYear, AT2017.DivisionID, CurrencyID, ExchangeRate,
 SaleUnitPrice, SaleAmount, DiscountAmount, SourceNo, '' AS WarrantyNo, '' AS ShelvesID, '' AS ShelvesName, '' AS FloorID, '' AS FloorName, DebitAccountID, CreditAccountID,
 LocationID, ImLocationID, LimitDate, Orders,
 ConversionFactor, ReTransactionID, ReVoucherID, Ana01ID, Ana02ID, Ana03ID,  '' as PeriodID, 
 '' as ProductID, '' as OrderID, '' as InventoryName1,
ISNULL(W89.S01ID,'') AS S01ID, ISNULL(W89.S02ID,'') AS S02ID, ISNULL(W89.S03ID,'') AS S03ID, ISNULL(W89.S04ID,'') AS S04ID, ISNULL(W89.S05ID,'') AS S05ID, 
ISNULL(W89.S06ID,'') AS S06ID, ISNULL(W89.S07ID,'') AS S07ID, ISNULL(W89.S08ID,'') AS S08ID, ISNULL(W89.S09ID,'') AS S09ID, ISNULL(W89.S10ID,'') AS S10ID,
ISNULL(W89.S11ID,'') AS S11ID, ISNULL(W89.S12ID,'') AS S12ID, ISNULL(W89.S13ID,'') AS S13ID, ISNULL(W89.S14ID,'') AS S14ID, ISNULL(W89.S15ID,'') AS S15ID, 
ISNULL(W89.S16ID,'') AS S16ID, ISNULL(W89.S17ID,'') AS S17ID, ISNULL(W89.S18ID,'') AS S18ID, ISNULL(W89.S19ID,'') AS S19ID, ISNULL(W89.S20ID,'') AS S20ID,
AT2017.Parameter01, AT2017.Parameter02, AT2017.Parameter03, AT2017.Parameter04, AT2017.Parameter05, AT2017.ConvertedQuantity, AT2017.ConvertedUnitID
From AT2017
LEFT JOIN WT8899 W89 WITH (NOLOCK) ON  W89.VoucherID = AT2017.VoucherID AND W89.TransactionID = AT2017.TransactionID AND W89.DivisionID = AT2017.DivisionID
union
Select 
AT2007.TransactionID, AT2007.VoucherID, BatchID, InventoryID, UnitID, 
ActualQuantity, UnitPrice, OriginalAmount, ConvertedAmount,
 Notes, TranMonth, TranYear, AT2007.DivisionID, CurrencyID, ExchangeRate,
 SaleUnitPrice, SaleAmount, DiscountAmount, SourceNo, AT2007.WarrantyNo, W69.ShelvesID, W69.ShelvesName, W70.FloorID, W70.FloorName, DebitAccountID, CreditAccountID,
 LocationID, ImLocationID, LimitDate, Orders,
 ConversionFactor, ReTransactionID, ReVoucherID, Ana01ID, Ana02ID, Ana03ID, PeriodID, 
ProductID, OrderID, InventoryName1,
ISNULL(W89.S01ID,'') AS S01ID, ISNULL(W89.S02ID,'') AS S02ID, ISNULL(W89.S03ID,'') AS S03ID, ISNULL(W89.S04ID,'') AS S04ID, ISNULL(W89.S05ID,'') AS S05ID, 
ISNULL(W89.S06ID,'') AS S06ID, ISNULL(W89.S07ID,'') AS S07ID, ISNULL(W89.S08ID,'') AS S08ID, ISNULL(W89.S09ID,'') AS S09ID, ISNULL(W89.S10ID,'') AS S10ID,
ISNULL(W89.S11ID,'') AS S11ID, ISNULL(W89.S12ID,'') AS S12ID, ISNULL(W89.S13ID,'') AS S13ID, ISNULL(W89.S14ID,'') AS S14ID, ISNULL(W89.S15ID,'') AS S15ID, 
ISNULL(W89.S16ID,'') AS S16ID, ISNULL(W89.S17ID,'') AS S17ID, ISNULL(W89.S18ID,'') AS S18ID, ISNULL(W89.S19ID,'') AS S19ID, ISNULL(W89.S20ID,'') AS S20ID,
AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05, AT2007.ConvertedQuantity, AT2007.ConvertedUnitID
From AT2007
LEFT JOIN WT8899 W89 WITH (NOLOCK) ON  W89.VoucherID = AT2007.VoucherID AND W89.TransactionID = AT2007.TransactionID AND W89.DivisionID = AT2007.DivisionID
LEFT JOIN WT0169 W69 WITH (NOLOCK) ON  W69.ShelvesID = AT2007.ShelvesID
LEFT JOIN WT0170 W70 WITH (NOLOCK) ON  W70.FloorID = AT2007.FloorID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
