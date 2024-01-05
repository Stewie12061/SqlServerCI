IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP90031]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP90031]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load màn hình chọn nhân viên
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: VANTAI ON 01/06/2021
-- <Example>
/*
    EXEC KPIP90031 'AS', '','PHUONG',1,25
*/

 CREATE PROCEDURE KPIP90031 (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
	 @DepartmentID VARCHAR(MAX) = NULL,
	 @ConditionTaskID VARCHAR(MAX) = NULL,
	 @UserID2 VARCHAR(50) =''
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@CustomerIndex int 

	SET @CustomerIndex = (SELECT TOP 1 CustomerName FROM CustomerIndex WITH (NOLOCK))
	
	SELECT Value INTO #KPIF9003Department FROM dbo.StringSplit(@DepartmentID, ',') 

	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'AT1103.EmployeeID, AT1103.FullName'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = '0'

	IF(EXISTS(SELECT TOP 1 1 FROM #KPIF9003Department))
	BEGIN
		SET @sWhere = @sWhere + '
						AND AT1102.DepartmentID IN (SELECT * From #KPIF9003Department) '
	END
	
	IF @TxtSearch IS NOT NULL SET @sWhere = @sWhere + '									
									AND (AT1103.EmployeeID LIKE N''%' + @TxtSearch + '%'' 
									OR AT1103.FullName LIKE N''%' + @TxtSearch + '%'' 
									OR AT1103.Address LIKE N''%' + @TxtSearch + '%'' 
									OR AT1103.DepartmentID LIKE N''%' + @TxtSearch + '%'' 
									OR AT1102.DepartmentName LIKE N''%' + @TxtSearch + '%'' 
									OR AT1103.Tel LIKE N''%' + @TxtSearch + '%'' 
									OR AT1103.Email LIKE N''%' + @TxtSearch + '%'')'
	
	IF ISNULL(@ConditionTaskID, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND AT1103.EmployeeID IN (''' + @ConditionTaskID + ''')'
	END

	IF ISNULL(@UserID2, '') != ''
	BEGIN
		if(@CustomerIndex <> 114) -- DTI
			SET @sWhere = @sWhere + ' AND AT1103.EmployeeID NOT IN (''' + @UserID2 + ''')'
	END

	SET @sSQL = '
				SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, ' + @TotalRow + ' AS TotalRow
							, AT1103.DivisionID, AT1103.EmployeeID, AT1103.FullName AS EmployeeName
							, AT1103.DepartmentID, AT1102.DepartmentName, AT1103.Address
							, AT1103.Tel, AT1103.Email, AT1103.IsCommon, AT1103.Disabled
				FROM AT1103 WITH (NOLOCK)
					LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DivisionID IN (AT1103.DivisionID, ''@@@'')
							AND AT1103.DepartmentID = AT1102.DepartmentID AND AT1102.Disabled = 0
					LEFT JOIN AT1405 WITH (NOLOCK) ON AT1103.EmployeeID = AT1405.UserID AND AT1405.DivisionID IN (AT1103.DivisionID,''@@@'')
				WHERE ISNULL(AT1103.Disabled, 0) = 0 AND ISNULL(AT1405.IsLock, 0) = 0 AND (AT1103.DivisionID IN (''' + @DivisionID + ''') OR AT1103.IsCommon = 1) 
				AND AT1103.EmployeeID != ''ASOFTADMIN'' ' + @sWhere + '
				ORDER BY ' + @OrderBy + '
				OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
				FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
EXEC (@sSQL)
PRINT(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
