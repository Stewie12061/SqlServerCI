IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0084]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0084]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Load nhân viên ở màn hình cập nhật số ngày phép ban đầu
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by: Hải Long, Date: 16/12/2016
 ---- EXEC HP0084 @DivisionID = 'MK', @UserID = 'ASOFTADMIN', @DepartmentID = NULL, @TeamID = NULL, @PageNumber = 1, @PageSize = 20, @TranMonth = 1, @TranYear = 2016
 
 CREATE PROCEDURE HP0084
 ( 
   @DivisionID VARCHAR(50),
   @UserID VARCHAR(50),
   @DepartmentID VARCHAR(50),
   @TeamID VARCHAR(50),
   @PageNumber INT,
   @PageSize INT,
   @TxtSearch NVARCHAR(250),
   @TranMonth INT,
   @TranYear INT
 ) 
 AS
 DECLARE @sSQL VARCHAR(MAX),
		 @OrderBy NVARCHAR(500),
		 @TotalRow NVARCHAR(50) = ''


SET @OrderBy = 'EmployeeID'
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'	

SET @sSQL = '
SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, *
FROM
(
	SELECT HT2803.EmployeeID, HV1400.FullName, HV1400.DepartmentID, HV1400.TeamID, HV1400.DepartmentName, HV1400.TeamName
	FROM HT2803 WITH (NOLOCK) 
	INNER JOIN HV1400 ON HT2803.DivisionID = HV1400.DivisionID AND HT2803.EmployeeID = HV1400.EmployeeID
	WHERE HT2803.DivisionID = ''' + @DivisionID + '''
	AND HV1400.DepartmentID LIKE ''' + @DepartmentID + '''
	AND HV1400.TeamID LIKE ''' + @TeamID + '''
	AND (ISNULL(HT2803.EmployeeID,'''') LIKE ''%'+@TxtSearch+'%'' OR ISNULL(HV1400.FullName,'''') LIKE ''%'+@TxtSearch+'%'') 
	AND HV1400.EmployeeID NOT IN (SELECT EmployeeID FROM HT1420 WITH (NOLOCK) WHERE DivisionID = ''' + @DivisionID + ''')
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
