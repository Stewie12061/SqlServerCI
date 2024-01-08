IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3206_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP3206_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
----  Load detail cho form ke thua nhieu don hang bán o phieu xuat kho
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 21/12/2009 by Bao Anh
----
---Created by: Bao Anh, date:21/12/2009
---purpose: Load detail cho form ke thua nhieu don hang bán o phieu xuat kho
/***************************************************************
'* Edited by : [GS] [Quoc Cuong] [29/07/2010]
'**************************************************************/
--- Edited by: Bao Anh	Date: 21/08/2012
--- Purpose: Bo sung cac truong tham so dung cho DVT quy doi theo cong thuc
--- Edited by: Bao Anh	Date: 23/08/2012
--- Purpose: Bo sung truong so luong quy doi va don gia quy doi
---- Modified on 05/09/2012 by Le Thi Thu Hien : Bổ sung điều kiện lọc  IsStock=1 nếu là khách hàng Thuận Lợi
---- Modified on 29/07/2013 by Le Thi Thu Hien : Bổ sung Description
---- Modified on 23/01/2014 by Nguyễn Thanh Sơn : Bổ sung load thêm trường RefInfor (bug 0022002)
---- Modified on 25/06/2015 by Hoang vu: BỔ sung thêm điều kiện load đơn hàng bán đã được điều chỉnh tăng/giảm (Khách hàng secoin)
---- Modified on 21/10/2015 by Kim Vu: Bổ sung load thêm trường Kho giữ chỗ khách hàng SGPT
---- Modified on 11/11/2015 by Tieu Mau: Bo sung load thong tin quy cach hang hoa
---- Modify on 21/01/2016 by Bảo Anh: Gọi store customize cho Angel
---- Modified by Tiểu Mai on 16/09/2016: Bổ sung trường SOrderIDRecognition
---- Modified by Bảo Thy on 18/05/2017: Sửa danh mục dùng chung
---- Modified by Tra Giang on 13/06/2019: Bổ sung VoucherNo
---- Modified by Tuấn Anh on 06/01/2020: Load thêm trường APKOrder - APK của đơn hàng bán : Lưu vết chứng từ tiến độ giao hàng để đồng bộ dữ liệu với WEB
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified on 12/01/2022 by Kiều Nga	: Fix lỗi kế thừa từ đơn hàng bán tại Phiếu Xuất Kho
---- Modified on 26/04/2023 by Đức Duy : Bổ sung các trường dữ liệu WNotes01 -> WNotes15
-- <Example>
---- EXEC AP3206_QC 'HT', '', '', 1

CREATE PROCEDURE [dbo].[AP3206_QC] 
    @DivisionID NVARCHAR(50),
    @lstSOrderID NVARCHAR(MAX),
    -- Thêm mới   : ''
    -- Hiệu chỉnh : Số chứng từ đang sửa
    @VoucherID NVARCHAR(50), 
    @ConnID NVARCHAR(100)
AS

DECLARE 
    @sSQL1 NVARCHAR(MAX),
    @sSQL2 NVARCHAR(MAX),
	@sSQL3 NVARCHAR(MAX),
    @Customize AS INT,
	@sWHERE AS NVARCHAR(4000),
	@sOrderID AS NVARCHAR(Max)
SET @sWHERE = N''
DECLARE	@TempTable table(CustomerName  int,IsExcel  int)

INSERT @TempTable
EXEC	[dbo].[AP4444]

SET @Customize = (SELECT TOP 1 CustomerName FROM @TempTable)

IF @Customize = 57 --- ANGEL
	EXEC AP3206_AG @DivisionID, @lstSOrderID, @VoucherID, @ConnID
ELSE
BEGIN
IF @Customize = 12 ---->> Khách hàng Thuận Lợi
BEGIN
	SET @sWHERE = N'
		AND AT1302.IsStocked = 1 '
