IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3206]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP3206]
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
---- Modify on 01/08/2016 by Phương Thảo: Customize SG Petro: Thay đổi cách order by
---- Modify on 07/09/2016 by Bảo Thy: Bổ sung ghi nhận đơn hàng SOrderIDRecognition
---- Modified by Tiểu Mai on 18/11/2016: Bổ sung tham số gọi store từ phiếu nhập or phiếu xuất
---- Modified on 18/05/2017 by Bảo Thy: Sửa danh mục dùng chung
---- Modify on 27/12/2017 by Bảo Anh: Trừ thêm tiền giảm giá đối với các cột đơn giá, thành tiền
---- Modify on 13/03/2018 by Bảo Anh: Sửa lỗi không kế thừa được đơn hàng khuyến mãi không nhập giá
---- Modified by Tiểu Mai on 07/06/2018: Bổ sung mã và tên đối tượng cho SGPT
---- Modified by Tra Giang on 21/02/2019: Bổ sung load trường VoucherNo 
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified on 12/01/2022 by Kiều Nga	: Fix lỗi kế thừa từ đơn hàng bán tại Phiếu Xuất Kho
---- Modified on 11/11/2022 by Nhật Quang : Bổ sung thêm trường tham số nvarchar 01 -> 10.
---- Modified on 14/12/2022 by Nhật Quang : Bổ sung lấy thêm trường IsProInventoryID
---- Modified on 14/02/2023 by Xuân Nguyên : Bổ sung lấy thêm trường ProductID và ProductName

-- <Example> 
--- exec AP3206 @Divisionid=N'KVC',@Lstsorderid=N'',@Voucherid=NULL,@Connid=N'55'

CREATE PROCEDURE [dbo].[AP3206] 
    @DivisionID NVARCHAR(50),
    @lstSOrderID NVARCHAR(MAX),
    -- Thêm mới   : ''
    -- Hiệu chỉnh : Số chứng từ đang sửa
    @VoucherID NVARCHAR(50), 
    @ConnID NVARCHAR(100),
    @IsImport TINYINT		----- 0: xuất kho, 1: nhập kho
AS

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	EXEC AP3206_QC @DivisionID, @lstSOrderID, @VoucherID, @ConnID
ELSE
	BEGIN
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
IF @Customize = 38 --- Bourbon
	EXEC AP3206_BBL @DivisionID, @lstSOrderID, @VoucherID, @ConnID, @IsImport
ELSE
BEGIN
IF @Customize = 12 ---->> Khách hàng Thuận Lợi
BEGIN
	SET @sWHERE = N'
		AND AT1302.IsStocked = 1 '
END
IF (@Customize = 43 OR @Customize = 71) ---->> Khách hàng Secoin hoặc HHP
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
ELSE
BEGIN 
	IF @IsImport = 0 
		SET @sOrderID = N'INNER JOIN AQ2903 ON AQ2903.DivisionID = OT2002.DivisionID AND AQ2903.SOrderID = OT2002.SOrderID AND AQ2903.TransactionID = OT2002.TransactionID '
	ELSE 
		SET @sOrderID = N'INNER JOIN (Select OT2001.DivisionID, TranMonth, TranYear, OT2002.SOrderID,  OT2001.OrderStatus, TransactionID, OT2001.Duedate, OT2001.Shipdate,
	OT2002.InventoryID, Isnull(OrderQuantity,0) as OrderQuantity  ,Isnull( ActualQuantity,0) as ActualQuantity, OT2001.PaymentTermID,AT1208.Duedays,
	case when OT2002.Finish = 1 then NULL else isnull(OrderQuantity, 0)- isnull(ActualQuantity, 0) end as EndQuantity, 0 as EndConvertedQuantity,
 ( isnull(OriginalAmount,0) - isnull(ActualOriginalAmount,0 ))  as EndOriginalAmount
From OT2002 inner join OT2001 on OT2002.SOrderID = OT2001.SOrderID
	left join AT1208 on AT1208.PaymentTermID = OT2001.PaymentTermID 	
	left join (Select AT2007.DivisionID, AT2007.OrderID, OTransactionID,
		InventoryID, sum(ActualQuantity) As ActualQuantity, sum(isnull(OriginalAmount,0)) as ActualOriginalAmount
		From AT2007 inner join AT2006 on AT2007.VoucherID = AT2006.VoucherID
		Where isnull(AT2007.OrderID,'''') <>'''' and AT2006.KindVoucherID = 1
		Group by AT2007.DivisionID, AT2007.OrderID, InventoryID, OTransactionID) as G  --- (co nghia la Giao  hang)
		on 	OT2001.DivisionID = G.DivisionID and
			OT2002.SOrderID = G.OrderID and
			OT2002.InventoryID = G.InventoryID and
			OT2002.TransactionID = G.OTransactionID) AQ2903 ON AQ2903.DivisionID = OT2002.DivisionID AND AQ2903.SOrderID = OT2002.SOrderID AND AQ2903.TransactionID = OT2002.TransactionID '

