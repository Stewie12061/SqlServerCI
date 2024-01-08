IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0112]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0112]
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
---- Modified on 04/05/2016 by Bảo Anh: Sửa lỗi in theo ngày sai
---- Modified by Bảo Thy on 25/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Bảo Thy on 26/04/2017: Bổ sung 20 trường quy cách
---- Modified by Hải Long on 05/07/2017: Fix lỗi bị tràn chuỗi
---- Modified by Xuân Nguyên on 20/01/2022:[2022/01/IS/0102]sửa điều kiện join bảng AV2107
---- Modified by Xuân Nguyên on 01/02/2023:Bổ sung select các trường WarrantyNo, ShelvesID, FloorID, ShelvesName, FloorName
---- Modified by Xuân Nguyên on 30/03/2023:Điều chỉnh lấy anaID từ AT2017 thay vì lấy từ AV2107
---- Modified by Xuân Nguyên on 20/06/2023:[2023/06/IS/0178]Bổ sung trưởng ObjectID
---- Modified by Đình Định on 07/07/2023: VIMEC - Bỏ group ObjectID.
---- Modified by Đình Định on 11/07/2023: VIMEC - Không lấy A07.Ana01ID.
---- Modified by Đình Định on 07/08/2023: BBL - Bổ sung cột ConvertedUnitID.
---- Modified by Thành Sang on 17/08/2023: BBL - Bổ sung cột ConvertedUnitID (Load theo kỳ)
---- Modified by Xuân Nguyên on 15/09/2023: BBL - Điều chỉnh lấy ConvertedUnitID và ConvertedQuantity từ AV2777
-- <Example>
/*
	AP0112 @Divisionid=N'VM',@Fromwarehouseid=N'K01',@Towarehouseid=N'K99',@Frominventoryid=N'001025-1',@Toinventoryid=N'X0003',@Frommonth=1,@Fromyear=2014,@Tomonth=1,@Toyear=2014,@Fromdate='2013-12-31 00:00:00',@Todate='2013-12-31 00:00:00',@Isdate=0,@Isinner=1
	AP0112 @Divisionid=N'VM',@Fromwarehouseid=N'K01',@Towarehouseid=N'KMBN',@Frominventoryid=N'001025-1',@Toinventoryid=N'X0003',@Frommonth=2,@Fromyear=2014,@Tomonth=2,@Toyear=2014, @Fromdate='2014-01-02 00:00:00',@Todate='2014-01-02 00:00:00',@Isdate=0, @Isinner=1  
*/
  
CREATE PROCEDURE AP0112
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
DECLARE @sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX) = '',  
		@KindVoucherList NVARCHAR(200), 
		@WareHouseID1 NVARCHAR(200)  
----Kiem tra co  Lay VCNB khong  
IF @IsInner = 0 SET @KindVoucherList = '(0,1,5,7,9,15,17,2,3,4,6,8,10,14,20) '  
 ----Set @KindVoucherListEx ='(2,4,6,8,10)'    
