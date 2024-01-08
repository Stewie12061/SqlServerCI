IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2030]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[POP2030]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid: màn hình kế thừa kế hoạch mua hàng dự trữ

-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Tiểu Mai on 20/07/2018
----Modify by Tra Giang on 22/01/2019: Bổ sung trường Ngày đặt hàng OrderDate
-- <Example>
---- 
/*-- <Example>
	POP2030 @DivisionID = 'AT', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @IsDate = 0 ,  @FromDate = '2018-07-01 08:00:05.813', 
	@ToDate = '2018-07-30 08:00:05.813', @FromMonth = 6, @FromYear = 2018, @ToMonth = 7, @ToYear = 2018, @ObjectID =N'CH002', @APK = '123456',@Mode=0
----*/

CREATE PROCEDURE POP2030
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
	 @ObjectID NVARCHAR(50), 
	 @APK VARCHAR(50), ----- Addnew truyền ''
	 @Mode TINYINT -- 1: Add New / 2: Edit
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',		
		@sWhere NVARCHAR(MAX) = N'',
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
END

SET @sWhere = @sWhere + N'
		AND T2.ObjectID LIKE '''+ @ObjectID+''' '


SET @sSQL = @sSQL + N'
SELECT	Convert(Tinyint,0) AS IsSelect, T1.APK, T1.DivisionID, T1.VoucherNo, T1.VoucherDate,T1.OrderDate, T2.ObjectID, A02.ObjectName,
		T2.InventoryID, A03.InventoryName, A03.UnitID, T2.OrderQuantity, 
		''POT2018'' AS InheritTableID, T2.APK AS InheritTransactionID, T1.APK AS InheritVoucherID
INTO #POP2030_POT2018
FROM POT2018 T2 WITH (NOLOCK)
LEFT JOIN POT2017 T1 WITH (NOLOCK) ON T1.APK = T2.APK_Master AND T1.DivisionID = T2.DivisionID
LEFT JOIN AT1202 A02 WITH (NOLOCK) ON T2.ObjectID = A02.ObjectID
LEFT JOIN AT1302 A03 WITH (NOLOCK) ON T2.InventoryID = A03.InventoryID
WHERE T1.DivisionID = '''+@DivisionID+''' '+@sWhere +'

UPDATE	T1
SET		t1.IsSelect = 1
FROM	#POP2030_POT2018 T1
INNER JOIN OT3002 T2 ON T1.APK = T2.InheritVoucherID AND T1.InheritTransactionID = T2.InheritTransactionID AND T2.InheritTableID = ''POT2018''
'

IF @Mode=1
BEGIN
SET @sSQL=@sSQL+
	'
	SELECT	ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, *
	FROM	#POP2030_POT2018
	WHERE	IsSelect<>1
	ORDER BY '+@OrderBy+' 
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
END
ELSE
BEGIN
SET @sSQL=@sSQL+
	'
	SELECT ROW_NUMBER() OVER (ORDER BY CurOrder desc, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, *
	FROM (
		SELECT	DISTINCT 1 AS CurOrder, T1.*
		FROM	#POP2030_POT2018 T1
		INNER JOIN OT3002 T2 ON T1.APK = T2.InheritVoucherID AND T1.InheritTransactionID = T2.InheritTransactionID AND T2.InheritTableID = ''POT2018''
		WHERE	T2.InheritVoucherID ='''+Isnull(@APK,'')+'''
		UNION ALL
		SELECT	0 AS CurOrder, *
		FROM	#POP2030_POT2018
		WHERE	IsSelect<>1		
	) X
	ORDER BY X.CurOrder desc, X.'+@OrderBy+' 
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
	'
END
PRINT @sSQL
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


