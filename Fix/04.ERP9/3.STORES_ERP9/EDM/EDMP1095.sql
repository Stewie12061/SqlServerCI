IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1095]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1095]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Chọn khối 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
---- 
-- <History>
----Created by: Hồng Thảo, Date: 13/09/2018
----Modified by 
-- <Example>
---- 
/*-- <Example>
	EDMP1095 @DivisionID = 'VS', @UserID = '', @PageNumber = 1, @PageSize = 25, @txtSearch = ''

	EDMP1095 @DivisionID, @UserID, @PageNumber, @PageSize, @XML,
----*/
CREATE PROCEDURE EDMP1095
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @txtSearch NVARCHAR(100)

)

AS 
DECLARE @sSQL NVARCHAR(MAX) = N'', 
		@OrderBy NVARCHAR(MAX) = N'', 
		@TotalRow NVARCHAR(50) = N'',
		@sWhere NVARCHAR(MAX) = N''

SET @OrderBy = N'EDMT1000.GradeID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF ISNULL(@txtSearch, '') <> '' SET @sWhere = @sWhere + N'
AND (EDMT1000.GradeID LIKE N''%'+@txtSearch+'%'' OR EDMT1000.Gradename LIKE N''%'+@txtSearch+'%'')'

SET @sSQL = @sSQL + N'
		SELECT  CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
		EDMT1000.GradeID, EDMT1000.GradeName
		FROM EDMT1000 WITH (NOLOCK) 
		WHERE EDMT1000.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND  EDMT1000.Disabled = 0
		'+@sWhere+' 

ORDER BY '+@OrderBy+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
	
	

 --PRINT @sSQL
 EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
