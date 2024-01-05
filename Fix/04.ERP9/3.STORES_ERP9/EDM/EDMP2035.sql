IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2035]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2035]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load chọn giáo viên/ bảo mẫu/người đề nghị 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo on 10/07/2019
----Modified by: Văn Tài	on 12/05/2022 - Bổ sung load chức vụ.
----Modified by: Văn Tài	on 30/11/2022 - Bổ sung lấy dữ liệu EContract.
-- <Example>
---- 
--	 
---  EXEC EDMP2035 @DivisionID = 'BE', @UserID='ASOFTADMIN',@PageNumber = '1',@PageSize  = '25',@ExcludeList = '',@txtSearch = '',@Mode = '2'

CREATE PROCEDURE [dbo].[EDMP2035]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @ExcludeList VARCHAR(MAX), 
	 @txtSearch NVARCHAR(100),
	 @Mode VARCHAR(50),
	 @listDepartmentID VARCHAR(MAX) = NULL, 
	 @listGroupID VARCHAR(MAX) = NULL 
	
)
AS 

DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@sJOIN NVARCHAR (MAX)
 

	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'AT1103.EmployeeID, AT1103.FullName'
	SET @sJOIN =''

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = '0'

	IF ISNULL(@ExcludeList, '') <> ''
	BEGIN 
		SET @sWhere = 'AND AT1103.EmployeeID NOT IN ('''+@ExcludeList+ ''')'
	END

	IF ISNULL(@listDepartmentID, '') <> ''
	BEGIN 
		SET @sWhere = 'AND AT1102.DepartmentID  IN ('''+@listDepartmentID+ ''')'
	END

	IF ISNULL(@listGroupID, '') <> ''
	BEGIN 
		SET @sWhere = 'AND AT1103.EmployeeID IN ( SELECT UserMarkedID FROM CIT1210 WHERE CIT1210.GroupID IN ('''+@listGroupID+'''))
					   AND AT1103.EmployeeID IN (SELECT UserMarkedID FROM CIT1210 WHERE CIT1210.UserMarkedID = AT1103.EmployeeID 
					   AND CIT1210.DivisionID IN ('''+@DivisionID+''',''@@@''))'
													  
	END
	
	IF ISNULL(@txtSearch,'') != '' SET @sWhere = @sWhere +'
									AND (AT1103.EmployeeID LIKE N''%'+@TxtSearch+'%'' 
									OR AT1103.FullName LIKE N''%'+@TxtSearch+'%'' 
									OR AT1103.Address LIKE N''%'+@TxtSearch+'%'' 
									OR AT1103.DepartmentID LIKE N''%'+ @TxtSearch+'%'' 
									OR AT1102.DepartmentName LIKE N''%'+ @TxtSearch+'%'' 
									OR AT1103.Tel LIKE N''%'+@TxtSearch + '%'' 
									OR AT1103.Email LIKE N''%'+@TxtSearch+'%'')'



---Xoá điều kiện AT1103.EmployeeTypeID = 'GV'
---Update : Đình Hoà [19/06/2020]
---Update : Hoài Bảo [12/01/2022] - Bổ sung điều kiện không load user hệ thống
IF @Mode = 0  ------Load giáo viên 
BEGIN 

	SET @sSQL = '
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
							, AT1103.DivisionID
							, AT1103.EmployeeID
							, AT1103.FullName AS EmployeeName
							, AT1103.DepartmentID
							, AT1102.DepartmentName
							, AT1103.Address
							, AT1103.Tel
							, AT1103.Email
							, HT02.DutyID
							, HT02.DutyName
							, AT1103.IsCommon
							, AT1103.Disabled
							, AT1103.EContractAccount
				FROM AT1103 WITH (NOLOCK) 
				LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DivisionID IN (AT1103.DivisionID,''@@@'')
													AND AT1103.DepartmentID = AT1102.DepartmentID AND AT1102.Disabled = 0
				LEFT JOIN HT1102 HT02 WITH (NOLOCK) ON HT02.DivisionID IN ('''+@DivisionID+''', ''@@@'')
													AND HT02.DutyID = AT1103.DutyID 												
				WHERE AT1103.Disabled = 0 AND AT1103.DivisionID IN ('''+@DivisionID+''',''@@@'') 
				AND AT1103.EmployeeID NOT IN (''ASOFTADMIN'',''UNASSIGNED'')
				'+@sWhere+'
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

END 

---Xoá điều kiện AT1103.EmployeeTypeID = 'BM'
---Update : Đình Hoà [19/06/2020]
IF @Mode = 1  ------Load bảo mẫu 
BEGIN 
	SET @sSQL = '
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
							, AT1103.DivisionID
							, AT1103.EmployeeID
							, AT1103.FullName as EmployeeName
							, AT1103.DepartmentID
							, AT1102.DepartmentName
							, AT1103.Address
							, AT1103.Tel
							, AT1103.Email
							, HT02.DutyID
							, HT02.DutyName
							, AT1103.IsCommon
							, AT1103.Disabled
							, AT1103.EContractAccount
				FROM AT1103 WITH (NOLOCK) 
				LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DivisionID IN (AT1103.DivisionID,''@@@'')
													AND AT1103.DepartmentID = AT1102.DepartmentID and AT1102.Disabled = 0
				LEFT JOIN HT1102 HT02 WITH (NOLOCK) ON HT02.DivisionID IN ('''+@DivisionID+''', ''@@@'')
													AND HT02.DutyID = AT1103.DutyID 				
				WHERE AT1103.Disabled = 0 AND AT1103.DivisionID IN ('''+@DivisionID+''',''@@@'') 
				AND AT1103.EmployeeID != ''ASOFTADMIN'' 
				'+@sWhere+'
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

END 


IF @Mode = 2  ------Load người đề nghị 
BEGIN 
	SET @sSQL = '
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
							, AT1103.DivisionID
							, AT1103.EmployeeID
							, AT1103.FullName as EmployeeName
							, AT1103.DepartmentID
							, AT1102.DepartmentName
							, AT1103.Address
							, AT1103.Tel
							, AT1103.Email
							, HT02.DutyID
							, HT02.DutyName
							, AT1103.IsCommon
							, AT1103.Disabled
							, AT1103.EContractAccount
				FROM AT1103 WITH (NOLOCK) 
				LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DivisionID IN (AT1103.DivisionID,''@@@'')
							AND AT1103.DepartmentID = AT1102.DepartmentID AND AT1102.Disabled = 0
				LEFT JOIN HT1102 HT02 WITH (NOLOCK) ON HT02.DivisionID IN ('''+@DivisionID+''', ''@@@'')
													AND HT02.DutyID = AT1103.DutyID 				
				WHERE AT1103.Disabled = 0 AND AT1103.DivisionID IN ('''+@DivisionID+''',''@@@'') 
				AND AT1103.EmployeeID != ''ASOFTADMIN'' 
				'+@sWhere+'
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

END 



---Update : Minh Hiếu [05/01/2022]
IF @Mode = 4  ------Load người đề nghị VNA, HN
BEGIN 
	SET @sSQL = '
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
							, AT1103.DivisionID
							, AT1103.EmployeeID
							, AT1103.FullName as EmployeeName
							, AT1103.DepartmentID
							, AT1102.DepartmentName
							, AT1103.Address
							, AT1103.Tel
							, AT1103.Email
							, HT02.DutyID
							, HT02.DutyName
							, AT1103.IsCommon
							, AT1103.Disabled
							, AT1103.EContractAccount
				FROM AT1103 WITH (NOLOCK) 
				LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DivisionID IN (AT1103.DivisionID,''@@@'')
													AND AT1103.DepartmentID = AT1102.DepartmentID AND AT1102.Disabled = 0
				LEFT JOIN HT1102 HT02 WITH (NOLOCK) ON HT02.DivisionID IN ('''+@DivisionID+''', ''@@@'')
													AND HT02.DutyID = AT1103.DutyID 		
				WHERE AT1103.Disabled = 0 AND AT1103.DivisionID IN (''@@@'',''VNA'',''HN'') 
				AND AT1103.EmployeeID != ''ASOFTADMIN'' 
				'+@sWhere+'
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

END



PRINT @sSQL
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
 