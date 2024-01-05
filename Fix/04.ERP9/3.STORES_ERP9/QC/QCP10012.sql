IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP10012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP10012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load màn hình chọn mặt hàng để khai báo định nghĩa tiêu chuẩn cho mặt hàng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by Le Hoang on 26/04/2021
----Modified by ... on ... 
/*
	exec QCP10012 @DivisionID=N'VNP',  @TxtSearch=N'',@UserID=N'',@PageNumber=N'1',@PageSize=N'25', @APK = N''
*/

 CREATE PROCEDURE [dbo].[QCP10012] (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
	 @APK NVARCHAR(50)
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)	
	

	SET @sWhere = ''
	SET @TotalRow = ''

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'COUNT(*) OVER ()'
	
	IF @TxtSearch IS NOT NULL SET @sWhere = @sWhere +'
								AND (a.InventoryID LIKE N''%'+@TxtSearch+'%'' 
								OR a.InventoryName LIKE N''%'+@TxtSearch+'%'' 
								OR a.InventoryTypeID LIKE N''%'+@TxtSearch+'%'' 
								OR a.UnitID LIKE N''%'+@TxtSearch+'%''
								OR AT1304.UnitName LIKE N''%'+@TxtSearch+'%''
								OR a.I01ID LIKE N''%'+@TxtSearch+'%''
								OR T15.AnaName LIKE N''%'+@TxtSearch+'%'')
								AND (b.APK IS NULL OR CONVERT(NVARCHAR(50),b.APK) = '''+@APK+''') '

		SET @sSQL = '
		SELECT ROW_NUMBER() OVER (ORDER BY a.InventoryName) AS RowNum, '+@TotalRow+' AS TotalRow, 
		a.DivisionID, a.InventoryID, a.InventoryName, a.InventoryTypeID
		, a.UnitID, AT1304.UnitName, a.IsCommon, a.Disabled
		, a.SalePrice01 as SalePrice, a.VATGroupID, T10.VATGroupName, a.VATPercent
		, a.I01ID, T15.AnaName As I01Name, a.I02ID, T25.AnaName As I02Name
		, a.I03ID, T35.AnaName As I03Name, a.I04ID, T45.AnaName As I04Name
		, a.I05ID, T55.AnaName As I05Name, a.Specification 
		FROM AT1302 a WITH(NOLOCK)
		LEFT JOIN (SELECT APK, InventoryID FROM QCT1020 WITH(NOLOCK)) AS b ON a.InventoryID = b.InventoryID  
		LEFT JOIN AT1304 WITH (NOLOCK) ON a.UnitID = AT1304.UnitID and AT1304.Disabled = 0
		LEFT JOIN AT1010 T10 WITH (NOLOCK) ON T10.VATGroupID = a.VATGroupID
		LEFT JOIN AT1015 T15 WITH (NOLOCK) ON a.I01ID = T15.AnaID AND T15.AnaTypeID = ''I01''
		LEFT JOIN AT1015 T25 WITH (NOLOCK) ON a.I02ID = T25.AnaID AND T25.AnaTypeID = ''I02''
		LEFT JOIN AT1015 T35 WITH (NOLOCK) ON a.I03ID = T35.AnaID AND T35.AnaTypeID = ''I03''
		LEFT JOIN AT1015 T45 WITH (NOLOCK) ON a.I04ID = T45.AnaID AND T45.AnaTypeID = ''I04''
		LEFT JOIN AT1015 T55 WITH (NOLOCK) ON a.I05ID = T55.AnaID AND T55.AnaTypeID = ''I05''
		WHERE 1 = 1 ' + @sWhere + '
		ORDER BY a.InventoryName
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
		
EXEC (@sSQL)
PRINT (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
