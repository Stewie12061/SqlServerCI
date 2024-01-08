IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP2024]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP2024]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load lưới 1: kế thừa đơn hàng mua (WMF2024)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by: Khả Vi, Date: 07/03/2018
----Modified by: Khả Vi, Date 10/04/2018: Bổ sung điều kiện lọc theo đối tượng 
----Modified by: Kim Thư on 29/06/2018: Lấy thêm cột VoucherNo
----Modified by: Kim Thư on 06/07/2018: chia làm 2 mode load dữ liệu add new và edit
----Modified by: Tiến Thành on 11/04/2023: Ẩn đơn hàng khi kế thừa hết số lượng 
----Modified by Hương Nhung on 28/12/2023: Bổ sung luồng kế thừa TK có/ TK Nợ (Customize NKC)
-- <Example>
---- 
/*-- <Example>
	WMP2024 @DivisionID = 'VF', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @IsDate = 0, @FromDate = '2017-12-01 08:00:05.813', 
	@ToDate = '2017-12-30 08:00:05.813', @FromMonth = 1, @FromYear = 2017, @ToMonth = 12, @ToYear = 2017, @ObjectID = 'TGDD', @APK  = ''
	
	WMP2024 @DivisionID, @UserID, @PageNumber, @PageSize, @IsDate, @FromDate, @ToDate, @FromMonth, @FromYear, @ToMonth, @ToYear, @ObjectID, @APK
----*/

CREATE PROCEDURE [dbo].[WMP2024]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsDate TINYINT, ---- 0: Radiobutton từ ngày có check
					  ---- 1: Radiobutton từ kỳ có check
	 @FromDate DATETIME, 
	 @ToDate DATETIME, 
	 @FromMonth INT, 
	 @FromYear INT, 
	 @ToMonth INT, 
	 @ToYear INT, 
	 @ObjectID VARCHAR(50), 
	 @APK VARCHAR(50)  ----- Addnew truyền ''
)
AS 
	DECLARE @sSQL NVARCHAR(MAX) = N'', 
			@SWhere NVARCHAR(MAX) = N'',
			@TotalRow NVARCHAR(50) = N''

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @sWhere = @sWhere + N'
OT3001.DivisionID = '''+@DivisionID+''' AND OT3001.OrderStatus NOT IN (0, 3, 4, 9) AND OT3001.[Disabled] = 0 '

