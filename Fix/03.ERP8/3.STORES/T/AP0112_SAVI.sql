IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0112_SAVI]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0112_SAVI]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
--- Số dư mặt hàng theo kho, lô, theo chứng từ có thể chọn theo ngày hay theo kỳ (cho mặt hàng theo lô)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Nguyen Van Nhan on: 28/02/2007
---- Modified [GS] [Tố Oanh] [28/07/2010]  
---- Modified on 10/02/2012 by Le Thi Thu Hien : JOIN DivisionID
---- Modified on 25/01/2013 by Bao Quynh : Xu ly truong hop in theo ngay, bo dieu kien kiem tra la dau ky.  
---- Modified on 30/01/2013 by Bao Quynh : Xua lai cau kiem tra dieu kien la ky dau tien (Select  BeginMonth +BeginYear *100  From AT1101 Where DivisionID = @DivisionID)  
---- Modified on 2013/08/21 by Khanh Van: Load them 15 Notes va 5 Parameter cho 2T  
---- Modified on 2013/12/31 by Mai Duyen: Load them 10 AnaID va Notes, VoucherDate
---- Modified on 2015/01/20 by Quốc Tuấn: Fix lỗi in theo ngày báo lỗi 
---- Modified on 25/10/2022 by Nhật Thanh: Bỏ group by các trường Notes 
---- Modified on 30/12/2022 by Xuân Nguyên: Bổ sung ISNULL() cho trường ConvertedAmount,OriginalAmount
-- <Example>
/*
	AP0112_SAVI @Divisionid=N'VM',@Fromwarehouseid=N'K01',@Towarehouseid=N'K99',@Frominventoryid=N'001025-1',@Toinventoryid=N'X0003',@Frommonth=1,@Fromyear=2014,@Tomonth=1,@Toyear=2014,@Fromdate='2013-12-31 00:00:00',@Todate='2013-12-31 00:00:00',@Isdate=0,@Isinner=1
	AP0112_SAVI @Divisionid=N'VM',@Fromwarehouseid=N'K01',@Towarehouseid=N'KMBN',@Frominventoryid=N'001025-1',@Toinventoryid=N'X0003',@Frommonth=2,@Fromyear=2014,@Tomonth=2,@Toyear=2014, @Fromdate='2014-01-02 00:00:00',@Todate='2014-01-02 00:00:00',@Isdate=0, @Isinner=1  
*/
  
CREATE PROCEDURE AP0112_SAVI
(   
    @DivisionID NVARCHAR(50),   
    @FromWareHouseID NVARCHAR(50),  
    @ToWareHouseID NVARCHAR(50),  
    @FromInventoryID NVARCHAR(50),  
    @ToInventoryID NVARCHAR(50),  
    @FromMonth INT,  
    @FromYear INT,  
    @ToMonth INT,  
    @ToYear INT,  
    @FromDate DATETIME,  
    @ToDate DATETIME,  
    @IsDate TINYINT,  
    @IsInner TINYINT ----- (0; khong co VCNB, 1: VCNB)  
)  
AS  
DECLARE @sSQL NVARCHAR(MAX), @KindVoucherList NVARCHAR(200), @WareHouseID1 NVARCHAR(200)  
----Kiem tra co  Lay VCNB khong  
IF @IsInner = 0 SET @KindVoucherList = '(0,1,5,7,9,15,17,2,3,4,6,8,10,14,20) '  
 ----Set @KindVoucherListEx ='(2,4,6,8,10)'    
ELSE SET @KindVoucherList = '(0,1,5,7,9,15,17,2,3,4,6,8,10,14,20) '  
---Set @KindVoucherListEx ='(2,3,4,6,8,10) '  
---- Tao View ket 2 bang AT2006 va AT2007
SET @sSQL = ' 
SELECT A07.TransactionID, A07.VoucherID, A07.BatchID, A07.InventoryID, A07.UnitID, A07.ActualQuantity, A07.ConvertedQuantity,
	A07.UnitPrice, A07.OriginalAmount, A07.ConvertedAmount, A07.Notes, A07.TranMonth, A07.TranYear, A07.DivisionID, A07.CurrencyID,
	A07.ExchangeRate, A07.SaleUnitPrice, A07.SaleAmount, A07.DiscountAmount, A07.SourceNo, A07.DebitAccountID, A07.CreditAccountID,
	A07.LocationID, A07.ImLocationID, A07.LimitDate, A07.Orders, A07.ConversionFactor, A07.ReTransactionID, A07.ReVoucherID,  
	 A07.PeriodID, A07.ProductID, A07.OrderID, A07.InventoryName1, A06.KindVoucherID,
	A06.VoucherDate, A07.Notes01, A07.Notes02, A07.Notes03, A07.Notes04, A07.Notes05, A07.Notes06, A07.Notes07, A07.Notes08,  
    A07.Notes09, A07.Notes10, A07.Notes11, A07.Notes12, A07.Notes13, A07.Notes14, A07.Notes15, 
	A07.MarkQuantity, A07.WarrantyNo, W69.ShelvesID, W69.ShelvesName, W70.FloorID, W70.FloorName    
