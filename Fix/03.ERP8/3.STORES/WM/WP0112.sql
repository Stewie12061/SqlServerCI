IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0112]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0112]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load edit/view cho các phiếu lắp ráp
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by Tiểu Mai on 27/07/2016
---- Modified by Hải Long on 27/12/2016: Bổ sung trường ObjectIDName
---- Modified by Bảo Thy on 26/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Kiều Nga on 14/06/2021 : Bổ sung quy cách
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Thanh Lượng on 07/08/2023: [2023/08/IS/0091] - Bổ sung thêm trường ApportionID(Bộ định mức).


-- <Example>
/*
	WP0112 'HT','', 1
*/


CREATE PROCEDURE [DBO].[WP0112]
(
    @DivisionID NVARCHAR(50),
	@VoucherID NVARCHAR(50),
	@Type INT
)
AS
DECLARE @sSQL NVARCHAR(MAX)='',
	    @sSQL1 NVARCHAR(MAX)='',
	    @sSQL2 NVARCHAR(MAX) = ''



SET @ssQL = '
SELECT 
A01.DivisionID,
A01.VoucherID,
A01.TableID,
A01.TranMonth,
A01.TranYear,
A01.VoucherTypeID,
A01.VoucherDate,
A01.VoucherNo,
A01.ObjectID,
A01.BatchID,
A01.Type,
A01.EmployeeID,
A01.Description,
A01.CreateDate,
A01.CreateUserID,
A01.LastModifyUserID,
A01.LastModifyDate,
A01.RefNo01,
A01.RefNo02,
A002.ObjectName, A01.ObjectID + '' - '' + A002.ObjectName as ObjectIDName,
A02.KindVoucherID,
A02.ImWareHouseID,
A02.ExWareHouseID,
A03.WareHouseName as ImWareHouseName,
A031.WareHouseName as ExWareHouseName,
A02.InventoryID,
A02.UnitID,
A02.ActualQuantity,
A02.UnitPrice,
A04.UnitName,
A02.OriginalAmount,
A02.ConvertedAmount,
A02.IsLedger,
'
SET @sSQL1 = '
A02.Notes,
A02.CurrencyID,
A02.ExchangeRate,
A02.SourceNo,
A02.LocationID,
A02.ImLocationID,
A02.LimitDate,
A02.Orders,
A02.ConversionFactor,
A02.ImStoreManID,
A02.ExStoreManID,
A11031.FullName as ImStoreManName,
A11031.FullName as ExStoreManName,
A1103.FullName EmployeeName, A02.TransactionID,
A12.InventoryName, 	
A02.DebitAccountID, A02.CreditAccountID,
DA.AccountName as DebitAccountName,
CA.AccountName as CreditAccountName,
A02.ConvertedQuantity,
A02.ConvertedPrice,
A02.ConvertedUnitID,	
A02.ReVoucherID,
A02.ReTransactionID,		 
A02.Ana01ID, A_01.AnaName Ana01Name, A02.Ana02ID, A_02.AnaName Ana02Name, 
A02.Ana03ID, A_03.AnaName Ana03Name, A02.Ana04ID, A_04.AnaName Ana04Name, 
A02.Ana05ID, A_05.AnaName Ana05Name, A02.Ana06ID, A_06.AnaName Ana06Name, 
A02.Ana07ID, A_07.AnaName Ana07Name, A02.Ana08ID, A_08.AnaName Ana08Name, 
A02.Ana09ID, A_09.AnaName Ana09Name, A02.Ana10ID, A_10.AnaName Ana10Name,
A02.Parameter01, A02.Parameter02, A02.Parameter03, A02.Parameter04, A02.Parameter05, 
A02.Parameter06, A02.Parameter07, A02.Parameter08, A02.Parameter09, A02.Parameter10, T2.VoucherNo as ReVoucherNo,A02.Rate,A01.Apportion,A01.ApportionID
,O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID
'

