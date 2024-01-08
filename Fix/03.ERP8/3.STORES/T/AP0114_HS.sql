IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0114_HS]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0114_HS]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

  
-----  Created by Nguyen Van Nhan, Date 12/2/2003 
----  Purpose: In  bao cao Nhap xuat ton theo Lo (dành cho khách hàng Hoa Sáng).
-----  Edit by Nguyen Quoc Huy, Date 31/08/2006  
/********************************************  
'* Edited by: [GS] [Tố Oanh] [28/07/2010]  
'********************************************/  
---- Modified on 24/07/2013 by Lê Thị Thu Hiền : Bổ sung 5 khoản mục I01ID đến I05ID  
---- Bo sung cho 2T, load len 15 notes va 5 parameter  
---- Edit by Mai Duyen: Bo sung them 10AnaID,AnaName01,VoucherDate,Notes cho ViMec
---- Modified by Thanh Sơn on 16/07/2014: Lấy dữ liệu trực tiếp từ store, không sinh ra view (AV0114)
---- Modified by Tiểu Mai on 04/04/2016: Bổ sung CustomizeIndex = 60 (HOA SÁNG)
---- Modified by Tiểu Mai on 18/05/2016: Fix bug bị double dòng dữ liệu
---- Modified by Bảo Thy on 25/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 16/01/2017: Fix ko load dữ liệu khi quản lý theo ngày hết hạn
---- Modified by Bảo Thy on 26/04/2017: Bổ sung in báo cáo khi thiết lập có quy cách
---- Modified by Bảo Anh on 18/05/2017: Sửa danh mục dùng chung
---- Modified by Bảo Anh on 04/05/2018: Bổ sung EndQuantity,EndConvertedAmount
---- Modified by Khánh Đoan on 04/10/2019:Bổ sung CustomizeIndex = 60 (HOA SÁNG)
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.

/*
 exec AP0114 @Divisionid=N'VM',@Fromwarehouseid=N'K01',@Towarehouseid=N'K99',@Frommonth=1,@Fromyear=2014,@Tomonth=1,
		@Toyear=2014,@Fromdate='2013-12-31 00:00:00',@Todate='2013-12-31 00:00:00',@Isdate=0,@Frominventoryid=N'001025-1',@Toinventoryid=N'X0003',@Isinner=1
  Select * from Av0114
 */

CREATE PROCEDURE [dbo].[AP0114_HS]   
    @DivisionID AS nvarchar(50),   
    @FromWareHouseID AS nvarchar(50),  
    @ToWareHouseID AS nvarchar(50),  
    @FromMonth AS int,  
    @FromYear AS int,  
    @ToMonth AS int,  
    @ToYear AS int,  
    @FromDate datetime,  
    @ToDate datetime,  
    @IsDate AS tinyint,  --- (0 theo ky, 1 theo thang)  
    @FromInventoryID AS nvarchar(50),  
    @ToInventoryID AS  nvarchar(50),  
    @IsInner  AS tinyint ----- (0; khong co VCNB, 1: VCNB)
AS  
Declare @sSQL AS varchar(MAX) = '',  
		@sSQL1 AS varchar(MAX) = '', 
		@KindVoucherListEx  AS nvarchar(200),  
		@KindVoucherListIm  AS nvarchar(200),  
		@WareHouseID1 AS nvarchar(200),   
		@FromMonthYearText NVARCHAR(20),   
		@ToMonthYearText NVARCHAR(20),   
		@FromDateText NVARCHAR(20),   
		@ToDateText NVARCHAR(20),
		@CustomerName INT  
      
SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)  
SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)  
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)  
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'  
  
Set @KindVoucherListEx   = '';  
Set @KindVoucherListIm   = '';  
Set @WareHouseID1 = '';  
   
If @IsInner =0   
  Begin   
 Set @KindVoucherListIm ='(1,5,7,9,15,17) '  
 Set @KindVoucherListEx ='(2,4,6,8,10,14,20) '  
   
  End  
Else  
  Begin  
 Set @KindVoucherListIm ='(1,3,5,7,9,15,17) '  
 Set @KindVoucherListEx ='(2,3,4,6,8,10,14,20) '  
   
 End  
  
Set  @WareHouseID1 = ' Case When KindVoucherID = 3 then AT2006.WareHouseID2 else AT2006.WareHouseID end '  
 
CREATE TABLE #CustomerIndex (CustomerName INT, ImportExcel INT)
INSERT INTO #CustomerIndex (CustomerName, ImportExcel) EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerIndex)
 
---Step 01:  Xac dinh so du tra ra view AV0124  
 Exec AP0112 @DivisionID, @FromWareHouseID, @ToWareHouseID, @FromInventoryID, @ToInventoryID,@FromMonth, @FromYear,@ToMonth,@ToYear, @FromDate, @ToDate, @IsDate, @IsInner  
 
 --Exec AP0112 @Divisionid=N'VM',@Fromwarehouseid=N'K01',@Towarehouseid=N'K99',@Frominventoryid=N'001025-1',@Toinventoryid=N'X0003',@Frommonth=1,@Fromyear=2014,@Tomonth=1,@Toyear=2014,@Fromdate='2013-12-31 00:00:00',@Todate='2013-12-31 00:00:00',@Isdate=0,@Isinner=1
 
 
---Step 02:  Xac dinh so phat sinh.  
  
