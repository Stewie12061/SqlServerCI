IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0087]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0087]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Load nhân viên hồ sơ phép ở màn hình tính phép
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by: Hải Long, Date: 27/12/2016
 ---- EXEC HP0087 @DivisionID = 'MK', @UserID = 'ASOFTADMIN', @DepartmentID = NULL, @TeamID = NULL, @PageNumber = 1, @PageSize = 20, @TranMonth = 1, @TranYear = 2016
 
 CREATE PROCEDURE HP0087
 ( 
   @DivisionID VARCHAR(50),
   @UserID VARCHAR(50),
   @LstDepartmentID VARCHAR(MAX),
   @LstTeamID VARCHAR(MAX),
   @PageNumber INT,
   @PageSize INT,
   @TxtSearch NVARCHAR(250),
   @TranMonth INT,
   @TranYear INT
 ) 
 AS
 DECLARE @sSQL NVARCHAR(MAX),
		 @sWhere NVARCHAR(MAX) = '',
		 @sWhere1 NVARCHAR(MAX) = '',
		 @sWhere2 NVARCHAR(MAX) = '',
		 @OrderBy NVARCHAR(500),
		 @TotalRow NVARCHAR(50) = ''


SET @OrderBy = 'EmployeeID'
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'	

IF ISNULL(@LstDepartmentID, '') <> '%' AND ISNULL(@LstDepartmentID, '') <> ''
BEGIN
	SET @sWhere = '
		AND HV1400.DepartmentID IN ('''+REPLACE(@LstDepartmentID, ',', ''',''')+''')' 
END

IF ISNULL(@LstTeamID, '') <> '%' AND ISNULL(@LstTeamID, '') <> ''
BEGIN
	SET @sWhere1 = '
		AND HV1400.TeamID IN ('''+REPLACE(@LstTeamID, ',', ''',''')+''')' 
END

IF ISNULL(@TxtSearch, '') <> '%' AND ISNULL(@TxtSearch, '') <> ''
BEGIN
	SET @sWhere2 = '
		AND (ISNULL(HV1400.EmployeeID,'''') LIKE ''%'+@TxtSearch+'%'' OR ISNULL(HV1400.FullName,'''') LIKE ''%'+@TxtSearch+'%'')'
END

SET @sSQL = '
SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, *
FROM
(
	SELECT HT2803.EmployeeID, HV1400.FullName, HV1400.DepartmentID, HV1400.TeamID, HV1400.DepartmentName, HV1400.TeamName
	FROM HT2803 WITH (NOLOCK) 
	INNER JOIN HV1400 ON HT2803.DivisionID = HV1400.DivisionID AND HT2803.EmployeeID = HV1400.EmployeeID
	WHERE HT2803.DivisionID = ''' + @DivisionID + '''
	' + @sWhere + @sWhere1 + @sWhere2 + '
	AND HT2803.TranMonth = ' + CONVERT(NVARCHAR(10), @TranMonth) + ' AND HT2803.TranYear = ' + CONVERT(NVARCHAR(10), @TranYear) + '
) A 	
ORDER BY '+@OrderBy+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

EXEC (@sSQL)
PRINT @sSQL

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