SET @sSQL2 = '
FROM AT0113 A02 WITH (NOLOCK)
	INNER JOIN AT0112 A01 WITH (NOLOCK) ON A01.DivisionID = A02.DivisionID AND A01.VoucherID = A02.VoucherID
	LEFT JOIN AT1309 T09 WITH (NOLOCK) ON T09.InventoryID = A02.InventoryID AND A02.ConvertedUnitID = T09.UnitID
	LEFT JOIN AT1304 T04 WITH (NOLOCK) ON T04.UnitID = ISNULL(A02.ConvertedUnitID,'''')
	LEFT JOIN AT1011 A_01 WITH (NOLOCK) ON A_01.AnaID = A02.Ana01ID AND A_01.AnaTypeID = ''A01''
	LEFT JOIN AT1011 A_02 WITH (NOLOCK) ON A_02.AnaID = A02.Ana02ID AND A_02.AnaTypeID = ''A02''
	LEFT JOIN AT1011 A_03 WITH (NOLOCK) ON A_03.AnaID = A02.Ana03ID AND A_03.AnaTypeID = ''A03''
	LEFT JOIN AT1011 A_04 WITH (NOLOCK) ON A_04.AnaID = A02.Ana04ID AND A_04.AnaTypeID = ''A04''
	LEFT JOIN AT1011 A_05 WITH (NOLOCK) ON A_05.AnaID = A02.Ana05ID AND A_05.AnaTypeID = ''A05''
	LEFT JOIN AT1011 A_06 WITH (NOLOCK) ON A_06.AnaID = A02.Ana06ID AND A_06.AnaTypeID = ''A02''
	LEFT JOIN AT1011 A_07 WITH (NOLOCK) ON A_07.AnaID = A02.Ana07ID AND A_07.AnaTypeID = ''A07''
	LEFT JOIN AT1011 A_08 WITH (NOLOCK) ON A_08.AnaID = A02.Ana08ID AND A_08.AnaTypeID = ''A08''
	LEFT JOIN AT1011 A_09 WITH (NOLOCK) ON A_09.AnaID = A02.Ana09ID AND A_09.AnaTypeID = ''A09''
	LEFT JOIN AT1011 A_10 WITH (NOLOCK) ON A_10.AnaID = A02.Ana10ID AND A_10.AnaTypeID = ''A10''
	LEFT JOIN AT1005 DA	WITH (NOLOCK) ON DA.AccountID = A02.DebitAccountID
	LEFT JOIN AT1005 CA	WITH (NOLOCK) ON CA.AccountID = A02.CreditAccountID
	LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.UnitID = A02.UnitID
	LEFT JOIN AT1302 A12 WITH (NOLOCK) ON A12.DivisionID IN (''@@@'', A02.DivisionID) AND A12.InventoryID = A02.InventoryID
	LEFT JOIN AT1303 A03 WITH (NOLOCK) ON A03.DivisionID IN (''@@@'', '''+@DivisionID+''') AND A03.WareHouseID = A02.ImWareHouseID
	LEFT JOIN AT1303 A031 WITH (NOLOCK) ON A031.DivisionID IN (''@@@'', '''+@DivisionID+''') AND A031.WareHouseID = A02.ExWareHouseID
	LEFT JOIN AT1202 A002 WITH (NOLOCK) ON A002.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A002.ObjectID = A01.ObjectID
	LEFT JOIN AT1103 A1103 WITH (NOLOCK) ON A1103.EmployeeID = A01.EmployeeID
	LEFT JOIN AT1103 A11031 WITH (NOLOCK) ON A11031.EmployeeID = A02.ImStoreManID
	LEFT JOIN AT1103 A11032 WITH (NOLOCK) ON A11032.EmployeeID = A02.ExStoreManID
	LEFT JOIN AV2006 T2 ON A02.DivisionID = T2.DivisionID AND T2.VoucherID = A02.ReVoucherID AND T2.TransactionID = A02.ReTransactionID	
	LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = A02.DivisionID AND O99.TransactionID = A02.TransactionID and O99.VoucherID = A02.VoucherID
WHERE A02.DivisionID = '''+@DivisionID+'''
AND A02.VoucherID = '''+@VoucherID+''' 
AND A01.Type = '+CONVERT(NVARCHAR(5),@Type)+'
ORDER BY A02.Orders, A02.KindVoucherID
'


EXEC (@sSQL + @sSQL1 + @sSQL2)
--PRINT (@sSQL)
--PRINT (@sSQL0)
--PRINT (@sSQL00)
--PRINT (@sSQL1)
--PRINT (@sSQL2)
--PRINT (@sSQL4)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