END
IF @Customize = 43 ---->> Khách hàng Secoin
	SET @sOrderID = N'inner join (
						Select AQ2901.*
					from
				(		--Begin View Cu AQ2901
						Select OT2001.DivisionID, OT2001.TranMonth, OT2001.TranYear, OT2002.SOrderID,  OT2001.OrderStatus, 
								OT2002.TransactionID, OT2001.Duedate, OT2001.Shipdate, OT2002.InventoryID, 
								Isnull(OT2002.OrderQuantity,0) as OrderQuantity  ,Isnull( G.ActualQuantity,0) as ActualQuantity, 
								OT2001.PaymentTermID,AT1208.Duedays,
								case when OT2002.Finish = 1 
									then NULL else isnull(OT2002.OrderQuantity, 0)
										- isnull(G.ActualQuantity, 0) 
										+ isnull(T.OrderQuantity ,0) end as EndQuantity, 
								G.OrderID as T9OrderID,
								case when OT2002.Finish = 1 
									then NULL else isnull(OT2002.ConvertedQuantity, 0)
													- isnull(G.ActualConvertedQuantity, 0) 
													+ Isnull(T.ConvertedQuantity,0)
								end as EndConvertedQuantity,
								( isnull(OT2002.OriginalAmount,0) - isnull(G.ActualOriginalAmount,0 ) + isnull(T.OriginalAmount,0))  as EndOriginalAmount
						From OT2002 WITH (NOLOCK) inner join OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2002.SOrderID = OT2001.SOrderID
									left join AT1208 WITH (NOLOCK) ON AT1208.PaymentTermID = OT2001.PaymentTermID 	
									left join 	(
													Select AT9000.DivisionID, AT9000.OrderID, OTransactionID,
															InventoryID, sum(Quantity) As ActualQuantity, sum(isnull(OriginalAmount,0)) as ActualOriginalAmount,
															SUM(isnull(ConvertedQuantity,Quantity)) As ActualConvertedQuantity
														From AT9000 WITH (NOLOCK)
														WHERE TransactionTypeID in (''T04'', ''T06'') and IsStock = 0 AND isnull(AT9000.OrderID,'''') <>''''
														Group by AT9000.DivisionID, AT9000.OrderID, InventoryID, OTransactionID
													) as G  --- (co nghia la Giao  hang)
													on 	OT2001.DivisionID = G.DivisionID AND OT2002.SOrderID = G.OrderID 
														and OT2002.InventoryID = G.InventoryID AND OT2002.TransactionID = G.OTransactionID
						--End View Cu AQ2901
									Left join (
												Select D.DivisionID, D.InventoryID, 
														Sum(D.OrderQuantity) as OrderQuantity, 
														Sum(D.ConvertedQuantity) as ConvertedQuantity, 
														Sum(D.OriginalAmount) as OriginalAmount,
														D.InheritVoucherID, D.InheritTransactionID 
												From OT2001 M WITH (NOLOCK) Inner join OT2002 D WITH (NOLOCK) on M.DivisionID = D.DivisionID and M.SOrderID = D.SOrderID
												Where M.OrderTypeID = 1
												Group by D.DivisionID, D.InventoryID, D.InheritVoucherID, D.InheritTransactionID
												) as T on T.DivisionID = OT2002.DivisionID and T.InheritVoucherID = OT2002.SOrderID 
																							and T.InheritTransactionID = OT2002.TransactionID
						Where OT2001.OrderTypeID = 0 or OT2001.OrderTypeID is null
						) AQ2901
						Where AQ2901.EndQuantity > 0) as AQ2903 
						ON AQ2903.DivisionID = OT2002.DivisionID AND AQ2903.SOrderID = OT2002.SOrderID AND AQ2903.TransactionID = OT2002.TransactionID'
Else
	SET @sOrderID = N'INNER JOIN AQ2903 ON AQ2903.DivisionID = OT2002.DivisionID AND AQ2903.SOrderID = OT2002.SOrderID AND AQ2903.TransactionID = OT2002.TransactionID '



SET @DivisionID = ISNULL(@DivisionID, '')
SET @lstSOrderID = ISNULL(@lstSOrderID, '')
SET @VoucherID = ISNULL(@VoucherID, '')
SET @ConnID = ISNULL(@ConnID, '')

SET @lstSOrderID = REPLACE(@lstSOrderID, ',', ''',''')

