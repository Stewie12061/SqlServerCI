IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0097]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0097]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load Grid khi kế thừa từ Phiếu yêu cầu nhâp xuất vcnb
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Thanh Sơn on 29/05/2014
---- Modified on 28/10/2015 by Tiểu Mai: bổ sung 20 quy cách từ table WT8899
---- Modified on 02/06/2016 by Bảo Thy: Bổ sung WITH (NOLOCK)
---- Modified on 13/02/2017 by Bảo Thy: Bổ sung ContractNo, COntractID, lấy tên kho Customize EIMSKIP
---- Modified on 16/05/2017 by Hải Long: Chỉnh sửa danh mục dùng chung
---- Modified on 08/06/2017 by Bảo Thy: Fix lỗi Phiếu xuất kho kế thừa phiếu yêu cầu xuất kho lỗi	
---- Modified by Bảo Thy on 13/06/2017: bổ sung 20 tham số master
---- Modified on 03/07/2017 by Hải Long: Lỗi khi kế thừa nhiều lần
---- Modified by Thị Phượng on 15/12/2017 Bổ sung kế thừa thêm trường IsVIP
---- Modified by Hoàng Vũ on 05/03/2017: Fixbug lỗi bảng chuẩn, sử dụng nghiều DivisionID thì dữ liệu hiển thị nhiều dòng
---- Modified by Kiều Nga on 27/04/2020: Fix lỗi cho sửa số lượng xuất kho nhiều hơn số lượng kế thừa từ Yêu cầu xuất kho (customer MaiThu)
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Nhật Quang on 28/12/2022 : Bổ sung trường IsProInventoryID
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Nhật Thanh on 18/08/2023: Bổ sung join thêm POST0022

-- <Example>
/*
    EXEC WP0097 'EIS','','59AI20140000000008'
*/

 CREATE PROCEDURE WP0097
(
     @DivisionID NVARCHAR(2000),
     @UserID VARCHAR(50),
     @VoucherIDList NVARCHAR(MAX)
)
AS
	DECLARE @sSQL   AS NVARCHAR(4000),
			@sSQL0  AS NVARCHAR(4000),
	        @sSQL1  AS NVARCHAR(4000),
	        @sSQL2  AS NVARCHAR(4000),
			@sSQL3  AS NVARCHAR(4000),
			@CustomerIndex INT,
			@sSelect NVARCHAR(MAX)='',
			@sSelect1 NVARCHAR(MAX)='',
			@sJoin NVARCHAR(MAX)=''

SELECT @CustomerIndex = ISNULL(CustomerName,-1) FROM CustomerIndex

IF @CustomerIndex = 70 ----EIMSKIP
BEGIN
	SET @sSelect = ', WT0095.ContractID, WT0095.ContractNo'
	SET @sSelect1 = ', (CASE WHEN WT0095.KindVoucherID IN (1,3,5,7,9) THEN A33.InventoryName ELSE '''' END) ImWareHouseName,
					(CASE WHEN WT0095.KindVoucherID in (2,4,6,8,10) THEN A33.InventoryName
					ELSE CASE WHEN WT0095.KindVoucherID = 3 THEN A03.InventoryName ELSE '''' END END) ExWareHouseName'

	SET @sJoin = 'LEFT JOIN AT1302 A33 WITH (NOLOCK) ON A33.DivisionID IN (''@@@'', WT0095.DivisionID) AND A33.InventoryID =WT0095.WareHouseID
				  LEFT JOIN AT1302 A03 WITH (NOLOCK) ON A03.DivisionID IN (''@@@'', WT0095.DivisionID) AND A03.InventoryID =WT0095.WareHouseID2'
END
ELSE
BEGIN
	SET @sJoin = 'LEFT JOIN AT1303 A33 WITH (NOLOCK) ON A33.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND A33.WareHouseID = WT0095.WareHouseID
				  LEFT JOIN AT1303 A03 WITH (NOLOCK) ON A03.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND A03.WareHouseID = WT0095.WareHouseID2'

	SET @sSelect1 = ', (CASE WHEN WT0095.KindVoucherID IN (1,3,5,7,9) THEN A33.WareHouseName ELSE '''' END) ImWareHouseName,
		(CASE WHEN WT0095.KindVoucherID in (2,4,6,8,10) THEN A33.WareHouseName
		  ELSE CASE WHEN WT0095.KindVoucherID = 3 THEN A03.WareHouseName ELSE '''' END END) ExWareHouseName'
