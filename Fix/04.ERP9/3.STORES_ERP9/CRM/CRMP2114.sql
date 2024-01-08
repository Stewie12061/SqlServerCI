IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2114]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2114]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid: màn hình kế thừa yêu khách hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Đình Hòa on 27/04/2021
----Updated	by Văn Tài	on 12/07/2023 - Bổ sung lấy thêm BOM Version.
-- <Example>
---- 
/*-- <Example>
	CRMP2114 @DivisionID = 'AIC', @UserID = '' , @PageNumber = 1, @PageSize = 25, @IsDate = 1, @FromDate = '', @ToDate = '', @FromMonth = 1, @FromYear = 2018, @ToMonth = 12, @ToYear = 2018,...'
----*/

CREATE PROCEDURE CRMP2114
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
	 @VoucherNo VARCHAR(50),
	 @InventoryID NVARCHAR(250) 
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',	
		@sSQL1 NVARCHAR(MAX) = N'',
		@sWhere NVARCHAR(MAX) = N'',
		@TotalRow NVARCHAR(50) = N'',
        @OrderBy NVARCHAR(500) = N''

SET @OrderBy = 'T1.VoucherNo'
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

IF (ISNULL(@VoucherNo, '') <> '' ) 
		SET @sWhere = @sWhere + N' AND T1.VoucherNo = '''+@VoucherNo+''''

IF (ISNULL(@InventoryID, '') <> '' ) 
		SET @sWhere = @sWhere + N' AND (T2.InventoryID = '''+@InventoryID+''' OR T3.InventoryName LIKE N''%' +@InventoryID+ '%'')'

SET @sSQL = @sSQL + N'
	SELECT DISTINCT T1.APK
		, T1.DivisionID
		, T1.VoucherNo
		, T1.VoucherDate
		, T1.ObjectID
		, T4.ObjectName
		, T2.PaperTypeID
		, T6.Description AS PaperTypeName
		, T2.InventoryID
		, T3.InventoryName
		, T1.EmployeeID
		, T5.FullName AS EmployeeName
		, T1.DeliveryAddress
		, T2.ActualQuantity
		, T2.PrintTypeID
		, T2.PrintNumber
		, T2.ColorPrint01 AS SideColor1
		, T2.ColorPrint02 AS SideColor2
		, T2.SideColor1 AS IsSideColor1
		, T2.SideColor2 AS IsSideColor2
		, T2.APKMInherited
		, T2.APKDInherited
		, T2.Length
		, T2.Width
		, T2.Height
		, T2.FileName
		, T2.FilmDate
		, T2.DeliveryTime
		, T2.ProductQuality
		, T2.SampleContent
		, T2.ColorSample
		, ISNULL(MT22.Version, 0) AS BOMVersion
	INTO #CRMT2100
	FROM CRMT2100 T1 WITH (NOLOCK)
		LEFT JOIN CRMT2101 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster
		LEFT JOIN AT1302 T3 WITH (NOLOCK) ON T2.InventoryID = T3.InventoryID
		LEFT JOIN AT1202 T4 WITH (NOLOCK) ON T1.ObjectID = T4.ObjectID
		LEFT JOIN AT1103 T5 WITH (NOLOCK) ON T1.EmployeeID = T5.EmployeeID
		LEFT JOIN CRMT0099 T6 WITH(NOLOCK) ON T6.CodeMaster = ''CRMT00000022'' AND T2.PaperTypeID = T6.ID
		OUTER APPLY
		(
			SELECT TOP 1 MT22.Version
			FROM CRMT2104 CT04 WITH (NOLOCK)
			INNER JOIN MT2123 MT23 WITH (NOLOCK) ON MT23.DivisionID = CT04.DivisionID
													AND MT23.APK = CT04.APKNodeParent
			INNER JOIN MT2122 MT22 WITH (NOLOCK) ON MT22.DivisionID = CT04.DivisionID
													AND MT22.APK = MT23.APK_2120
			WHERE 
				CT04.DivisionID = T1.DivisionID
				AND CT04.APKMaster = T1.APK
		) MT22
	WHERE ISNULL(T1.DeleteFlg, 0) <> 1 AND T1.DivisionID = '''+@DivisionID+''' '
	 +@sWhere +'
'

SET @sSQL1 = @sSQL1 + ' SELECT ROW_NUMBER() OVER (ORDER BY T1.VoucherDate desc, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * FROM #CRMT2100 T1
ORDER BY '+@OrderBy+' 
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
'

PRINT @sSQL + @sSQL1
EXEC (@sSQL + @sSQL1)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
