IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP1020]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP1020]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid Form LMF1020: Truy vấn TS đảm bảo
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
 EXEC LMP1020 @DivisionID = 'AS',@UserID = 'ASOFTADMIN',@PageNumber = 1,@PageSize = 20, @SourceID = '%',@AssetID = '' ,  @AssetName = '', @Status = null, @Disabled = null
*/
----
CREATE PROCEDURE [LMP1020] 
( 
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@PageNumber INT,
	@PageSize INT,	
	@SourceID NVARCHAR(50),
	@AssetID NVARCHAR(1000),
	@AssetName NVARCHAR(1000),
	@Status INT,
	@Disabled INT
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX) = '',
        @OrderBy NVARCHAR(500) = 'SourceID, AssetID',
        @TotalRow NVARCHAR(50) = ''
        
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL' 	

IF ISNULL(@SourceID,'') <> ''
BEGIN
	SET @sWhere = @sWhere + '
	AND LMT1020.SourceID LIKE ''%' + ISNULL(@SourceID,'') + '%'''
END	
		
IF ISNULL(@AssetID,'') <> ''
BEGIN
	SET @sWhere = @sWhere + '
	AND LMT1020.AssetID LIKE ''%' + ISNULL(@AssetID,'') + '%'''
END		

IF ISNULL(@AssetID,'') <> ''
BEGIN
	SET @sWhere = @sWhere + '
	AND LMT1020.AssetName LIKE ''%' + ISNULL(@AssetName,'') + '%'''
END	

IF @Status is not null
BEGIN
	SET @sWhere = @sWhere + '
	AND LMT1020.Status LIKE '+STR(@Status)+''
END	

IF @Disabled is not null
BEGIN
	SET @sWhere = @sWhere + '
	AND LMT1020.Disabled LIKE '+STR(@Disabled)+''
END	
		
SET @sSQL = '
SELECT  ROW_NUMBER() OVER (ORDER BY LMT1020.AssetID) AS RowNum, COUNT(*) OVER () as TotalRow, LMT1020.*, LMT99.Description as SourceName,LMT0099.Description as StatusName 
FROM LMT1020 WITH (NOLOCK)
LEFT JOIN LMT0099 WITH (NOLOCK) ON LMT0099.OrderNo = LMT1020.Status AND CodeMaster = ''LMT00000016''
LEFT JOIN LMT0099 LMT99 WITH (NOLOCK) ON LMT99.ID = LMT1020.SourceID AND LMT99.CodeMaster = ''LMT00000004''                                
WHERE LMT1020.DivisionID = '''+@DivisionID+''' 
 ' + @sWhere + '
ORDER BY LMT1020.AssetID
OFFSET ' + CONVERT(NVARCHAR(10), (@PageNumber - 1) * @PageSize) + ' ROWS
FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'

--PRINT(@sSQL)
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