END


IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	EXEC WP0097_QC @DivisionID, @UserID, @VoucherIDList
ELSE 
BEGIN

	        
SET @ssQL = 
	    '
Select 	Distinct WT0095.VoucherID InheritVoucherID,	WT0095.ReDeTypeID,		WT0095.VoucherTypeID,		WT0095.VoucherNo,	WT0095.IsGoodsFirstVoucher, WT0095.IsGoodsRecycled, ''WT0095'' InheritTableID,
	WT0095.VoucherDate,		
	WT0095.RefNo01,
	WT0095.RefNo02,	
	WT0095.KindVoucherID,
	WT0095.RDAddress,
	WT0095.ContactPerson,
	WT0095.InventoryTypeID,
	WT0095.ObjectID,	
	AT1202.ObjectName,
	WT0095.VATObjectName,	
	' +  case when @CustomerIndex = 57 then '
	(CASE WHEN W95.KindVoucherID IN (1,3,5,7,9) THEN A33.WareHouseName ELSE '''' END) ImWareHouseName,
	(CASE WHEN W95.KindVoucherID in (2,4,6,8,10) THEN A33.WareHouseName
		  ELSE CASE WHEN W95.KindVoucherID = 3 THEN A03.WareHouseName ELSE '''' END END) ExWareHouseName,'
		  else '' end + '
	(Case when ISNULL(P22.IsRefund,0) = 2 Then (select top 1 TransportWareHouseID from WT0000 WITH (NOLOCK) where DefDivisionID=WT0095.DivisionID) else (Case when WT0095.KindVoucherID in (1,3,5,7,9) then WT0095.WareHouseID Else '''' End) END) as ImWareHouseID,
	(Case when WT0095.KindVoucherID in (2,4,6,8,10)  then WT0095.WareHouseID Else 
		Case When WT0095.KindVoucherID =3 then WT0095.WareHouseID2 else '''' End End) as ExWareHouseID,
	WT0095.EmployeeID,	WT0096.TransactionID InheritTransactionID,   WT0095.VoucherID,		WT0096.InventoryID,				AT1302.InventoryName,       WT0096.UnitID,		AT1304.UnitName,
    Isnull(WT0096.ActualQuantity, 0) - isnull(G.ActualQuantity,0) AS ActualQuantity,     UnitPrice,       		OriginalAmount,      	WT0096.ConvertedAmount,     	WT0095.Description,			WT0095.TranMonth,	WT0095.TranYear,	WT0095.DivisionID,
    SaleUnitPrice,      SaleAmount,       		DiscountAmount,       	SourceNo,	
    DebitAccountID, 	CreditAccountID,		DA.GroupID AS DebitGroupID	,	CA.GroupID AS CreditGroupID,			
    LocationID,
	ImLocationID, 
	
	Ana01ID,    AT1011_01.AnaName as Ana01Name,
	Ana02ID,    AT1011_02.AnaName as Ana02Name,
	Ana03ID,	AT1011_03.AnaName as Ana03Name,
	Ana04ID, 	AT1011_04.AnaName as Ana04Name,
	Ana05ID,	AT1011_05.AnaName as Ana05Name,
	Ana06ID,    AT1011_06.AnaName as Ana06Name,
	Ana07ID,    AT1011_07.AnaName as Ana07Name,
	Ana08ID,	AT1011_08.AnaName as Ana08Name,
	Ana09ID, 	AT1011_09.AnaName as Ana09Name,
	Ana10ID,	AT1011_10.AnaName as Ana10Name,
	WT0095.IsInheritWarranty, WT0095.EVoucherID, WT0096.WVoucherID, WT0095.IsVoucher,
'
SET @sSQL0 = 
'
	WT0096.Orders, LimitDate, WT0096.Notes as Notes,
	WT0096.ConversionFactor, WT0096.ReVoucherID, WT0096.ReTransactionID,
	WT0096.ReVoucherID as ReOldVoucherID, WT0096.ReTransactionID as ReOldTransactionID,
	Isnull(WT0096.ActualQuantity, 0) - isnull(G.ActualQuantity,0) AS OldQuantity, CreditAccountID AS OldCreditAccountID, WT0096.MarkQuantity AS OldMarkQuantity,
	AT2004.OrderNo as OrderNo,
	WT0096.OrderID, WT0096.OTransactionID, WT0096.MOrderID, WT0096.SOrderID, WT0096.MTransactionID, WT0096.STransactionID,
	AT1302.IsSource,	AT1302.IsLimitDate,	AT1302.IsLocation,
	AT1302.MethodID, AT1302.IsVIP,
	V06.VoucherNo as ReVoucherNo,
	AT1302.AccountID,
	AT1302.Specification,
	AT1302.S1, AT1302.S2, AT1302.S3,
	
	AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, AT1302.Barcode,
	
	-- Phuc vu bao cao  DVT qui doi  cho cac khach hang dung version cu truoc 7.1
	WT0096.PeriodID,
	AT1309.UnitID As ConversionUnitID,
	AT1309.ConversionFactor As ConversionFactor2,
	AT1309.Operator, 
	---------------------------------------

	M01.Description as PeriodName,
    WT0096.ProductID,	AT02.InventoryName as ProductName,
	(Select Top 1 isnull(ExpenseConvertedAmount,0) From AT9000 WITH (NOLOCK) Where AT9000.DivisionID = WT0096.DivisionID AND AT9000.VoucherID = WT0096.VoucherID AND AT9000.TransactionID = WT0096.TransactionID AND TableID = ''AT9000'' AND TransactionTypeID in (''T03'',''T04'',''T24'',''T25'')) As ExpenseConvertedAmount,
	(Select Top 1 isnull(DiscountAmount,0) From AT9000 WITH (NOLOCK) Where AT9000.DivisionID = WT0096.DivisionID AND AT9000.VoucherID = WT0096.VoucherID AND AT9000.TransactionID = WT0096.TransactionID AND TableID = ''AT9000'' AND TransactionTypeID in (''T03'',''T04'',''T24'',''T25'')) As DiscountAmount2,
	(Select Top 1 InvoiceDate From AT9000 WITH (NOLOCK) Where AT9000.DivisionID = WT0096.DivisionID AND AT9000.VoucherID = WT0096.VoucherID AND AT9000.TransactionID = WT0096.TransactionID AND TableID = ''AT9000'' AND TransactionTypeID in (''T03'',''T04'',''T24'',''T25'')) As InvoiceDate,
	'
	
	SET @sSQL1 =
 --   'ActEndQty = (SELECT AT2008.EndQuantity
--		FROM AT2008
--		WHERE AT2008.DivisionID = ''' + @DivisionID + '''
	--		AND AT2008.InventoryID = WT0096.InventoryID
	--		AND AT2008.InventoryAccountID = AT1302.AccountID),
'
	WT0096.ETransactionID, OT2203.EstimateID,
--- Cac thong tin lien quan den DVT qui doi  cho 
	WT0096.Parameter01,WT0096.Parameter02, WT0096.Parameter03,WT0096.Parameter04, WT0096.Parameter05,
	WT0096.ConvertedQuantity, WT0096.ConvertedPrice, isnull(WT0096.ConvertedUnitID,AT1302.UnitID) as ConvertedUnitID ,  isnull(T04.UnitName,AT1304.UnitName) as ConvertedUnitName,
	Isnull(T09.Operator,0) as T09Operator, isnull(T09.ConversionFactor,1) as  T09ConversionFactor ,
	isnull(T09.DataType,0) as DataType  , T09.FormulaID, AT1319.FormulaDes,
	WT0096.LocationCode, WT0096.Location01ID, WT0096.Location02ID, WT0096.Location03ID, WT0096.Location04ID, WT0096.Location05ID,
--- SL mark (yeu cau cua 2T)
	WT0096.MarkQuantity,
	WT0096.Notes AS TDescription,
--- CP khac	(yeu cau cua 2T)
	WT0096.OExpenseConvertedAmount,
	WT0096.Notes01 as WNotes01, WT0096.Notes02 as WNotes02, WT0096.Notes03 as WNotes03, WT0096.Notes04 as WNotes04, WT0096.Notes05 as WNotes05,
	WT0096.Notes06 as WNotes06, WT0096.Notes07 as WNotes07, WT0096.Notes08 as WNotes08,	WT0096.Notes09 as WNotes09, WT0096.Notes10 as WNotes10,
	WT0096.Notes11 as WNotes11, WT0096.Notes12 as WNotes12, WT0096.Notes13 as WNotes13, WT0096.Notes14 as WNotes14, WT0096.Notes15 as WNotes15, WT0095.CreateUserID,
	DA.IsObject as DIsObject, CA.IsObject as CIsObject, WT0096.StandardPrice, WT0096.StandardAmount,
	WT0095.SParameter01, WT0095.SParameter02, WT0095.SParameter03, WT0095.SParameter04, WT0095.SParameter05, WT0095.SParameter06, WT0095.SParameter07, 
	WT0095.SParameter08, WT0095.SParameter09, WT0095.SParameter10, WT0095.SParameter11, WT0095.SParameter12, WT0095.SParameter13, WT0095.SParameter14, 
	WT0095.SParameter15, WT0095.SParameter16, WT0095.SParameter17, WT0095.SParameter18, WT0095.SParameter19, WT0095.SParameter20,P22.IsRefund
	, ISNULL(WT0096.ReceiveQuantity,0) as ReceiveQuantity,WT0096.ActualQuantity as InheritQuantity,WT0095.VoucherNo as InheritVoucherNo
	'+@sSelect+@sSelect1+', WT0096.IsProInventoryID
'
	
	SET @sSQL2 = 
	    'FROM WT0096 WITH (NOLOCK)
INNER JOIN AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (''@@@'', WT0096.DivisionID) AND AT1302.InventoryID =WT0096.InventoryID
LEFT JOIN AT1304 WITH (NOLOCK)	on AT1304.UnitID = WT0096.UnitID
INNER JOIN WT0095 WITH (NOLOCK)	on WT0095.DivisionID  = WT0096.DivisionID AND WT0095.VoucherID =WT0096.VoucherID
LEFT JOIN AT2004 WITH (NOLOCK)	on AT2004.DivisionID  = WT0095.DivisionID AND AT2004.OrderID =WT0095.OrderID
LEFT JOIN AV2006 V06 on V06.DivisionID = WT0096.DivisionID AND V06.VoucherID = WT0096.ReVoucherID AND V06.TransactionID =WT0096.ReTransactionID --AND V06.VoucherNo = WT0095.VoucherNo
LEFT JOIN MT1601 M01 WITH (NOLOCK)	on M01.DivisionID  = WT0096.DivisionID AND M01.PeriodID =WT0096.PeriodID
LEFT JOIN AT1302 AT02 WITH (NOLOCK)	on AT02.DivisionID IN (''@@@'', WT0096.DivisionID) AND AT02.InventoryID =WT0096.ProductID
LEFT JOIN (Select InventoryID,Min(UnitID) As UnitID, Min(ConversionFactor) As ConversionFactor, Min(Operator) As Operator, DivisionID From AT1309 WITH (NOLOCK) Group By InventoryID, DivisionID) AT1309 
on WT0096.InventoryID = AT1309.InventoryID --- Phuc vu bao cao nen chua bo oin nay duoc
LEFT JOIN AT1011 AT1011_01 WITH (NOLOCK) on AT1011_01.AnaID = WT0096.Ana01ID AND AT1011_01.AnaTypeID = ''A01''
LEFT JOIN AT1011 AT1011_02 WITH (NOLOCK) on AT1011_02.AnaID = WT0096.Ana02ID AND AT1011_02.AnaTypeID = ''A02''
LEFT JOIN AT1011 AT1011_03 WITH (NOLOCK) on AT1011_03.AnaID = WT0096.Ana03ID AND AT1011_03.AnaTypeID = ''A03''
LEFT JOIN AT1011 AT1011_04 WITH (NOLOCK) on AT1011_04.AnaID = WT0096.Ana04ID AND AT1011_04.AnaTypeID = ''A04''
LEFT JOIN AT1011 AT1011_05 WITH (NOLOCK) on AT1011_05.AnaID = WT0096.Ana05ID AND AT1011_05.AnaTypeID = ''A05''
Left join AT1011 AT1011_06 WITH (NOLOCK) on AT1011_06.AnaID = WT0096.Ana06ID and AT1011_06.AnaTypeID = ''A06''
Left join AT1011 AT1011_07 WITH (NOLOCK) on AT1011_07.AnaID = WT0096.Ana07ID and AT1011_07.AnaTypeID = ''A07''
Left join AT1011 AT1011_08 WITH (NOLOCK) on AT1011_08.AnaID = WT0096.Ana08ID and AT1011_08.AnaTypeID = ''A08''
Left join AT1011 AT1011_09 WITH (NOLOCK) on AT1011_09.AnaID = WT0096.Ana09ID and AT1011_09.AnaTypeID = ''A09''
Left join AT1011 AT1011_10 WITH (NOLOCK) on AT1011_10.AnaID = WT0096.Ana10ID and AT1011_10.AnaTypeID = ''A10''
LEFT JOIN OT2203 WITH (NOLOCK)	on OT2203.DivisionID = WT0096.DivisionID AND OT2203.TransactionID = WT0096.ETransactionID
LEFT JOIN AT1309 T09 WITH (NOLOCK)	on T09.InventoryID = WT0096.InventoryID AND  WT0096.ConvertedUnitID = T09.UnitID
LEFT JOIN AT1304 T04 WITH (NOLOCK)	on T04.UnitID =  isnull(WT0096.ConvertedUnitID,'''')
LEFT JOIN AT1319 WITH (NOLOCK)	on isnull(T09.FormulaID,'''')  = AT1319.FormulaID 
LEFT JOIN AT1202 WITH (NOLOCK)	on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = WT0095.ObjectID
LEFT JOIN AT1005 DA WITH (NOLOCK)	ON DA.AccountID = WT0096.DebitAccountID
LEFT JOIN AT1005 CA WITH (NOLOCK)	ON CA.AccountID = WT0096.CreditAccountID
LEFT JOIN POST0022 P22 WITH (NOLOCK) ON P22.DivisionID = WT0095.DivisionID  AND P22.VoucherNo = WT0095.RefNo01
LEFT JOIN 
(
	SELECT 
	AT2007.DivisionID, 
	AT2007.OrderID,
	AT2007.InheritVoucherID, 
	AT2007.InheritTransactionID, 
	AT2007.OTransactionID,
	AT2007.InventoryID, 
	SUM(ISNULL(AT2007.ConvertedQuantity, 0)) AS ActualConvertedQuantity, 
	SUM(ISNULL(AT2007.ActualQuantity, 0)) AS ActualQuantity, 
	SUM(ISNULL(AT2007.OriginalAmount, 0)) AS ActualOriginalAmount, 
	SUM(ISNULL(AT2007.ConvertedAmount, 0)) AS ActualConvertedAmount
	FROM AT2007  WITH (NOLOCK)
	INNER JOIN AT2006 WITH (NOLOCK) ON AT2007.VoucherID = AT2006.VoucherID AND AT2007.DivisionID = AT2006.DivisionID
	WHERE AT2007.InheritTableID = ''WT0095''
	GROUP BY AT2007.DivisionID, AT2007.OrderID, InventoryID, OTransactionID, AT2007.InheritVoucherID, AT2007.InheritTransactionID
) AS G ON G.DivisionID = WT0096.DivisionID AND G.InheritVoucherID = WT0096.VoucherID AND G.InheritTransactionID = WT0096.TransactionID 
'

SET @sSQL3 = @sJoin + N'
WHERE  	WT0096.DivisionID =''' +@DivisionID+ '''
AND WT0096.VoucherID IN ('''+@VoucherIDList+''')
AND Isnull(WT0096.ActualQuantity, 0) - isnull(G.ActualQuantity,0) > 0
ORDER BY WT0096.Orders'


--PRINT(@sSQL)
--PRINT( @sSQL0) 
--PRINT (@sSQL1)
--PRINT (@sSQL2)
--PRINT (@sSQL3)

EXEC(@sSQL + @sSQL0 + @sSQL1 + @sSQL2+ @sSQL3)
	
END	



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
