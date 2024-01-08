IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2029]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2029]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Load Grid: màn hình kế thừa đơn đặt hàng nội bộ hoặc khách hàng sỉ

-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Tiểu Mai on 20/07/2018
----Modify by Tra Giang  on 25/10/2018:fix lỗi search theo ngày cho đơn đặt hàng nội bộ 
----Modify by Tra Giang  on 29/11/2018: Bổ sung hiên thị tất cả đơn hàng khi chưa check chọn theo loại 
-- <Example>
---- 
/*-- <Example>
	POP2029 @DivisionID = 'AT', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @IsDate = 0 ,  @FromDate = '2018-07-01 08:00:05.813', 
	@ToDate = '2018-07-30 08:00:05.813', @FromMonth = 6, @FromYear = 2018, @ToMonth = 7, @ToYear = 2018, @OrderType =1,@APK = '123456',@Mode=0
----*/

CREATE PROCEDURE POP2029
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,	 
	 @IsDate TINYINT, ---- 0: Radiobutton từ kỳ có check
					  ---- 1: Radiobutton từ ngày có check
	 @FromDate DATETIME, 
	 @ToDate DATETIME, 
	 @FromMonth INT, 
	 @FromYear INT, 
	 @ToMonth INT, 
	 @ToYear INT, 
	 @OrderType TINYINT,	---- 0: cửa hàng
							---- 1: Sỉ/lẻ
							---- 2: tất cả đơn hàng
	 @APK VARCHAR(50), ----- Addnew truyền ''
	 @Mode TINYINT -- 1: Add New / 2: Edit
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',		
		@sWhere NVARCHAR(MAX) = N'',
		@sWhere1 NVARCHAR(MAX) = N'',
		@TotalRow NVARCHAR(50) = N'',
        @OrderBy NVARCHAR(500) = N''


SET @OrderBy = 'VoucherNo'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF @IsDate = 0 
BEGIN
	SET @sWhere = @sWhere + N'
	AND T1.TranMonth + T1.TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+''
END
ELSE
BEGIN
	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') 
		SET @sWhere = @sWhere + N'
		AND T1.VoucherDate >= '''+CONVERT(VARCHAR(10), @FromDate, 120)+''''
	IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') 
		SET @sWhere = @sWhere + N'
		AND T1.VoucherDate <= '''+CONVERT(VARCHAR(10), @ToDate, 120)+''''
	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') 
		SET @sWhere = @sWhere + N'
		AND T1.VoucherDate BETWEEN '''+CONVERT(VARCHAR(10), @FromDate, 120)+''' AND '''+CONVERT(VARCHAR(10), @ToDate, 120)+''' '
		
	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') 
		SET @sWhere1 = @sWhere1 + N'
		AND T1.OrderDate >= '''+CONVERT(VARCHAR(10), @FromDate, 120)+''''
	IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') 
		SET @sWhere1 = @sWhere1 + N'
		AND T1.OrderDate <= '''+CONVERT(VARCHAR(10), @ToDate, 120)+''''
	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') 
		SET @sWhere1 = @sWhere1 + N'
		AND T1.OrderDate BETWEEN '''+CONVERT(VARCHAR(10), @FromDate, 120)+''' AND '''+CONVERT(VARCHAR(10), @ToDate, 120)+''' '
