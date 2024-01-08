IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP1250]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CIP1250]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid chọn bảng giá
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 11/04/2018 by Khả Vi
----Modify on 02/05/2018 by Khả Vi: Bổ sung kế thừa bảng giá bán đề nghị (VIETFIRST)
-- <Example>
/*   
CIP1250 @DivisionID = 'VF', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @FromDate = '2018-04-26', @ToDate = '2018-04-26', @FirmID = 'APPLE', 
@txtSearch = '', @ScreenID = 'CIF1331', @Mode = 1

CIP1250 @DivisionID, @UserID, @PageNumber, @PageSize, @FromDate, @ToDate, @FirmID, @txtSearch, @ScreenID, @Mode
*/
----
CREATE PROCEDURE CIP1250
( 
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@PageNumber INT, 
	@PageSize INT, 
	@FromDate DATETIME, 
	@ToDate DATETIME, 
	@FirmID VARCHAR(50), 
	@txtSearch VARCHAR(50), 
	@ScreenID VARCHAR(50), 
	@Mode INT ---- 0: Gọi từ radiobuton kế thừa bảng giá bán
			  ---- 1: Gọi từ radiobutton kế thừa bảng giá bán đề nghị 
					
) 
AS 
DECLARE @sSQL NVARCHAR (MAX), 
		@sWhere NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50) = N''

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
IF @ScreenID = 'CIF1251' AND @Mode = 0
BEGIN
	SET @OrderBy = ' OT1301.ID'

	IF ISNULL(@txtSearch, '') <> '' SET @sWhere = @sWhere + N'
	AND (OT1301.ID LIKE ''%'+@txtSearch+'%'' OR OT1301.[Description] LIKE ''%'+@txtSearch+'%'' OR OT1301.FromDate LIKE ''%'+@txtSearch+'%'' 
	OR OT1301.ToDate LIKE ''%'+@txtSearch+'%'' OR OT1301.InventoryTypeID LIKE ''%'+@txtSearch+'%'')'
	
	SET @sSQL = N'
	SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
	OT1301.ID, OT1301.[Description], OT1301.FromDate, OT1301.ToDate, OT1301.InventoryTypeID, AT1301.InventoryTypeName
	FROM OT1301 WITH (NOLOCK) 
	LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.DivisionID IN (OT1301.DivisionID, ''@@@'') AND OT1301.InventoryTypeID = AT1301.InventoryTypeID
	WHERE OT1301.DivisionID = '''+@DivisionID+''' AND OT1301.TypeID = 0 
	'+@sWhere+'
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
END  
ELSE IF @ScreenID = 'CIF1251' AND @Mode = 1 
BEGIN
	SET @OrderBy = ' SOT1030.ID'

	IF ISNULL(@txtSearch, '') <> '' SET @sWhere = @sWhere + N'
	AND (SOT1030.ID LIKE ''%'+@txtSearch+'%'' OR SOT1030.[Description] LIKE ''%'+@txtSearch+'%'' OR SOT1030.FromDate LIKE ''%'+@txtSearch+'%'' 
	OR SOT1030.ToDate LIKE ''%'+@txtSearch+'%'')'

	SET @sSQL = N'
	SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
	SOT1030.ID, SOT1030.[Description], SOT1030.FromDate, SOT1030.ToDate, NULL AS InventoryTypeID, NULL AS InventoryTypeName
	FROM SOT1030 WITH (NOLOCK)
	WHERE SOT1030.DivisionID = '''+@DivisionID+''' AND SOT1030.FirmID = '''+@FirmID+'''
	AND '''+ISNULL(CONVERT(VARCHAR(20), @FromDate, 112), '')+''' BETWEEN ISNULL(CONVERT(VARCHAR(20), SOT1030.FromDate, 112), '''')
		AND ISNULL(CONVERT(VARCHAR(20), SOT1030.ToDate, 112), '''')
	AND '''+ISNULL(CONVERT(VARCHAR(20), @ToDate, 112), '')+''' BETWEEN ISNULL(CONVERT(VARCHAR(20), SOT1030.FromDate, 112), '''')
	AND ISNULL(CONVERT(VARCHAR(20), SOT1030.ToDate, 112), '''')
	'+@sWhere+'
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
END 

ELSE IF @ScreenID = 'CIF1331'
BEGIN
	SET @OrderBy = ' OT1301.ID'

	IF ISNULL(@txtSearch, '') <> '' SET @sWhere = @sWhere + N'
	AND (OT1301.ID LIKE ''%'+@txtSearch+'%'' OR OT1301.[Description] LIKE ''%'+@txtSearch+'%'' OR OT1301.FromDate LIKE ''%'+@txtSearch+'%'' 
	OR OT1301.ToDate LIKE ''%'+@txtSearch+'%'' OR OT1301.InventoryTypeID LIKE ''%'+@txtSearch+'%'')'
	
	SET @sSQL = N'
	SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
	OT1301.ID, OT1301.[Description], OT1301.FromDate, OT1301.ToDate, OT1301.InventoryTypeID, AT1301.InventoryTypeName
	FROM OT1301 WITH (NOLOCK) 
	LEFT JOIN AT1301 WITH (NOLOCK) ON AT1301.DivisionID IN (OT1301.DivisionID, ''@@@'') AND OT1301.InventoryTypeID = AT1301.InventoryTypeID
	WHERE OT1301.DivisionID = '''+@DivisionID+''' AND OT1301.TypeID = 1
	'+@sWhere+'
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
END 

--PRINT @sSQL 
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

