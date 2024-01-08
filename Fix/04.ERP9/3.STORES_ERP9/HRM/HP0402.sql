IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0402]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0402]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load danh sách nhân viên theo tổ nhóm, phòng ban (ERP 9.0)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tiểu Mai on 12/12/2016
---- Modified by Tiểu Mai on 13/02/2017: Bổ sung phân trang
---- Modified by Trọng Kiên on 11/08/2020: Xử lý dữ liệu trùng
-- <Example>
---- 
/*-- <Example>
	EXEC HP0402 'ANG',6,2016,N'%', N'%'
	select * from HT2803 
----*/

CREATE PROCEDURE HP0402
( 
	 @DivisionID VARCHAR(50),
	 @TranMonth INT,
	 @TranYear INT,
	 @ListDepartmentID NVARCHAR(MAX),
	 @ListTeamID NVARCHAR(MAX),
	 @Mode TINYINT = 0,
	 @PageNumber INT = 0,
	 @PageSize INT = 0,
	 @TxtSearch NVARCHAR(250) = ''
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @TotalRow NVARCHAR(50) = '',
        @OrderBy NVARCHAR(500) = ''
             
SET @sWhere = ''

IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @OrderBy = 'H03.EmployeeID, H14.TeamID'

IF Isnull(@ListDepartmentID,'%') = '%'  
	SET @sWhere = @sWhere + '
		AND H14.DepartmentID LIKE N''%''	'
ELSE 
	SET @sWhere = @sWhere + '
		AND H14.DepartmentID IN ('''+@ListDepartmentID+''')	'
		
IF Isnull(@ListTeamID,'%') = '%'  
	SET @sWhere = @sWhere + '
		AND H14.TeamID LIKE N''%''	'
ELSE 
	SET @sWhere = @sWhere + '
		AND H14.TeamID IN ('''+@ListTeamID+''')	'

IF ISNULL(@TxtSearch, '') <> '%' AND ISNULL(@TxtSearch, '') <> ''
BEGIN
	SET @sWhere = @sWhere + '
		AND (ISNULL(H14.EmployeeID,'''') LIKE ''%'+@TxtSearch+'%'' OR ISNULL(H14.FullName,'''') LIKE ''%'+@TxtSearch+'%'')'
END


IF @Mode = 1
BEGIN 
	SET @sSQL = '
	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, H03.EmployeeID, H14.FullName
	FROM HT2803 H03 WITH (NOLOCK)
	LEFT JOIN HV1400 H14 ON H14.DivisionID = H03.DivisionID AND H14.EmployeeID = H03.EmployeeID 
	WHERE H14.DivisionID = ''' +@DivisionID +'''
		AND H03.TranMonth = '+CONVERT(NVARCHAR(5),@TranMonth)+'
		AND H03.TranYear = '+CONVERT(NVARCHAR(5),@TranYear)+ @sWhere + '
	GROUP BY H03.EmployeeID, H14.TeamID, H14.FullName
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
	'
END
ELSE 
BEGIN
	SET @sSQL = '
	SELECT 0 AS RowNum, 0 AS TotalRow, H03.EmployeeID, H14.FullName
	FROM HT2803 H03 WITH (NOLOCK)
	LEFT JOIN HV1400 H14 ON H14.DivisionID = H03.DivisionID AND H14.EmployeeID = H03.EmployeeID 
	WHERE H14.DivisionID = ''' +@DivisionID +'''
		AND H03.TranMonth = '+CONVERT(NVARCHAR(5),@TranMonth)+'
		AND H03.TranYear = '+CONVERT(NVARCHAR(5),@TranYear)+ @sWhere + '
	ORDER BY '+@OrderBy+'
	'
END
EXEC (@sSQL)
PRINT(@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
