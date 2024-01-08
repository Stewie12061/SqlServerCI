IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0086]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0086]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Load nhân viên ở màn hình cập nhật hồ sơ phép
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by: Hải Long, Date: 16/12/2016
 ---- EXEC HP0086 @DivisionID = 'MK', @UserID = 'ASOFTADMIN', @DepartmentID = 'B000000', @TeamID = 'BPC0000', @PageNumber = 1, @PageSize = 20, @TxtSearch = 'Nam',  @TranMonth = 1, @TranYear = 2016
 
 CREATE PROCEDURE [DBO].[HP0086]
 ( 
   @DivisionID VARCHAR(50),
   @UserID VARCHAR(50),
   @DepartmentID VARCHAR(MAX),
   @TeamID VARCHAR(MAX),
   @PageNumber INT,
   @PageSize INT,
   @TxtSearch NVARCHAR(250),
   @TranMonth INT,
   @TranYear INT
 ) 
 AS
 DECLARE @sSQL VARCHAR(MAX),
		 @OrderBy NVARCHAR(500),
		 @TotalRow NVARCHAR(50) = '',
		 @sWhere NVARCHAR(4000) = '',
		 @sWhere1 NVARCHAR(4000) = '',
		 @sWhere2 NVARCHAR(4000) = ''


IF ISNULL(@DepartmentID, '') <> '%' AND ISNULL(@DepartmentID, '') <> ''
BEGIN
	SET @DepartmentID = REPLACE(@DepartmentID, ',', ''',''')
	SET @sWhere = '
	AND HV1400.DepartmentID IN (''' + @DepartmentID + ''')'
END

IF ISNULL(@TeamID, '') <> '%' AND ISNULL(@TeamID, '') <> ''
BEGIN
	SET @TeamID = REPLACE(@TeamID, ',', ''',''')
	SET @sWhere1 = '
	AND HV1400.TeamID IN (''' + @TeamID + ''')'
END

IF ISNULL(@TxtSearch, '') <> '%' AND ISNULL(@TxtSearch, '') <> ''
BEGIN
	SET @sWhere2 = '
	AND (ISNULL(HV1400.EmployeeID,'''') LIKE ''%'+@TxtSearch+'%'' OR ISNULL(HV1400.FullName,'''') LIKE ''%'+@TxtSearch+'%'')'
END


SET @OrderBy = 'EmployeeID'
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'	

SET @sSQL = '
SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, *
FROM
(
	SELECT HV1400.EmployeeID, HV1400.FullName, HV1400.DepartmentID, HV1400.TeamID
	FROM HV1400 WITH (NOLOCK) 
	WHERE HV1400.DivisionID = ''' + @DivisionID + '''
	' + @sWhere + @sWhere1 + @sWhere2 + '
		AND HV1400.EmployeeID NOT IN 
			(
				SELECT EmployeeID FROM HT2803 WITH (NOLOCK) 
				WHERE DivisionID = ''' + @DivisionID + ''' 
				AND TranMonth = ' + CONVERT(NVARCHAR(10), @TranMonth) + '
				AND TranYear = ' + CONVERT(NVARCHAR(10), @TranYear) + '
			) 		
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
