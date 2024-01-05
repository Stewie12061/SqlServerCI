IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP10004]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP10004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- In danh muc phong ban - Store CIP10004
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phạm Lê Hoàng on 12/05/2021
---- 
--EXEC CIP10004 'AS','', '','','',''
----
CREATE PROCEDURE CIP10004
( 
    @DivisionID VARCHAR(50),
	@TxtSearch NVARCHAR(MAX)= '',
	@UserID VARCHAR(50) = '',
	@PageNumber INT,
	@PageSize INT
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50)
        
SET @sWhere = ''

SET @OrderBy = 'DivisionID, DepartmentID'

SET @sWhere = @sWhere+ ' AND (AT1102.DivisionID IN (''' + @DivisionID + ''', ''@@@'') Or AT1102.IsCommon = 1)'

IF ISNULL(@TxtSearch,'') != ''  
BEGIN
	SET @sWhere = @sWhere +'
	AND (AT1102.DepartmentID LIKE N''%'+@TxtSearch+'%'' 
	OR AT1102.DepartmentName LIKE N''%'+@TxtSearch+'%'') '
END

SET @sSQL = '
SELECT 
	AT1102.DivisionID, AT1101.DivisionName, AT1102.DepartmentID, AT1102.DepartmentName, AT1102.IsCommon,
	AT1102.CreateUserID, AT1102.LastModifyUserID, AT1102.CreateDate, AT1102.LastModifyDate 
INTO #TempAT1102
FROM AT1102 With (NOLOCK)
LEFT JOIN AT1101 WITH(NOLOCK) ON AT1101.DivisionID = AT1102.DivisionID
WHERE 1 = 1 '+@sWhere+'

DECLARE @Count INT
SELECT @Count = COUNT(DepartmentID)
FROM #TempAT1102

SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow, M.*
FROM #TempAT1102 M WITH (NOLOCK)
ORDER BY ' + @OrderBy + '
OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '

EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
