IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0145]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0145]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- In báo cáo số lượng thành phẩm giao cho từng đối tượng (CustomizeIndex = 80 -- Bê tông Long An)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by Tieu Mai on 18/09/2017
---- Modified by Bảo Thy on 19/01/2018: Bổ sung lọc báo cáo theo quy cách
---- Modified by Bảo Thy on 04/04/2018: bổ sung InventoryID_QC
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by ... on ...
-- <Example>
/*	
	exec WP0145 'ANG', '2017-01-02 00:00:00.000', '2017-07-27 00:00:00.000', 'ANHPHU', '120201', '-000000016', 'K-0009'	
*/
CREATE PROCEDURE WP0145
(
	@DivisionID			NVARCHAR(50),
	@FromDate			DATETIME,
	@ToDate				DATETIME,
	@ObjectID			NVARCHAR(50),
	@Ana03ID			NVARCHAR(50),
	@FromInventoryID	NVARCHAR(50),
	@ToInventoryID		NVARCHAR(50),
	@IsSearchStandard	TINYINT,
	@StandardList		XML
	
)
AS

DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
		@sSQL3 NVARCHAR(MAX),
		@sSQL4 NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX),
		@sWhere1 NVARCHAR(MAX)
		
SET @sSQL = N''
SET @sWhere = N''
SET @sWhere = @sWhere + N' AND CONVERT(NVARCHAR(10),A06.VoucherDate,101) BETWEEN '''+CONVERT(NVARCHAR(10),@FromDate,101)+''' AND '''+ CONVERT(NVARCHAR(10),@ToDate,101)+''''

IF ISNULL(@IsSearchStandard,0) = 1
BEGIN
	CREATE TABLE #StandardList_WP0145 (InventoryID VARCHAR(50), StandardTypeID VARCHAR(50), StandardID VARCHAR(50))
	
	INSERT INTO #StandardList_WP0145 (InventoryID, StandardTypeID, StandardID)
	SELECT	X.Data.query('InventoryID').value('.','VARCHAR(50)') AS InventoryID,
			X.Data.query('StandardTypeID').value('.','VARCHAR(50)') AS StandardTypeID,
			X.Data.query('StandardID').value('.','VARCHAR(50)') AS StandardID
	FROM @StandardList.nodes('//Data') AS X (Data)
END

SET @sSQL = '
---- Lấy khối lượng đặt hàng
SELECT O02.DivisionID, O01.ObjectID, O02.InventoryID, A32.InventoryName, O02.UnitID, O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
	O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID, O02.Ana03ID, SUM(O02.OrderQuantity) AS OrderQuantity
INTO #TEMP1
FROM OT2002 O02 WITH (NOLOCK)
LEFT JOIN OT2001 O01 WITH (NOLOCK) ON O01.DivisionID = O02.DivisionID AND O01.SOrderID = O02.SOrderID
LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = O02.DivisionID AND O99.TransactionID = O02.TransactionID AND O02.SOrderID = O99.VoucherID
LEFT JOIN AT1020 A20 WITH (NOLOCK) ON A20.DivisionID = O02.DivisionID AND A20.ContractID = O02.InheritVoucherID
LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID IN (''@@@'', O02.DivisionID) AND A32.InventoryID = O02.InventoryID
WHERE O02.DivisionID = '''+@DivisionID+''' AND O01.ObjectID LIKE '''+@ObjectID+'''
	AND O02.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+'''
	AND O02.Ana03ID LIKE '''+@Ana03ID+''' 
GROUP BY  O02.DivisionID, O01.ObjectID, O02.InventoryID, A32.InventoryName, O02.UnitID, O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
	O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID, O02.Ana03ID
	'

SET @sSQL1 = '
---- Lấy khối lượng đã giao
SELECT A07.DivisionID, A06.ObjectID, A06.VoucherDate, A32.I02ID, A07.InventoryID, O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
	O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
	A07.Ana01ID, A07.Ana02ID, A07.Ana03ID, A07.Ana04ID, A07.Ana05ID, A07.Ana06ID, A07.Ana07ID, A07.Ana08ID, A07.Ana09ID, A07.Ana10ID,
	SUM(A07.ActualQuantity) AS  DeliveryQuantity
