IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP2004]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP2004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- In  bao cao Lenh nhap  kho
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by Khánh Đoan on 02/11/2019
---- Modified by 
---- 
---- Modified on by 
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Huỳnh Thử on 17/12/2020 : Bỏ Left Join AT1020 bị Double
---- Modified by Huỳnh Thử on 05/01/2021 : Bố sung trường LimitDate
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

-- <Example>
/*
    EXEC WP2010 @DivisionID='',@VoucherID=''
*/


CREATE PROCEDURE [dbo].[WP2004] 
(
	 @DivisionID AS nvarchar(50), 
	 @VoucherID NVARCHAR(50)  
)
AS
DECLARE 
	@sSQL NVARCHAR(MAX),
	@sSQL1 NVARCHAR(MAX)
	

SET @sSQL =N' SELECT 
					T07.InventoryID , AT1302.InventoryName , AT1304.UnitName, T07.SourceNo , T07.LimitDate,
					T02.ActualQuantity, AT1303.WareHouseName, 
					T01.VoucherNo as VoucherNoPL ,T01.LocationID,T01.Description,T06.VoucherNo,
					T06.SParameter01,T06.SParameter02,T06.SParameter03,T06.SParameter04,T06.SParameter05,
					T06.SParameter06,T06.SParameter07,T06.SParameter08,T06.SParameter09,T06.SParameter10,
					T06.SParameter11,T06.SParameter12,T06.SParameter13,T06.SParameter14,T06.SParameter15,
					T06.SParameter16,T06.SParameter17,T06.SParameter18,T06.SParameter19,T06.SParameter20,
					AT1405.UserName,AT1202.ObjectName, T06.WareHouseID, T06.VoucherDate,AT1303.Address AS ImAddress,AT1202.Address,
					AT1302.I01ID,AT1302.I02ID,AT1302.I03ID,AT1302.I04ID,AT1302.I05ID,
					AT1302.I06ID,AT1302.I07ID,AT1302.I08ID,AT1302.I09ID,AT1302.I10ID,
					T07.Ana01ID,	T07.Ana02ID,	T07.Ana03ID,	T07.Ana04ID,	T07.Ana05ID,
					T07.Ana06ID,	T07.Ana07ID,	T07.Ana08ID,	T07.Ana09ID,	T07.Ana10ID,
					A01.AnaName Ana01Name, A02.AnaName Ana02Name,A03.AnaName Ana03Name,A04.AnaName Ana04Name,A05.AnaName Ana05Name,
					A06.AnaName Ana06Name, A07.AnaName Ana07Name,A08.AnaName Ana08Name,A09.AnaName Ana09Name,A10.AnaName Ana10Name'

SET @sSQL1 =N'		
			FROM AT2007 T07  WITH (NOLOCK)
			LEFT JOIN AT2006  T06 WITH (NOLOCK) ON T06.VoucherID = T07.VoucherID 
			LEFT JOIN WT2002 T02 WITH (NOLOCK) ON T02.ReTransactionID = T07.TransactionID
			LEFT JOIN WT2001 T01 WITH (NOLOCK) ON T01.VoucherID = T02.VoucherID
			LEFT JOIN AT1302  WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', T02.DivisionID) AND AT1302.InventoryID = T02.InventoryID
			LEFT JOIN AT1405 WITH (NOLOCK) ON AT1405.UserID = T06.EmployeeID
			LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = T06.ObjectID 
			LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (''@@@'', '''+@DivisionID+''') AND AT1303.WareHouseID = T06.WareHouseID
			LEFT JOIN AT1304 WITH (NOLOCK) ON T02.UnitID = AT1304.UnitID
			--LEFT JOIN AT1020 WITH (NOLOCK) ON AT1020.ObjectID = T06.ObjectID 
			LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.AnaID = T07.Ana01ID AND A01.AnaTypeID = ''A01''
			LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A02.AnaID = T07.Ana02ID AND A02.AnaTypeID = ''A02''
			LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.AnaID = T07.Ana03ID AND A03.AnaTypeID = ''A03''
			LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A04.AnaID = T07.Ana04ID AND A04.AnaTypeID = ''A04''
			LEFT JOIN AT1011 A05 WITH (NOLOCK) ON A05.AnaID = T07.Ana05ID AND A05.AnaTypeID = ''A05''
			LEFT JOIN AT1011 A06 WITH (NOLOCK) ON A06.AnaID = T07.Ana06ID AND A06.AnaTypeID = ''A06''
			LEFT JOIN AT1011 A07 WITH (NOLOCK) ON A07.AnaID = T07.Ana07ID AND A07.AnaTypeID = ''A07''
			LEFT JOIN AT1011 A08 WITH (NOLOCK) ON A08.AnaID = T07.Ana08ID AND A08.AnaTypeID = ''A08''
			LEFT JOIN AT1011 A09 WITH (NOLOCK) ON A09.AnaID = T07.Ana09ID AND A09.AnaTypeID = ''A09''
			LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.AnaID = T07.Ana10ID AND A10.AnaTypeID = ''A10''
			WHERE T06.DivisionID = '''+@DivisionID+''' AND T01.KindVoucherID =1 AND
		    T06.VoucherID = '''+@VoucherID+'''
			'

--print @sSQL
--PRINT @sSQL1 
EXEC (@sSQL+@sSQL1 )

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
