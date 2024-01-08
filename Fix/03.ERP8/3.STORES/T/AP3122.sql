		IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3122]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP3122]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--Created by Nguyen Thi Ngoc Minh	
--Date :20/05/2004
--Purpose: Bao cao ban hang theo ma phan tich - chi tiet tung hoa don
---Last Edit: 07/05/2009 Nguyen Thi Thuy Tuyen , 
---- Modified ON 09/03/2012 by Lê Thị Thu Hiền : Sửa /(T19.ConversionFactor,0)
---- Modified ON 09/03/2012 by Lê Thị Thu Hiền : Mantis 0019908 Bỏ IsStocked = 1
---- Modified by To Oanh: Bo sung PaymentTermID (khach hang tatung ngay 02/08/2013)
---- Modified by Thanh Sơn on 14/10/2013: theo bug(0021588- KINGCOM)
---- Modified by Bảo Anh on 18/06/2014: Cắt chuỗi @sSQL sang @sSQL0
---- Modified by Mai Duyen on 31/12/2013: Bổ sung lấy thêm cột InventoryTypeName,I01Name (khách hàng VIMEC)
---- Modified by Tiểu Mai on 30/06/2016: Bổ sung GV1.UnitPrice,GV1.ActualQuantity,A06.VoucherNo
---- Modified by Tiểu Mai on 07/07/2016: Bổ sung trường T02.Varchar01, T02.ETaxConvertedUnit
---- Modified by Bảo Thy on 08/05/2017: Sửa danh mục dùng chung
---- Modified by Bảo Thy on 06/07/2017: Bổ sung AT1202.ObjectName, AT1202.Address, VATConvertedAmount
---- Modified by Kim Thư on 01/11/2018: Sửa in theo ngày lấy doanh thu hàng bán trả lại (T24)
---- Modified by Kim Thư on 11/03/2019: Sửa kết bảng AT1309 bổ sung thêm kết UnitID - sửa lỗi double dòng
---- Modified by Hoàng Trúc on 10/09/2019: bổ sung trường RefInfor 
---- Modified by Huỳnh Thử on 24/04/2020: Lấy Thêm Trường PayVoucherID ( Bổ sung trường Ngày thanh toán hóa đơn PayDate)
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Huỳnh Thử on 02/07/2021: Cải thiệt tốc độ.
---- Modified by Nhựt Trường on 26/04/2022: Bổ sung trường WarehouseName.
---- Modified by Nhựt Trường on 27/06/2022: [2022/05/IS/0189] - Điều chỉnh thay left cho inner khi join bảng AT1303.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Đình Định on 03/07/2023: Bổ sung WareHouseID.
---- Modified by Xuân Nguyên on 11/08/2023: [2023/08/IS/0140] Bổ sung điều kiện DivisionID dùng chung khi join AV6666
---- Modified by Hoàng Long on 15/11/2023: [2023/11/TA/0118] - Bổ sung báo cáo chi tiết số lượng hàng bán.
/********************************************
'* Edited by: [GS] [Tố Oanh] [29/07/2010]
'********************************************/
---- 

CREATE PROCEDURE [dbo].[AP3122] 
  @DivisionID as nvarchar(50),  
    @Group1 as nvarchar(50),  
    @IsFilter1 as tinyint,  
    @Filter1 as nvarchar(50),  
    @Group1From as nvarchar(50),  
    @Group1To as nvarchar(50),      
    @Group2 as nvarchar(50),  
    @IsFilter2 as tinyint,  
    @Filter2 as nvarchar(50),  
    @Group2From as nvarchar(50),  
    @Group2To as nvarchar(50),  
    @Group3 as nvarchar(50),  
    @IsFilter3 as tinyint,  
    @Filter3 as nvarchar(50),  
    @Group3From as nvarchar(50),  
    @Group3To as nvarchar(50),
	@Group4 as nvarchar(50),  
    @IsFilter4 as tinyint,  
    @Filter4 as nvarchar(50),  
    @Group4From as nvarchar(50),  
    @Group4To as nvarchar(50),
    @FromInventoryID as nvarchar(50),  
    @ToInventoryID as nvarchar(50),  
    @FromInventoryTypeID as nvarchar(50),  
    @ToInventoryTypeID as nvarchar(50),  
    @FromDate as datetime,  
    @ToDate as datetime,  
    @FromMonth as int,  
    @FromYear as int,  
    @ToMonth as int,  
    @ToYear as int,  
    @IsMonth as tinyint,  
    @AmountUnit as int,  
    @IsDebit as tinyint  