IF ISNULL(@ObjectID,N'')<>N''
	SET @SWhere=@SWhere+' AND ISNULL(OT3001.ObjectID, '''') = '''+@ObjectID+''' '
 

IF @IsDate = 0 
BEGIN
	SET @sWhere = @sWhere + N'
	AND OT3001.TranMonth + OT3001.TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+''
END
ELSE
BEGIN
	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') SET @sWhere = @sWhere + N'
	AND ISNULL(CONVERT(VARCHAR, OT3001.OrderDate, 120),'''') >= '''+ISNULL(CONVERT(VARCHAR, @FromDate, 120),'')+''''
	IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') SET @sWhere = @sWhere + N'
	AND ISNULL(CONVERT(VARCHAR, OT3001.OrderDate, 120),'''') <= '''+ISNULL(CONVERT(VARCHAR, @ToDate, 120),'')+''''
	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') SET @sWhere = @sWhere + N'
	AND ISNULL(CONVERT(VARCHAR, OT3001.OrderDate, 120),'''') BETWEEN '''+ISNULL(CONVERT(VARCHAR, @FromDate, 120),'')+''' AND '''+ISNULL(CONVERT(VARCHAR, @ToDate, 120),'')+'''	'
END 

IF @APK=''
BEGIN
SET @sSQL = N'
SELECT ROW_NUMBER() OVER (ORDER BY VoucherNo) AS RowNum, '+@TotalRow+' AS TotalRow, *
FROM
(
	SELECT DISTINCT OT3001.APK AS APKMaster, OT3001.DivisionID, OT3001.POrderID AS OrderID, OT3001.VoucherNo, OT3001.OrderDate, OT3001.ObjectID, AT1202.ObjectName, OT3001.Notes--, OT3002.OrderQuantity,
	AT1302.PrimeCostAccountID as CreditAccountName, AT1302.AccountID as DebitAccountName
	--CASE WHEN ISNULL(T3.IsCheck, '''') <> '''' THEN T3.IsCheck ELSE 0 END AS IsCheck
	--ISNULL(IIF(T3.InventoryID=OT3002.InventoryID,SUM(T3.ActualQuantity),0),0) as InheritedQuantity
	FROM OT3001 WITH (NOLOCK) 
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (OT3001.DivisionID, ''@@@'') AND OT3001.ObjectID = AT1202.ObjectID
	LEFT JOIN OT3002 WITH (NOLOCK) ON OT3001.DivisionID  = OT3002.DivisionID AND OT3001.POrderID  = OT3002.POrderID 
	LEFT JOIN AT1302 WITH (NOLOCK) ON OT3002.DivisionID  = AT1302.DivisionID AND OT3002.InventoryID  = AT1302.InventoryID
	LEFT JOIN
	(
		SELECT A.InventoryID, SUM(A.ActualQuantity) AS ActualQuantity, A.InheritTransactionID 
		FROM AT2007 A
		INNER JOIN AT2006 WITH (NOLOCK) ON A.VoucherID = AT2006.APK 
		WHERE A.DivisionID = '''+@DivisionID+''' AND AT2006.KindVoucherID = 1 AND A.InheritTableID = ''OT3001''
		AND NOT EXISTS (SELECT TOP 1 1 FROM AT2007 T1 WITH (NOLOCK) WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.APK = A.APK 
		AND T1.InheritTransactionID = '''+@APK+''')
		GROUP BY A.InventoryID, A.InheritTransactionID 
	) AS T3 ON OT3002.TransactionID = T3.InheritTransactionID
	--LEFT JOIN WMT2007 T3 ON T3.DivisionID=OT3002.DivisionID AND T3.InheritAPK=OT3002.APK AND T3.InheritAPKMaster=OT3001.APK AND T3.InheritTableID=''OT3001'' AND T3.InventoryID=OT3002.InventoryID
	WHERE '+@sWhere+'
	GROUP BY OT3001.APK, OT3001.DivisionID, OT3001.POrderID, OT3001.VoucherNo, OT3001.OrderDate, OT3001.ObjectID, AT1202.ObjectName, OT3001.Notes,OT3002.InventoryID, OT3002.OrderQuantity, T3.InventoryID --, T3.IsCheck
	,AT1302.PrimeCostAccountID, AT1302.AccountID
	HAVING OT3002.OrderQuantity - ISNULL(IIF(T3.InventoryID=OT3002.InventoryID,SUM(T3.ActualQuantity),0),0) >0

)Temp 
ORDER BY VoucherNo
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY		
'
END
ELSE
BEGIN
SET @sSQL = N'
SELECT ROW_NUMBER() OVER (ORDER BY CurOrder DESC, VoucherNo) AS RowNum, '+@TotalRow+' AS TotalRow, *
FROM
(
	SELECT DISTINCT OT3001.APK AS APKMaster, OT3001.DivisionID, OT3001.POrderID AS OrderID, OT3001.VoucherNo, OT3001.OrderDate, OT3001.ObjectID, AT1202.ObjectName, OT3001.Notes, 0 AS CurOrder
	--CASE WHEN ISNULL(T3.IsCheck, '''') <> '''' THEN T3.IsCheck ELSE 0 END AS IsCheck
	--ISNULL(IIF(T3.InventoryID=OT3002.InventoryID,SUM(T3.ActualQuantity),0),0) as InheritedQuantity
	FROM OT3001 WITH (NOLOCK) 
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (OT3001.DivisionID, ''@@@'') AND OT3001.ObjectID = AT1202.ObjectID
	LEFT JOIN OT3002 WITH (NOLOCK) ON OT3001.DivisionID  = OT3002.DivisionID AND OT3001.POrderID  = OT3002.POrderID 
	LEFT JOIN
	(
		SELECT A.InventoryID, SUM(A.ActualQuantity) AS ActualQuantity, A.InheritTransactionID 
		FROM AT2007 A
		INNER JOIN AT2006 WITH (NOLOCK) ON A.VoucherID = AT2006.APK 
		WHERE A.DivisionID = '''+@DivisionID+''' AND AT2006.KindVoucherID = 1 AND A.InheritTableID = ''OT3001''
		AND NOT EXISTS (SELECT TOP 1 1 FROM AT2007 T1 WITH (NOLOCK) WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.APK = A.APK 
		AND T1.InheritTransactionID = '''+@APK+''')
		GROUP BY A.InventoryID, A.InheritTransactionID 
	) AS T3 ON OT3002.TransactionID = T3.InheritTransactionID
	--LEFT JOIN WMT2007 T3 ON T3.DivisionID=OT3002.DivisionID AND T3.InheritAPK=OT3002.APK AND T3.InheritAPKMaster=OT3001.APK AND T3.InheritTableID=''OT3001'' AND T3.InventoryID=OT3002.InventoryID
	WHERE '+@sWhere+'
	GROUP BY OT3001.APK, OT3001.DivisionID, OT3001.POrderID, OT3001.VoucherNo, OT3001.OrderDate, OT3001.ObjectID, AT1202.ObjectName, OT3001.Notes,OT3002.InventoryID, OT3002.OrderQuantity, T3.InventoryID --, T3.IsCheck
	HAVING OT3002.OrderQuantity - ISNULL(IIF(T3.InventoryID=OT3002.InventoryID,SUM(T3.ActualQuantity),0),0) >0
	
	UNION ALL

	SELECT OT3001.APK AS APKMaster, OT3001.DivisionID, OT3001.POrderID AS OrderID, OT3001.VoucherNo, OT3001.OrderDate, OT3001.ObjectID, AT1202.ObjectName, OT3001.Notes, 1 AS CurOrder
	--CASE WHEN ISNULL(T3.IsCheck, '''') <> '''' THEN T3.IsCheck ELSE 0 END AS IsCheck
	--ISNULL(IIF(T3.InventoryID=OT3002.InventoryID,SUM(T3.ActualQuantity),0),0) as InheritedQuantity
	FROM OT3001 WITH (NOLOCK) 
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (OT3001.DivisionID, ''@@@'') AND OT3001.ObjectID = AT1202.ObjectID
	LEFT JOIN OT3002 WITH (NOLOCK) ON OT3001.DivisionID  = OT3002.DivisionID AND OT3001.POrderID  = OT3002.POrderID 
	LEFT JOIN
	(
		SELECT A.InventoryID, SUM(A.ActualQuantity) AS ActualQuantity, A.InheritTransactionID 
		FROM AT2007 A
		INNER JOIN AT2006 WITH (NOLOCK) ON A.VoucherID = AT2006.APK 
		WHERE A.DivisionID = '''+@DivisionID+''' AND AT2006.KindVoucherID = 1 AND A.InheritTableID = ''OT3001''
		AND NOT EXISTS (SELECT TOP 1 1 FROM AT2007 T1 WITH (NOLOCK) WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.APK = A.APK 
		AND T1.InheritTransactionID = '''+@APK+''')
		GROUP BY A.InventoryID, A.InheritTransactionID 
	) AS T2 ON OT3002.TransactionID = T3.InheritTransactionID
	--LEFT JOIN WMT2007 T3 ON T3.InheritAPK=OT3002.APK AND T3.InheritAPKMaster=OT3001.APK AND T3.InheritTableID=''OT3001'' AND T3.InventoryID=OT3002.InventoryID
	INNER JOIN WMT2006 T4 ON T4.APK=T3.APKMaster
	WHERE T4.DivisionID in ('''+@DivisionID+''', ''@@@'') AND T4.APK = '''+@APK+'''
	GROUP BY OT3001.APK, OT3001.DivisionID, OT3001.POrderID, OT3001.VoucherNo, OT3001.OrderDate, OT3001.ObjectID, AT1202.ObjectName, OT3001.Notes,OT3002.InventoryID, OT3002.OrderQuantity, T3.InventoryID --, T3.IsCheck

)Temp 
ORDER BY CurOrder DESC, VoucherNo
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY		
'
END

--LEFT JOIN 
--	(
--		SELECT WMT2007.InheritAPK AS APK, WMT2007.InventoryID, SUM(WMT2007.ActualQuantity) AS ActualQuantity
--		FROM WMT2007 WITH (NOLOCK)
--		LEFT JOIN WMT2006 WITH (NOLOCK) ON WMT2007.APKMaster = WMT2006.APK 
--		WHERE WMT2007.DivisionID = '''+@DivisionID+''' AND WMT2006.KindVoucherID = 1 AND WMT2007.InheritTableID = ''OT3001''
--		AND NOT EXISTS (SELECT TOP 1 1 FROM WMT2007 T1 WITH (NOLOCK) WHERE T1.DivisionID = WMT2007.DivisionID AND T1.APK = WMT2007.APK
--			AND T1.APKMaster = '''+@APK+''')
--		GROUP BY WMT2007.InheritAPK, WMT2007.InventoryID
--	) AS T2 ON OT3002.APK = T2.APK
--	LEFT JOIN
--	(
--		SELECT InheritAPKMaster AS APKMaster, 1 AS IsCheck FROM WMT2007 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND APKMaster = '''+@APK+'''
--	) AS T3 ON OT3001.APK = T3.APKMaster

PRINT @sSQL
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
