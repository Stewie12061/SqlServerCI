IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP2010]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP2010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-------- Created by		Khánh Đoan.
-------- Date 12/12/2007. In bao cao ton theo vi tri o 
-------- Date 16/03/2020 by Huỳnh Thử: Trừ số lượng đã làm lệch xuất kho
-------- Date 27/03/2020 by Huỳnh Thử: Lấy thêm Mã số Thuế, địa chỉ, tên đối tượng
-------- Date 17/04/2020 by Huỳnh Thử: Phần mềm chỉ trừ số lượng xuất để lên số tồn tại ngày in nếu LXK đã được kế thừa vào phiếu xuất kho để đảm bảo số liệu đồng nhất giữa các báo cáo
---- 	 Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- 	 Modified by Huỳnh Thử on 27/10/2020 : Bỏ Join tới bảng WT2003
---- 	 Modified by Huỳnh Thử on 15/12/2020 : Left Join AT2007 on T07.VoucherID = T06.VoucherID  AND T07.TransactionID = T02.ReTransactionID
---- 	 Modified by Xuân Nguyên on 10/05/2022 : [EIMSKIP][2022/04/IS/0273] Số lượng xuất lấy từ AT2007 thay vì WT2002
----	 Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE [dbo].[WP2010]  	(
		@DivisionID AS nvarchar(50),
		@FromMonth INT,
	  	@FromYear INT,
		@ToMonth INT,
		@ToYear INT,  
		@FromDate  as datetime ,
		@ToDate as datetime,
		@IsDate as TINYINT, ----0 theo ky, 1 theo ngày
		@WareHouseID AS nvarchar(50),
		@ObjectID AS nvarchar(50),
		@FromInventoryID AS NVARCHAR(50),
		@ToInventoryID AS NVARCHAR(50)
		)
AS

declare 
	@sSQL1 AS nvarchar(4000),
	@sWhere  as NVARCHAR(4000)

IF @IsDate = 0
	SET  @sWhere = '
		And (T01.TranMonth + T01.TranYear*100 between ' + cast(@FromMonth + @FromYear*100 as nvarchar(50)) + ' and ' +  cast(@ToMonth + @ToYear*100 as nvarchar(50))  + ')'
ELSE
	SET  @sWhere = '
		And (T01.VoucherDate  Between '''+ CONVERT(VARCHAR, @FromDate,111)+''' AND '''+ CONVERT(VARCHAR, @ToDate,111)+''')'
		
--- Load Lệnh xuất kho 



SET @sSQL1 ='	
	SELECT WT2002.RePVoucherID AS VoucherID,WT2002.RePTransactionID AS TransactionID, Sum(AT2007.ActualQuantity) as ActualQuantity
    INTO #TAM From AT2007 
	left join AT2006 on AT2006.VoucherID = AT2007.VoucherID
	Left join WT2002 on WT2002.VoucherID = AT2007.InheritVoucherID and WT2002.TransactionID = AT2007.InheritTransactionID
	left join WT2001 on WT2001.VoucherID = Wt2002.VoucherID
	where AT2006.KindVoucherID = 2
	and WT2001.KindVoucherID = 2
	AND WT2001.WarehouseID LIKE '''+@WareHouseID+'''
	AND WT2001.ObjectID ='''+@ObjectID+'''
	And Format(AT2006.VoucherDate,''yyyy/MM/dd'') <= '''+CONVERT(NVARCHAR(50),@FromDate,111)+'''
	And WT2002.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+'''
	GRoup by WT2002.RePVoucherID,WT2002.RePTransactionID

	SELECT * FROM (
	SELECT DISTINCT T01.KindVoucherID,T02.LimitDate ,T01.LocationID, T01.VoucherNo AS VoucherNoPL,  T02.InventoryID , AT1302.InventoryName , T02.SourceNo , 
	ISNULL(T02.ActualQuantity,0) - ISNULL((select SUM(#TAM.ActualQuantity) FROM #TAM WHERE VoucherID = T02.VoucherID AND TransactionID = T02.TransactionID),0) AS ActualQuantity,
	AT1302.I01ID,AT1302.I02ID,AT1302.I03ID,AT1302.I04ID,AT1302.I05ID,
	AT1302.I06ID,AT1302.I07ID,AT1302.I08ID,AT1302.I09ID,AT1302.I10ID,
	T07.Ana01ID,	T07.Ana02ID,	T07.Ana03ID,	T07.Ana04ID,	T07.Ana05ID,
	T07.Ana06ID,	T07.Ana07ID,	T07.Ana08ID,	T07.Ana09ID,	T07.Ana10ID,
	A01.AnaName Ana01Name, A02.AnaName Ana02Name,A03.AnaName Ana03Name,A04.AnaName Ana04Name,A05.AnaName Ana05Name,
	A06.AnaName Ana06Name, A07.AnaName Ana07Name,A08.AnaName Ana08Name,A09.AnaName Ana09Name,A10.AnaName Ana10Name,
	T06.ObjectID, T06.VoucherDate , T06.VoucherNo, AT1202.Address,AT1202.VATNo,AT1202.ObjectName
	FROM WT2002 T02 WITH (NOLOCK ) 
	LEFT JOIN WT2001 T01 WITH (NOLOCK ) ON T01.VoucherID = T02.VoucherID 
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', T02.DivisionID) AND AT1302.InventoryID = T02.InventoryID
	LEFT JOIN AT2006 T06 WITH (NOLOCK) ON T06.VoucherID = T02.ReVoucherID 
	LEFT JOIN AT2007 T07 WITH (NOLOCK) ON T06.VoucherID = T07.ReVoucherID AND T07.TransactionID = T02.ReTransactionID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = T06.ObjectID
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
	--LEFT JOIN WT2003 WITH (NOLOCK) ON WT2003.ReVoucherID = T02.VoucherID AND WT2003.ReTransactionID = T02.TransactionID
	WHERE 
	-- WT2003.EndQuantity > 0
	--AND
	T06.WarehouseID LIKE '''+@WareHouseID+'''
	AND T06.ObjectID ='''+@ObjectID+'''
	And Format(T01.VoucherDate,''yyyy/MM/dd'')  <= '''+CONVERT(NVARCHAR(50),@FromDate,111)+'''
	And T02.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+'''
	AND T01.KindVoucherID = 1
	) A
	WHERE A.ActualQuantity > 0
	ORDER BY A.InventoryID 
'
	print @sSQL1
EXEC(@sSQL1)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