AS  
  
DECLARE  @sSQL as nvarchar(4000),
  @sSQL0 as nvarchar(4000),	
  @sSQL1 as nvarchar(4000),  
  @sWHERE as nvarchar(500),  
  @sSELECT as nvarchar(500),  
  @sGROUPBY as nvarchar(500),  
  @PeriodFrom as int,  
  @PeriodTo as int,  
  @ConversionAmountUnit as int,  
  @GroupName1 as nvarchar(250),  
  @GroupName2 as nvarchar(250),  
  @GroupName3 as nvarchar(250),
  @GroupName4 as nvarchar(250),
  @Filter1ID as nvarchar(250),  
  @Filter2ID as nvarchar(250),  
  @Filter3ID as nvarchar(250),
  @Filter4ID as nvarchar(250),
  @Field1ID as nvarchar(50),  
  @Field2ID as nvarchar(50),  
  @Field3ID as nvarchar(50),
  @Field4ID as nvarchar(50)
  
  
IF @AmountUnit = 0  
 SET @ConversionAmountUnit =1  
IF @AmountUnit = 1  
 SET @ConversionAmountUnit =1000  
IF @AmountUnit = 2  
 SET @ConversionAmountUnit =1000000  
  
Set @PeriodFrom = @FromMonth + @FromYear*100  
Set @PeriodTo = @ToMonth + @ToYear*100  
  