END 


SET @DivisionID = ISNULL(@DivisionID, '')
SET @lstSOrderID = ISNULL(@lstSOrderID, '')
SET @VoucherID = ISNULL(@VoucherID, '')
SET @ConnID = ISNULL(@ConnID, '')

SET @lstSOrderID = REPLACE(@lstSOrderID, ',', ''',''')

IF @Customize = 36 ---->> Khách hàng Sài Gòn Petro
BEGIN
SET @sSQL1 = '
-- Thông tin phiếu nhập kho
SELECT 
	AT2007.UnitID,
	AT1302.InventoryName, 
    AT2007.OrderID,
    AT2007.MOrderID, -- Dùng cho MINH PHUONG
    AT2007.SOrderID, -- Dùng cho MINH PHUONG
    AT2007.MTransactionID, -- Dùng cho MINH PHUONG
    AT2007.STransactionID, -- Dùng cho MINH PHUONG
    AT2007.OTransactionID AS TransactionID,
    AT2007.InventoryID,
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
    1 AS Orders,
    1 AS IsCheck, 
    AT2007.Notes, 
    AT1302.IsDiscount, 
    AT2007.DivisionID,
    AT2007.Notes AS Description,
    NULL AS RefInfor,
    AT2007.StandardPrice,
    AT2007.StandardAmount,
	NULL AS WareHouseID, -- Dùng cho SGPT
	AT2006.ObjectID,
	AT1202.ObjectName,
	AT1202.IsProInventoryID
FROM AT2007 WITH (NOLOCK)
INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT2007.InventoryID = AT1302.InventoryID 
LEFT JOIN AT2006 WITH (NOLOCK) ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT2006.DivisionID = AT1202.DivisionID AND AT1202.ObjectID = AT2006.ObjectID 
WHERE AT2007.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(''' + @DivisionID + '''))
    AND AT2007.VoucherID = ''' + @VoucherID + ''' 
    '+@sWHERE+'

UNION
'
SET @sSQL2 = '
-- Thông tin đơn hàng
SELECT 
    OT2002.UnitID, ISNULL(OT2002.InventoryCommonName, AT1302.InventoryName) AS InventoryName, OT2002.SOrderID AS OrderID,
    OT2002.SOrderID AS MOrderID, -- Dùng cho MINH PHUONG
    OT2002.RefSOrderID AS SOrderID, -- Dùng cho MINH PHUONG
    OT2002.TransactionID AS MTransactionID, -- Dùng cho MINH PHUONG
    OT2002.RefSTransactionID AS STransactionID, -- Dùng cho MINH PHUONG
    OT2002.TransactionID, OT2002.InventoryID, OT2002.Parameter01,
	OT2002.Parameter02, OT2002.Parameter03, OT2002.Parameter04,OT2002.Parameter05, AQ2903.EndConvertedQuantity as ConvertedQuantity,OT2002.ConvertedSalePrice AS ConvertedPrice, 
    CASE WHEN ISNULL(OT2002.InventoryCommonName, '''') = '''' THEN 0 ELSE 1 END AS IsEditInventoryName,  AQ2903.EndQuantity AS ActualQuantity, 
	OT2002.SalePrice AS UnitPrice,
    CASE WHEN ISNULL(AQ2903.EndQuantity, 0) = ISNULL(AQ2903.OrderQuantity, 0) THEN ISNULL(OT2002.OriginalAmount, 0)  - ISNULL(OT2002.DiscountOriginalAmount, 0)		ELSE ISNULL(AQ2903.EndQuantity, 0) * ISNULL(OT2002.SalePrice, 0) * (100 - ISNULL(OT2002.DiscountPercent, 0)) / 100 END AS OriginalAmount,     
    CASE WHEN ISNULL(AQ2903.EndQuantity, 0) = ISNULL(AQ2903.OrderQuantity, 0) THEN ISNULL(OT2002.ConvertedAmount, 0) - ISNULL(OT2002.DiscountConvertedAmount, 0)	ELSE ISNULL(AQ2903.EndQuantity, 0) * ISNULL(OT2002.SalePrice, 0) * (100 - ISNULL(OT2002.DiscountPercent, 0)) * ISNULL(OT2001.ExchangeRate, 0) / 100 END AS	
	ConvertedAmount, AT1302.IsSource, AT1302.IsLocation, AT1302.IsLimitDate, AT1302.PrimeCostAccountID AS DebitAccountID, AT1302.AccountID AS CreditAccountID, 
	AT1302.MethodID, AT1302.IsStocked,OT2002.Ana01ID, OT2002.Ana02ID, OT2002.Ana03ID, OT2002.Ana04ID, OT2002.Ana05ID, OT2002.Ana06ID, OT2002.Ana07ID, 
	OT2002.Ana08ID, OT2002.Ana09ID, OT2002.Ana10ID, 1 AS Orders,0 AS IsCheck, OT2001.Notes, AT1302.IsDiscount, OT2002.DivisionID, OT2002.Description,
	OT2002.RefInfor, OT2002.StandardPrice, OT2002.StandardAmount,
	OT2002.WareHouseID, -- Dùng cho SGPT
	OT2001.ObjectID,
	AT1202.ObjectName
	OT2002.IsProInventoryID
FROM OT2002 WITH (NOLOCK) '
SET @sSQL3 = '
INNER JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2002.SOrderID = OT2001.SOrderID
INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DIvisionID IN (OT2002.DivisionID,''@@@'') AND OT2002.InventoryID = AT1302.InventoryID
LEFT JOIN AT1202 WITH (NOLOCK) ON OT2001.DivisionID = AT1202.DivisionID AND AT1202.ObjectID = OT2001.ObjectID 
 
'+ @sOrderID +'

WHERE OT2002.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(''' + @DivisionID + '''))
    AND OT2002.SOrderID in (''' + @lstSOrderID + ''') 
    AND (CASE WHEN AT1302.IsDiscount = 1 THEN AQ2903.EndOriginalAmount ELSE AQ2903.EndQuantity END ) > 0
    '+@sWHERE+'