END
IF ISNULL(@OrderType,' ') = 2 -- Load tât cả đơn hàng
BEGIN
	SET @sSQL = @sSQL + N'
	SELECT	Convert(Tinyint,0) AS IsSelect, T1.APK, T1.DivisionID, T1.VoucherNo, T1.VoucherDate, T1.ObjectID, A02.ObjectName,
			T2.InventoryID, A03.InventoryName, A03.UnitID, T2.OrderQuantity, T2.RequireDate,
			''POT2016'' AS InheritTableID, T2.APK AS InheritTransactionID, T1.APK AS InheritVoucherID
	INTO #TEMP1
	FROM POT2016 T2 WITH (NOLOCK)
	LEFT JOIN POT2015 T1 WITH (NOLOCK) ON T1.APK = T2.APK_Master AND T1.DivisionID = T2.DivisionID
	LEFT JOIN AT1202 A02 WITH (NOLOCK) ON T1.ObjectID = A02.ObjectID
	LEFT JOIN AT1302 A03 WITH (NOLOCK) ON T2.InventoryID = A03.InventoryID
	WHERE T1.DivisionID = '''+@DivisionID+''' '+@sWhere +'

	UPDATE	T1
	SET		t1.IsSelect = 1
	FROM	#TEMP1 T1
	INNER JOIN POT2018 T2 ON T1.APK = T2.InheritVoucherID AND T2.InheritTableID = ''POT2016''

	SELECT	Convert(Tinyint,0) AS IsSelect, T1.APK, T1.DivisionID, T1.VoucherNo, T1.OrderDate VoucherDate, T1.ObjectID, A02.ObjectName,
			T2.InventoryID, A03.InventoryName, A03.UnitID, T2.OrderQuantity, T2.RequireDate,
			''OT2002'' AS InheritTableID, T2.APK AS InheritTransactionID, T1.APK AS InheritVoucherID
	INTO #TEMP2
	FROM OT2002 T2 WITH (NOLOCK)
	LEFT JOIN OT2001 T1 WITH (NOLOCK) ON T1.SOrderID = T2.SOrderID AND T1.DivisionID = T2.DivisionID
	LEFT JOIN AT1202 A02 WITH (NOLOCK) ON T1.ObjectID = A02.ObjectID
	LEFT JOIN AT1302 A03 WITH (NOLOCK) ON T2.InventoryID = A03.InventoryID
	WHERE T1.IsConfirm=1 and T1.DivisionID = '''+@DivisionID+''' 
		AND OrderType = 0 --- Don hang ban
	'+@sWhere1 +'

	UPDATE	T1
	SET		t1.IsSelect = 1
	FROM	#TEMP2  T1
	INNER JOIN OT2002 T2 ON T1.APK = T2.InheritVoucherID AND T2.InheritTableID = ''OT2002''
	SELECT *  INTO #POP2029_POT2016 FROM #TEMP1 UNION SELECT * FROM #TEMP2

	'
END
ELSE
BEGIN
IF ISNULL(@OrderType,0) = 1 --- Cửa hàng
BEGIN
	SET @sSQL = @sSQL + N'
	SELECT	Convert(Tinyint,0) AS IsSelect, T1.APK, T1.DivisionID, T1.VoucherNo, T1.VoucherDate, T1.ObjectID, A02.ObjectName,
			T2.InventoryID, A03.InventoryName, A03.UnitID, T2.OrderQuantity, T2.RequireDate,
			''POT2016'' AS InheritTableID, T2.APK AS InheritTransactionID, T1.APK AS InheritVoucherID
	INTO #POP2029_POT2016
	FROM POT2016 T2 WITH (NOLOCK)
	LEFT JOIN POT2015 T1 WITH (NOLOCK) ON T1.APK = T2.APK_Master AND T1.DivisionID = T2.DivisionID
	LEFT JOIN AT1202 A02 WITH (NOLOCK) ON T1.ObjectID = A02.ObjectID
	LEFT JOIN AT1302 A03 WITH (NOLOCK) ON T2.InventoryID = A03.InventoryID
	WHERE T1.DivisionID = '''+@DivisionID+''' '+@sWhere +'

	UPDATE	T1
	SET		t1.IsSelect = 1
	FROM	#POP2029_POT2016 T1
	INNER JOIN POT2018 T2 ON T1.APK = T2.InheritVoucherID AND T2.InheritTableID = ''POT2016''
	'