INTO #TEMP2
FROM AT2007 A07 WITH (NOLOCK)
LEFT JOIN AT2006 A06 WITH (NOLOCK) ON A06.DivisionID = A07.DivisionID AND A06.VoucherID = A07.VoucherID
LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = A07.DivisionID AND O99.TransactionID = A07.TransactionID AND O99.VoucherID = A07.VoucherID
LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID IN (''@@@'', A07.DivisionID) AND A32.InventoryID = A07.InventoryID
WHERE A06.DivisionID = '''+@DivisionID+'''
	AND A06.ObjectID LIKE '''+@ObjectID+'''
	AND A07.Ana03ID LIKE '''+@Ana03ID+''' 
	AND A07.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+'''
	AND ISNULL(A06.IsDelivery,0) <> 0
	AND A06.KindVoucherID = 3
	'+@sWhere+'
GROUP BY A07.DivisionID, A06.ObjectID, A06.VoucherDate, A32.I02ID, A07.InventoryID, O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
	O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
	A07.Ana01ID, A07.Ana02ID, A07.Ana03ID, A07.Ana04ID, A07.Ana05ID, A07.Ana06ID, A07.Ana07ID, A07.Ana08ID, A07.Ana09ID, A07.Ana10ID
'

SET @sSQL2 = '
SELECT T1.*, T2.VoucherDate AS Delivery_VoucherDate, T2.DeliveryQuantity,
	AT02.ObjectName, A03.AnaName AS Ana03Name,
	T1.InventoryID + CASE WHEN ISNULL(T1.S01ID,'''')<>'''' THEN ''.''+T1.S01ID ELSE '''' END+
	CASE WHEN ISNULL(T1.S02ID,'''')<>'''' THEN ''.''+T1.S02ID ELSE '''' END+
	CASE WHEN ISNULL(T1.S03ID,'''')<>'''' THEN ''.''+T1.S03ID ELSE '''' END+
	CASE WHEN ISNULL(T1.S04ID,'''')<>'''' THEN ''.''+T1.S04ID ELSE '''' END+
	CASE WHEN ISNULL(T1.S05ID,'''')<>'''' THEN ''.''+T1.S05ID ELSE '''' END+
	CASE WHEN ISNULL(T1.S06ID,'''')<>'''' THEN ''.''+T1.S06ID ELSE '''' END+
	CASE WHEN ISNULL(T1.S07ID,'''')<>'''' THEN ''.''+T1.S07ID ELSE '''' END+
	CASE WHEN ISNULL(T1.S08ID,'''')<>'''' THEN ''.''+T1.S08ID ELSE '''' END+
	CASE WHEN ISNULL(T1.S09ID,'''')<>'''' THEN ''.''+T1.S09ID ELSE '''' END+
	CASE WHEN ISNULL(T1.S10ID,'''')<>'''' THEN ''.''+T1.S10ID ELSE '''' END+
	CASE WHEN ISNULL(T1.S11ID,'''')<>'''' THEN ''.''+T1.S11ID ELSE '''' END+
	CASE WHEN ISNULL(T1.S12ID,'''')<>'''' THEN ''.''+T1.S12ID ELSE '''' END+
	CASE WHEN ISNULL(T1.S13ID,'''')<>'''' THEN ''.''+T1.S13ID ELSE '''' END+
	CASE WHEN ISNULL(T1.S14ID,'''')<>'''' THEN ''.''+T1.S14ID ELSE '''' END+
	CASE WHEN ISNULL(T1.S15ID,'''')<>'''' THEN ''.''+T1.S15ID ELSE '''' END+
	CASE WHEN ISNULL(T1.S16ID,'''')<>'''' THEN ''.''+T1.S16ID ELSE '''' END+
	CASE WHEN ISNULL(T1.S17ID,'''')<>'''' THEN ''.''+T1.S17ID ELSE '''' END+
	CASE WHEN ISNULL(T1.S18ID,'''')<>'''' THEN ''.''+T1.S18ID ELSE '''' END+
	CASE WHEN ISNULL(T1.S19ID,'''')<>'''' THEN ''.''+T1.S19ID ELSE '''' END+
	CASE WHEN ISNULL(T1.S20ID,'''')<>'''' THEN ''.''+T1.S20ID ELSE '''' END As InventoryID_QC
'+CASE WHEN ISNULL(@IsSearchStandard,0) = 1 THEN 'INTO #WP0145_Report' ELSE '' END+'
FROM #TEMP1 T1'
SET @sSQL3 = '
LEFT JOIN #TEMP2 T2 ON T1.DivisionID  = T2.DivisionID AND T1.ObjectID  = T2.ObjectID
						AND T1.InventoryID = T2.InventoryID AND ISNULL(T1.Ana03ID,'''')  = ISNULL(T2.Ana03ID,'''')
						AND ISNULL(T1.S01ID,'''') = ISNULL(T2.S01ID,'''')
						AND ISNULL(T1.S02ID,'''') = ISNULL(T2.S02ID,'''')
						AND ISNULL(T1.S03ID,'''') = ISNULL(T2.S03ID,'''')
						AND ISNULL(T1.S04ID,'''') = ISNULL(T2.S04ID,'''')
						AND ISNULL(T1.S05ID,'''') = ISNULL(T2.S05ID,'''')
						AND ISNULL(T1.S06ID,'''') = ISNULL(T2.S06ID,'''')
						AND ISNULL(T1.S07ID,'''') = ISNULL(T2.S07ID,'''')
						AND ISNULL(T1.S08ID,'''') = ISNULL(T2.S08ID,'''')
						AND ISNULL(T1.S09ID,'''') = ISNULL(T2.S09ID,'''')
						AND ISNULL(T1.S10ID,'''') = ISNULL(T2.S10ID,'''')
						AND ISNULL(T1.S11ID,'''') = ISNULL(T2.S11ID,'''')
						AND ISNULL(T1.S12ID,'''') = ISNULL(T2.S12ID,'''')
						AND ISNULL(T1.S13ID,'''') = ISNULL(T2.S13ID,'''')
						AND ISNULL(T1.S14ID,'''') = ISNULL(T2.S14ID,'''')
						AND ISNULL(T1.S15ID,'''') = ISNULL(T2.S15ID,'''')
						AND ISNULL(T1.S16ID,'''') = ISNULL(T2.S16ID,'''')
						AND ISNULL(T1.S17ID,'''') = ISNULL(T2.S17ID,'''')
						AND ISNULL(T1.S18ID,'''') = ISNULL(T2.S18ID,'''')
						AND ISNULL(T1.S19ID,'''') = ISNULL(T2.S19ID,'''')
						AND ISNULL(T1.S20ID,'''') = ISNULL(T2.S20ID,'''')
LEFT JOIN AT1202 AT02 WITH (NOLOCK) ON AT02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT02.ObjectID  = T1.ObjectID
LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A03.AnaID  = T1.Ana03ID AND A03.AnaTypeID  = ''A03''
'
IF ISNULL(@IsSearchStandard,0) = 1
BEGIN
	SET @sSQL4 = '
	SELECT * 
	FROM
	(
		SELECT T1.*
		FROM #WP0145_Report AS T1
		INNER JOIN #StandardList_WP0145 T2 ON T1.InventoryID = T2.InventoryID
		WHERE 
		(	T2.StandardTypeID = ''S01'' AND ISNULL(T1.S01ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S02'' AND ISNULL(T1.S02ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S03'' AND ISNULL(T1.S03ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S04'' AND ISNULL(T1.S04ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S05'' AND ISNULL(T1.S05ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S06'' AND ISNULL(T1.S06ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S07'' AND ISNULL(T1.S07ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S08'' AND ISNULL(T1.S08ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S09'' AND ISNULL(T1.S09ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S10'' AND ISNULL(T1.S10ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S11'' AND ISNULL(T1.S11ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S12'' AND ISNULL(T1.S12ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S13'' AND ISNULL(T1.S13ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S14'' AND ISNULL(T1.S14ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S15'' AND ISNULL(T1.S15ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S16'' AND ISNULL(T1.S16ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S17'' AND ISNULL(T1.S17ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S18'' AND ISNULL(T1.S18ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S19'' AND ISNULL(T1.S19ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S20'' AND ISNULL(T1.S20ID,'''') = T2.StandardID)
		UNION ALL
		SELECT  T1.*
		FROM #WP0145_Report AS T1
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #StandardList_WP0145 T2 WHERE T1.InventoryID = T2.InventoryID)
		AND ISNULL(T1.S01ID,'''') = '''' AND ISNULL(T1.S02ID,'''') = '''' AND ISNULL(T1.S03ID,'''') = ''''
		AND ISNULL(T1.S04ID,'''') = '''' AND ISNULL(T1.S05ID,'''') = '''' AND ISNULL(T1.S06ID,'''') = '''' 
		AND ISNULL(T1.S07ID,'''') = '''' AND ISNULL(T1.S08ID,'''') = '''' AND ISNULL(T1.S09ID,'''') = '''' 
		AND ISNULL(T1.S10ID,'''') = '''' AND ISNULL(T1.S11ID,'''') = '''' AND ISNULL(T1.S12ID,'''') = '''' 
		AND ISNULL(T1.S13ID,'''') = '''' AND ISNULL(T1.S14ID,'''') = '''' AND ISNULL(T1.S15ID,'''') = '''' 
		AND ISNULL(T1.S16ID,'''') = '''' AND ISNULL(T1.S17ID,'''') = '''' AND ISNULL(T1.S18ID,'''') = '''' 
		AND ISNULL(T1.S19ID,'''') = '''' AND ISNULL(T1.S20ID,'''') = '''' 
	)Temp'

END

--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sSQL3
--PRINT @sSQL4

EXEC (@sSQL+@sSQL1+@sSQL2+@sSQL3+@sSQL4)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
