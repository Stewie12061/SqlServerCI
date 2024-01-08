IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP2005]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP2005]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
--- In  bao cao Lenh xuat kho
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by Khánh Đoan on 07/10/2019  
---- Modified by Huỳnh Thử on 18/12/2019 Lấy thêm số chứng từ lệnh xuất kho, số tồn tại hiện tại
---- Modified by Huỳnh Thử on 11/03/2020 Lấy thêm trường Phiếu pallet
---- Modified by Huỳnh Thử on 17/04/2020 Thay đổi VoucherData từ At2006 sang WT2001- Lệnh xuất kho
---- Modified by Huỳnh Thử on 28/08/2020 where VoucherData lệch xuất kho, lấy số tồn hiện tại của ngày in báo cáo
---- Modified by Huỳnh Thử on 28/08/2020 Lấy Số chứng từ yêu cầu xuất kho
---- Modified by Huỳnh Thử on 23/09/2020 -- Tính tổng số lượng đã xuất trước lệch xuất kho này
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- 
---- Modified on by 
-- <Example>
/*
    EXEC WP2010 @DivisionID='',@VoucherID=''
*/

CREATE PROCEDURE [dbo].[WP2005] 
(
	 @DivisionID AS nvarchar(50), 
	 @VoucherID NVARCHAR(50),
	 @VoucherDate DATETIME
)
AS
DECLARE 
	@sSQL NVARCHAR(MAX),
	@sSQL1 NVARCHAR(MAX)
	
SET @sSQL =N' 

					SELECT DISTINCT T02.RePTransactionID,
					T02.InventoryID , AT1302.InventoryName , 
					AT1302.I01ID,AT1302.I02ID,AT1302.I03ID,AT1302.I04ID,AT1302.I05ID,
					AT1302.I06ID,AT1302.I07ID,AT1302.I08ID,AT1302.I09ID,AT1302.I10ID,
					T02.SourceNo , 
					T02.ActualQuantity,T011_PL.VoucherNo AS VoucherNoPallet, T02.LocationID,T01.VoucherDate,T07.LimitDate,
					T07.Ana01ID,	T07.Ana02ID,	T07.Ana03ID,	T07.Ana04ID,	T07.Ana05ID,
					T07.Ana06ID,	T07.Ana07ID,	T07.Ana08ID,	T07.Ana09ID,	T07.Ana10ID,
					T06.SParameter01,T06.SParameter02,T06.SParameter03,T06.SParameter04,T06.SParameter05,
					T06.SParameter06,T06.SParameter07,T06.SParameter08,T06.SParameter09,T06.SParameter10,
					T06.SParameter11,T06.SParameter12,T06.SParameter13,T06.SParameter14,T06.SParameter15,
					T06.SParameter16,T06.SParameter17,T06.SParameter18,T06.SParameter19,T06.SParameter20,
					AT1405.UserName,AT1202.ObjectName, T06.WareHouseID,AT1303.Address AS ImAddress,AT1202.Address, T01.VoucherNo,T95.VoucherNo AS VoucherNoYCXK,
					((SELECT ISNULL(ActualQuantity, 0) FROM WT2002 WHERE VoucherID = T02.RePVoucherID AND TransactionID = T02.RePTransactionID) - 
					ISNULL((SELECT SUM(WT2002.ActualQuantity) FROM WT2002 WITH (NOLOCK)
						LEFT JOIN WT2001 ON WT2001.VoucherID = WT2002.VoucherID 
						WHERE WT2001.KindVoucherID = 2 AND WT2002.RePTransactionID = T02.RePTransactionID 
						AND WT2001.VoucherDate < '''+CONVERT(NVARCHAR(50),@VoucherDate,120)+'''),0) -- Tính tổng số lượng đã xuất trước lệch xuất kho này
					- ISNULL(T02.ActualQuantity, 0)) AS EndQuantity
					'
					
SET @sSQL1 =N'	
					FROM 	WT2002 T02 WITH (NOLOCK)
					LEFT JOIN WT2001 T01 WITH (NOLOCK) ON T01.VoucherID = T02.VoucherID
					LEFT JOIN WT2001 T011_PL WITH (NOLOCK) ON T011_PL.VoucherID = T02.RePVoucherID
					LEFT JOIN WT0095 T95 WITH (NOLOCK) ON T95.VoucherID = T02.InheritVoucherID
					LEFT JOIN WT2001 T011 WITH (NOLOCK) ON T011.VoucherID = T02.RePVoucherID
					LEFT JOIN AT2007 T07  WITH (NOLOCK) ON T07.VoucherID = T02.ReVoucherID  AND T07.TransactionID = T02.ReTransactionID 
					LEFT JOIN AT2006  T06 WITH (NOLOCK) ON T06.VoucherID = T07.VoucherID  
					LEFT JOIN AT1302  WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', T02.DivisionID) AND AT1302.InventoryID = T02.InventoryID
					LEFT JOIN AT1405 WITH (NOLOCK) ON AT1405.UserID = T06.EmployeeID
					LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = T06.ObjectID 
					LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (''@@@'', '''+@DivisionID+''') AND AT1303.WareHouseID = T06.WareHouseID
					LEFT JOIN AT1020 WITH (NOLOCK) ON AT1020.ObjectID = T06.ObjectID 
					WHERE T01.DivisionID = '''+@DivisionID+''' AND T01.KindVoucherID =2 AND
					T01.VoucherID = '''+@VoucherID+'''
					
					'

print @sSQL
PRINT @sSQL1 
EXEC (@sSQL+@sSQL1 )

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
	