SET @sSQL1 = '
-- Thông tin phiếu nhập kho
SELECT 
    AT2007.OrderID,
	'''' as VoucherNo,
    AT2007.MOrderID, -- Dùng cho MINH PHUONG
    AT2007.SOrderID, -- Dùng cho MINH PHUONG
    AT2007.MTransactionID, -- Dùng cho MINH PHUONG
    AT2007.STransactionID, -- Dùng cho MINH PHUONG
    AT2007.OTransactionID AS TransactionID,
    AT2007.InventoryID,
    AT1302.InventoryName, 
    AT2007.UnitID,
    AT2007.Parameter01,
    AT2007.Parameter02,
    AT2007.Parameter03,
    AT2007.Parameter04,
    AT2007.Parameter05,
    AT2007.ConvertedQuantity,
    AT2007.ConvertedPrice, 
    0 AS IsEditInventoryName,
    AT2007.ActualQuantity, 
    AT2007.UnitPrice, 
    AT2007.OriginalAmount, 
    AT2007.ConvertedAmount, 
    AT1302.IsSource, 
    AT1302.IsLocation, 
    AT1302.IsLimitDate, 
    AT1302.PrimeCostAccountID AS DebitAccountID, 
    AT1302.AccountID AS CreditAccountID, 
    AT1302.MethodID, 
    AT1302.IsStocked,
    AT2007.Ana01ID, 
    AT2007.Ana02ID, 
    AT2007.Ana03ID, 
    AT2007.Ana04ID, 
    AT2007.Ana05ID, 
    AT2007.Ana06ID, 
    AT2007.Ana07ID, 
    AT2007.Ana08ID, 
    AT2007.Ana09ID, 
    AT2007.Ana10ID, 
    AT2007.Orders,
    1 AS IsCheck, 
    AT2007.Notes, 
    AT1302.IsDiscount, 
    AT2007.DivisionID,
    AT2007.Notes AS Description,
    NULL AS RefInfor,
    AT2007.StandardPrice,
    AT2007.StandardAmount,
	NULL AS WareHouseID, -- Dùng cho SGPT
	W89.S01ID, W89.S02ID, W89.S03ID, W89.S04ID, W89.S05ID, W89.S06ID, W89.S07ID, W89.S08ID, W89.S09ID, W89.S10ID, 
    W89.S11ID, W89.S12ID, W89.S13ID, W89.S14ID, W89.S15ID, W89.S16ID, W89.S17ID, W89.S18ID, W89.S19ID, W89.S20ID,
    AT2007.SOrderIDRecognition, NULL AS APKOrder,
	NULL AS WNotes01, NULL AS WNotes02, NULL AS WNotes03, NULL AS WNotes04, NULL AS WNotes05, 
	NULL AS WNotes06, NULL AS WNotes07, NULL AS WNotes08, NULL AS WNotes09, NULL AS WNotes10, 
	NULL AS WNotes11, NULL AS WNotes12, NULL AS WNotes13, NULL AS WNotes14, NULL AS WNotes15
FROM AT2007 WITH (NOLOCK)
INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT2007.InventoryID = AT1302.InventoryID 
LEFT JOIN  WT8899 W89 WITH (NOLOCK) on W89.DivisionID = AT2007.DivisionID AND W89.TableID = ''AT2007'' and W89.VoucherID = AT2007.VoucherID and W89.TransactionID = AT2007.TransactionID
WHERE AT2007.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(''' + @DivisionID + '''))
    AND AT2007.VoucherID = ''' + @VoucherID + ''' 
    '+@sWHERE+'

UNION
'
SET @sSQL2 = '
-- Thông tin đơn hàng
SELECT 
    OT2002.SOrderID AS OrderID,
	OT2001.VoucherNo,
    OT2002.SOrderID AS MOrderID, -- Dùng cho MINH PHUONG
    OT2002.RefSOrderID AS SOrderID, -- Dùng cho MINH PHUONG
    OT2002.TransactionID AS MTransactionID, -- Dùng cho MINH PHUONG
    OT2002.RefSTransactionID AS STransactionID, -- Dùng cho MINH PHUONG
    OT2002.TransactionID, OT2002.InventoryID, ISNULL(OT2002.InventoryCommonName, AT1302.InventoryName) AS InventoryName, OT2002.UnitID, OT2002.Parameter01,
	OT2002.Parameter02, OT2002.Parameter03, OT2002.Parameter04,OT2002.Parameter05, AQ2903.EndConvertedQuantity as ConvertedQuantity,OT2002.ConvertedSalePrice AS ConvertedPrice, 
    CASE WHEN ISNULL(OT2002.InventoryCommonName, '''') = '''' THEN 0 ELSE 1 END AS IsEditInventoryName,  AQ2903.EndQuantity AS ActualQuantity, 
	OT2002.SalePrice AS UnitPrice,
    CASE WHEN ISNULL(AQ2903.EndQuantity, 0) = ISNULL(AQ2903.OrderQuantity, 0) THEN ISNULL(OT2002.OriginalAmount, 0)  - ISNULL(OT2002.DiscountOriginalAmount, 0)		ELSE ISNULL(AQ2903.EndQuantity, 0) * ISNULL(OT2002.SalePrice, 0) * (100 - ISNULL(OT2002.DiscountPercent, 0)) / 100 END AS OriginalAmount,     
    CASE WHEN ISNULL(AQ2903.EndQuantity, 0) = ISNULL(AQ2903.OrderQuantity, 0) THEN ISNULL(OT2002.ConvertedAmount, 0) - ISNULL(OT2002.DiscountConvertedAmount, 0)	ELSE ISNULL(AQ2903.EndQuantity, 0) * ISNULL(OT2002.SalePrice, 0) * (100 - ISNULL(OT2002.DiscountPercent, 0)) * ISNULL(OT2001.ExchangeRate, 0) / 100 END AS	
	ConvertedAmount, AT1302.IsSource, AT1302.IsLocation, AT1302.IsLimitDate, AT1302.PrimeCostAccountID AS DebitAccountID, AT1302.AccountID AS CreditAccountID, 
	AT1302.MethodID, AT1302.IsStocked,OT2002.Ana01ID, OT2002.Ana02ID, OT2002.Ana03ID, OT2002.Ana04ID, OT2002.Ana05ID, OT2002.Ana06ID, OT2002.Ana07ID, 
	OT2002.Ana08ID, OT2002.Ana09ID, OT2002.Ana10ID, OT2002.Orders,0 AS IsCheck, OT2001.Notes, AT1302.IsDiscount, OT2002.DivisionID, OT2002.Description,
	OT2002.RefInfor, OT2002.StandardPrice, OT2002.StandardAmount,
	OT2002.WareHouseID, -- Dùng cho SGPT
	O89.S01ID, O89.S02ID, O89.S03ID, O89.S04ID, O89.S05ID, O89.S06ID, O89.S07ID, O89.S08ID, O89.S09ID, O89.S10ID, 
    O89.S11ID, O89.S12ID, O89.S13ID, O89.S14ID, O89.S15ID, O89.S16ID, O89.S17ID, O89.S18ID, O89.S19ID, O89.S20ID,
    ISNULL(OT2002.SOrderIDRecognition, OT2002.SOrderID) as SOrderIDRecognition, CONVERT(VARCHAR(100),OT2001.APK) as APKOrder,
	OT2002.nvarchar01 AS WNotes01, 	OT2002.nvarchar02 AS WNotes02, 	OT2002.nvarchar03 AS WNotes03, 	OT2002.nvarchar04 AS WNotes04, 	OT2002.nvarchar05 AS WNotes05, 
	OT2002.nvarchar06 AS WNotes06, 	OT2002.nvarchar07 AS WNotes07, 	OT2002.nvarchar08 AS WNotes08, 	OT2002.nvarchar09 AS WNotes09, 	OT2002.nvarchar10 AS WNotes10, 
	OT2002.nvarchar11 AS WNotes11, 	OT2002.nvarchar12 AS WNotes12, 	OT2002.nvarchar13 AS WNotes13, 	OT2002.nvarchar14 AS WNotes14, 	OT2002.nvarchar15 AS WNotes15
FROM OT2002 WITH (NOLOCK) '
SET @sSQL3 = '
INNER JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2002.SOrderID = OT2001.SOrderID
INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (OT2002.DivisionID,''@@@'') AND OT2002.InventoryID = AT1302.InventoryID
LEFT JOIN OT8899 O89 WITH (NOLOCK) ON O89.DivisionID = OT2002.DivisionID AND O89.TransactionID = OT2002.TransactionID AND O89.VoucherID = OT2002.SOrderID AND O89.TableID = ''OT2002''
 
'+ @sOrderID +'

WHERE OT2002.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(''' + @DivisionID + '''))
    AND OT2002.SOrderID in (''' + @lstSOrderID + ''') 
    AND (CASE WHEN AT1302.IsDiscount = 1 THEN AQ2903.EndOriginalAmount ELSE AQ2903.EndQuantity END ) > 0
    '+@sWHERE+'
' 

--PRINT @sSQL1 
--PRINT @sSQL2
--PRINT @sSQL3

IF NOT EXISTS(SELECT TOP 1 1 FROM sysObjects WHERE XType = 'V' AND Name = 'AV3206' + @ConnID)
    EXEC('CREATE VIEW AV3206' + @ConnID + ' -- Tạo bởi AP3206
            AS ' + @sSQL1 + @sSQL2+ @sSQL3)
ELSE 
    EXEC('ALTER VIEW AV3206' + @ConnID + ' -- Tạo bởi AP3206
            AS ' + @sSQL1 + @sSQL2 + @sSQL3)

IF NOT EXISTS(SELECT TOP 1 1 FROM sysObjects WHERE XType = 'V' AND Name = 'AV3206')
    EXEC('CREATE VIEW AV3206 -- Tạo bởi AP3206
            AS ' + @sSQL1 + @sSQL2 + @sSQL3)
ELSE 
    EXEC('ALTER VIEW AV3206 -- Tạo bởi AP3206
            AS ' + @sSQL1 + @sSQL2 + @sSQL3)

END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