FROM AT2007 A07   
INNER JOIN AT2006 A06 on A06.VoucherID = A07.VoucherID AND A06.DivisionID = A07.DivisionID
	LEFT JOIN WT0169 W69 ON A07.ShelvesID = W69.ShelvesID
	LEFT JOIN WT0170 W70 ON A07.FloorID = W70.FloorID
'  
  
---Print @sSQL  
IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE XTYPE = 'V' AND NAME = 'AV2107')  
 EXEC('CREATE VIEW AV2107  -----TAO BOI AP0112_SAVI  
  AS '+@sSQL)  
ELSE  
 EXEC('ALTER VIEW AV2107  -----TAO BOI AP0112_SAVI  
  AS '+@sSQL)  
  
SET @WareHouseID1 = ' CASE WHEN KindVoucherID = 3 THEN A06.WareHouseID2 ELSE AT2006.WareHouseID END '  
IF @IsDate = 0  
	IF @FromMonth + @FromYear * 100 = (SELECT BeginMonth + BeginYear * 100 FROM AT1101 WHERE DivisionID = @DivisionID)  
   ---Xac dinh so du ton dau AT2017  
		SET @sSQL = '
SELECT A17.VoucherID ReVoucherID, A17.TransactionID ReTransactionID, A16.WareHouseID, A16.VoucherNo, A17.InventoryID,
	A17.SourceNo, A17.LimitDate, A17.UnitID,  A17.ActualQuantity, A17.ConvertedQuantity, A17.OriginalAmount,
	A17.ConvertedAmount, A17.DivisionID, A17.Notes01, A17.Notes02, A17.Notes03, A17.Notes04, A17.Notes05, A17.Notes06,
	A17.Notes07, A17.Notes08, A17.Notes09, A17.Notes10, A17.Notes11, A17.Notes12, A17.Notes13, A17.Notes14, A17.Notes15,   
     A17.MarkQuantity,
     A17.Notes, A16.VoucherDate, '''' AS WarrantyNo, '''' AS ShelvesID, '''' AS ShelvesName, '''' AS FloorID, '''' AS FloorName
FROM AT2017 A17   
	INNER JOIN AT2016 A16 ON A16.VoucherID = A17.VoucherID AND A16.DivisionID = A17.DivisionID  
WHERE A16.DivisionID = ''' + @DivisionID + '''
	AND (A17.InventoryID LIKE '''+@FromInventoryID+''' OR A17.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+''')
	AND (A16.WareHouseID LIKE '''+@FromWareHouseID+''' OR A16.WareHouseID BETWEEN '''+@FromWareHouseID+''' AND '''+@ToWareHouseID+''')'
	
	ELSE ---Xac dinh so du ton dau cua cac ky tro ve truoc  
		SET @sSQL = '
SELECT A14.ReVoucherID, A14.ReTransactionID, A14.WareHouseID, A14.ReVoucherNo VoucherNo, A14.InventoryID, A14.ReSourceNo SourceNo,
	A14.LimitDate, N.UnitID,  ReQuantity - SUM(ISNULL(A07.ActualQuantity, 0)) ActualQuantity, 0 ConvertedQuantity,  
    ISNULL(ReMarkQuantity, 0) - SUM(ISNULL(A07.MarkQuantity, 0)) MarkQuantity, ISNULL(N.OriginalAmount,0) - SUM(ISNULL(A07.OriginalAmount, 0)) OriginalAmount,  
    ISNULL(N.ConvertedAmount,0) - SUM(ISNULL(A07.ConvertedAmount,0)) ConvertedAmount, A14.DivisionID, MAX(A07.Notes01) Notes01, MAX(A07.Notes02) Notes02, MAX(A07.Notes03) Notes03, MAX(A07.Notes04) Notes04, MAX(A07.Notes05) Notes05,
    MAX(A07.Notes06) Notes06, MAX(A07.Notes07) Notes07, MAX(A07.Notes08) Notes08, MAX(A07.Notes09) Notes09, MAX(A07.Notes10) Notes10, MAX(A07.Notes11) Notes11, MAX(A07.Notes12) Notes12, MAX(A07.Notes13) Notes13, MAX(A07.Notes14) Notes14, MAX(A07.Notes15) Notes15,
    MAX(ISNULL(A07.Notes,'''')) Notes, MAX (A07.VoucherDate) VoucherDate, A14.ReWarrantyNo AS WarrantyNo, W69.ShelvesID, W69.ShelvesName, W70.FloorID, W70.FloorName  
FROM AT0114 A14  
	LEFT JOIN WT0169 W69 ON A14.ReShelvesID = W69.ShelvesID
	LEFT JOIN WT0170 W70 ON A14.ReFloorID = W70.FloorID
	LEFT JOIN AV2107 A07 ON A07.ReTransactionID = A14.ReTransactionID AND A07.DivisionID = A14.DivisionID AND A07.TranMonth + A07.TranYear * 100 < '+STR(@FromMonth + 100 * @FromYear)+' AND ISNULL(A07.KindVoucherID,0) IN  '+@KindVoucherList+'        
	INNER JOIN AV2777 N on N.TransactionID = A14.ReTransactionID AND N.DivisionID = A14.DivisionID  
	INNER JOIN AV2666 ON AV2666.VoucherID = N.VoucherID AND AV2666.DivisionID = A14.DivisionID  
WHERE ReTranMonth + ReTranYear * 100 < '+STR(@FromMonth + 100 * @FromYear)+'
	AND A14.DivisionID = '''+@DivisionID+'''
	AND (A14.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+''')
	AND (A14.WareHouseID BETWEEN '''+@FromWareHouseID+''' AND '''+@ToWareHouseID+''')  
    AND ISNULL(AV2666.KindVoucherID,0) IN '+@KindVoucherList+'    
GROUP BY A14.ReVoucherID, A14.ReTransactionID, A14.InventoryID, A14.WareHouseID, A14.ReVoucherNO, A14.reSourceNO,
	A14.LimitDate,ReQuantity, ReMarkQuantity, N.UnitID, N.OriginalAmount,N.ConvertedAmount, A14.DivisionID,
	A14.ReWarrantyNo, W69.ShelvesID, W69.ShelvesName, W70.FloorID, W70.FloorName '  
  
ELSE -- Theo ngay  
	SET @sSQL = '  
SELECT A14.ReVoucherID, A14.ReTransactionID, A14.WareHouseID, A14.ReVoucherNo VoucherNo,
	A14.InventoryID, A14.ReSourceNo SourceNo, A14.LimitDate, N.UnitID,  ReQuantity - SUM(ISNULL(A07.ActualQuantity, 0)) ActualQuantity,  
    0 ConvertedQuantity, ISNULL(ReMarkQuantity, 0) - SUM(ISNULL(A07.MarkQuantity, 0)) MarkQuantity,
	ISNULL(N.OriginalAmount,0) - SUM(ISNULL(A07.OriginalAmount, 0)) OriginalAmount, ISNULL(N.ConvertedAmount,0) - SUM(ISNULL(A07.ConvertedAmount, 0)) ConvertedAmount,  
    A14.DivisionID, MAX(A07.Notes01) Notes01, MAX(A07.Notes02) Notes02, MAX(A07.Notes03) Notes03, MAX(A07.Notes04) Notes04, MAX(A07.Notes05) Notes05,
    MAX(A07.Notes06) Notes06, MAX(A07.Notes07) Notes07, MAX(A07.Notes08) Notes08, MAX(A07.Notes09) Notes09, MAX(A07.Notes10) Notes10, MAX(A07.Notes11) Notes11, MAX(A07.Notes12) Notes12, MAX(A07.Notes13) Notes13, MAX(A07.Notes14) Notes14, MAX(A07.Notes15) Notes15, MAX(ISNULL(A07.Notes,'''')) Notes,
    MAX(A07.VoucherDate) VoucherDate, A14.ReWarrantyNo AS WarrantyNo, W69.ShelvesID, W69.ShelvesName, W70.FloorID, W70.FloorName  
FROM AT0114 A14
	LEFT JOIN WT0169 W69 ON A14.ReShelvesID = W69.ShelvesID
	LEFT JOIN WT0170 W70 ON A14.ReFloorID = W70.FloorID
LEFT JOIN AV2107 A07 ON A07.ReTransactionID = A14.ReTransactionID AND CONVERT(VARCHAR, A07.VoucherDate, 112) < '''+CONVERT(VARCHAR, @FromDate, 112)+''' AND A07.DivisionID = A14.DivisionID  
	INNER JOIN AV2777 N ON N.TransactionID = A14.ReTransactionID AND N.DivisionID = A14.DivisionID
	INNER JOIN AV2666 ON AV2666.VoucherID = N.VoucherID AND AV2666.DivisionID = A14.DivisionID  
 WHERE CONVERT(VARCHAR, A14.ReVoucherDate, 112) < '''+CONVERT(VARCHAR, @FromDate, 112)+'''
	AND A14.DivisionID = '''+@DivisionID+'''
	AND (A14.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+''')
	AND ( A14.WareHouseID BETWEEN  '''+@FromWareHouseID+''' AND '''+@ToWareHouseID+''')
 GROUP BY A14.ReVoucherID, A14.ReTransactionID, A14.InventoryID, A14.WareHouseID, A14.ReVoucherNo, A14.ReVoucherDate,
	A14.reSourceNO, A14.LimitDate, ReQuantity, ReMarkQuantity, N.UnitID, N.OriginalAmount,N.ConvertedAmount, 
	A14.DivisionID, A14.ReWarrantyNo, W69.ShelvesID, W69.ShelvesName, W70.FloorID, W70.FloorName'  
 
 Print @sSQL 
IF NOT EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WHERE XTYPE = 'V' AND NAME = 'AV0125')  
	EXEC('CREATE VIEW AV0125  -----TAO BOI AP0112_SAVI
    AS '+@sSQL)  
ELSE EXEC('ALTER VIEW AV0125  -----TAO BOI AP0112_SAVI
	AS '+@sSQL)  
  








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
