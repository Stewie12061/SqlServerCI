IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0115]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0115]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load lưới danh mục phiếu lắp ráp (ANGEL)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by Tiểu Mai on 27/07/2016
---- Modified by Bảo Thy on 26/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Kiều Nga on 10/06/2021 : Bổ sung IsNotUpdatePrice và IsReturn ,@sWhere
---- Modified by Nhật Thanh on 18/02/2022 : Bổ sung điều kiện sort theo VoucherDate,VoucherTypeID, VoucherNo
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

-- <Example>
/*
	WP0115 'HT','07/27/2016', '07/27/2016', 0
*/


CREATE PROCEDURE [DBO].[WP0115]
(
    @DivisionID NVARCHAR(50),
	@FromDate DATETIME,
	@ToDate DATETIME,
	@Mode INT,  --- 0: Lắp ráp, 1: Tháo dỡ
	@sWhere NVARCHAR(4000)=''
)
AS
DECLARE @sSQL NVARCHAR(MAX) = '',
	    @sSQL1 NVARCHAR(MAX) = '',
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
A002.ObjectName, 
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
ISNULL((SELECT TOP 1 IsNotUpdatePrice FROM AT0113 WITH (NOLOCK) WHERE KindVoucherID='+CASE WHEN @Mode  = 0 THEN '2' ELSE '1' END +' AND VoucherID=A01.VoucherID AND IsNotUpdatePrice = 1),0) as IsNotUpdatePrice,
ISNULL((SELECT TOP 1 IsReturn FROM AT0113 WITH (NOLOCK) WHERE KindVoucherID='+CASE WHEN @Mode  = 0 THEN '2' ELSE '1' END +' AND VoucherID=A01.VoucherID AND IsReturn = 1),0) as IsReturn,
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
A1103.FullName EmployeeName,A02.TransactionID,
A12.InventoryName, 	
A02.DebitAccountID, A02.CreditAccountID,
DA.AccountName as DebitAccountName,
CA.AccountName as CreditAccountName,
A02.ConvertedQuantity,
A02.ConvertedPrice,
A02.ConvertedUnitID,			
A02.LocationID, A02.ImLocationID, 
A02.Ana01ID, A_01.AnaName Ana01Name, A02.Ana02ID, A_02.AnaName Ana02Name, 
A02.Ana03ID, A_03.AnaName Ana03Name, A02.Ana04ID, A_04.AnaName Ana04Name, 
A02.Ana05ID, A_05.AnaName Ana05Name, A02.AnA02ID, A_06.AnaName AnA02Name, 
A02.AnA02ID, A_07.AnaName AnA02Name, A02.Ana08ID, A_08.AnaName Ana08Name, 
A02.Ana09ID, A_09.AnaName Ana09Name, A02.Ana10ID, A_10.AnaName Ana10Name,
A02.Parameter01, A02.Parameter02, A02.Parameter03, A02.Parameter04, A02.Parameter05, 
A02.Parameter06, A02.Parameter07, A02.Parameter08, A02.Parameter09, A02.Parameter10
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
	LEFT JOIN AT1103 A11032 WITH (NOLOCK) ON A11032.EmployeeID = A02.ExStoreManID'
	+ CASE WHEN ISNULL(@sWhere,'') <> '' THEN '
	INNER JOIN (SELECT DISTINCT A13.DivisionID, VoucherID FROM AT0113 A13 WITH (NOLOCK) 
				LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID  = A13.DivisionID AND AT1302.InventoryID  = A13.InventoryID 
				WHERE '+@sWhere+') A13 ON A13.DivisionID = A02.DivisionID AND A13.VoucherID = A02.VoucherID' ELSE '' END+ '
WHERE A02.DivisionID = '''+@DivisionID+'''
AND A01.Type = '+CONVERT(NVARCHAR(5),@Mode)+'
AND A02.KindVoucherID = '+CASE WHEN @Mode  = 0 THEN '1' ELSE '2' END +'
AND CONVERT(NVARCHAR(10),A01.VoucherDate,112) between '+CONVERT(NVARCHAR(10),@FromDate,112)+' AND '+ CONVERT(NVARCHAR(10),@ToDate,112)+ '
order by VoucherDate,VoucherTypeID, VoucherNo'




EXEC (@sSQL + @sSQL1 + @sSQL2)
--PRINT (@sSQL)
--PRINT (@sSQL1)
--PRINT (@sSQL2)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