SET @sSQL = '
SELECT AT9000.VoucherID ,A2.VoucherID AS TVoucherID,A2.VoucherDate  AS TVoucherDate
FROM AT9000 WITH (NOLOCK)
LEFT JOIN dbo.AT9000 A2 WITH (NOLOCK) ON A2.TVoucherID = AT9000.VoucherID
WHERE	AT9000.DivisionID =  ''' + @DivisionID + '''  
		AND AT9000.TransactionTypeID in  (''T04'',  ''T24'', ''T40'') 
		AND ISNULL(A2.VoucherID,'''') <> '''' AND 

'
IF @IsMonth = 0
    SET @sSQL = @sSQL + ' CONVERT(DATETIME,CONVERT(VARCHAR(10),AT9000.VoucherDate,101),101) BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate, 101) + ''' '
ELSE
    SET @sSQL = @sSQL + ' AT9000.TranMonth + AT9000.TranYear * 100 BETWEEN ' + STR(@FromMonth) + '+ 100 * ' + STR(@FromYear) + ' AND ' + STR(@ToMonth) + ' + 100 * ' + STR(@ToYear) + '  '


IF NOT EXISTS (SELECT TOP 1 1 FROM   SysObjects WHERE  NAME = 'AV3122' AND Xtype = 'V')
    EXEC ('CREATE VIEW AV3122 -- tao boi AP3122     
        AS ' + @sSQL)
ELSE
    EXEC ('ALTER VIEW AV3122 -- tao boi AP3122
		AS ' + @sSQL)
----------------------------------------------

If @Group1 != ''  
Exec AP4700  @Group1, @Field1ID OUTPUT  
  
If @Group2 != ''  
Exec AP4700  @Group2, @Field2ID OUTPUT  
  
If @Group3 != ''  
Exec AP4700  @Group3, @Field3ID OUTPUT  

If @Group4 != ''  
Exec AP4700  @Group4, @Field4ID OUTPUT
  
Set @sWHERE = ''  
Set @sSELECT = ''  
Set @sGROUPBY = ''  
  
If @IsDebit = 1  
 SET @sWHERE = @sWHERE + ' AV4301.D_C = ''D'''  
Else  
 SET @sWHERE = @sWHERE + ' AV4301.D_C = ''C'''  
  
If @IsFilter1 = 1  
  Begin  
 Exec AP4700  @Filter1, @Filter1ID OUTPUT  
 SET @sWHERE = @sWHERE + ' and   
     (AV4301.' + @Filter1ID + ' between ''' + @Group1From + ''' and ''' + @Group1To + ''') '  
 SET @sSELECT = @sSELECT +' AV4301.' + @Filter1ID + ' as Filter1, '  
 SET @sGROUPBY = @sGROUPBY +', AV4301.' + @Filter1ID    
  End  
  
If @IsFilter2 = 1  
  Begin  
 Exec AP4700  @Filter2, @Filter2ID OUTPUT  
 SET @sWHERE = @sWHERE + ' and   
     (AV4301.' + @Filter2ID + ' between ''' + @Group2From + ''' and ''' + @Group2To + ''') '  
 SET @sSELECT = @sSELECT +' AV4301.' + @Filter2ID + ' as Filter2, '  
 SET @sGROUPBY = @sGROUPBY +', AV4301.' + @Filter2ID  
  End  
  
If @IsFilter3 = 1  
  Begin  
 Exec AP4700  @Filter3, @Filter3ID OUTPUT  
 SET @sWHERE = @sWHERE + ' and   
     (AV4301.' + @Filter3ID + ' between ''' + @Group3From + ''' and ''' + @Group3To + ''') '  
 SET @sSELECT = @sSELECT +' AV4301.' + @Filter3ID + ' as Filter3, '  
 SET @sGROUPBY = @sGROUPBY +', AV4301.' + @Filter3ID   
  End  

If @IsFilter4 = 1  
  Begin  
 Exec AP4700  @Filter4, @Filter4ID OUTPUT  
 SET @sWHERE = @sWHERE + ' and   
     (AV4301.' + @Filter4ID + ' between ''' + @Group4From + ''' and ''' + @Group4To + ''') '  
 SET @sSELECT = @sSELECT +' AV4301.' + @Filter4ID + ' as Filter4, '  
 SET @sGROUPBY = @sGROUPBY +', AV4301.' + @Filter4ID   
  End 
  
If @IsMonth  = 0  
Begin  
  
  Set @sSQL='  
 Select  ' + (Case when @Group1 != '' then ' V1.SelectionID as  Group1ID,   
  V1.SelectionName as Group1Name, ' else '' end)   
  + (Case when @Group2 != '' then ' V2.SelectionID as  Group2ID,   
  V2.SelectionName as Group2Name, ' else '' end)
  + (Case when @Group3 != '' then ' V3.SelectionID as  Group3ID,   
  V3.SelectionName as Group3Name, ' else '' end)
   + (Case when @Group4 != '' then ' V4.SelectionID as  Group4ID,   
  V4.SelectionName as Group4Name, ' else '' end) + '  
  ' + @sSELECT +  '   
  AV4301.InventoryID as InvID, T02.InventoryName, T34.UnitName, 
  AV4301.VoucherDate, AV4301.VoucherNo,
  AV4301.UnitPrice,   AV4301.PaymentTermID, AT1208.PaymentTermName,
  AV4301.Ana01ID, AV4301.Ana02ID, AV4301.Ana03ID, AV4301.Ana04ID, AV4301.Ana05ID,  
  AV4301.AnaName01,AV4301.AnaName02,AV4301.AnaName03,AV4301.AnaName04,AV4301.AnaName05,  
  AV4301.I01ID, AV4301.I02ID, AV4301.I03ID, AV4301.I04ID, AV4301.I05ID,   
  AV4301.O01ID, AV4301.O02ID, AV4301.O03ID, AV4301.O04ID, AV4301.O05ID,   
  isnull(CommissionPercent,0) as CommissionPercent, isnull(AV4301.DiscountRate,0) as DiscountRate ,  
  AV4301.InvoiceDate, AV4301.Serial, AV4301.InvoiceNo, AV4301.Description, AV4301.VATTypeID, AV4301.VATRate,     
  sum(Case when TransactionTypeID in (''T04'',''T40'') then isnull(AV4301.Quantity,0) else - isnull(AV4301.Quantity,0) End) as Quantity,  
  
  Cast( sum(Case when TransactionTypeID in (''T04'',''T40'') then isnull(AV4301.Quantity,0) else - isnull(AV4301.Quantity,0) End) as int)/ CASE WHEN ISNULL(T19.ConversionFactor,0) = 0 THEN 1 ELSE T19.ConversionFactor END as ConvertQuantity,  
  
  cast ( sum(Case when TransactionTypeID in (''T04'',''T40'') then isnull(AV4301.Quantity,0) else - isnull(AV4301.Quantity,0) End) as int) %  CASE WHEN ISNULL(T19.ConversionFactor,0) = 0 THEN 1 ELSE T19.ConversionFactor END  as ConvertQuantity1,  
  Isnull(T19.ConversionFactor,1) as  ConversionFactor ,  
  T34C.UnitName as UnitNameC,   
  
  sum( Case when  TransactionTypeID in (''T04'',''T40'')  then isnull(AV4301.OriginalAmount,0) else - isnull(AV4301.OriginalAmount,0) End )/' + ltrim(rtrim(str(@ConversionAmountUnit))) + ' as OriginalAmount,  
  sum(Case when  TransactionTypeID in (''T04'',''T40'')  then isnull(AV4301.ConvertedAmount,0) else -  isnull(AV4301.ConvertedAmount,0) End)/' + ltrim(rtrim(str(@ConversionAmountUnit))) + ' as ConvertedAmount,  
  sum(Case when  TransactionTypeID in (''T04'',''T40'')  then isnull(GV.OriginalAmount,0) else  -isnull(GV.OriginalAmount,0) End )/' + ltrim(rtrim(str(@ConversionAmountUnit))) + ' as GVOriginalAmount,  
  sum(Case when  TransactionTypeID in (''T04'',''T40'')  then isnull(GV.ConvertedAmount,0) Else - isnull(GV.ConvertedAmount,0) End)/' + ltrim(rtrim(str(@ConversionAmountUnit))) + ' as GVConvertedAmount,  
  sum(Case when  TransactionTypeID in (''T04'',''T40'')  then isnull(GV1.OriginalAmount,0) else  -isnull(GV1.OriginalAmount,0) End )/' + ltrim(rtrim(str(@ConversionAmountUnit))) + ' as GV1OriginalAmount,  
  sum(Case when  TransactionTypeID in (''T04'',''T40'')  then isnull(GV1.ConvertedAmount,0) Else - isnull(GV1.ConvertedAmount,0) End)/' + ltrim(rtrim(str(@ConversionAmountUnit))) + ' as GV1ConvertedAmount,  
  avg(isnull(GV.UnitPrice,0))/' + ltrim(rtrim(str(@ConversionAmountUnit))) + ' as GVUnitPrice,  gv.SourceNo,AV4301.DivisionID,
  SUM(ISNULL(AV4301.VATConvertedAmount, 0)) / ' + LTRIM(RTRIM(STR(@ConversionAmountUnit)))+ ' AS VATConvertedAmount,
  MAX(AV4301.O01Name) AS O01Name,
  Max(AV4301.CO3ID) as CO3ID,
  Max(AV4301.I01Name) AS I01Name,
  Max(AV4301.InventoryTypeName) AS InventoryTypeName,
  GV1.UnitPrice as GV1UnitPrice,
  GV1.ActualQuantity as GV1ActualQuantity,
  A06.VoucherNo as GV1VoucherNo,
  T02.Varchar01, T02.ETaxConvertedUnit,AV4301.ObjectID, AV4301.ObjectName, AT1202.Address, AT1202.Tel,AV4301.RefInfor, MAX(TVoucherDate) as  PayDate,
  AT1303.WareHouseID, AT1303.WareHouseName, AT8899.S01ID,AT8899.S02ID,AT8899.S03ID, AT8899.S04ID,AT8899.S05ID,AT8899.S06ID,AT8899.S07ID,AT8899.S08ID,AT8899.S09ID,AT8899.S10ID,AT8899.S11ID,AT8899.S12ID,AT8899.S13ID,AT8899.S14ID,AT8899.S15ID,AT8899.S16ID,AT8899.S17ID,AT8899.S18ID,AT8899.S19ID,AT8899.S20ID' 
  
 Set @sSQL0 = '
 From AV4301 ' + (Case when @Group1 != '' then '  left join  AV6666 V1 on  V1.SelectionType ='''+@Group1+''' and V1.DivisionID  IN ('''+@DivisionID+''', ''@@@'')  and  
     V1.SelectionID = AV4301.'+ @Field1ID +'  
     ' else '' end) +   
   
     (Case when @Group2 != '' then '  left join  AV6666 V2 on  V2.SelectionType ='''+@Group2+''' and V2.DivisionID  IN ('''+@DivisionID+''', ''@@@'')  and  
     V2.SelectionID = AV4301.'+ @Field2ID +'  
     ' else '' end) +   

	 (Case when @Group3 != '' then '  left join  AV6666 V3 on  V3.SelectionType ='''+@Group3+''' and V3.DivisionID  IN ('''+@DivisionID+''', ''@@@'')  and  
     V3.SelectionID = AV4301.'+ @Field3ID +'  
     ' else '' end) + 
  
     (Case when @Group4 != '' then '  left join  AV6666 V4 on  V4.SelectionType ='''+@Group4+''' and V4.DivisionID  IN ('''+@DivisionID+''', ''@@@'')  and  
     V4.SelectionID = AV4301.'+ @Field4ID +'  
     ' else '' end) + '  
  LEFT JOIN AV3122 WITH (NOLOCK) ON AV3122.TVoucherID = AV4301.VoucherID
  left join AT1302 as T02 WITH (NOLOCK) on T02.DivisionID IN (AV4301.DivisionID,''@@@'') AND T02.InventoryID = AV4301.InventoryID
  left join AT1208 WITH (NOLOCK) on AT1208.PaymentTermID = AV4301.PaymentTermID   
  left join AT2007 as GV WITH (NOLOCK) on (GV.VoucherID = AV4301.VoucherID and GV.TransactionID = AV4301.TransactionID) and GV.DivisionID = AV4301.DivisionID  
  left join AT2007 as GV1 WITH (NOLOCK) on (GV1.VoucherID = AV4301.WOrderID and GV1.TransactionID = AV4301.WTransactionID)  and  GV1.DivisionID = AV4301.DivisionID   
      --and GV.TableID = ''AT2006'') 
  left join AT2006 as A06 WITH (NOLOCK) ON GV1.DivisionID = A06.DivisionID  AND GV1.VoucherID = A06.VoucherID 
  Left JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (A06.DivisionID,''@@@'') AND AT1303.WarehouseID = A06.WarehouseID
  left join AT1304 as T34 WITH (NOLOCK) on T34.UnitID = AV4301.UnitID
  left join AT1309 as T19 WITH (NOLOCK) on  T19.Orders = 1 and T19.InventoryID = AV4301.InventoryID and T19.UnitID = T34.UnitID
  left join AT1304 as T34C WITH (NOLOCK) on T34C.UnitID = T19.UnitID
  LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AV4301.ObjectID = AT1202.ObjectID
  LEFT JOIN AT8899 WITH (NOLOCK) ON AT8899.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AV4301.TransactionID = AT8899.TransactionID'  
  
Set @sSQL1 =' Where AV4301.DivisionID = ''' + @DivisionID + ''' and   
  --T02.IsStocked = 1 and  
  AV4301.VoucherDate between ''' + convert(nvarchar(10),@FromDate,101)  + ''' and ''' + convert(nvarchar(10),@ToDate,101) + ''' and  
  (AV4301.InventoryID between ''' + @FromInventoryID + ''' and ''' + @ToInventoryID + ''') and  
  (T02.InventoryTypeID between ''' + @FromInventoryTypeID + ''' and ''' + @ToInventoryTypeID + ''')  and  
  AV4301.TransactionTypeID  in ( ''T04'', ''T24'', ''T40'')   and  
  ' + @sWHERE + '  
  
 Group by   ' + (Case when @Group1 != '' then ' V1.SelectionID,  V1.SelectionName, ' else '' end) +  
  (Case when @Group2 != '' then ' V2.SelectionID,  V2.SelectionName, ' else '' end) +  
  (Case when @Group3 != '' then ' V3.SelectionID,  V3.SelectionName, ' else '' end) + 
  (Case when @Group4 != '' then ' V4.SelectionID,  V4.SelectionName, ' else '' end) +'  
  AV4301.InventoryID, T02.InventoryName, T34.UnitName, AV4301.VoucherDate, AV4301.VoucherNo, AV4301.UnitPrice,AV4301.PaymentTermID,AT1208.PaymentTermName,
  AV4301.Ana01ID, AV4301.Ana02ID, AV4301.Ana03ID, AV4301.Ana04ID, AV4301.Ana05ID,  
  AV4301.AnaName01,AV4301.AnaName02,AV4301.AnaName03,AV4301.AnaName04,AV4301.AnaName05,  
  AV4301.I01ID, AV4301.I02ID, AV4301.I03ID, AV4301.I04ID, AV4301.I05ID,   
  AV4301.O01ID, AV4301.O02ID, AV4301.O03ID, AV4301.O04ID, AV4301.O05ID,   
  CommissionPercent, AV4301.DiscountRate,  AV4301.VATTypeID,AV4301.VATRate,  
  AV4301.InvoiceDate, AV4301.Serial, AV4301.InvoiceNo, AV4301.Description,   T19.ConversionFactor, T34C.UnitName , gv.SourceNo, AV4301.DivisionID,
  GV1.UnitPrice, GV1.ActualQuantity,AT8899.S01ID,AT8899.S02ID,AT8899.S03ID, AT8899.S04ID,AT8899.S05ID,AT8899.S06ID,AT8899.S07ID,AT8899.S08ID,AT8899.S09ID,AT8899.S10ID,AT8899.S11ID,AT8899.S12ID,AT8899.S13ID,AT8899.S14ID,AT8899.S15ID,AT8899.S16ID,AT8899.S17ID,AT8899.S18ID,AT8899.S19ID,AT8899.S20ID,GV.UnitPrice,
  A06.VoucherNo, T02.Varchar01, T02.ETaxConvertedUnit,AV4301.ObjectID, AV4301.ObjectName, AT1202.Address, AT1202.Tel,AV4301.RefInfor, AT1303.WareHouseID, AT1303.WareHouseName --,AV4301.PayVoucherID
   ' + @sGROUPBY  
End  
ELSE  
 BEGIN  
   
  Set @sSQL = '  
 Select ' + (Case when @Group1 != '' then ' V1.SelectionID as  Group1ID,   
  V1.SelectionName as Group1Name, ' else '' end)   
  + (Case when @Group2 != '' then ' V2.SelectionID as  Group2ID,   
  V2.SelectionName as Group2Name, ' else '' end)   
  + (Case when @Group3 != '' then ' V3.SelectionID as  Group3ID,   
  V3.SelectionName as Group3Name, ' else '' end)   
   + (Case when @Group4 != '' then ' V4.SelectionID as  Group4ID,   
  V4.SelectionName as Group4Name, ' else '' end) + '  
  ' + @sSELECT + '    
 AV4301.InventoryID as InvID, T02.InventoryName, T34.UnitName,  
  AV4301.VoucherDate, AV4301.VoucherNo,  
  AV4301.UnitPrice, AV4301.PaymentTermID,  AT1208.PaymentTermName,
  AV4301.Ana01ID, AV4301.Ana02ID, AV4301.Ana03ID, AV4301.Ana04ID, AV4301.Ana05ID,  
  AV4301.AnaName01,AV4301.AnaName02,AV4301.AnaName03,AV4301.AnaName04,AV4301.AnaName05,  
  AV4301.I01ID, AV4301.I02ID, AV4301.I03ID, AV4301.I04ID, AV4301.I05ID,   
  AV4301.O01ID, AV4301.O02ID, AV4301.O03ID, AV4301.O04ID, AV4301.O05ID,   
  isnull(CommissionPercent,0) as CommissionPercent, isnull(AV4301.DiscountRate,0) as DiscountRate,   
  AV4301.InvoiceDate, AV4301.Serial, AV4301.InvoiceNo, AV4301.Description, AV4301.VATTypeID,AV4301.VATRate,    
  sum(Case when TransactionTypeID in (''T04'',''T40'') then isnull(AV4301.Quantity,0) else - isnull(AV4301.Quantity,0) End) as Quantity,  
  
  
  Cast( sum(Case when TransactionTypeID in (''T04'',''T40'') then isnull(AV4301.Quantity,0) else - isnull(AV4301.Quantity,0) End) as int)/ CASE WHEN ISNULL(T19.ConversionFactor,0) = 0 THEN 1 ELSE T19.ConversionFactor END as ConvertQuantity,  
  
  cast ( sum(Case when TransactionTypeID in (''T04'',''T40'') then isnull(AV4301.Quantity,0) else - isnull(AV4301.Quantity,0) End) as int) % CASE WHEN ISNULL(T19.ConversionFactor,0) = 0 THEN 1 ELSE T19.ConversionFactor END  as ConvertQuantity1,  
  Isnull(T19.ConversionFactor,1) as  ConversionFactor ,  
  T34C.UnitName as UnitNameC,   
  
  sum( Case when  TransactionTypeID in (''T04'',''T40'')  then isnull(AV4301.OriginalAmount,0) else - isnull(AV4301.OriginalAmount,0) End )/' + ltrim(rtrim(str(@ConversionAmountUnit))) + ' as OriginalAmount,  
  sum(Case when  TransactionTypeID in (''T04'',''T40'')  then isnull(AV4301.ConvertedAmount,0) else -  isnull(AV4301.ConvertedAmount,0) End)/' + ltrim(rtrim(str(@ConversionAmountUnit))) + ' as ConvertedAmount,  
  sum(Case when  TransactionTypeID in (''T04'',''T40'')  then isnull(GV.OriginalAmount,0) else  -isnull(GV.OriginalAmount,0) End )/' + ltrim(rtrim(str(@ConversionAmountUnit))) + ' as GVOriginalAmount,  
  sum(Case when  TransactionTypeID in (''T04'',''T40'')  then isnull(GV.ConvertedAmount,0) Else -isnull(GV.ConvertedAmount,0) End)/' + ltrim(rtrim(str(@ConversionAmountUnit))) + ' as GVConvertedAmount,  
  sum(Case when  TransactionTypeID in (''T04'',''T40'')  then isnull(GV1.OriginalAmount,0) else  -isnull(GV1.OriginalAmount,0) End )/' + ltrim(rtrim(str(@ConversionAmountUnit))) + ' as GV1OriginalAmount,  
  sum(Case when  TransactionTypeID in (''T04'',''T40'')  then isnull(GV1.ConvertedAmount,0) Else - isnull(GV1.ConvertedAmount,0) End)/' + ltrim(rtrim(str(@ConversionAmountUnit))) + ' as GV1ConvertedAmount,  
  avg(isnull(GV.UnitPrice,0))/' + ltrim(rtrim(str(@ConversionAmountUnit))) + ' as GVUnitPrice,  GV.SourceNo, AV4301.DivisionID,
  SUM(ISNULL(AV4301.VATConvertedAmount, 0)) / ' + LTRIM(RTRIM(STR(@ConversionAmountUnit)))+ ' AS VATConvertedAmount,
  MAX(AV4301.O01Name) AS O01Name,
  Max(AV4301.CO3ID) as CO3ID,
  Max(AV4301.I01Name) AS I01Name,
  Max(AV4301.InventoryTypeName) AS InventoryTypeName,
  GV1.UnitPrice as GV1UnitPrice,
  GV1.ActualQuantity as GV1ActualQuantity,
  A06.VoucherNo as GV1VoucherNo, T02.Varchar01, T02.ETaxConvertedUnit, AV4301.ObjectID, AV4301.ObjectName, AT1202.Address,AV4301.RefInfor, MAX(TVoucherDate) as  PayDate,
  AT1303.WareHouseID, AT1303.WareHouseName,AT8899.S01ID,AT8899.S02ID,AT8899.S03ID, AT8899.S04ID,AT8899.S05ID,AT8899.S06ID,AT8899.S07ID,AT8899.S08ID,AT8899.S09ID,AT8899.S10ID,AT8899.S11ID,AT8899.S12ID,AT8899.S13ID,AT8899.S14ID,AT8899.S15ID,AT8899.S16ID,AT8899.S17ID,AT8899.S18ID,AT8899.S19ID,AT8899.S20ID,GV.UnitPrice AS PriceList' 
 
 Set @sSQL0 = ' 
 From AV4301 ' + (Case when @Group1 != '' then '  left join  AV6666 V1 on  V1.SelectionType ='''+@Group1+''' and V1.DivisionID  IN ('''+@DivisionID+''', ''@@@'')  and  
     V1.SelectionID = AV4301.'+ @Field1ID +'  
     ' else '' end) +   
   
     (Case when @Group2 != '' then '  left join  AV6666 V2 on  V2.SelectionType ='''+@Group2+''' and V2.DivisionID  IN ('''+@DivisionID+''', ''@@@'')  and  
     V2.SelectionID = AV4301.'+ @Field2ID +'  
     ' else '' end) +   
  
     (Case when @Group3 != '' then '  left join  AV6666 V3 on  V3.SelectionType ='''+@Group3+''' and V3.DivisionID  IN ('''+@DivisionID+''', ''@@@'')  and  
     V3.SelectionID = AV4301.'+ @Field3ID +'  
     ' else '' end) + 
	 
	 (Case when @Group4 != '' then '  left join  AV6666 V4 on  V4.SelectionType ='''+@Group4+''' and V4.DivisionID  IN ('''+@DivisionID+''', ''@@@'')  and  
     V4.SelectionID = AV4301.'+ @Field4ID +'  
     ' else '' end) +'  
  LEFT JOIN AV3122 WITH (NOLOCK) ON AV3122.TVoucherID = AV4301.VoucherID
  left join AT1302 as T02 WITH (NOLOCK) on T02.DivisionID IN (AV4301.DivisionID,''@@@'') AND T02.InventoryID = AV4301.InventoryID
  left join AT1208 WITH (NOLOCK) on AT1208.PaymentTermID = AV4301.PaymentTermID   
  left join AT2007 as GV WITH (NOLOCK) on (GV.VoucherID = AV4301.VoucherID and GV.TransactionID = AV4301.TransactionID) and GV.DivisionID = AV4301.DivisionID   
      --and GV.TableID = ''AT2006'')  
  left join AT2007 as GV1 WITH (NOLOCK) on (GV1.VoucherID = AV4301.WOrderID and GV1.TransactionID = AV4301.WTransactionID)  and  GV1.DivisionID = AV4301.DivisionID
  left join AT2006 as A06 WITH (NOLOCK) ON GV1.DivisionID = A06.DivisionID  AND GV1.VoucherID = A06.VoucherID
  Left JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (A06.DivisionID,''@@@'') AND AT1303.WarehouseID = A06.WarehouseID
  left join AT1304 as T34 WITH (NOLOCK) on T34.UnitID = AV4301.UnitID
  left join AT1309 as T19 WITH (NOLOCK) on  T19.Orders = 1 and T19.InventoryID = AV4301.InventoryID and T19.UnitID = T34.UnitID
  left join AT1304 as T34C WITH (NOLOCK) on T34C.UnitID = T19.UnitID 
  LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AV4301.ObjectID = AT1202.ObjectID
  LEFT JOIN AT8899 WITH (NOLOCK) ON AT8899.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AV4301.TransactionID = AT8899.TransactionID
  '   
  
Set @sSQL1 = ' Where AV4301.DivisionID = ''' + @DivisionID + ''' and   
  --T02.IsStocked = 1 and   
  ((AV4301.TranMonth + AV4301.TranYear*100) between ''' +   
  ltrim(rtrim(str(@PeriodFrom)))  + ''' and ''' + ltrim(rtrim(str(@PeriodTo))) + ''') and  
  (AV4301.InventoryID between ''' + @FromInventoryID + ''' and ''' + @ToInventoryID + ''') and  
  (T02.InventoryTypeID between ''' + @FromInventoryTypeID + ''' and ''' + @ToInventoryTypeID + ''')  and  
  AV4301.TransactionTypeID  in ( ''T04'',  ''T24'', ''T40'')  and  
  ' + @sWHERE + '  
  
 Group by  ' + (Case when @Group1 != '' then ' V1.SelectionID,  V1.SelectionName, ' else '' end) +  
  (Case when @Group2 != '' then ' V2.SelectionID,  V2.SelectionName, ' else '' end) +  
  (Case when @Group3 != '' then ' V3.SelectionID,  V3.SelectionName, ' else '' end) + 
  (Case when @Group4 != '' then ' V4.SelectionID,  V4.SelectionName, ' else '' end) + '  
  AV4301.InventoryID, T02.InventoryName, T34.UnitName,AV4301.VoucherDate, AV4301.VoucherNo,AV4301.UnitPrice, AV4301.PaymentTermID, AT1208.PaymentTermName,
  AV4301.Ana01ID, AV4301.Ana02ID, AV4301.Ana03ID, AV4301.Ana04ID, AV4301.Ana05ID,  
  AV4301.AnaName01,AV4301.AnaName02,AV4301.AnaName03,AV4301.AnaName04,AV4301.AnaName05,  
  AV4301.I01ID, AV4301.I02ID, AV4301.I03ID, AV4301.I04ID, AV4301.I05ID,   
  AV4301.O01ID, AV4301.O02ID, AV4301.O03ID, AV4301.O04ID, AV4301.O05ID,   
  CommissionPercent,  AV4301.DiscountRate, AV4301.VATTypeID, AV4301.VATRate,  
  AV4301.InvoiceDate, AV4301.Serial, AV4301.InvoiceNo, AV4301.Description,   T19.ConversionFactor, T34C.UnitName , GV.SourceNo, AV4301.DivisionID,
  GV1.UnitPrice,
  GV1.ActualQuantity,AT8899.S01ID,AT8899.S02ID,AT8899.S03ID, AT8899.S04ID,AT8899.S05ID,AT8899.S06ID,AT8899.S07ID,AT8899.S08ID,AT8899.S09ID,AT8899.S10ID,AT8899.S11ID,AT8899.S12ID,AT8899.S13ID,AT8899.S14ID,AT8899.S15ID,AT8899.S16ID,AT8899.S17ID,AT8899.S18ID,AT8899.S19ID,AT8899.S20ID,GV.UnitPrice,
  A06.VoucherNo, T02.Varchar01, T02.ETaxConvertedUnit,AV4301.ObjectID, AV4301.ObjectName, AT1202.Address,AV4301.RefInfor, AT1303.WareHouseID, AT1303.WareHouseName--,AV4301.PayVoucherID
   ' + @sGROUPBY  
 --print @sSQL  
   
 END  

 print @sSQL  
 print @sSQL0  
 print @sSQL1  
--SELECT @sSQL
--SELECT @sSQL0
--SELECT @sSQL1

If not exists (Select top 1 1 From SysObjects Where name = 'AV3121' and Xtype ='V')  
  Exec('Create view AV3121 -- tao boi AP3122  
   as '+@sSQL + @sSQL0 + @sSQL1)	
Else  
 Exec ('Alter view AV3121 -- tao boi AP3122  
    as '+@sSQL + @sSQL0 + @sSQL1)  

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