END
ELSE	---- Khách sỉ/lẻ
BEGIN
	SET @sSQL = @sSQL + N'
	SELECT	Convert(Tinyint,0) AS IsSelect, T1.APK, T1.DivisionID, T1.VoucherNo, T1.OrderDate VoucherDate, T1.ObjectID, A02.ObjectName,
			T2.InventoryID, A03.InventoryName, A03.UnitID, T2.OrderQuantity, T2.RequireDate,
			''OT2002'' AS InheritTableID, T2.APK AS InheritTransactionID, T1.APK AS InheritVoucherID
	INTO #POP2029_POT2016
	FROM OT2002 T2 WITH (NOLOCK)
	LEFT JOIN OT2001 T1 WITH (NOLOCK) ON T1.SOrderID = T2.SOrderID AND T1.DivisionID = T2.DivisionID
	LEFT JOIN AT1202 A02 WITH (NOLOCK) ON T1.ObjectID = A02.ObjectID
	LEFT JOIN AT1302 A03 WITH (NOLOCK) ON T2.InventoryID = A03.InventoryID
	WHERE T1.IsConfirm=1 and  T1.DivisionID = '''+@DivisionID+''' 
		AND OrderType = 0 --- Don hang ban
	'+@sWhere1 +'

	UPDATE	T1
	SET		t1.IsSelect = 1
	FROM	#POP2029_POT2016 T1
	INNER JOIN OT2002 T2 ON T1.APK = T2.InheritVoucherID AND T2.InheritTableID = ''OT2002''
	'
END
END


--SET @sWhere = @sWhere + N'
--		AND ISNULl(T1.OrderType,0) = '+ STR(ISNULL(@OrderType,0))


IF @Mode=1
BEGIN
SET @sSQL=@sSQL+
	'
	SELECT	ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, *
	FROM	#POP2029_POT2016
	WHERE	IsSelect<>1
	ORDER BY '+@OrderBy+' 
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
END
ELSE
BEGIN
	IF ISNULL(@OrderType,0) = 2
	BEGIN 
		SET @sSQL=@sSQL+
	'
	SELECT ROW_NUMBER() OVER (ORDER BY CurOrder desc, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, *
	FROM (
		SELECT	DISTINCT 1 AS CurOrder, T1.*
		FROM	#POP2029_POT2016 T1
		LEFT  JOIN POT2018 T2 ON T1.APK = T2.InheritVoucherID AND T2.InheritTableID = ''POT2016'' 
		LEFT JOIN OT2002 T3 ON T1.APK = T3.InheritVoucherID AND T3.InheritTableID = ''OT2002'' 
		WHERE	T2.InheritVoucherID ='''+Isnull(@APK,'')+''' OR T3.InheritVoucherID ='''+Isnull(@APK,'')+'''
		UNION ALL
		SELECT	0 AS CurOrder, *
		FROM	#POP2029_POT2016
		WHERE	IsSelect<>1		
	) X
	ORDER BY X.CurOrder desc, X.'+@OrderBy+' 
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
	'

	END 
	ELSE
	BEGIN 
	SET @sSQL=@sSQL+
	'
	SELECT ROW_NUMBER() OVER (ORDER BY CurOrder desc, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, *
	FROM (
		SELECT	DISTINCT 1 AS CurOrder, T1.*
		FROM	#POP2029_POT2016 T1
		'+CASE WHEN ISNULL(@OrderType,0) = 0 THEN ' 
		INNER JOIN POT2018 T2 ON T1.APK = T2.InheritVoucherID AND T2.InheritTableID = ''POT2016'' ' ELSE '
		INNER JOIN OT2002 T2 ON T1.APK = T2.InheritVoucherID AND T2.InheritTableID = ''OT2002'' ' END +'
		WHERE	T2.InheritVoucherID ='''+Isnull(@APK,'')+'''
		UNION ALL
		SELECT	0 AS CurOrder, *
		FROM	#POP2029_POT2016
		WHERE	IsSelect<>1		
	) X
	ORDER BY X.CurOrder desc, X.'+@OrderBy+' 
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
	'
END
 END 
 --PRINT @sSQL
EXEC (@sSQL)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
