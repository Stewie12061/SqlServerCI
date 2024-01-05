IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0085]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0085]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Load nhân viên ở màn hình kế thừa hồ sơ phép
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by: Hải Long, Date: 16/12/2016
 ---- EXEC HP0085 @DivisionID = 'MK', @UserID = 'ASOFTADMIN', @LstDepartmentID = 'B000000,B000000', @LstTeamID = 'BPC0000,EMA0000', @PageNumber = 1, @PageSize = 20, @TxtSearch = '', @Mode = 2, @TranMonth = 2, @TranYear = 2017, @LastTranMonth = 12, @LastTranYear = 2016

 
 CREATE PROCEDURE HP0085
 ( 
   @DivisionID VARCHAR(50),
   @UserID VARCHAR(50),
   @LstDepartmentID VARCHAR(MAX),
   @LstTeamID VARCHAR(MAX),
   @PageNumber INT,
   @PageSize INT,
   @TxtSearch NVARCHAR(250),
   @Mode as tinyint,
   @TranMonth INT,
   @TranYear INT,
   @LastTranMonth INT,
   @LastTranYear INT 
 ) 
 AS
 DECLARE @sSQL VARCHAR(MAX),
		 @OrderBy NVARCHAR(500),
		 @TotalRow NVARCHAR(50) = '',
		 @sWhere NVARCHAR(4000) = '',
		 @sWhere1 NVARCHAR(4000) = '',
		 @sWhere2 NVARCHAR(4000) = ''

IF ISNULL(@LstDepartmentID, '') <> '%'
BEGIN
	SET @sWhere = '
		AND HV1400.DepartmentID IN ('''+REPLACE(@LstDepartmentID, ',', ''',''')+''')' 
END

IF ISNULL(@LstTeamID, '') <> '%'
BEGIN
	SET @sWhere1 = '
		AND HV1400.TeamID IN ('''+REPLACE(@LstTeamID, ',', ''',''')+''')' 
END

IF ISNULL(@TxtSearch, '') <> '%'
BEGIN
	SET @sWhere2 = '
		AND (ISNULL(HV1400.EmployeeID,'''') LIKE ''%'+@TxtSearch+'%'' OR ISNULL(HV1400.FullName,'''') LIKE ''%'+@TxtSearch+'%'')'
END


SET @LstDepartmentID = REPLACE(@LstDepartmentID, ',', ''',''')
SET @LstTeamID = REPLACE(@LstTeamID, ',', ''',''')

SET @OrderBy = 'EmployeeID'
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'	

IF @Mode = 1 --- ho so nhan su
BEGIN
	SET @sSQL = '
	SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, *
	FROM
	(
		SELECT HV1400.EmployeeID, HV1400.FullName, HV1400.DepartmentID, HV1400.TeamID
		FROM HV1400
		WHERE HV1400.DivisionID = ''' + @DivisionID + '''
		' + @sWhere + @sWhere1 + @sWhere2 + '
		AND HV1400.EmployeeID NOT IN (SELECT EmployeeID FROM HT2803 WITH (NOLOCK) WHERE DivisionID = ''' + @DivisionID + ''' AND TranMonth = ' + CONVERT(NVARCHAR(10),@TranMonth) + ' AND TranYear = ' + CONVERT(NVARCHAR(10),@TranYear) + ')
	) A 	
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'	
END
ELSE -- Mode = 2 Ho so phep
BEGIN
	SET @sSQL = '
	SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, *
	FROM
	(
		SELECT HT2803.EmployeeID, HV1400.FullName, HV1400.DepartmentID, HV1400.TeamID
		FROM HT2803 WITH (NOLOCK) 
		LEFT JOIN HV1400 ON HV1400.DivisionID = HT2803.DivisionID AND HV1400.EmployeeID = HT2803.EmployeeID
		WHERE HV1400.DivisionID = ''' + @DivisionID + '''
		' + @sWhere + @sWhere1 + @sWhere2 + '
		AND HT2803.EmployeeID NOT IN (SELECT EmployeeID FROM HT2803 WITH (NOLOCK) WHERE DivisionID = ''' + @DivisionID + ''' AND TranMonth = ' + CONVERT(NVARCHAR(10),@TranMonth) + ' AND TranYear = ' + CONVERT(NVARCHAR(10),@TranYear) + ')
		AND HT2803.TranMonth = ' + CONVERT(NVARCHAR(10),@LastTranMonth) + '
		AND HT2803.TranYear = ' + CONVERT(NVARCHAR(10),@LastTranYear) + '
	) A 	
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'	
END


EXEC (@sSQL)
PRINT @sSQL

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
