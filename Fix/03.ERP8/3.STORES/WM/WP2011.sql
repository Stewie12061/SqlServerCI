IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP2011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP2011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-------- Date 12/11/2019. Thẻ Pallet
-------- Created by		Khánh Đoan.
-------- Update by on 19/02/2020	Huỳnh Thử -- lấy thêm cột vị trí ô WT2001
-------- Update by on 16/03/2020	Huỳnh Thử -- Trừ số lượng đã kế thừa từ lệnh xuất kho
-------- Update by on 23/03/2020	Huỳnh Thử -- Thêm IsNull
-------- Update by on 03/04/2020	Huỳnh Thử -- Số lượng tồn > 0
-------- Update by on 03/04/2020    Huỳnh Thử -- Bổ sung danh mục dùng chung
-------- Update by on 18/11/2020	Huỳnh Thử -- Lấy số lượng thực xuất từ phiếu xuất thay vì từ YCXK > 0
-------- Update by on 28/12/2020	Huỳnh Thử -- Bổ sung in hàng loạt
-------- Update by on 28/12/2020	Huỳnh Thử -- Cải tiến tốc độ
-------- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE [dbo].[WP2011]  	(
			@DivisionID AS nvarchar(50),
			@VoucherID AS nvarchar(MAX)

		)
AS

declare 
	@sSQL1 AS nvarchar(max)



SET @sSQL1='

		select LNK.VoucherID,SUM (AT2007.ActualQuantity) AS ActualQuantity 
		INTO #temp
		From AT2007 with (Nolock) 
		left join WT2002 LXK with (Nolock) on LXK.VoucherID  = AT2007.InheritVoucherID AND LXK.TransactionID  = AT2007.InheritTransactionID
		left join WT2002 LNK with (Nolock) on LNK.VoucherID  = LXK.RePVoucherID AND LNK.TransactionID  = LXK.RePTransactionID
		--where LNK.VoucherID is not null
		group by LNK.VoucherID

	--- Xuất
	SELECT T02.RePTransactionID AS TransactionID,T02.RePVoucherID AS VoucherID,
	(A.ActualQuantity)  AS ActualQuantity 
	INTO #TAM FROM WT2002 T02 WITH (NOLOCK)
	LEFT JOIN WT2001 T01 WITH (NOLOCK) ON  T01.VoucherID = T02.VoucherID
	LEFT JOIN #temp A on A.VoucherID = T01.VoucherID
	WHERE T01.KindVoucherID = 2
	AND T02.RePVoucherID in ('+@VoucherID+')

	--- Nhập
	SELECT * FROM (
		SELECT T02.InventoryID , AT1302.InventoryName,T01.VoucherNo, T02.SourceNo,T01.LocationID,
		AT1302.I01ID,AT1302.I02ID,AT1302.I03ID,AT1302.I04ID,AT1302.I05ID,
		AT1302.I06ID,AT1302.I07ID,AT1302.I08ID,AT1302.I09ID,AT1302.I10ID,
		T02.ActualQuantity - (select ISNULL(SUM(#TAM.ActualQuantity),0) FROM #TAM WHERE VoucherID = T02.VoucherID AND TransactionID = T02.TransactionID) AS ActualQuantity ,
		T07.Ana01ID,	T07.Ana02ID,	T07.Ana03ID,	T07.Ana04ID,	T07.Ana05ID,
		T07.Ana06ID,	T07.Ana07ID,	T07.Ana08ID,	T07.Ana09ID,	T07.Ana10ID,
		T02.LimitDate, T06.ObjectID ,AT1202.ObjectName, AT1202.Address
		FROM WT2002 T02 WITH (NOLOCK)
		LEFT JOIN WT2001 T01 WITH (NOLOCK) ON  T01.VoucherID = T02.VoucherID
		LEFT JOIN AT1302  WITH (NOLOCK) ON  AT1302.DivisionID IN (''@@@'', T02.DivisionID) AND AT1302.InventoryID = T02.InventoryID
		LEFT JOIN AT2007 T07 WITH (NOLOCK) ON T07.VoucherID = T02.ReVoucherID  AND T07.TransactionID = T02.ReTransactionID
		LEFT JOIN AT2006 T06  WITH (NOLOCK) ON T06.VoucherID= T07.VoucherID
		LEFT JOIN AT1202  WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = T06.ObjectID
		WHERE T01.KindVoucherID =1 
		AND T01.VoucherID in ('+@VoucherID+')
	) A
	WHERE A.ActualQuantity > 0
'
--print @sSQL1
EXEC(@sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