' 	
END
ELSE
BEGIN
SET @sSQL1 = '
-- Thông tin phiếu nhập kho
SELECT '''' AS VoucherNo,
    AT2007.OrderID,
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
	NULL AS WareHouseID -- Dùng cho SGPT
	, NULL AS SOrderIDRecognition,
	AT1302.Barcode,
	NULL AS W01,
	NULL AS W02,
	NULL AS W03,
	NULL AS W04,
	NULL AS W05,
	NULL AS W06,
	NULL AS W07,
	NULL AS W08,
	NULL AS W09,
	NULL AS W10,
	AT2007.IsProInventoryID,
	AT2007.ProductID,NULL as ProductName
FROM AT2007 WITH (NOLOCK)
INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT2007.InventoryID = AT1302.InventoryID 
WHERE AT2007.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(''' + @DivisionID + '''))
    AND AT2007.VoucherID = ''' + @VoucherID + ''' 
    '+@sWHERE+'

UNION
'
SET @sSQL2 = '
-- Thông tin đơn hàng
SELECT OT2001.VoucherNo,
    OT2002.SOrderID AS OrderID,
    OT2002.SOrderID AS MOrderID, -- Dùng cho MINH PHUONG
    OT2002.RefSOrderID AS SOrderID, -- Dùng cho MINH PHUONG
    OT2002.TransactionID AS MTransactionID, -- Dùng cho MINH PHUONG
    OT2002.RefSTransactionID AS STransactionID, -- Dùng cho MINH PHUONG
    OT2002.TransactionID, OT2002.InventoryID, ISNULL(OT2002.InventoryCommonName, AT1302.InventoryName) AS InventoryName, OT2002.UnitID, OT2002.Parameter01,
	OT2002.Parameter02, OT2002.Parameter03, OT2002.Parameter04,OT2002.Parameter05, AQ2903.EndConvertedQuantity as ConvertedQuantity,
	(OT2002.ConvertedSalePrice - ISNULL(OT2002.SaleOffAmount01,0) - ISNULL(OT2002.SaleOffAmount02,0) - ISNULL(OT2002.SaleOffAmount03,0) - ISNULL(OT2002.SaleOffAmount04,0) - ISNULL(OT2002.SaleOffAmount05,0)) AS ConvertedPrice,
    CASE WHEN ISNULL(OT2002.InventoryCommonName, '''') = '''' THEN 0 ELSE 1 END AS IsEditInventoryName,  AQ2903.EndQuantity AS ActualQuantity, 
	(OT2002.SalePrice - ISNULL(OT2002.SaleOffAmount01,0) - ISNULL(OT2002.SaleOffAmount02,0) - ISNULL(OT2002.SaleOffAmount03,0) - ISNULL(OT2002.SaleOffAmount04,0) - ISNULL(OT2002.SaleOffAmount05,0)) AS UnitPrice,
    
	--(CASE WHEN ISNULL(AQ2903.EndQuantity, 0) = ISNULL(AQ2903.OrderQuantity, 0) THEN ISNULL(OT2002.OriginalAmount, 0)  - ISNULL(OT2002.DiscountOriginalAmount, 0)		ELSE ISNULL(AQ2903.EndQuantity, 0) * ISNULL(OT2002.SalePrice, 0) * (100 - ISNULL(OT2002.DiscountPercent, 0)) / 100 END) - ISNULL(AQ2903.EndQuantity, 0)*(ISNULL(OT2002.SaleOffAmount01,0) - ISNULL(OT2002.SaleOffAmount02,0) - ISNULL(OT2002.SaleOffAmount03,0) - ISNULL(OT2002.SaleOffAmount04,0) - ISNULL(OT2002.SaleOffAmount05,0)) AS OriginalAmount,     
    --(CASE WHEN ISNULL(AQ2903.EndQuantity, 0) = ISNULL(AQ2903.OrderQuantity, 0) THEN ISNULL(OT2002.ConvertedAmount, 0) - ISNULL(OT2002.DiscountConvertedAmount, 0)	ELSE ISNULL(AQ2903.EndQuantity, 0) * ISNULL(OT2002.SalePrice, 0) * (100 - ISNULL(OT2002.DiscountPercent, 0)) * ISNULL(OT2001.ExchangeRate, 0) / 100 END) - ISNULL(AQ2903.EndQuantity, 0)*(ISNULL(OT2002.SaleOffAmount01,0) - ISNULL(OT2002.SaleOffAmount02,0) - ISNULL(OT2002.SaleOffAmount03,0) - ISNULL(OT2002.SaleOffAmount04,0) - ISNULL(OT2002.SaleOffAmount05,0)) AS ConvertedAmount,
	
	(ISNULL(AQ2903.EndQuantity, 0) * (OT2002.SalePrice - ISNULL(OT2002.SaleOffAmount01,0) - ISNULL(OT2002.SaleOffAmount02,0) - ISNULL(OT2002.SaleOffAmount03,0) - ISNULL(OT2002.SaleOffAmount04,0) - ISNULL(OT2002.SaleOffAmount05,0))) AS OriginalAmount,
	(ISNULL(AQ2903.EndQuantity, 0) * (OT2002.SalePrice - ISNULL(OT2002.SaleOffAmount01,0) - ISNULL(OT2002.SaleOffAmount02,0) - ISNULL(OT2002.SaleOffAmount03,0) - ISNULL(OT2002.SaleOffAmount04,0) - ISNULL(OT2002.SaleOffAmount05,0))) AS ConvertedAmount,
	
	AT1302.IsSource, AT1302.IsLocation, AT1302.IsLimitDate, AT1302.PrimeCostAccountID AS DebitAccountID, AT1302.AccountID AS CreditAccountID, 
	AT1302.MethodID, AT1302.IsStocked,OT2002.Ana01ID, OT2002.Ana02ID, OT2002.Ana03ID, OT2002.Ana04ID, OT2002.Ana05ID, OT2002.Ana06ID, OT2002.Ana07ID, 
	OT2002.Ana08ID, OT2002.Ana09ID, OT2002.Ana10ID, OT2002.Orders,0 AS IsCheck, OT2001.Notes, AT1302.IsDiscount, OT2002.DivisionID, OT2002.Description,
	OT2002.RefInfor, OT2002.StandardPrice, OT2002.StandardAmount,
	OT2002.WareHouseID -- Dùng cho SGPT
	,OT2002.SOrderIDRecognition,
	AT1302.Barcode,
	OT2002.nvarchar01 AS W01,
	OT2002.nvarchar02 AS W02,
	OT2002.nvarchar03 AS W03,
	OT2002.nvarchar04 AS W04,
	OT2002.nvarchar05 AS W05,
	OT2002.nvarchar06 AS W06,
	OT2002.nvarchar07 AS W07,
	OT2002.nvarchar08 AS W08,
	OT2002.nvarchar09 AS W09,
	OT2002.nvarchar10 AS W10,
	OT2002.IsProInventoryID,
	OT2002.ProductID,OT2002.ProductName
FROM OT2002 WITH (NOLOCK) '
SET @sSQL3 = '
INNER JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2002.SOrderID = OT2001.SOrderID
INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (OT2002.DivisionID,''@@@'') AND OT2002.InventoryID = AT1302.InventoryID
 
'+ @sOrderID +'

WHERE OT2002.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(''' + @DivisionID + '''))
    AND OT2002.SOrderID in (''' + @lstSOrderID + ''') 
    --AND (CASE WHEN AT1302.IsDiscount = 1 THEN AQ2903.EndOriginalAmount ELSE AQ2903.EndQuantity END ) > 0
	AND (AQ2903.EndOriginalAmount > 0 OR AQ2903.EndQuantity > 0)
    '+@sWHERE+'
' 
END

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

END 




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
