IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2112]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[SOP2112]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load Grid chi tiết vật tu tiêu hao
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Đình Hòa on: 14/05/2021
-- <Example>
/*

*/
CREATE PROCEDURE SOP2112
(
	@APKMaster VARCHAR(50),
	@DivisionID VARCHAR(50),
	@PageNumber INT,
	@PageSize INT
)
AS

DECLARE @sSQL NVARCHAR (MAX)='',
		@sSQL1 NVARCHAR (MAX)='',
        @strStandardID NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX)='',
        @OrderBy NVARCHAR(500)
        
SET @OrderBy = 'S01.OrderStd'

IF ISNULL(@DivisionID, '') != ''
	SET @sWhere = @sWhere + N'S01.DivisionID = '''+ @DivisionID +''''

IF ISNULL(@APKMaster, '') != ''
	SET @sWhere = @sWhere + N' AND (S01.APKMaster = '''+ @APKMaster +''' OR S00.APKMaster_9000 = '''+ @APKMaster +''')'

SELECT @strStandardID = COALESCE(@strStandardID + ', ', '') + X.StandardID
FROM (SELECT DISTINCT StandardID
	  FROM SOT2113 WITH(NOLOCK)) X

SET @sSQL = N'SELECT *
INTO #TempSOT2112
FROM (SELECT S01.APK, S01.APKMaster, S01.NodeID, S01.NodeName, S01.Price, S01.Amount, S02.StandardID, S02.StandardValue, S01.Quantity, S01.QuantityBOM, S01.PercentageLoss, S01.Density, S01.CategoryID, S01.UnitID, S03.UnitName, S01.OrderStd
FROM SOT2112 S01 WITH(NOLOCK)
LEFT JOIN SOT2110 S00 WITH(NOLOCK) ON S00.APK = S01.APKMaster AND S00.DivisionID = S01.DivisionID
LEFT JOIN SOT2113 S02 WITH(NOLOCK) ON S01.APK = S02.APKMaster_SOT2112
LEFT JOIN AT1304 S03 WITH(NOLOCK) ON S01.UnitID = S03.UnitID AND S03.DivisionID IN (S01.DivisionID,''@@@'')
WHERE '+ @sWhere + ' 
) X 
PIVOT  
(  
MAX (X.StandardValue)  
FOR X.StandardID IN  
(' + @strStandardID +  ')  
) AS Std '

SET @sSQL1 =N'SELECT ROW_NUMBER() OVER (Order BY '+@OrderBy+') AS RowNum
				   , COUNT(*) OVER () AS TotalRow, S01.*
			  FROM #TempSOT2112 S01
			  Order BY '+@OrderBy+'
			  OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			  FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@sSQL + @sSQL1)

PRINT (@sSQL)
PRINT (@sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