ELSE SET @KindVoucherList = '(0,1,5,7,9,15,17,2,3,4,6,8,10,14,20) '  
---Set @KindVoucherListEx ='(2,3,4,6,8,10) '  
---- Tao View ket 2 bang AT2006 va AT2007
SET @sSQL1 = ' 
SELECT A07.TransactionID, A07.VoucherID, A07.BatchID, A07.InventoryID, A07.UnitID, A07.ActualQuantity, A07.ConvertedQuantity,
	A07.UnitPrice, A07.OriginalAmount, A07.ConvertedAmount, A07.Notes, A07.TranMonth, A07.TranYear, A07.DivisionID, A07.CurrencyID,
	A07.ExchangeRate, A07.SaleUnitPrice, A07.SaleAmount, A07.DiscountAmount, A07.SourceNo, A07.WarrantyNo, A07.ShelvesID, A07.FloorID, wt0169.shelvesName, wt0170.floorName , A07.DebitAccountID, A07.CreditAccountID,
	A07.LocationID, A07.ImLocationID, A07.LimitDate, A07.Orders, A07.ConversionFactor, A07.ReTransactionID, A07.ReVoucherID,  
	A07.Ana01ID, A07.Ana02ID, A07.Ana03ID, A07.PeriodID, A07.ProductID, A07.OrderID, A07.InventoryName1, A06.KindVoucherID,
	A06.VoucherDate, A07.Notes01, A07.Notes02, A07.Notes03, A07.Notes04, A07.Notes05, A07.Notes06, A07.Notes07, A07.Notes08,  
    A07.Notes09, A07.Notes10, A07.Notes11, A07.Notes12, A07.Notes13, A07.Notes14, A07.Notes15,   
	ISNULL(A07.Parameter01, 0) Parameter01, ISNULL(A07.Parameter02, 0) Parameter02, ISNULL(A07.Parameter03, 0) Parameter03,
	ISNULL(A07.Parameter04,0) Parameter04, ISNULL(A07.Parameter05,0) Parameter05, A07.MarkQuantity,
    A07.Ana04ID, A07.Ana05ID, A07.Ana06ID, A07.Ana07ID, A07.Ana08ID, A07.Ana09ID, A07.Ana10ID,
	ISNULL(W89.S01ID,'''') AS S01ID, ISNULL(W89.S02ID,'''') AS S02ID, ISNULL(W89.S03ID,'''') AS S03ID, ISNULL(W89.S04ID,'''') AS S04ID, ISNULL(W89.S05ID,'''') AS S05ID, 
	ISNULL(W89.S06ID,'''') AS S06ID, ISNULL(W89.S07ID,'''') AS S07ID, ISNULL(W89.S08ID,'''') AS S08ID, ISNULL(W89.S09ID,'''') AS S09ID, ISNULL(W89.S10ID,'''') AS S10ID,
	ISNULL(W89.S11ID,'''') AS S11ID, ISNULL(W89.S12ID,'''') AS S12ID, ISNULL(W89.S13ID,'''') AS S13ID, ISNULL(W89.S14ID,'''') AS S14ID, ISNULL(W89.S15ID,'''') AS S15ID, 
	ISNULL(W89.S16ID,'''') AS S16ID, ISNULL(W89.S17ID,'''') AS S17ID, ISNULL(W89.S18ID,'''') AS S18ID, ISNULL(W89.S19ID,'''') AS S19ID, ISNULL(W89.S20ID,'''') AS S20ID,
	A06.ObjectID
FROM AT2007 A07 WITH (NOLOCK)  
left join wt0169 with (nolock) on wt0169.shelvesID = A07.shelvesID
left join wt0170 with (nolock) on wt0170.floorID = A07.floorID
INNER JOIN AT2006 A06 WITH (NOLOCK) on A06.VoucherID = A07.VoucherID AND A06.DivisionID = A07.DivisionID
LEFT JOIN WT8899 W89 WITH (NOLOCK) ON W89.DivisionID = A07.DivisionID AND W89.TransactionID = A07.TransactionID AND W89.VoucherID = A07.VoucherID '
  
--Print @sSQL  
IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE XTYPE = 'V' AND NAME = 'AV2107')  
 EXEC('CREATE VIEW AV2107  -----TAO BOI AP0112  
  AS '+@sSQL1)  
ELSE  
 EXEC('ALTER VIEW AV2107  -----TAO BOI AP0112  
  AS '+@sSQL1)  
  
SET @WareHouseID1 = ' CASE WHEN KindVoucherID = 3 THEN A06.WareHouseID2 ELSE AT2006.WareHouseID END '  
IF @IsDate = 0  
	IF @FromMonth + @FromYear * 100 = (SELECT BeginMonth + BeginYear * 100 FROM AT1101 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
	BEGIN
		---Xac dinh so du ton dau AT2017  
		SET @sSQL1 = '
		SELECT A17.VoucherID ReVoucherID, A17.TransactionID ReTransactionID, A16.WareHouseID, A16.VoucherNo, A17.InventoryID,
			   A17.SourceNo, A17.LimitDate, A17.UnitID, A17.UnitPrice, A17.ActualQuantity, A17.ConvertedQuantity, A17.OriginalAmount,
			   A17.ConvertedAmount, A17.DivisionID, A17.Notes01, A17.Notes02, A17.Notes03, A17.Notes04, A17.Notes05, A17.Notes06,
			   A17.Notes07, A17.Notes08, A17.Notes09, A17.Notes10, A17.Notes11, A17.Notes12, A17.Notes13, A17.Notes14, A17.Notes15,   
			   A17.Parameter01, A17.Parameter02, A17.Parameter03, A17.Parameter04, A17.Parameter05, A17.MarkQuantity,
			   A17.Ana01ID, A17.Ana02ID, A17.Ana03ID, A17.Ana04ID, A17.Ana05ID, A17.Ana06ID, A17.Ana07ID, A17.Ana08ID,
			   A17.Ana09ID, A17.Ana10ID, A17.Notes, A16.VoucherDate,
			   ISNULL(W89.S01ID,'''') AS S01ID, ISNULL(W89.S02ID,'''') AS S02ID, ISNULL(W89.S03ID,'''') AS S03ID, ISNULL(W89.S04ID,'''') AS S04ID, ISNULL(W89.S05ID,'''') AS S05ID, 
			   ISNULL(W89.S06ID,'''') AS S06ID, ISNULL(W89.S07ID,'''') AS S07ID, ISNULL(W89.S08ID,'''') AS S08ID, ISNULL(W89.S09ID,'''') AS S09ID, ISNULL(W89.S10ID,'''') AS S10ID,
			   ISNULL(W89.S11ID,'''') AS S11ID, ISNULL(W89.S12ID,'''') AS S12ID, ISNULL(W89.S13ID,'''') AS S13ID, ISNULL(W89.S14ID,'''') AS S14ID, ISNULL(W89.S15ID,'''') AS S15ID, 
			   ISNULL(W89.S16ID,'''') AS S16ID, ISNULL(W89.S17ID,'''') AS S17ID, ISNULL(W89.S18ID,'''') AS S18ID, ISNULL(W89.S19ID,'''') AS S19ID, ISNULL(W89.S20ID,'''') AS S20ID ,
			   A17.WarrantyNo, A17.ShelvesID, A17.FloorID, wt0169.ShelvesName, wt0170.FloorName, A16.ObjectID, A17.ConvertedUnitID
		FROM AT2017 A17 WITH (NOLOCK)   
		INNER JOIN AT2016 A16 WITH (NOLOCK) ON A16.VoucherID = A17.VoucherID AND A16.DivisionID = A17.DivisionID  
		LEFT JOIN WT8899 W89 WITH (NOLOCK) ON W89.DivisionID = A17.DivisionID AND W89.TransactionID = A17.TransactionID AND W89.VoucherID = A17.VoucherID
		left join wt0170 with (nolock) on wt0170.floorID = A17.floorID
		left join wt0169 with (nolock) on wt0169.shelvesID = A17.shelvesID
		WHERE A16.DivisionID IN (''' + @DivisionID + ''',''@@@'')
			AND (A17.InventoryID LIKE '''+@FromInventoryID+''' OR A17.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+''')
			AND (A16.WareHouseID LIKE '''+@FromWareHouseID+''' OR A16.WareHouseID BETWEEN '''+@FromWareHouseID+''' AND '''+@ToWareHouseID+''')'		
	END  
	ELSE ---Xac dinh so du ton dau cua cac ky tro ve truoc  
	BEGIN
		SET @sSQL1 = '
		SELECT A14.ReVoucherID, A14.ReTransactionID, A14.WareHouseID, A14.ReVoucherNo VoucherNo, A14.InventoryID, A14.ReSourceNo SourceNo, A14.ReWarrantyNo WarrantyNo, A14.ReShelvesID ShelvesID, A14.ReFloorID FloorID, wt0169.ShelvesName, wt0170.FloorName,
			A14.LimitDate, N.UnitID, N.UnitPrice, ReQuantity - SUM(ISNULL(A07.ActualQuantity, 0)) ActualQuantity, N.ConvertedQuantity-SUM(ISNULL(A07.ConvertedQuantity, 0)) ConvertedQuantity,  
			ISNULL(ReMarkQuantity, 0) - SUM(ISNULL(A07.MarkQuantity, 0)) MarkQuantity, N.OriginalAmount - SUM(ISNULL(A07.OriginalAmount, 0)) OriginalAmount,  
			N.ConvertedAmount - SUM(ISNULL(A07.ConvertedAmount,0)) ConvertedAmount, A14.DivisionID, A07.Notes01, A07.Notes02, A07.Notes03, A07.Notes04, A07.Notes05,
			A07.Notes06, A07.Notes07, A07.Notes08, A07.Notes09, A07.Notes10, A07.Notes11, A07.Notes12, A07.Notes13, A07.Notes14, A07.Notes15,
			A07.Parameter01, A07.Parameter02, A07.Parameter03, A07.Parameter04, A07.Parameter05, A17.Ana01ID, A17.Ana02ID, A17.Ana03ID, A17.Ana04ID, A17.Ana05ID,
			A17.Ana06ID, A17.Ana07ID, A17.Ana08ID, A17.Ana09ID, A17.Ana10ID, MAX(ISNULL(A07.Notes,'''')) Notes, MAX (ISNULL(A07.VoucherDate, A14.ReVoucherDate)) VoucherDate,
			ISNULL(A14.S01ID,'''') AS S01ID, ISNULL(A14.S02ID,'''') AS S02ID, ISNULL(A14.S03ID,'''') AS S03ID, ISNULL(A14.S04ID,'''') AS S04ID, ISNULL(A14.S05ID,'''') AS S05ID, 
			ISNULL(A14.S06ID,'''') AS S06ID, ISNULL(A14.S07ID,'''') AS S07ID, ISNULL(A14.S08ID,'''') AS S08ID, ISNULL(A14.S09ID,'''') AS S09ID, ISNULL(A14.S10ID,'''') AS S10ID,
			ISNULL(A14.S11ID,'''') AS S11ID, ISNULL(A14.S12ID,'''') AS S12ID, ISNULL(A14.S13ID,'''') AS S13ID, ISNULL(A14.S14ID,'''') AS S14ID, ISNULL(A14.S15ID,'''') AS S15ID, 
			ISNULL(A14.S16ID,'''') AS S16ID, ISNULL(A14.S17ID,'''') AS S17ID, ISNULL(A14.S18ID,'''') AS S18ID, ISNULL(A14.S19ID,'''') AS S19ID, ISNULL(A14.S20ID,'''') AS S20ID,
			MAX(A07.ObjectID) AS ObjectID, N.ConvertedUnitID
		FROM AT0114 A14 WITH (NOLOCK)
		left join wt0169 with (nolock) on wt0169.shelvesID = A14.reshelvesID
		left join wt0170 with (nolock) on wt0170.floorID = A14.refloorID
			LEFT JOIN AV2107 A07 with (nolock) ON A07.ReTransactionID = A14.ReTransactionID AND A07.DivisionID = A14.DivisionID AND A07.TranMonth + A07.TranYear * 100 < '+STR(@FromMonth + 100 * @FromYear)+' AND ISNULL(A07.KindVoucherID,0) IN  '+@KindVoucherList+'
			LEFT JOIN AT2017 A17 with (nolock) ON A17.TransactionID = A14.ReTransactionID AND A17.DivisionID = A14.DivisionID
			LEFT JOIN WT8899 W89 WITH (NOLOCK) ON W89.DivisionID = A17.DivisionID AND W89.TransactionID = A17.TransactionID AND W89.VoucherID = A17.VoucherID 
			AND ISNULL(W89.S01ID,'''') = Isnull(A14.S01ID,'''') AND ISNULL(W89.S02ID,'''') = isnull(A14.S02ID,'''')
			AND ISNULL(W89.S03ID,'''') = isnull(A14.S03ID,'''') AND ISNULL(W89.S04ID,'''') = isnull(A14.S04ID,'''') 
			AND ISNULL(W89.S05ID,'''') = isnull(A14.S05ID,'''') AND ISNULL(W89.S06ID,'''') = isnull(A14.S06ID,'''') 
			AND ISNULL(W89.S07ID,'''') = isnull(A14.S07ID,'''') AND ISNULL(W89.S08ID,'''') = isnull(A14.S08ID,'''') 
			AND ISNULL(W89.S09ID,'''') = isnull(A14.S09ID,'''') AND ISNULL(W89.S10ID,'''') = isnull(A14.S10ID,'''') 
			AND ISNULL(W89.S11ID,'''') = isnull(A14.S11ID,'''') AND ISNULL(W89.S12ID,'''') = isnull(A14.S12ID,'''') 
			AND ISNULL(W89.S13ID,'''') = isnull(A14.S13ID,'''') AND ISNULL(W89.S14ID,'''') = isnull(A14.S14ID,'''') 
			AND ISNULL(W89.S15ID,'''') = isnull(A14.S15ID,'''') AND ISNULL(W89.S16ID,'''') = isnull(A14.S16ID,'''') 
			AND ISNULL(W89.S17ID,'''') = isnull(A14.S17ID,'''') AND ISNULL(W89.S18ID,'''') = isnull(A14.S18ID,'''') 
			AND ISNULL(W89.S19ID,'''') = isnull(A14.S19ID,'''') AND ISNULL(W89.S20ID,'''') = isnull(A14.S20ID,'''') 
			LEFT JOIN AT2016 A16 with (nolock) ON A16.DivisionID = A14.DivisionID AND A16.VoucherID = A17.VoucherID
				        
			INNER JOIN AV2777 N with (nolock) on N.TransactionID = A14.ReTransactionID AND N.DivisionID = A14.DivisionID  
			INNER JOIN AV2666 with (nolock) ON AV2666.VoucherID = N.VoucherID AND AV2666.DivisionID = A14.DivisionID' 
			
		SET @sSQL2 = '	
		WHERE ReTranMonth + ReTranYear * 100 < '+STR(@FromMonth + 100 * @FromYear)+'
		  AND A14.DivisionID IN (''' + @DivisionID + ''',''@@@'')
		  AND (A14.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+''')
		  AND (A14.WareHouseID BETWEEN '''+@FromWareHouseID+''' AND '''+@ToWareHouseID+''')  
		  AND ISNULL(AV2666.KindVoucherID,0) IN '+@KindVoucherList+'    
		GROUP BY A14.ReVoucherID, A14.ReTransactionID, A14.InventoryID, A14.WareHouseID, A14.ReVoucherNO, A14.reSourceNO, A14.reWarrantyNo, A14.reShelvesID, A14.reFloorID, WT0169.ShelvesName, WT0170.FloorName,
			     A14.LimitDate,ReQuantity,N.ConvertedQuantity, ReMarkQuantity, N.UnitID, N.OriginalAmount,N.ConvertedAmount, N.UnitPrice, A14.DivisionID,
			     A07.Notes01, A07.Notes02, A07.Notes03, A07.Notes04, A07.Notes05, A07.Notes06, A07.Notes07, A07.Notes08, A07.Notes09,
			     A07.Notes10, A07.Notes11, A07.Notes12, A07.Notes13, A07.Notes14, A07.Notes15, 
			     A07.Parameter01, A07.Parameter02, A07.Parameter03, A07.Parameter04, A07.Parameter05,
			     A17.Ana01ID, A17.Ana02ID, A17.Ana03ID, A17.Ana04ID, A17.Ana05ID,
			     A17.Ana06ID, A17.Ana07ID, A17.Ana08ID, A17.Ana09ID, A17.Ana10ID,
			     ISNULL(A14.S01ID,''''), ISNULL(A14.S02ID,''''), ISNULL(A14.S03ID,''''), ISNULL(A14.S04ID,'''') , ISNULL(A14.S05ID,''''),
			     ISNULL(A14.S06ID,''''), ISNULL(A14.S07ID,''''), ISNULL(A14.S08ID,''''), ISNULL(A14.S09ID,'''') , ISNULL(A14.S10ID,''''),
			     ISNULL(A14.S11ID,''''), ISNULL(A14.S12ID,''''), ISNULL(A14.S13ID,''''), ISNULL(A14.S14ID,'''') , ISNULL(A14.S15ID,''''),
			     ISNULL(A14.S16ID,''''), ISNULL(A14.S17ID,''''), ISNULL(A14.S18ID,''''), ISNULL(A14.S19ID,'''') , ISNULL(A14.S20ID,''''),
				 N.ConvertedUnitID' 		
	END 
  
ELSE -- Theo ngay  
BEGIN
	SET @sSQL1 = '  
	SELECT A14.ReVoucherID, A14.ReTransactionID, A14.WareHouseID, A14.ReVoucherNo VoucherNo,
		A14.InventoryID, A14.ReSourceNo SourceNo, A14.ReWarrantyNo WarrantyNo, A14.ReShelvesID ShelvesID, A14.ReFloorID FloorID, wt0169.ShelvesName, wt0170.FloorName, A14.LimitDate, N.UnitID, N.UnitPrice,
		ReQuantity - SUM(ISNULL(A07.ActualQuantity, 0)) ActualQuantity,  
		N.ConvertedQuantity-SUM(ISNULL(A07.ConvertedQuantity, 0))  ConvertedQuantity, ISNULL(ReMarkQuantity, 0) - SUM(ISNULL(A07.MarkQuantity, 0)) MarkQuantity,
		N.OriginalAmount - SUM(ISNULL(A07.OriginalAmount, 0)) OriginalAmount, N.ConvertedAmount - SUM(ISNULL(A07.ConvertedAmount, 0)) ConvertedAmount,  
		A14.DivisionID, A07.Notes01, A07.Notes02, A07.Notes03, A07.Notes04, A07.Notes05, A07.Notes06, A07.Notes07, A07.Notes08,  
		A07.Notes09, A07.Notes10, A07.Notes11, A07.Notes12, A07.Notes13, A07.Notes14, A07.Notes15, A07.Parameter01,
		A07.Parameter02, A07.Parameter03, A07.Parameter04, A07.Parameter05, A17.Ana01ID, A17.Ana02ID, A17.Ana03ID, A17.Ana04ID, A17.Ana05ID,
			A17.Ana06ID, A17.Ana07ID, A17.Ana08ID, A17.Ana09ID, A17.Ana10ID, MAX(ISNULL(A07.Notes,'''')) Notes, 
		MAX (ISNULL(A07.VoucherDate, A14.ReVoucherDate)) VoucherDate,
		ISNULL(A14.S01ID,'''') AS S01ID, ISNULL(A14.S02ID,'''') AS S02ID, ISNULL(A14.S03ID,'''') AS S03ID, ISNULL(A14.S04ID,'''') AS S04ID, ISNULL(A14.S05ID,'''') AS S05ID, 
		ISNULL(A14.S06ID,'''') AS S06ID, ISNULL(A14.S07ID,'''') AS S07ID, ISNULL(A14.S08ID,'''') AS S08ID, ISNULL(A14.S09ID,'''') AS S09ID, ISNULL(A14.S10ID,'''') AS S10ID,
		ISNULL(A14.S11ID,'''') AS S11ID, ISNULL(A14.S12ID,'''') AS S12ID, ISNULL(A14.S13ID,'''') AS S13ID, ISNULL(A14.S14ID,'''') AS S14ID, ISNULL(A14.S15ID,'''') AS S15ID, 
		ISNULL(A14.S16ID,'''') AS S16ID, ISNULL(A14.S17ID,'''') AS S17ID, ISNULL(A14.S18ID,'''') AS S18ID, ISNULL(A14.S19ID,'''') AS S19ID, ISNULL(A14.S20ID,'''') AS S20ID,
		MAX(A07.ObjectID) AS ObjectID, N.ConvertedUnitID
		FROM AT0114 A14 WITH (NOLOCK)
		left join wt0169 WITH (NOLOCK) ON wt0169.shelvesID = A14.reshelvesID
		left join wt0170 WITH (NOLOCK) ON wt0170.floorID = A14.refloorID
		LEFT JOIN AV2107 A07 WITH (NOLOCK) ON A07.ReTransactionID = A14.ReTransactionID AND CONVERT(VARCHAR, A07.VoucherDate, 112) < '''+CONVERT(VARCHAR, @FromDate, 112)+''' AND A07.DivisionID = A14.DivisionID  
		LEFT JOIN AT2017 A17 WITH (NOLOCK) ON A17.TransactionID = A14.ReTransactionID AND A17.DivisionID = A14.DivisionID
		LEFT JOIN WT8899 W89 WITH (NOLOCK) ON W89.DivisionID = A17.DivisionID AND W89.TransactionID = A17.TransactionID AND W89.VoucherID = A17.VoucherID 
		AND ISNULL(W89.S01ID,'''') = Isnull(A14.S01ID,'''') AND ISNULL(W89.S02ID,'''') = isnull(A14.S02ID,'''')
		AND ISNULL(W89.S03ID,'''') = isnull(A14.S03ID,'''') AND ISNULL(W89.S04ID,'''') = isnull(A14.S04ID,'''') 
		AND ISNULL(W89.S05ID,'''') = isnull(A14.S05ID,'''') AND ISNULL(W89.S06ID,'''') = isnull(A14.S06ID,'''') 
		AND ISNULL(W89.S07ID,'''') = isnull(A14.S07ID,'''') AND ISNULL(W89.S08ID,'''') = isnull(A14.S08ID,'''') 
		AND ISNULL(W89.S09ID,'''') = isnull(A14.S09ID,'''') AND ISNULL(W89.S10ID,'''') = isnull(A14.S10ID,'''') 
		AND ISNULL(W89.S11ID,'''') = isnull(A14.S11ID,'''') AND ISNULL(W89.S12ID,'''') = isnull(A14.S12ID,'''') 
		AND ISNULL(W89.S13ID,'''') = isnull(A14.S13ID,'''') AND ISNULL(W89.S14ID,'''') = isnull(A14.S14ID,'''') 
		AND ISNULL(W89.S15ID,'''') = isnull(A14.S15ID,'''') AND ISNULL(W89.S16ID,'''') = isnull(A14.S16ID,'''') 
		AND ISNULL(W89.S17ID,'''') = isnull(A14.S17ID,'''') AND ISNULL(W89.S18ID,'''') = isnull(A14.S18ID,'''') 
		AND ISNULL(W89.S19ID,'''') = isnull(A14.S19ID,'''') AND ISNULL(W89.S20ID,'''') = isnull(A14.S20ID,'''') 
		LEFT JOIN AT2016 A16 WITH (NOLOCK) ON A16.DivisionID = A14.DivisionID AND A16.VoucherID = A17.VoucherID	
		INNER JOIN AV2777 N WITH (NOLOCK) ON N.TransactionID = A14.ReTransactionID AND N.DivisionID = A14.DivisionID
		INNER JOIN AV2666 WITH (NOLOCK) ON AV2666.VoucherID = N.VoucherID AND AV2666.DivisionID = A14.DivisionID'  
		
	 SET @sSQL2 = '		
	 WHERE CONVERT(VARCHAR, A14.ReVoucherDate, 112) < '''+CONVERT(VARCHAR, @FromDate, 112)+'''
		AND A14.DivisionID IN (''' + @DivisionID + ''',''@@@'')
		AND (A14.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+''')
		AND ( A14.WareHouseID BETWEEN  '''+@FromWareHouseID+''' AND '''+@ToWareHouseID+''')
		AND ISNULL(AV2666.KindVoucherID,0) IN '+@KindVoucherList+'
	 GROUP BY A14.ReVoucherID, A14.ReTransactionID, A14.InventoryID, A14.WareHouseID, A14.ReVoucherNo, A14.ReVoucherDate,
		A14.reSourceNO,  A14.reWarrantyNo, A14.reShelvesID, A14.reFloorID, wt0169.ShelvesName, wt0170.FloorName, A14.LimitDate, ReQuantity,N.ConvertedQuantity, ReMarkQuantity, N.UnitID, N.OriginalAmount,N.ConvertedAmount, N.UnitPrice,
		A14.DivisionID,A07.Notes01, A07.Notes02, A07.Notes03, A07.Notes04, A07.Notes05, A07.Notes06, A07.Notes07, A07.Notes08,  
		A07.Notes09, A07.Notes10, A07.Notes11, A07.Notes12, A07.Notes13, A07.Notes14, A07.Notes15, A07.Parameter01, A07.Parameter02,
		A07.Parameter03, A07.Parameter04, A07.Parameter05, A17.Ana01ID, A17.Ana02ID, A17.Ana03ID, A17.Ana04ID, A17.Ana05ID,
			A17.Ana06ID, A17.Ana07ID, A17.Ana08ID, A17.Ana09ID, A17.Ana10ID,
		ISNULL(A14.S01ID,''''), ISNULL(A14.S02ID,''''), ISNULL(A14.S03ID,''''), ISNULL(A14.S04ID,'''') , ISNULL(A14.S05ID,''''),
		ISNULL(A14.S06ID,''''), ISNULL(A14.S07ID,''''), ISNULL(A14.S08ID,''''), ISNULL(A14.S09ID,'''') , ISNULL(A14.S10ID,''''),
		ISNULL(A14.S11ID,''''), ISNULL(A14.S12ID,''''), ISNULL(A14.S13ID,''''), ISNULL(A14.S14ID,'''') , ISNULL(A14.S15ID,''''),
		ISNULL(A14.S16ID,''''), ISNULL(A14.S17ID,''''), ISNULL(A14.S18ID,''''), ISNULL(A14.S19ID,'''') , ISNULL(A14.S20ID,''''),
		N.ConvertedUnitID'  	
END

IF NOT EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE XTYPE = 'V' AND NAME = 'AV0125')  
	EXEC('CREATE VIEW AV0125  -----TAO BOI AP0112
    AS '+@sSQL1 + @sSQL2)  
ELSE EXEC('ALTER VIEW AV0125  -----TAO BOI AP0112
	AS '+@sSQL1 + @sSQL2)  

--PRINT @sSQL1  
--PRINT @sSQL2

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO