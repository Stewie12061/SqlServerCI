IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV3121]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV3121]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

------ Created by Nguyễn Văn Tài.
------ Created Date 30/06/2021.
------ Purpose: View động, fix tạo trước khi chạy fix.
------ Modified by Đức Duy on 17/02/2023: [2023/02/IS/0091] -  Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE view AV3121 -- tao boi AP3122  
    as   
 Select   V1.SelectionID as  Group1ID,   
  V1.SelectionName as Group1Name,  V2.SelectionID as  Group2ID,   
  V2.SelectionName as Group2Name,  V3.SelectionID as  Group3ID,   
  V3.SelectionName as Group3Name,   
     
  AV4301.InventoryID as InvID, T02.InventoryName, T34.UnitName, 
  AV4301.VoucherDate, AV4301.VoucherNo,
  AV4301.UnitPrice,   AV4301.PaymentTermID, AT1208.PaymentTermName,
  AV4301.Ana01ID, AV4301.Ana02ID, AV4301.Ana03ID, AV4301.Ana04ID, AV4301.Ana05ID,  
  AV4301.AnaName01,AV4301.AnaName02,AV4301.AnaName03,AV4301.AnaName04,AV4301.AnaName05,  
  AV4301.I01ID, AV4301.I02ID, AV4301.I03ID, AV4301.I04ID, AV4301.I05ID,   
  AV4301.O01ID, AV4301.O02ID, AV4301.O03ID, AV4301.O04ID, AV4301.O05ID,   
  isnull(CommissionPercent,0) as CommissionPercent, isnull(AV4301.DiscountRate,0) as DiscountRate ,  
  AV4301.InvoiceDate, AV4301.Serial, AV4301.InvoiceNo, AV4301.Description, AV4301.VATTypeID, AV4301.VATRate,     
  sum(Case when TransactionTypeID in ('T04','T40') then isnull(AV4301.Quantity,0) else - isnull(AV4301.Quantity,0) End) as Quantity,  
  
  Cast( sum(Case when TransactionTypeID in ('T04','T40') then isnull(AV4301.Quantity,0) else - isnull(AV4301.Quantity,0) End) as int)/ CASE WHEN ISNULL(T19.ConversionFactor,0) = 0 THEN 1 ELSE T19.ConversionFactor END as ConvertQuantity,  
  
  cast ( sum(Case when TransactionTypeID in ('T04','T40') then isnull(AV4301.Quantity,0) else - isnull(AV4301.Quantity,0) End) as int) %  CASE WHEN ISNULL(T19.ConversionFactor,0) = 0 THEN 1 ELSE T19.ConversionFactor END  as ConvertQuantity1,  
  Isnull(T19.ConversionFactor,1) as  ConversionFactor ,  
  T34C.UnitName as UnitNameC,   
  
  sum( Case when  TransactionTypeID in ('T04','T40')  then isnull(AV4301.OriginalAmount,0) else - isnull(AV4301.OriginalAmount,0) End )/1 as OriginalAmount,  
  sum(Case when  TransactionTypeID in ('T04','T40')  then isnull(AV4301.ConvertedAmount,0) else -  isnull(AV4301.ConvertedAmount,0) End)/1 as ConvertedAmount,  
  sum(Case when  TransactionTypeID in ('T04','T40')  then isnull(GV.OriginalAmount,0) else  -isnull(GV.OriginalAmount,0) End )/1 as GVOriginalAmount,  
  sum(Case when  TransactionTypeID in ('T04','T40')  then isnull(GV.ConvertedAmount,0) Else - isnull(GV.ConvertedAmount,0) End)/1 as GVConvertedAmount,  
  sum(Case when  TransactionTypeID in ('T04','T40')  then isnull(GV1.OriginalAmount,0) else  -isnull(GV1.OriginalAmount,0) End )/1 as GV1OriginalAmount,  
  sum(Case when  TransactionTypeID in ('T04','T40')  then isnull(GV1.ConvertedAmount,0) Else - isnull(GV1.ConvertedAmount,0) End)/1 as GV1ConvertedAmount,  
  avg(isnull(GV.UnitPrice,0))/1 as GVUnitPrice,  gv.SourceNo,AV4301.DivisionID,
  SUM(ISNULL(AV4301.VATConvertedAmount, 0)) / 1 AS VATConvertedAmount,
  MAX(AV4301.O01Name) AS O01Name,
  Max(AV4301.CO3ID) as CO3ID,
  Max(AV4301.I01Name) AS I01Name,
  Max(AV4301.InventoryTypeName) AS InventoryTypeName,
  GV1.UnitPrice as GV1UnitPrice,
  GV1.ActualQuantity as GV1ActualQuantity,
  A06.VoucherNo as GV1VoucherNo,
  T02.Varchar01, T02.ETaxConvertedUnit,AV4301.ObjectID, AV4301.ObjectName, AT1202.Address,
  AV4301.S01ID, AV4301.S02ID, AV4301.S03ID, AV4301.S04ID, AV4301.S05ID, AV4301.S06ID, AV4301.S07ID, AV4301.S08ID, AV4301.S09ID, AV4301.S10ID,
  AV4301.S11ID, AV4301.S12ID, AV4301.S13ID, AV4301.S14ID, AV4301.S15ID, AV4301.S16ID, AV4301.S17ID, AV4301.S18ID, AV4301.S19ID, AV4301.S20ID 
 From AV4301   left join  AV6666 V1 on  V1.SelectionType ='A04' and V1.DivisionID IN (AV4301.DivisionID,'@@@') and  
     V1.SelectionID = AV4301.Ana04ID  
       left join  AV6666 V2 on  V2.SelectionType ='A06' and V2.DivisionID IN (AV4301.DivisionID,'@@@') and  
     V2.SelectionID = AV4301.Ana06ID  
       left join  AV6666 V3 on  V3.SelectionType ='OB' and V3.DivisionID IN (AV4301.DivisionID,'@@@') and  
     V3.SelectionID = AV4301.ObjectID  
       
  left join AT1302 as T02 WITH (NOLOCK) on T02.InventoryID = AV4301.InventoryID
  left join AT1208 WITH (NOLOCK) on AT1208.PaymentTermID = AV4301.PaymentTermID   
  left join AT2007 as GV WITH (NOLOCK) on (GV.VoucherID = AV4301.VoucherID and GV.TransactionID = AV4301.TransactionID) and GV.DivisionID = AV4301.DivisionID  
  left join AT2007 as GV1 WITH (NOLOCK) on (GV1.VoucherID = AV4301.WOrderID and GV1.TransactionID = AV4301.WTransactionID)  and  GV1.DivisionID = AV4301.DivisionID   
      --and GV.TableID = 'AT2006') 
  left join AT2006 as A06 WITH (NOLOCK) ON GV1.DivisionID = A06.DivisionID  AND GV1.VoucherID = A06.VoucherID 
  left join AT1304 as T34 WITH (NOLOCK) on T34.UnitID = AV4301.UnitID
  left join AT1309 as T19 WITH (NOLOCK) on  T19.Orders = 1 and T19.InventoryID = AV4301.InventoryID
  left join AT1304 as T34C WITH (NOLOCK) on T34C.UnitID = T19.UnitID
  LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (AV4301.DivisionID, '@@@') AND AV4301.ObjectID = AT1202.ObjectID  Where AV4301.DivisionID = 'HCM' and   
  --T02.IsStocked = 1 and  
  AV4301.VoucherDate between '01/13/2021' and '01/13/2021' and  
  AV4301.TransactionTypeID  in ( 'T04', 'T40')     
   and AV4301.D_C = 'D'  
  
 Group by    V1.SelectionID,  V1.SelectionName,  V2.SelectionID,  V2.SelectionName,  V3.SelectionID,  V3.SelectionName,   
  AV4301.InventoryID, T02.InventoryName, T34.UnitName, AV4301.VoucherDate, AV4301.VoucherNo, AV4301.UnitPrice,AV4301.PaymentTermID,AT1208.PaymentTermName,
  AV4301.Ana01ID, AV4301.Ana02ID, AV4301.Ana03ID, AV4301.Ana04ID, AV4301.Ana05ID,  
  AV4301.AnaName01,AV4301.AnaName02,AV4301.AnaName03,AV4301.AnaName04,AV4301.AnaName05,  
  AV4301.I01ID, AV4301.I02ID, AV4301.I03ID, AV4301.I04ID, AV4301.I05ID,   
  AV4301.O01ID, AV4301.O02ID, AV4301.O03ID, AV4301.O04ID, AV4301.O05ID,   
  CommissionPercent, AV4301.DiscountRate,  AV4301.VATTypeID,AV4301.VATRate,  
  AV4301.InvoiceDate, AV4301.Serial, AV4301.InvoiceNo, AV4301.Description,   T19.ConversionFactor, T34C.UnitName , gv.SourceNo, AV4301.DivisionID,
  GV1.UnitPrice, GV1.ActualQuantity,
  A06.VoucherNo, T02.Varchar01, T02.ETaxConvertedUnit,AV4301.ObjectID, AV4301.ObjectName, AT1202.Address,
  AV4301.S01ID, AV4301.S02ID, AV4301.S03ID, AV4301.S04ID, AV4301.S05ID, AV4301.S06ID, AV4301.S07ID, AV4301.S08ID, AV4301.S09ID, AV4301.S10ID,
  AV4301.S11ID, AV4301.S12ID, AV4301.S13ID, AV4301.S14ID, AV4301.S15ID, AV4301.S16ID, AV4301.S17ID, AV4301.S18ID, AV4301.S19ID, AV4301.S20ID
   


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO