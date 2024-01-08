IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0082]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0082]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Trả dữ liệu cho màn hình khai báo tồn phép đầu kỳ
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created on 07/05/2004 by: Hải Long
--- Modified on 12/07/2018 by Bảo Anh: Sắp xếp theo mã nhân viên
---- Modified on 05/01/2019 by Bảo Anh: Bổ sung cột Số phép bù ban đầu
---- Modified on 08/12/2023 by Đình Định: APT - Join lại cột DepartmentID tránh double dòng.
-- <Example>
/*   
   EXEC HP0082 @DivisionID = 'ANG', @TranMonth = 2, @TranYear = 2016, @PageNumber=1, @PageSize=10, @IsSearch = 1, @LstDepartmentID = 'PRD, PSX', @LstTeamID = 'TRD, PSX', @EmployeeID = '', @FullName = ''
*/

CREATE PROCEDURE [dbo].[HP0082]
(
	@DivisionID NVARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@PageNumber INT,
	@PageSize INT,
	@IsSearch BIT,	
	@LstDepartmentID NVARCHAR(4000),
	@LstTeamID NVARCHAR(4000),
	@EmployeeID NVARCHAR(100),
	@FullName NVARCHAR(100)
)
AS
DECLARE @sSQL NVARCHAR(4000),
		@sWhere NVARCHAR(500) = '',
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50) = ''
		
SET @OrderBy = 'A.EmployeeID'
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'		
		
SET @LstDepartmentID = REPLACE(@LstDepartmentID, ',', ''',''')
SET @LstTeamID = REPLACE(@LstTeamID, ',', ''',''')
	
IF @IsSearch = 1
BEGIN		
	IF ISNULL(@LstDepartmentID, '') <> '' 
	BEGIN 
		SET @sWhere = @sWhere + 'AND HT1400.DepartmentID IN (''' + @LstDepartmentID + ''')' + char(13)
	END

	IF ISNULL(@LstTeamID, '') <> '' 
	BEGIN

		SET @sWhere = @sWhere + 'AND HT1400.TeamID IN (''' + @LstTeamID + ''')'	+ char(13)
	END

	IF ISNULL(@EmployeeID, '') <> '' 
	BEGIN
	 
		SET @sWhere = @sWhere + 'AND HT1420.EmployeeID LIKE ''%' + @EmployeeID + '%''' + char(13)	
	END

	IF ISNULL(@FullName, '') <> '' 
	BEGIN
	
		SET @sWhere = @sWhere + 'AND Ltrim(RTrim(isnull(HT1400.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT1400.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT1400.FirstName,''''))) LIKE ''%' + @FullName + '%''' + char(13)
	END
END 

SET @sSQL = '
SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, *
FROM
(
	SELECT HT1420.APK, HT1420.DivisionID, HT1420.TranMonth, HT1420.TranYear, HT1420.EmployeeID, Ltrim(RTrim(isnull(HT1400.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT1400.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT1400.FirstName,''''))) AS FullName,
	AT1102.DepartmentName, HT1101.TeamName, HT1420.FirstLoaDays, (CASE WHEN HT1420.TranMonth + HT1420.TranYear*100 <> ' + CONVERT(NVARCHAR(10), @TranMonth + @TranYear*100) + ' THEN 1 ELSE 0 END) AS IsInvisible,
	HT1420.CreateUserID, HT1420.CreateDate, HT1420.LastModifyUserID, HT1420.LastModifyDate, HT1420.FirstOTLeaveDays
	FROM HT1420 WITH (NOLOCK) 
	INNER JOIN HT2803 WITH (NOLOCK) ON HT1420.DivisionID = HT2803.DivisionID AND HT1420.EmployeeID = HT2803.EmployeeID
	INNER JOIN HT1400 WITH (NOLOCK) ON HT2803.DivisionID = HT1400.DivisionID AND HT2803.EmployeeID = HT1400.EmployeeID
	LEFT JOIN AT1102 WITH (NOLOCK) ON HT1400.DepartmentID = AT1102.DepartmentID
	LEFT JOIN HT1101 WITH (NOLOCK) ON HT1400.DivisionID = HT1101.DivisionID AND HT1400.TeamID = HT1101.TeamID AND HT1400.DepartmentID = HT1101.DepartmentID
	WHERE HT1420.DivisionID = ''' + @DivisionID + '''
	AND HT2803.TranMonth = ' + CONVERT(NVARCHAR(10), @TranMonth) + '
	AND HT2803.TranYear = ' + CONVERT(NVARCHAR(10), @TranYear) + '
	' + @sWhere + 
	'
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