----- Step 02-1:  Xac dinh phat sinh nhap.  
If @IsDate =0  
Set @sSQL ='   
SELECT AT2007.InventoryID, AT2006.WareHouseID,AT2007.TransactionID AS ReTransactionID,   
AT2006.VoucherNo, AT2006.VoucherDate,  AT2007.SourceNo, AT2007.LimitDate,   
AT2007.UnitID, AT2007.UnitPrice, AT2007.ActualQuantity, AT2007.ConvertedQuantity,AT2007.OriginalAmount,   
AT2007.ConvertedAmount, AT2007.DivisionID, AT2007.Notes01, AT2007.Notes02, AT2007.Notes03,   
AT2007.Notes04, AT2007.Notes05, AT2007.Notes06, AT2007.Notes07, AT2007.Notes08,  
AT2007.Notes09, AT2007.Notes10, AT2007.Notes11, AT2007.Notes12, AT2007.Notes13,   
AT2007.Notes14, AT2007.Notes15, AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05, isnull(AT2007.MarkQuantity,0) as MarkQuantity ,
AT2007.Ana01ID,AT2007.Ana02ID,AT2007.Ana03ID,AT2007.Ana04ID,AT2007.Ana05ID,AT2007.Ana06ID,AT2007.Ana07ID,AT2007.Ana08ID,AT2007.Ana09ID,AT2007.Ana10ID, AT2007.Notes,
ISNULL(W89.S01ID,'''') AS S01ID, ISNULL(W89.S02ID,'''') AS S02ID, ISNULL(W89.S03ID,'''') AS S03ID, ISNULL(W89.S04ID,'''') AS S04ID, ISNULL(W89.S05ID,'''') AS S05ID, 
ISNULL(W89.S06ID,'''') AS S06ID, ISNULL(W89.S07ID,'''') AS S07ID, ISNULL(W89.S08ID,'''') AS S08ID, ISNULL(W89.S09ID,'''') AS S09ID, ISNULL(W89.S10ID,'''') AS S10ID,
ISNULL(W89.S11ID,'''') AS S11ID, ISNULL(W89.S12ID,'''') AS S12ID, ISNULL(W89.S13ID,'''') AS S13ID, ISNULL(W89.S14ID,'''') AS S14ID, ISNULL(W89.S15ID,'''') AS S15ID, 
ISNULL(W89.S16ID,'''') AS S16ID, ISNULL(W89.S17ID,'''') AS S17ID, ISNULL(W89.S18ID,'''') AS S18ID, ISNULL(W89.S19ID,'''') AS S19ID, ISNULL(W89.S20ID,'''') AS S20ID
FROM  AT2007 WITH (NOLOCK)   
INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID  
LEFT JOIN WT8899 W89 WITH (NOLOCK) ON W89.DivisionID = AT2007.DivisionID AND W89.TransactionID = AT2007.TransactionID AND W89.VoucherID = AT2007.VoucherID
WHERE AT2006.DivisionID =''' + @DivisionID + ''' AND   
  (AT2007.InventoryID like '''+@FromInventoryID+''' or   
  AT2007.InventoryID between '''+@FromInventoryID+''' AND '''+@ToInventoryID+''') AND  
  (AT2006.WareHouseID  like '''+@FromWareHouseID+''' or   
  AT2006.WareHouseID between  '''+@FromWareHouseID+''' AND  '''+@ToWareHouseID+''') AND  
  (AT2006.TranMonth + AT2006.TranYear*100 >= '+@FromMonthYearText+ '    
  and AT2006.TranMonth + AT2006.TranYear*100 <= '+@ToMonthYearText+ '  
  )  AND  
  KindVoucherID in  '+ @KindVoucherListIm +'  
  
'  
Else  
 Set @sSQL ='  
SELECT AT2007.InventoryID, AT2006.WareHouseID,AT2007.TransactionID AS ReTransactionID,   
AT2006.VoucherNo, AT2006.VoucherDate,  AT2007.SourceNo, AT2007.LimitDate, AT2007.UnitID, AT2007.UnitPrice,   
AT2007.ActualQuantity, AT2007.ConvertedQuantity,AT2007.OriginalAmount, AT2007.ConvertedAmount, AT2007.DivisionID,   
AT2007.Notes01, AT2007.Notes02, AT2007.Notes03, AT2007.Notes04, AT2007.Notes05, AT2007.Notes06, AT2007.Notes07, AT2007.Notes08,  
AT2007.Notes09, AT2007.Notes10, AT2007.Notes11, AT2007.Notes12, AT2007.Notes13, AT2007.Notes14, AT2007.Notes15, AT2007.Parameter01, AT2007.Parameter02, 
AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05, isnull(AT2007.MarkQuantity,0) as MarkQuantity , 
AT2007.Ana01ID,AT2007.Ana02ID,AT2007.Ana03ID,AT2007.Ana04ID,AT2007.Ana05ID,AT2007.Ana06ID,AT2007.Ana07ID,AT2007.Ana08ID,AT2007.Ana09ID,AT2007.Ana10ID, AT2007.Notes,
ISNULL(W89.S01ID,'''') AS S01ID, ISNULL(W89.S02ID,'''') AS S02ID, ISNULL(W89.S03ID,'''') AS S03ID, ISNULL(W89.S04ID,'''') AS S04ID, ISNULL(W89.S05ID,'''') AS S05ID, 
ISNULL(W89.S06ID,'''') AS S06ID, ISNULL(W89.S07ID,'''') AS S07ID, ISNULL(W89.S08ID,'''') AS S08ID, ISNULL(W89.S09ID,'''') AS S09ID, ISNULL(W89.S10ID,'''') AS S10ID,
ISNULL(W89.S11ID,'''') AS S11ID, ISNULL(W89.S12ID,'''') AS S12ID, ISNULL(W89.S13ID,'''') AS S13ID, ISNULL(W89.S14ID,'''') AS S14ID, ISNULL(W89.S15ID,'''') AS S15ID, 
ISNULL(W89.S16ID,'''') AS S16ID, ISNULL(W89.S17ID,'''') AS S17ID, ISNULL(W89.S18ID,'''') AS S18ID, ISNULL(W89.S19ID,'''') AS S19ID, ISNULL(W89.S20ID,'''') AS S20ID
FROM AT2007 WITH (NOLOCK)   
INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID 
LEFT JOIN WT8899 W89 WITH (NOLOCK) ON W89.DivisionID = AT2007.DivisionID AND W89.TransactionID = AT2007.TransactionID AND W89.VoucherID = AT2007.VoucherID
WHERE AT2006.DivisionID =''' + @DivisionID + ''' AND   
  (AT2007.InventoryID like '''+@FromInventoryID+''' or   
  AT2007.InventoryID between '''+@FromInventoryID+''' AND '''+@ToInventoryID+''') AND  
  (AT2006.WareHouseID  like '''+@FromWareHouseID+''' or   
  AT2006.WareHouseID between  '''+@FromWareHouseID+''' AND  '''+@ToWareHouseID+''') AND  
  (AT2006.VoucherDate  >= '''+@FromDateText+'''    
  and AT2006.VoucherDate <= '''+@ToDateText+'''  
  )  AND  
  KindVoucherID in  '+ @KindVoucherListIm +'  
  
 '  

-- print @sSQL
IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE XTYPE='V' AND NAME ='AV0128')  
 EXEC('CREATE VIEW AV0128  -----TAO BOI AP0114  
  AS '+@sSQL)  
ELSE  
 EXEC('ALTER VIEW AV0128  -----TAO BOI AP0114  
  AS '+@sSQL)  
  
  
------ Step 02-2:  Xac dinh phat sinh xuat.  
If @IsDate = 0  
Set @sSQL ='   
SELECT AT2007.ReTransactionID,   '+ @WareHouseID1 +' AS WareHouseID, AT2007.InventoryID, AT2007.UnitPrice,   
SUM(ISNULL(AT2007.ActualQuantity,0)) AS ExQuantity, SUM(ISNULL(AT2007.ConvertedQuantity,0)) AS ExConvertedQuantity,  
SUM(ISNULL(AT2007.OriginalAmount,0)) AS ExOriginalAmount, SUM(ISNULL( AT2007.ConvertedAmount,0)) AS ExConvertedAmount, AT2007.DivisionID,   
AT2007.Notes01, AT2007.Notes02, AT2007.Notes03, AT2007.Notes04, AT2007.Notes05, AT2007.Notes06, AT2007.Notes07, AT2007.Notes08,  
AT2007.Notes09, AT2007.Notes10, AT2007.Notes11, AT2007.Notes12, AT2007.Notes13, AT2007.Notes14, AT2007.Notes15, AT2007.Parameter01, AT2007.Parameter02, 
AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05, SUM(ISNULL(AT2007.MarkQuantity,0)) AS ExMarkQuantity  ,
AT2007.Ana01ID,AT2007.Ana02ID,AT2007.Ana03ID,AT2007.Ana04ID,AT2007.Ana05ID,AT2007.Ana06ID,AT2007.Ana07ID,AT2007.Ana08ID,AT2007.Ana09ID,AT2007.Ana10ID,
Max(isnull(AT2007.Notes,'''')) as Notes, Max(AT2006.VoucherDate) as VoucherDate,
ISNULL(W89.S01ID,'''') AS S01ID, ISNULL(W89.S02ID,'''') AS S02ID, ISNULL(W89.S03ID,'''') AS S03ID, ISNULL(W89.S04ID,'''') AS S04ID, ISNULL(W89.S05ID,'''') AS S05ID, 
ISNULL(W89.S06ID,'''') AS S06ID, ISNULL(W89.S07ID,'''') AS S07ID, ISNULL(W89.S08ID,'''') AS S08ID, ISNULL(W89.S09ID,'''') AS S09ID, ISNULL(W89.S10ID,'''') AS S10ID,
ISNULL(W89.S11ID,'''') AS S11ID, ISNULL(W89.S12ID,'''') AS S12ID, ISNULL(W89.S13ID,'''') AS S13ID, ISNULL(W89.S14ID,'''') AS S14ID, ISNULL(W89.S15ID,'''') AS S15ID, 
ISNULL(W89.S16ID,'''') AS S16ID, ISNULL(W89.S17ID,'''') AS S17ID, ISNULL(W89.S18ID,'''') AS S18ID, ISNULL(W89.S19ID,'''') AS S19ID, ISNULL(W89.S20ID,'''') AS S20ID
FROM AT2007 WITH (NOLOCK)   
INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID  
LEFT JOIN WT8899 W89 WITH (NOLOCK) ON W89.DivisionID = AT2007.DivisionID AND W89.TransactionID = AT2007.TransactionID AND W89.VoucherID = AT2007.VoucherID
WHERE AT2006.DivisionID =''' + @DivisionID + ''' AND   
  (AT2007.InventoryID like '''+@FromInventoryID+''' or   
  AT2007.InventoryID between '''+@FromInventoryID+''' AND '''+@ToInventoryID+''') AND  
  ('+@WareHouseID1+' like '''+@FromWareHouseID+''' or   
  '+@WareHouseID1+' between  '''+@FromWareHouseID+''' AND  '''+@ToWareHouseID+''') AND  
  (AT2006.TranMonth + AT2006.TranYear*100 >= '+@FromMonthYearText+ '    
  and AT2006.TranMonth + AT2006.TranYear*100 <= '+@ToMonthYearText+ '  
  )  AND  
  KindVoucherID in '+ @KindVoucherListEx+'  
GROUP BY ReTransactionID,  '+ @WareHouseID1 +',  InventoryID, AT2007.UnitPrice, AT2007.DivisionID,   
AT2007.Notes01, AT2007.Notes02, AT2007.Notes03,   
AT2007.Notes04, AT2007.Notes05, AT2007.Notes06, AT2007.Notes07, AT2007.Notes08,  
AT2007.Notes09, AT2007.Notes10, AT2007.Notes11, AT2007.Notes12, AT2007.Notes13,   
AT2007.Notes14, AT2007.Notes15, AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05 ,
AT2007.Ana01ID,AT2007.Ana02ID,AT2007.Ana03ID,AT2007.Ana04ID,AT2007.Ana05ID,AT2007.Ana06ID,AT2007.Ana07ID,AT2007.Ana08ID,AT2007.Ana09ID,AT2007.Ana10ID,
ISNULL(W89.S01ID,''''), ISNULL(W89.S02ID,''''), ISNULL(W89.S03ID,''''), ISNULL(W89.S04ID,''''), ISNULL(W89.S05ID,''''), 
ISNULL(W89.S06ID,''''), ISNULL(W89.S07ID,''''), ISNULL(W89.S08ID,''''), ISNULL(W89.S09ID,''''), ISNULL(W89.S10ID,''''),
ISNULL(W89.S11ID,''''), ISNULL(W89.S12ID,''''), ISNULL(W89.S13ID,''''), ISNULL(W89.S14ID,''''), ISNULL(W89.S15ID,''''), 
ISNULL(W89.S16ID,''''), ISNULL(W89.S17ID,''''), ISNULL(W89.S18ID,''''), ISNULL(W89.S19ID,''''), ISNULL(W89.S20ID,'''')
'  
  
Else   
Set @sSQL ='   
SELECT AT2007.ReTransactionID,   '+ @WareHouseID1 +' AS WareHouseID, AT2007.InventoryID, AT2007.UnitPrice,   
SUM(AT2007.ActualQuantity) AS ExQuantity, SUM(AT2007.ConvertedQuantity) AS ExConvertedQuantity, SUM(AT2007.OriginalAmount) AS ExOriginalAmount ,   
SUM( AT2007.ConvertedAmount) AS ExConvertedAmount, AT2007.DivisionID, AT2007.Notes01, AT2007.Notes02, AT2007.Notes03,   
AT2007.Notes04, AT2007.Notes05, AT2007.Notes06, AT2007.Notes07, AT2007.Notes08, AT2007.Notes09, AT2007.Notes10, AT2007.Notes11, AT2007.Notes12, AT2007.Notes13,   
AT2007.Notes14, AT2007.Notes15, AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05, 
SUM(ISNULL(AT2007.MarkQuantity,0)) AS ExMarkQuantity, AT2007.Ana01ID,AT2007.Ana02ID,AT2007.Ana03ID,AT2007.Ana04ID,AT2007.Ana05ID,AT2007.Ana06ID,
AT2007.Ana07ID,AT2007.Ana08ID,AT2007.Ana09ID,AT2007.Ana10ID, Max(isnull(AT2007.Notes,'''')) as Notes ,Max(AT2006.VoucherDate) as VoucherDate,
ISNULL(W89.S01ID,'''') AS S01ID, ISNULL(W89.S02ID,'''') AS S02ID, ISNULL(W89.S03ID,'''') AS S03ID, ISNULL(W89.S04ID,'''') AS S04ID, ISNULL(W89.S05ID,'''') AS S05ID, 
ISNULL(W89.S06ID,'''') AS S06ID, ISNULL(W89.S07ID,'''') AS S07ID, ISNULL(W89.S08ID,'''') AS S08ID, ISNULL(W89.S09ID,'''') AS S09ID, ISNULL(W89.S10ID,'''') AS S10ID,
ISNULL(W89.S11ID,'''') AS S11ID, ISNULL(W89.S12ID,'''') AS S12ID, ISNULL(W89.S13ID,'''') AS S13ID, ISNULL(W89.S14ID,'''') AS S14ID, ISNULL(W89.S15ID,'''') AS S15ID, 
ISNULL(W89.S16ID,'''') AS S16ID, ISNULL(W89.S17ID,'''') AS S17ID, ISNULL(W89.S18ID,'''') AS S18ID, ISNULL(W89.S19ID,'''') AS S19ID, ISNULL(W89.S20ID,'''') AS S20ID
FROM AT2007  WITH (NOLOCK)  
INNER JOIN AT2006 WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID 
LEFT JOIN WT8899 W89 WITH (NOLOCK) ON W89.DivisionID = AT2007.DivisionID AND W89.TransactionID = AT2007.TransactionID AND W89.VoucherID = AT2007.VoucherID
WHERE AT2006.DivisionID =''' + @DivisionID + ''' AND   
  (AT2007.InventoryID like '''+@FromInventoryID+''' or   
  AT2007.InventoryID between '''+@FromInventoryID+''' AND '''+@ToInventoryID+''') AND  
  ('+@WareHouseID1+' like '''+@FromWareHouseID+''' or   
  '+@WareHouseID1+' between  '''+@FromWareHouseID+''' AND  '''+@ToWareHouseID+''') AND  
  (AT2006.VoucherDate  >= '''+@FromDateText+'''    
  and AT2006.VoucherDate <= '''+@ToDateText+'''  
  )  AND  
  KindVoucherID in '+ @KindVoucherListEx+'  
GROUP BY ReTransactionID, '+ @WareHouseID1 +',InventoryID,AT2007.UnitPrice, AT2007.DivisionID,   
AT2007.Notes01, AT2007.Notes02, AT2007.Notes03,   
AT2007.Notes04, AT2007.Notes05, AT2007.Notes06, AT2007.Notes07, AT2007.Notes08,  
AT2007.Notes09, AT2007.Notes10, AT2007.Notes11, AT2007.Notes12, AT2007.Notes13,   
AT2007.Notes14, AT2007.Notes15, AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05,
AT2007.Ana01ID,AT2007.Ana02ID,AT2007.Ana03ID,AT2007.Ana04ID,AT2007.Ana05ID,AT2007.Ana06ID,AT2007.Ana07ID,AT2007.Ana08ID,AT2007.Ana09ID,AT2007.Ana10ID,
ISNULL(W89.S01ID,''''), ISNULL(W89.S02ID,''''), ISNULL(W89.S03ID,''''), ISNULL(W89.S04ID,''''), ISNULL(W89.S05ID,''''), 
ISNULL(W89.S06ID,''''), ISNULL(W89.S07ID,''''), ISNULL(W89.S08ID,''''), ISNULL(W89.S09ID,''''), ISNULL(W89.S10ID,''''),
ISNULL(W89.S11ID,''''), ISNULL(W89.S12ID,''''), ISNULL(W89.S13ID,''''), ISNULL(W89.S14ID,''''), ISNULL(W89.S15ID,''''), 
ISNULL(W89.S16ID,''''), ISNULL(W89.S17ID,''''), ISNULL(W89.S18ID,''''), ISNULL(W89.S19ID,''''), ISNULL(W89.S20ID,'''')
  '  
--Print  @sSQL  
  
IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE XTYPE='V' AND NAME ='AV0129')  
 EXEC('CREATE VIEW AV0129  -----TAO BOI AP0114  
  AS '+@sSQL)  
ELSE  
 EXEC('ALTER VIEW AV0129  -----TAO BOI AP0114  
  AS '+@sSQL)  
    
------ Step 02-3:  Xac dinh phat sinh du-nhap  
IF @CustomerName = 60 --- HOA SANG
BEGIN
		Set @sSQL='  
		SELECT AV01.InventoryID, AT1302.InventoryName, AV01.WareHouseID, WareHouseName, AV01.ReTransactionID,   
		  AV01.VoucherNo, AV01.SourceNo, AV01.LimitDate, AV01.UnitID,  AV01.UnitPrice,   
		  AV01.ActualQuantity AS BeginQuantity,   
			AV01.ConvertedQuantity AS BeginConvertedQuantity,   
		  AV01.OriginalAmount AS BeginOriginalAmount,   
		  AV01.ConvertedAmount AS BeginConvertedAmount,  
		  0 AS DebitQuantity, 0 AS DebitConvertedQuantity,   
		  0 AS DebitOriginalAmount, 0 AS DebitConvertedAmount, AV01.DivisionID,  
		  AV01.Notes01, AV01.Notes02, AV01.Notes03,   
		  AV01.Notes04, AV01.Notes05, AV01.Notes06, AV01.Notes07, AV01.Notes08,  
		  AV01.Notes09, AV01.Notes10, AV01.Notes11, AV01.Notes12, AV01.Notes13,   
		  AV01.Notes14, AV01.Notes15, AV01.Parameter01, AV01.Parameter02, AV01.Parameter03, AV01.Parameter04, AV01.Parameter05,AV01.MarkQuantity as BeginMarkQuantity, 0 as DebitMarkQuantity,  
		  AT1302.I01ID,AT1302.I02ID,AT1302.I03ID,AT1302.I04ID,AT1302.I05ID ,
		  AV01.Ana01ID,AV01.Ana02ID,AV01.Ana03ID,AV01.Ana04ID,AV01.Ana05ID,AV01.Ana06ID,AV01.Ana07ID,AV01.Ana08ID,AV01.Ana09ID,AV01.Ana10ID,
		  AV01.Notes,AV01.VoucherDate 
  
		FROM  AV0125 AV01   
		INNER JOIN AT1302 WITH (NOLOCK)   
		 ON  AT1302.InventoryID =AV01.InventoryID
		INNER JOIN AT1303 WITH (NOLOCK)   
		 ON  AT1303.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND AT1303.WareHouseID =AV01.WareHouseID
		 
		UNION ALL  
		SELECT AV02.InventoryID,  AT1302.InventoryName, AV02.WareHouseID, WareHouseName, AV02.ReTransactionID,   
		  AV02.VoucherNo, AV02.SourceNo, AV02.LimitDate, AV02.UnitID,  AV02.UnitPrice,   
		  0 AS BeginQuantity, 0 AS BeginConvertedQuantity,0 AS BeginOriginalAmount, 0 AS BeginConvertedAmount,  
		  AV02.ActualQuantity AS DebitQuantity, AV02.ConvertedQuantity AS DebitConvertedQuantity,AV02.OriginalAmount AS DebitOriginalAmount,   
		  AV02.ConvertedAmount AS DebitConvertedAmount, AV02.DivisionID,  
		  AV02.Notes01, AV02.Notes02, AV02.Notes03,   
		  AV02.Notes04, AV02.Notes05, AV02.Notes06, AV02.Notes07, AV02.Notes08,  
		  AV02.Notes09, AV02.Notes10, AV02.Notes11, AV02.Notes12, AV02.Notes13,   
		  AV02.Notes14, AV02.Notes15,  
		  AV02.Parameter01, AV02.Parameter02, AV02.Parameter03, AV02.Parameter04, AV02.Parameter05,  
		  0 as BeginMarkQuantity, AV02.MarkQuantity AS DebitMarkQuantity,  
		  AT1302.I01ID,AT1302.I02ID,AT1302.I03ID,AT1302.I04ID,AT1302.I05ID,
		   AV02.Ana01ID,AV02.Ana02ID,AV02.Ana03ID,AV02.Ana04ID,AV02.Ana05ID,AV02.Ana06ID,AV02.Ana07ID,AV02.Ana08ID,AV02.Ana09ID,AV02.Ana10ID,
		  AV02.Notes,AV02.VoucherDate   
		FROM  AV0128 AV02  WITH (NOLOCK)  
		INNER JOIN AT1302 WITH (NOLOCK) on AT1302.InventoryID =AV02.InventoryID
		INNER JOIN AT1303 WITH (NOLOCK) on AT1303.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND AT1303.WareHouseID =AV02.WareHouseID
		' 	
END
ELSE
BEGIN
	Set @sSQL='  
	SELECT AV01.InventoryID, AT1302.InventoryName, AV01.WareHouseID, WareHouseName, AV01.ReTransactionID,   
	AV01.VoucherNo, AV01.SourceNo, AV01.LimitDate, AV01.UnitID,  AV01.UnitPrice,   
	AV01.ActualQuantity AS BeginQuantity,   
	AV01.ConvertedQuantity AS BeginConvertedQuantity,   
	AV01.OriginalAmount AS BeginOriginalAmount,   
	AV01.ConvertedAmount AS BeginConvertedAmount,  
	0 AS DebitQuantity, 0 AS DebitConvertedQuantity,   
	0 AS DebitOriginalAmount, 0 AS DebitConvertedAmount, AV01.DivisionID,  
	AV01.Notes01, AV01.Notes02, AV01.Notes03,   
	AV01.Notes04, AV01.Notes05, AV01.Notes06, AV01.Notes07, AV01.Notes08,  
	AV01.Notes09, AV01.Notes10, AV01.Notes11, AV01.Notes12, AV01.Notes13,   
	AV01.Notes14, AV01.Notes15, AV01.Parameter01, AV01.Parameter02, AV01.Parameter03, AV01.Parameter04, AV01.Parameter05,AV01.MarkQuantity as BeginMarkQuantity, 0 as DebitMarkQuantity,  
	AT1302.I01ID,AT1302.I02ID,AT1302.I03ID,AT1302.I04ID,AT1302.I05ID ,
	AV01.Ana01ID,AV01.Ana02ID,AV01.Ana03ID,AV01.Ana04ID,AV01.Ana05ID,AV01.Ana06ID,AV01.Ana07ID,AV01.Ana08ID,AV01.Ana09ID,AV01.Ana10ID,AV01.Notes,AV01.VoucherDate,
	ISNULL(AV01.S01ID,'''') AS S01ID, ISNULL(AV01.S02ID,'''') AS S02ID, ISNULL(AV01.S03ID,'''') AS S03ID, ISNULL(AV01.S04ID,'''') AS S04ID, ISNULL(AV01.S05ID,'''') AS S05ID, 
	ISNULL(AV01.S06ID,'''') AS S06ID, ISNULL(AV01.S07ID,'''') AS S07ID, ISNULL(AV01.S08ID,'''') AS S08ID, ISNULL(AV01.S09ID,'''') AS S09ID, ISNULL(AV01.S10ID,'''') AS S10ID,
	ISNULL(AV01.S11ID,'''') AS S11ID, ISNULL(AV01.S12ID,'''') AS S12ID, ISNULL(AV01.S13ID,'''') AS S13ID, ISNULL(AV01.S14ID,'''') AS S14ID, ISNULL(AV01.S15ID,'''') AS S15ID, 
	ISNULL(AV01.S16ID,'''') AS S16ID, ISNULL(AV01.S17ID,'''') AS S17ID, ISNULL(AV01.S18ID,'''') AS S18ID, ISNULL(AV01.S19ID,'''') AS S19ID, ISNULL(AV01.S20ID,'''') AS S20ID
	FROM  AV0125 AV01   
	INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.InventoryID =AV01.InventoryID AND at1302.DivisionID = AV01.DivisionID  
	INNER JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND AT1303.WareHouseID =AV01.WareHouseID 
	WHERE  (IsSource = 1 OR IsLimitDate = 1)  
	UNION ALL  
	SELECT AV02.InventoryID,  AT1302.InventoryName, AV02.WareHouseID, WareHouseName, AV02.ReTransactionID,   
	AV02.VoucherNo, AV02.SourceNo, AV02.LimitDate, AV02.UnitID,  AV02.UnitPrice,   
	0 AS BeginQuantity, 0 AS BeginConvertedQuantity,0 AS BeginOriginalAmount, 0 AS BeginConvertedAmount,  
	AV02.ActualQuantity AS DebitQuantity, AV02.ConvertedQuantity AS DebitConvertedQuantity,AV02.OriginalAmount AS DebitOriginalAmount,   
	AV02.ConvertedAmount AS DebitConvertedAmount, AV02.DivisionID, AV02.Notes01, AV02.Notes02, AV02.Notes03, AV02.Notes04, AV02.Notes05, 
	AV02.Notes06, AV02.Notes07, AV02.Notes08, AV02.Notes09, AV02.Notes10, AV02.Notes11, AV02.Notes12, AV02.Notes13, AV02.Notes14, AV02.Notes15,  
	AV02.Parameter01, AV02.Parameter02, AV02.Parameter03, AV02.Parameter04, AV02.Parameter05, 0 as BeginMarkQuantity, AV02.MarkQuantity AS DebitMarkQuantity,  
	AT1302.I01ID,AT1302.I02ID,AT1302.I03ID,AT1302.I04ID,AT1302.I05ID,
	AV02.Ana01ID,AV02.Ana02ID,AV02.Ana03ID,AV02.Ana04ID,AV02.Ana05ID,AV02.Ana06ID,AV02.Ana07ID,AV02.Ana08ID,AV02.Ana09ID,AV02.Ana10ID, AV02.Notes,AV02.VoucherDate,
	ISNULL(AV02.S01ID,'''') AS S01ID, ISNULL(AV02.S02ID,'''') AS S02ID, ISNULL(AV02.S03ID,'''') AS S03ID, ISNULL(AV02.S04ID,'''') AS S04ID, ISNULL(AV02.S05ID,'''') AS S05ID, 
	ISNULL(AV02.S06ID,'''') AS S06ID, ISNULL(AV02.S07ID,'''') AS S07ID, ISNULL(AV02.S08ID,'''') AS S08ID, ISNULL(AV02.S09ID,'''') AS S09ID, ISNULL(AV02.S10ID,'''') AS S10ID,
	ISNULL(AV02.S11ID,'''') AS S11ID, ISNULL(AV02.S12ID,'''') AS S12ID, ISNULL(AV02.S13ID,'''') AS S13ID, ISNULL(AV02.S14ID,'''') AS S14ID, ISNULL(AV02.S15ID,'''') AS S15ID, 
	ISNULL(AV02.S16ID,'''') AS S16ID, ISNULL(AV02.S17ID,'''') AS S17ID, ISNULL(AV02.S18ID,'''') AS S18ID, ISNULL(AV02.S19ID,'''') AS S19ID, ISNULL(AV02.S20ID,'''') AS S20ID
	FROM  AV0128 AV02   
	INNER JOIN AT1302 WITH (NOLOCK) on AT1302.InventoryID =AV02.InventoryID
	INNER JOIN AT1303 WITH (NOLOCK) on AT1303.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND AT1303.WareHouseID =AV02.WareHouseID
	WHERE  (IsSource = 1 OR IsLimitDate = 1) ' 		
END
-- print @sSQL
IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE XTYPE='V' AND NAME ='AV0120')  
 EXEC('CREATE VIEW AV0120  -----TAO BOI AP0114  
  AS '+@sSQL)  
ELSE  
 EXEC('ALTER VIEW AV0120  -----TAO BOI AP0114  
  AS '+@sSQL)  
  
------ Step 02-4:  Xac dinh phat sinh du-nhap - xuat
IF @CustomerName = 60 --- HOA SANG
BEGIN
SET @sSQL = '  
SELECT DISTINCT AV0120.InventoryID, AV0120.InventoryName,  AV0120.WareHouseID,AV0120.WareHouseName, AV0120.ReTransactionID,   
AV0120.VoucherNo, AV0120.SourceNo , AV0120.LimitDate, AV0120.UnitID,   AV0120.UnitPrice,  
AV0120.BeginQuantity, AV0120.BeginConvertedQuantity, AV0120.BeginOriginalAmount, AV0120.BeginConvertedAmount ,  
AV0120.DebitQuantity, AV0120.DebitConvertedQuantity, AV0120.DebitOriginalAmount, AV0120.DebitConvertedAmount ,  
SUM(AV0119.EXQuantity) AS EXQuantity,sum(AV0119.EXConvertedQuantity) AS EXConvertedQuantity, 
sum(EXMarkQuantity) AS EXMarkQuantity, sum(ExOriginalAmount) AS ExOriginalAmount, sum(ExConvertedAmount) AS ExConvertedAmount,
ISNULL(AV0120.BeginQuantity, 0) + ISNULL(AV0120.DebitQuantity, 0) - ISNULL(SUM(AV0119.EXQuantity), 0) AS EndQuantity,
ISNULL(AV0120.BeginConvertedAmount, 0) + ISNULL(AV0120.DebitConvertedAmount, 0) - ISNULL(sum(ExConvertedAmount), 0) AS EndConvertedAmount,
AV0120.DivisionID,  
AV0120.Notes01, AV0120.Notes02, AV0120.Notes03, AV0120.Notes04, AV0120.Notes05, AV0120.Notes06, AV0120.Notes07, AV0120.Notes08,
AV0120.Notes09, AV0120.Notes10, AV0120.Notes11, AV0120.Notes12, AV0120.Notes13, AV0120.Notes14, AV0120.Notes15, AV0120.BeginMarkQuantity, AV0120.DebitMarkQuantity,  
AV0120.Parameter01, AV0120.Parameter02, AV0120.Parameter03, AV0120.Parameter04, AV0120.Parameter05, AV0120.I01ID,AV0120.I02ID,AV0120.I03ID,AV0120.I04ID,AV0120.I05ID ,
AV0120.Ana01ID,AV0120.Ana02ID,AV0120.Ana03ID,AV0120.Ana04ID,AV0120.Ana05ID,AV0120.Ana06ID,AV0120.Ana07ID,AV0120.Ana08ID,AV0120.Ana09ID,AV0120.Ana10ID,
AV0120.Notes,AV0120.VoucherDate, 
T1.AnaName as AnaName01, T2.AnaName as AnaName02, T3.AnaName as AnaName03, T4.AnaName as AnaName04, T5.AnaName as AnaName05
FROM AV0120  
LEFT  JOIN AT1011 T1 WITH (NOLOCK) on T1.AnaID = AV0120.Ana01ID And T1.AnaTypeID = ''A01''
LEFT  JOIN AT1011 T2 WITH (NOLOCK) on T2.AnaID = AV0120.Ana02ID And T2.AnaTypeID = ''A02''
LEFT  JOIN AT1011 T3 WITH (NOLOCK) on T3.AnaID = AV0120.Ana03ID And T3.AnaTypeID = ''A03''
LEFT  JOIN AT1011 T4 WITH (NOLOCK) on T4.AnaID = AV0120.Ana04ID And T4.AnaTypeID = ''A04''
LEFT  JOIN AT1011 T5 WITH (NOLOCK) on T5.AnaID = AV0120.Ana05ID And T5.AnaTypeID = ''A05''
LEFT  JOIN  AV0129  AV0119 ON AV0119.InventoryID = AV0120.InventoryID AND AV0119.WareHouseID = AV0120.WareHouseID 
AND AV0119.ReTransactionID = AV0120.ReTransactionID
GROUP BY AV0120.InventoryID, AV0120.InventoryName,  AV0120.WareHouseID,AV0120.WareHouseName, AV0120.ReTransactionID, AV0120.VoucherNo, AV0120.SourceNo , AV0120.LimitDate, 
AV0120.UnitID,   AV0120.UnitPrice, AV0120.BeginQuantity, AV0120.BeginConvertedQuantity, AV0120.BeginOriginalAmount, AV0120.BeginConvertedAmount ,  
AV0120.DebitQuantity, AV0120.DebitConvertedQuantity, AV0120.DebitOriginalAmount, AV0120.DebitConvertedAmount, AV0120.Notes01, AV0120.Notes02, AV0120.Notes03,   
AV0120.Notes04, AV0120.Notes05, AV0120.Notes06, AV0120.Notes07, AV0120.Notes08,AV0120.Notes09, AV0120.Notes10, AV0120.Notes11, AV0120.Notes12, AV0120.Notes13,   
AV0120.Notes14, AV0120.Notes15, AV0120.BeginMarkQuantity, AV0120.DebitMarkQuantity, AV0120.Parameter01, AV0120.Parameter02, AV0120.Parameter03, AV0120.Parameter04, 
AV0120.Parameter05, AV0120.I01ID,AV0120.I02ID,AV0120.I03ID,AV0120.I04ID,AV0120.I05ID, AV0120.Ana01ID,AV0120.Ana02ID,AV0120.Ana03ID,AV0120.Ana04ID,AV0120.Ana05ID,
AV0120.Ana06ID,AV0120.Ana07ID,AV0120.Ana08ID,AV0120.Ana09ID,AV0120.Ana10ID, AV0120.Notes,AV0120.VoucherDate, 
T1.AnaName, T2.AnaName, T3.AnaName, T4.AnaName, T5.AnaName,AV0120.DivisionID
'
END
ELSE
BEGIN
SET @sSQL = '  
SELECT DISTINCT AV0120.InventoryID, AV0120.InventoryName,  AV0120.WareHouseID,AV0120.WareHouseName, AV0120.ReTransactionID,   
AV0120.VoucherNo, AV0120.SourceNo , AV0120.LimitDate, AV0120.UnitID,   AV0120.UnitPrice,  
AV0120.BeginQuantity, AV0120.BeginConvertedQuantity, AV0120.BeginOriginalAmount, AV0120.BeginConvertedAmount ,  
AV0120.DebitQuantity, AV0120.DebitConvertedQuantity, AV0120.DebitOriginalAmount, AV0120.DebitConvertedAmount ,  
SUM(AV0129.EXQuantity) AS EXQuantity,sum(EXConvertedQuantity) AS EXConvertedQuantity, 
sum(EXMarkQuantity) AS EXMarkQuantity, sum(ExOriginalAmount) AS ExOriginalAmount, sum(ExConvertedAmount) AS ExConvertedAmount,
ISNULL(AV0120.BeginQuantity, 0) + ISNULL(AV0120.DebitQuantity, 0) - ISNULL(SUM(AV0129.EXQuantity), 0) AS EndQuantity,
ISNULL(AV0120.BeginConvertedAmount, 0) + ISNULL(AV0120.DebitConvertedAmount, 0) - ISNULL(sum(ExConvertedAmount), 0) AS EndConvertedAmount,
AV0120.DivisionID,  
AV0120.Notes01, AV0120.Notes02, AV0120.Notes03, AV0120.Notes04, AV0120.Notes05, AV0120.Notes06, AV0120.Notes07, AV0120.Notes08,
AV0120.Notes09, AV0120.Notes10, AV0120.Notes11, AV0120.Notes12, AV0120.Notes13, AV0120.Notes14, AV0120.Notes15, AV0120.BeginMarkQuantity, AV0120.DebitMarkQuantity,  
AV0120.Parameter01, AV0120.Parameter02, AV0120.Parameter03, AV0120.Parameter04, AV0120.Parameter05, AV0120.I01ID,AV0120.I02ID,AV0120.I03ID,AV0120.I04ID,AV0120.I05ID ,
AV0120.Ana01ID,AV0120.Ana02ID,AV0120.Ana03ID,AV0120.Ana04ID,AV0120.Ana05ID,AV0120.Ana06ID,AV0120.Ana07ID,AV0120.Ana08ID,AV0120.Ana09ID,AV0120.Ana10ID,
AV0120.Notes,AV0120.VoucherDate, 
T1.AnaName as AnaName01, T2.AnaName as AnaName02, T3.AnaName as AnaName03, T4.AnaName as AnaName04, T5.AnaName as AnaName05,
ISNULL(AV0120.S01ID,'''') AS S01ID, ISNULL(AV0120.S02ID,'''') AS S02ID, ISNULL(AV0120.S03ID,'''') AS S03ID, ISNULL(AV0120.S04ID,'''') AS S04ID, ISNULL(AV0120.S05ID,'''') AS S05ID, 
ISNULL(AV0120.S06ID,'''') AS S06ID, ISNULL(AV0120.S07ID,'''') AS S07ID, ISNULL(AV0120.S08ID,'''') AS S08ID, ISNULL(AV0120.S09ID,'''') AS S09ID, ISNULL(AV0120.S10ID,'''') AS S10ID,
ISNULL(AV0120.S11ID,'''') AS S11ID, ISNULL(AV0120.S12ID,'''') AS S12ID, ISNULL(AV0120.S13ID,'''') AS S13ID, ISNULL(AV0120.S14ID,'''') AS S14ID, ISNULL(AV0120.S15ID,'''') AS S15ID, 
ISNULL(AV0120.S16ID,'''') AS S16ID, ISNULL(AV0120.S17ID,'''') AS S17ID, ISNULL(AV0120.S18ID,'''') AS S18ID, ISNULL(AV0120.S19ID,'''') AS S19ID, ISNULL(AV0120.S20ID,'''') AS S20ID,
A01.StandardName AS StandardName01, A02.StandardName AS StandardName02, A03.StandardName AS StandardName03, A04.StandardName AS StandardName04, 
A05.StandardName AS StandardName05, A06.StandardName AS StandardName06, A07.StandardName AS StandardName07, A08.StandardName AS StandardName08, 
A09.StandardName AS StandardName09, A10.StandardName AS StandardName10, A11.StandardName AS StandardName11, A12.StandardName AS StandardName12,
A13.StandardName AS StandardName13, A14.StandardName AS StandardName14, A15.StandardName AS StandardName15, A16.StandardName AS StandardName16,
A17.StandardName AS StandardName17, A18.StandardName AS StandardName18, A19.StandardName AS StandardName19, A20.StandardName AS StandardName20
FROM AV0120  
LEFT  JOIN AT1011 T1 WITH (NOLOCK) on T1.AnaID = AV0120.Ana01ID And T1.AnaTypeID = ''A01''
LEFT  JOIN AT1011 T2 WITH (NOLOCK) on T2.AnaID = AV0120.Ana02ID And T2.AnaTypeID = ''A02''
LEFT  JOIN AT1011 T3 WITH (NOLOCK) on T3.AnaID = AV0120.Ana03ID And T3.AnaTypeID = ''A03''
LEFT  JOIN AT1011 T4 WITH (NOLOCK) on T4.AnaID = AV0120.Ana04ID And T4.AnaTypeID = ''A04''
LEFT  JOIN AT1011 T5 WITH (NOLOCK) on T5.AnaID = AV0120.Ana05ID And T5.AnaTypeID = ''A05''
LEFT  JOIN  AV0129  AV0119 ON AV0119.InventoryID = AV0120.InventoryID AND  AND AV0119.WareHouseID = AV0120.WareHouseID 
AND AV0119.ReTransactionID = AV0120.ReTransactionID'

SET @sSQL1 = '
LEFT JOIN AT0128 A01 WITH (NOLOCK) ON AV0120.S01ID = A01.StandardID AND A01.StandardTypeID = ''S01''
LEFT JOIN AT0128 A02 WITH (NOLOCK) ON AV0120.S02ID = A02.StandardID AND A02.StandardTypeID = ''S02''
LEFT JOIN AT0128 A03 WITH (NOLOCK) ON AV0120.S03ID = A03.StandardID AND A03.StandardTypeID = ''S03''
LEFT JOIN AT0128 A04 WITH (NOLOCK) ON AV0120.S04ID = A04.StandardID AND A04.StandardTypeID = ''S04''
LEFT JOIN AT0128 A05 WITH (NOLOCK) ON AV0120.S05ID = A05.StandardID AND A05.StandardTypeID = ''S05''
LEFT JOIN AT0128 A06 WITH (NOLOCK) ON AV0120.S06ID = A06.StandardID AND A06.StandardTypeID = ''S06''
LEFT JOIN AT0128 A07 WITH (NOLOCK) ON AV0120.S07ID = A07.StandardID AND A07.StandardTypeID = ''S07''
LEFT JOIN AT0128 A08 WITH (NOLOCK) ON AV0120.S08ID = A08.StandardID AND A08.StandardTypeID = ''S08''
LEFT JOIN AT0128 A09 WITH (NOLOCK) ON AV0120.S09ID = A09.StandardID AND A09.StandardTypeID = ''S09''
LEFT JOIN AT0128 A10 WITH (NOLOCK) ON AV0120.S10ID = A10.StandardID AND A10.StandardTypeID = ''S10''
LEFT JOIN AT0128 A11 WITH (NOLOCK) ON AV0120.S11ID = A11.StandardID AND A11.StandardTypeID = ''S11''
LEFT JOIN AT0128 A12 WITH (NOLOCK) ON AV0120.S12ID = A12.StandardID AND A12.StandardTypeID = ''S12''
LEFT JOIN AT0128 A13 WITH (NOLOCK) ON AV0120.S13ID = A13.StandardID AND A13.StandardTypeID = ''S13''
LEFT JOIN AT0128 A14 WITH (NOLOCK) ON AV0120.S14ID = A14.StandardID AND A14.StandardTypeID = ''S14''
LEFT JOIN AT0128 A15 WITH (NOLOCK) ON AV0120.S15ID = A15.StandardID AND A15.StandardTypeID = ''S15''
LEFT JOIN AT0128 A16 WITH (NOLOCK) ON AV0120.S16ID = A16.StandardID AND A16.StandardTypeID = ''S16''
LEFT JOIN AT0128 A17 WITH (NOLOCK) ON AV0120.S17ID = A17.StandardID AND A17.StandardTypeID = ''S17''
LEFT JOIN AT0128 A18 WITH (NOLOCK) ON AV0120.S18ID = A18.StandardID AND A18.StandardTypeID = ''S18''
LEFT JOIN AT0128 A19 WITH (NOLOCK) ON AV0120.S19ID = A19.StandardID AND A19.StandardTypeID = ''S19''
LEFT JOIN AT0128 A20 WITH (NOLOCK) ON AV0120.S20ID = A20.StandardID AND A20.StandardTypeID = ''S20''  
GROUP BY AV0120.InventoryID, AV0120.InventoryName,  AV0120.WareHouseID,AV0120.WareHouseName, AV0120.ReTransactionID, AV0120.VoucherNo, AV0120.SourceNo , AV0120.LimitDate, 
AV0120.UnitID,   AV0120.UnitPrice, AV0120.BeginQuantity, AV0120.BeginConvertedQuantity, AV0120.BeginOriginalAmount, AV0120.BeginConvertedAmount ,  
AV0120.DebitQuantity, AV0120.DebitConvertedQuantity, AV0120.DebitOriginalAmount, AV0120.DebitConvertedAmount, AV0120.Notes01, AV0120.Notes02, AV0120.Notes03,   
AV0120.Notes04, AV0120.Notes05, AV0120.Notes06, AV0120.Notes07, AV0120.Notes08,AV0120.Notes09, AV0120.Notes10, AV0120.Notes11, AV0120.Notes12, AV0120.Notes13,   
AV0120.Notes14, AV0120.Notes15, AV0120.BeginMarkQuantity, AV0120.DebitMarkQuantity, AV0120.Parameter01, AV0120.Parameter02, AV0120.Parameter03, AV0120.Parameter04, 
AV0120.Parameter05, AV0120.I01ID,AV0120.I02ID,AV0120.I03ID,AV0120.I04ID,AV0120.I05ID, AV0120.Ana01ID,AV0120.Ana02ID,AV0120.Ana03ID,AV0120.Ana04ID,AV0120.Ana05ID,
AV0120.Ana06ID,AV0120.Ana07ID,AV0120.Ana08ID,AV0120.Ana09ID,AV0120.Ana10ID, AV0120.Notes,AV0120.VoucherDate, 
T1.AnaName, T2.AnaName, T3.AnaName, T4.AnaName, T5.AnaName, AV0120.DivisionID, ISNULL(AV0120.S01ID,''''), ISNULL(AV0120.S02ID,''''), ISNULL(AV0120.S03ID,''''), 
ISNULL(AV0120.S04ID,''''), ISNULL(AV0120.S05ID,''''), ISNULL(AV0120.S06ID,''''), ISNULL(AV0120.S07ID,''''), ISNULL(AV0120.S08ID,''''), ISNULL(AV0120.S09ID,''''), 
ISNULL(AV0120.S10ID,''''), ISNULL(AV0120.S11ID,''''), ISNULL(AV0120.S12ID,''''), ISNULL(AV0120.S13ID,''''), ISNULL(AV0120.S14ID,''''), ISNULL(AV0120.S15ID,''''), 
ISNULL(AV0120.S16ID,''''), ISNULL(AV0120.S17ID,''''), ISNULL(AV0120.S18ID,''''), ISNULL(AV0120.S19ID,''''), ISNULL(AV0120.S20ID,''''),
A01.StandardName, A02.StandardName, A03.StandardName, A04.StandardName, A05.StandardName, A06.StandardName, A07.StandardName, A08.StandardName, 
A09.StandardName, A10.StandardName, A11.StandardName, A12.StandardName,A13.StandardName, A14.StandardName, A15.StandardName, A16.StandardName,
A17.StandardName, A18.StandardName, A19.StandardName, A20.StandardName '  
END
--PRINT(@sSQL) 
--PRINT(@sSQL1)
EXEC (@sSQL+@sSQL1)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
