IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0512]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0512]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load phân công giám sát (NEWTOYO)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi, Date: 26/09/2017
-- <Example>
---- 
/*-- <Example>
	EXEC [HP0512] @DivisionID ='CH', @EmployeeID = '%', @TranMonth = 1, @TranYear = 2017,
					@FromDate = '', @ToDate = '2017-01-31', @IsMode = 1, @FromDepartment = 'PB1', @ToDepartment = 'Z1', @TeamID = '%'
	
----*/
CREATE PROCEDURE HP0512
( 
	 @DivisionID VARCHAR(50),
	 @EmployeeID VARCHAR(50),
	 @TranMonth INT,
	 @TranYear INT,
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @IsMode INT, -- 0 load grid khi edit
			-- 1 load grid tại màn hình truy vấn
	 @FromDepartment VARCHAR(50), 
	 @ToDepartment VARCHAR(50), 
	 @TeamID VARCHAR(50)

)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
        @sWhere NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
		@Period INT = 0

SET @OrderBy = 'HT1114.EmployeeID'
SET @Period = (@TranMonth + @TranYear * 100)
SET @sWhere = @sWhere + 'HT1114.DivisionID = '''+@DivisionID+''' AND (HT1114.TranMonth + HT1114.TranYear * 100) = '+STR(@Period)+' ' 

IF @IsMode = 1
BEGIN

	IF ISNULL(@EmployeeID,'') <> '' SET @sWhere = @sWhere + '
	AND ISNULL(HT1114.EmployeeID,'''') LIKE ''%'+@EmployeeID+'%'' '
	IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE, HT1114.FromDate, 120), 126) >= '''+CONVERT(VARCHAR(10), @FromDate, 126)+''' '
	IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE, HT1114.ToDate, 120), 126) <= '''+CONVERT(VARCHAR(10), @ToDate, 126)+''' '
	IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE, HT1114.FromDate, 120), 126)  BETWEEN '''+CONVERT(VARCHAR(10), @FromDate, 126)+''' AND '''+CONVERT(VARCHAR(10), @ToDate, 126)+''' 
	AND CONVERT(VARCHAR(10), CONVERT(DATE, HT1114.ToDate, 120), 126)  BETWEEN '''+CONVERT(VARCHAR(10), @FromDate, 126) +''' AND '''+CONVERT(VARCHAR(10), @ToDate, 126) +''' '	

	IF (@FromDepartment IS NOT NULL AND @ToDepartment IS NULL) SET @sWhere = @sWhere + '
	AND HT1400.DepartmentID <= '''+@ToDepartment+''' '
	IF (@FromDepartment IS NULL AND @ToDepartment IS NOT NULL) SET @sWhere = @sWhere + '
	AND HT1400.DepartmentID <= '''+@ToDepartment+''' '
	IF (@FromDepartment IS NOT NULL AND @ToDepartment IS NOT NULL) SET @sWhere = @sWhere + '
	AND HT1400.DepartmentID  BETWEEN '''+@FromDepartment+''' AND '''+@ToDepartment+''' '

	IF ISNULL(@TeamID,'') <> '' SET @sWhere = @sWhere + '
	AND ISNULL(HT1400.TeamID,'''') LIKE ''%'+@TeamID+'%'' '

	
	
	SET @sSQL= N'SELECT HT1114.APK, HT1114.DivisionID, HT1114.EmployeeID, (CASE 
				WHEN ISNULL(MiddleName,'''') = '''' THEN LTRIM(RTRIM(ISNULL(HT1400.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT1400.FirstName,''''))) 
				WHEN ISNULL(MiddleName,'''') <> '''' THEN LTRIM(RTRIM(ISNULL(HT1400.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT1400.MiddleName,''''))) + '' '' +  LTRIM(RTRIM(ISNULL(HT1400.FirstName,''''))) 
				END) AS EmployeeName,
				HT1114.MachineID, HT1109.MachineName, HT1114.FromDate, HT1114.ToDate, HT1114.Notes, HT1114.CreateUserID, HT1114.CreateDate, HT1114.LastModifyUserID, HT1114.LastModifyDate
				FROM HT1114 WITH (NOLOCK)
				LEFT JOIN HT1400 WITH (NOLOCK) ON HT1114.DivisionID = HT1400.DivisionID AND HT1114.EmployeeID = HT1400.EmployeeID 
				LEFT JOIN HT1109 WITH (NOLOCK) ON HT1114.DivisionID = HT1109.DivisionID AND  HT1114.MachineID  = HT1109.MachineID AND HT1109.Disabled = 0
				WHERE '+@sWhere+'
				ORDER BY '+@OrderBy+''
END

IF @IsMode = 0
BEGIN
	
	SET @sWhere = @sWhere + ' AND HT1114.EmployeeID = '''+@EmployeeID+''' '

	SET @sSQL= N'SELECT HT1114.APK, HT1114.DivisionID, HT1114.EmployeeID, (CASE 
				WHEN ISNULL(MiddleName,'''') = '''' THEN LTRIM(RTRIM(ISNULL(HT1400.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT1400.FirstName,''''))) 
				WHEN ISNULL(MiddleName,'''') <> '''' THEN LTRIM(RTRIM(ISNULL(HT1400.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT1400.MiddleName,''''))) + '' '' +  LTRIM(RTRIM(ISNULL(HT1400.FirstName,''''))) 
				END) AS EmployeeName ,
				HT1114.MachineID, HT1109.MachineName, HT1114.FromDate, HT1114.ToDate, HT1114.Notes, HT1114.CreateUserID, HT1114.CreateDate, HT1114.LastModifyUserID, HT1114.LastModifyDate
				FROM HT1114 WITH (NOLOCK)
				LEFT JOIN HT1400 WITH (NOLOCK) ON HT1114.DivisionID = HT1400.DivisionID AND HT1114.EmployeeID = HT1400.EmployeeID 
				LEFT JOIN HT1109 WITH (NOLOCK) ON HT1114.DivisionID = HT1109.DivisionID AND  HT1114.MachineID  = HT1109.MachineID AND HT1109.Disabled = 0
				WHERE '+@sWhere+' 
				ORDER BY '+@OrderBy+''
END

EXEC (@sSQL)
--PRINT (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
