IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP1023]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP1023]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid Form LMF1023 Kế thừa TSCĐ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 09/01/2018 by Phương Thảo
----Modify on
-- <Example>
/*  
 EXEC LMP1023 @DivisionID = 'AS',@UserID = 'ASOFTADMIN',@PageNumber = 1,@PageSize = 20, @SourceID = '%',@AssetID = ''  
*/
----
CREATE PROCEDURE [LMP1023] 
( 
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@PageNumber INT,
	@PageSize INT,	
	@SourceID NVARCHAR(50),
	@AssetID NVARCHAR(1000)
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'SourceID, AssetID',
        @TotalRow NVARCHAR(50) = N''
        
IF @PageNumber = 1 SET @TotalRow = N'COUNT(*) OVER ()' ELSE SET @TotalRow = N'NULL' 	
		
IF ISNULL(@AssetID,'') <> ''
BEGIN
	SET @sWhere = @sWhere + N'
	AND AssetID LIKE ''%' + ISNULL(@AssetID,'') + '%'''
END		
		
SET @sSQL = N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+N')) AS RowNum, '+@TotalRow+N' AS TotalRow, *
FROM
(
	SELECT ''FixAsset'' AS SourceID, N''Tài sản cố định'' AS SourceName, AT1503.AssetID AS InheritID, AT1503.AssetID, AT1503.AssetName, AT1503.ConvertedAmount AS AccountingValue, Notes AS Note
	FROM AT1503 WITH (NOLOCK)
	LEFT JOIN LMT1020 WITH (NOLOCK) ON LMT1020.DivisionID = AT1503.DivisionID AND LMT1020.InheritID = AT1503.AssetID	
	WHERE AT1503.DivisionID = ''' + @DivisionID + N'''
	AND NOT EXISTS (SELECT TOP 1 1 FROM LMT1020 WITH (NOLOCK) WHERE LMT1020.DivisionID = AT1503.DivisionID AND LMT1020.InheritID = AT1503.AssetID)
	UNION ALL	
	SELECT ''Project'' AS SourceID, N''Dự án'' AS SourceName, AnaID AS InheritID, AnaID AS AssetID, AnaName AS AssetName, NULL AS AccountingValue, Notes AS Note
	FROM AT1011 WITH (NOLOCK)
	LEFT JOIN LMT1020 WITH (NOLOCK) ON LMT1020.DivisionID = AT1011.DivisionID AND LMT1020.InheritID = AT1011.AnaID	
	WHERE AT1011.DivisionID IN (''' + @DivisionID + ''' , ''@@@'')
	AND AT1011.[Disabled] = 0
	AND  NOT EXISTS (SELECT TOP 1 1 FROM LMT1020 WITH (NOLOCK) WHERE LMT1020.DivisionID = AT1011.DivisionID AND LMT1020.InheritID = AT1011.AnaID)
	AND AnaTypeID = (SELECT ProjectAnaTypeID FROM AT0000 WHERE DefDivisionID = ''' + @DivisionID + ''')
) A 	
WHERE SourceID LIKE ''' + @SourceID + '''' + @sWhere + '
ORDER BY ' + @OrderBy + '
OFFSET ' + CONVERT(NVARCHAR(10), (@PageNumber - 1) * @PageSize) + ' ROWS
FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'

--PRINT(@sSQL)
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

