IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP2026]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP2026]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Load lưới 1: kế thừa yêu cầu nhập kho, xuất kho, vcnb
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by: Khả Vi, Date: 12/03/2018
----Modified by: Kim Thư, date: 5/7/2018 - Chi làm 2 mode add new và edit
----Modified by: Hồng Thắm, date: 11/10/2023 - Bổ sung kế thừa InventoryTypeID khi tạo mới phiếu xuất kho
-- <Example>
---- 
/*-- <Example>
	WMP2026 @DivisionID = 'VF', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @FormID = 'WMF2025', @IsDate = 0 ,  @FromDate = '', 
	@ToDate = '', @FromMonth = 12, @FromYear = 2017, @ToMonth = 1, @ToYear = 2018, @ImWareHouseID = '', @ExWareHouseID = ''
	@APK = '', @ObjectID = 'DMX-HVT' 

	WMP2026 @DivisionID, @UserID, @PageNumber, @PageSize, @FormID, @IsDate,  @FromDate, @ToDate, @FromMonth, @FromYear, @ToMonth, @ToYear, @ImWareHouseID, @ExWareHouseID, @APK, @ObjectID

----*/

CREATE PROCEDURE WMP2026
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @FormID VARCHAR(50), 
	 @IsDate TINYINT, ---- 0: Radiobutton từ ngày có check
					  ---- 1: Radiobutton từ kỳ có check
	 @FromDate DATETIME, 
	 @ToDate DATETIME, 
	 @FromMonth INT, 
	 @FromYear INT, 
	 @ToMonth INT, 
	 @ToYear INT, 
	 @ImWareHouseID VARCHAR(50), 
	 @ExWareHouseID VARCHAR(50), 
	 @APK VARCHAR(50), ----- Addnew truyền ''
	 @ObjectID VARCHAR(50) 

)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
		@sWhere NVARCHAR(MAX) = N'',
		@TotalRow NVARCHAR(50) = N''

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @sWhere = @sWhere + N' T1.DivisionID = '''+@DivisionID+''' AND T1.IsCheck = 1'

--IF @FormID='WMF2025' SET @sWhere = @sWhere + ' AND T1.KindVoucherID = 1 AND T1.ImWareHouseID = '''+@ImWareHouseID+''' '
--ELSE IF @FormID='WMF2026' SET @sWhere = @sWhere + ' AND T1.KindVoucherID = 2 AND T1.ExWareHouseID = '''+@ExWareHouseID+''' '
--ELSE SET @sWhere = @sWhere + ' AND T1.KindVoucherID = 3 AND T1.ImWareHouseID = '''+@ImWareHouseID+'''  AND T1.ExWareHouseID = '''+@ExWareHouseID+''' '

IF @FormID='WMF2029'
BEGIN
	IF ISNULL(@ExWarehouseID,'')<>''
		SET @sWhere = @sWhere + ' AND T1.KindVoucherID = 2 AND T1.ExWareHouseID = '''+@ExWareHouseID+''' '
	ELSE
		SET @sWhere = @sWhere + ' AND T1.KindVoucherID = 2'
END

IF @FormID='WMF2025'
BEGIN
	IF ISNULL(@ImWarehouseID,'')<>''
		SET @sWhere = @sWhere + ' AND T1.KindVoucherID = 1 AND T1.ImWareHouseID = '''+@ImWareHouseID+''' '
	ELSE
		SET @sWhere = @sWhere + ' AND T1.KindVoucherID = 1'
END

IF @FormID='WMF2028'
BEGIN
	IF ISNULL(@ImWarehouseID,'')<>'' AND ISNULL(@ExWarehouseID,'')=''
		SET @sWhere = @sWhere + ' AND T1.KindVoucherID = 3 AND T1.ImWareHouseID = '''+@ImWareHouseID+''' '
	ELSE IF ISNULL(@ImWarehouseID,'')='' AND ISNULL(@ExWarehouseID,'')<>''
		SET @sWhere = @sWhere + ' AND T1.KindVoucherID = 3 AND T1.ExWareHouseID = '''+@ExWareHouseID+''' '
	ELSE IF ISNULL(@ImWarehouseID,'')<>'' AND ISNULL(@ExWarehouseID,'')<>''
		SET @sWhere = @sWhere + ' AND T1.KindVoucherID = 3 AND T1.ExWareHouseID = '''+@ExWareHouseID+''' AND T1.ImWareHouseID = '''+@ImWareHouseID+''' '
	ELSE
		SET @sWhere = @sWhere + ' AND T1.KindVoucherID = 3'
END

IF ISNULL(@ObjectID,N'')<>N''
	SET @sWhere=@sWhere+' AND T1.ObjectID = '''+@ObjectID+''' '

IF @IsDate = 0 
BEGIN
	SET @sWhere = @sWhere + N'
	AND T1.TranMonth + T1.TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+''
END
ELSE
BEGIN
	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') SET @sWhere = @sWhere + N'
	AND ISNULL(CONVERT(VARCHAR, T1.VoucherDate, 120),'''') >= '''+ISNULL(CONVERT(VARCHAR, @FromDate, 120),'')+''''
	IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') SET @sWhere = @sWhere + N'
	AND ISNULL(CONVERT(VARCHAR, T1.VoucherDate, 120),'''') <= '''+ISNULL(CONVERT(VARCHAR, @ToDate, 120),'')+''''
	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') SET @sWhere = @sWhere + N'
	AND ISNULL(CONVERT(VARCHAR, T1.VoucherDate, 120),'''') BETWEEN '''+ISNULL(CONVERT(VARCHAR, @FromDate, 120),'')+''' AND '''+ISNULL(CONVERT(VARCHAR, @ToDate, 120),'')+'''	'
END

IF @APK=''
BEGIN
SET @sSQL = N'
SELECT ROW_NUMBER() OVER (ORDER BY VoucherDate, VoucherNo) AS RowNum, '+@TotalRow+' AS TotalRow, *
FROM
(
	SELECT DISTINCT T1.VoucherID AS APKMaster, T1.DivisionID, T1.VoucherNo, T1.VoucherDate, T1.ObjectID, T4.ObjectName, T1.WarehouseID, T5.WareHouseName AS ImWarehouseName,
					T1.WarehouseID2, T6.WareHouseName AS ExWarehouseName, T1.PONumber, T1.InventoryTypeID
	FROM WT0095 T1 INNER JOIN WT0096 T2 ON T1.DivisionID = T2.DivisionID AND T1.VoucherID = T2.VoucherID
				   --LEFT JOIN WMT2007 T3 ON T3.InheritTableID=''WMT2080'' AND T3.InheritAPK=T2.APK AND T3.InheritAPKMaster=T1.APK AND T3.InventoryID=T2.InventoryID
				   LEFT JOIN AT1202 T4 ON T4.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.ObjectID=T4.ObjectID
				   LEFT JOIN AT1303 T5 ON T5.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.WarehouseID=T5.WareHouseID
				   LEFT JOIN AT1303 T6 ON T6.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.WarehouseID=T6.WareHouseID
	WHERE '+@sWhere+' 
			AND NOT EXISTS (SELECT TOP 1 1 FROM WMT2007 WITH (NOLOCK) WHERE T1.DivisionID = WMT2007.DivisionID AND WMT2007.InheritAPKMaster = T1.APK AND T2.APK = WMT2007.InheritAPK AND WMT2007.InheritTableID = ''WMT2080'')
	GROUP BY T1.VoucherID, T1.DivisionID, T1.VoucherNo, T1.VoucherDate, T1.ObjectID, T4.ObjectName, T1.WarehouseID, T5.WareHouseName, T1.WarehouseID2, T6.WarehouseName, T1.PONumber, T1.InventoryTypeID

)Temp 
ORDER BY VoucherDate, VoucherNo
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY	
'
END
ELSE
BEGIN
SET @sSQL = N'
SELECT ROW_NUMBER() OVER (ORDER BY CurOrder DESC, VoucherDate, VoucherNo) AS RowNum, '+@TotalRow+' AS TotalRow, *
FROM
(
	SELECT DISTINCT T1.APK AS APKMaster, T1.DivisionID, T1.VoucherNo, T1.VoucherDate, T1.ObjectID, T4.ObjectName, T1.ImWarehouseID, T5.WareHouseName AS ImWarehouseName, T1.ExWarehouseID, T7.WareHouseName AS ExWarehouseName, 1 AS CurOrder
	FROM WMT2080 T1 INNER JOIN WMT2081 T2 ON T1.APK = T2.APKMaster
				   INNER JOIN WMT2007 T3 ON T3.InheritTableID=''WMT2080'' AND T3.InheritAPK=T2.APK AND T3.InheritAPKMaster=T1.APK AND T3.InventoryID=T2.InventoryID
				   LEFT JOIN AT1202 T4 ON T4.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.ObjectID=T4.ObjectID
				   LEFT JOIN AT1303 T5 ON T5.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.ImWarehouseID=T5.WareHouseID
				   INNER JOIN WMT2006 T6 ON T3.APKMaster=T6.APK
				   LEFT JOIN AT1303 T7 ON T6.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.ExWarehouseID=T7.WareHouseID
	WHERE T1.DivisionID = '''+@DivisionID+''' AND T6.APK='''+@APK+'''
	GROUP BY T1.APK, T1.DivisionID, T1.VoucherNo, T1.VoucherDate, T1.ObjectID, T4.ObjectName, T1.ImWarehouseID, T5.WareHouseName, T1.ExWarehouseID, T7.WarehouseName
	
	UNION ALL

	SELECT DISTINCT T1.APK AS APKMaster, T1.DivisionID, T1.VoucherNo, T1.VoucherDate, T1.ObjectID, T4.ObjectName, T1.ImWarehouseID, T5.WareHouseName AS ImWarehouseName, T1.ExWarehouseID, T6.WareHouseName AS ExWarehouseName, 0 AS CurOrder
	FROM WMT2080 T1 INNER JOIN WMT2081 T2 ON T1.DivisionID = T2.DivisionID AND T1.APK = T2.APKMaster
				   --LEFT JOIN WMT2007 T3 ON T3.InheritTableID=''WMT2080'' AND T3.InheritAPK=T2.APK AND T3.InheritAPKMaster=T1.APK AND T3.InventoryID=T2.InventoryID
				   LEFT JOIN AT1202 T4 ON T4.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.ObjectID=T4.ObjectID
				   LEFT JOIN AT1303 T5 ON T5.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.ImWarehouseID=T5.WareHouseID
				   LEFT JOIN AT1303 T6 ON T6.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.ExWarehouseID=T6.WareHouseID
	WHERE '+@sWhere+' 
			AND NOT EXISTS (SELECT TOP 1 1 FROM WMT2007 WITH (NOLOCK) WHERE T1.DivisionID = WMT2007.DivisionID AND WMT2007.InheritAPKMaster = T1.APK AND T2.APK = WMT2007.InheritAPK AND WMT2007.InheritTableID = ''WMT2080'')
	GROUP BY T1.APK, T1.DivisionID, T1.VoucherNo, T1.VoucherDate, T1.ObjectID, T4.ObjectName, T1.ImWarehouseID, T5.WareHouseName, T1.ExWarehouseID, T6.WarehouseName
)Temp 
ORDER BY CurOrder DESC, VoucherDate, VoucherNo
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
