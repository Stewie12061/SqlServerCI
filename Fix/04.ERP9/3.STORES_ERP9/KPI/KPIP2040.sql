IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP2040]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP2040]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Load đổ dữ liệu vào màn hình KPIF2040
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Truong Lam 28/08/2019
---- Modified by Vĩnh Tâm 04/04/2020: Điều chỉnh điều kiện lọc và param truyền vào
---- Modified by Nhựt Trường 01/06/2021: Fix lỗi Order by.
---- <Example>
---- 

CREATE PROCEDURE [dbo].[KPIP2040]
(
	@ConditionCalculateEffectiveSalary NVARCHAR(max),
	@DivisionIDList VARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
	@PageNumber INT,
	@PageSize INT,
	@DivisionID VARCHAR(50),  --Biến môi trường
	@DepartmentIDList VARCHAR(2000),
	@EmployeeName NVARCHAR(50),
	@TranMonth VARCHAR(50),
	@TranYear VARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX)


-- Check Para DivisionIDList null then get DivisionID 
IF ISNULL(@DivisionIDList, '') != ''
	SET @sWhere = ' K1.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'')'
ELSE 
	SET @sWhere = ' K1.DivisionID IN (''' + @DivisionID + ''', ''@@@'')'

IF ISNULL(@DepartmentIDList, '') != ''
	SET @sWhere = @sWhere + ' AND K1.DepartmentID IN (''' + @DepartmentIDList + ''', ''@@@'')'

IF ISNULL(@EmployeeName, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(A1.FullName, '''') LIKE N''%' + @EmployeeName + '%'' OR ISNULL(K1.EmployeeID,'''') LIKE N''%' + @EmployeeName + '%'' )'

IF ISNULL(@TranMonth, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(K1.TranMonth,'''') IN (''' + @TranMonth + ''') '

IF ISNULL(@TranYear, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(K1.TranYear,'''') LIKE N''%' + @TranYear + '%'' '

IF ISNULL(@ConditionCalculateEffectiveSalary, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(K1.EmployeeID, K1.CreateUserID) IN (N''' + @ConditionCalculateEffectiveSalary + ''' )'

SET @sSQL = '
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY TranMonth DESC, TranYear, EmployeeID)) AS RowNum, COUNT(*) OVER () AS TotalRow, *
FROM
(
	SELECT K1.APK, K1.DivisionID, K1.DepartmentID, K1.EmployeeID, K1.TranMonth, K1.TranYear, K1.FixedSalary, K1.EffectiveSalary
		, K1.TargetSales, K1.CompletionRate, K1.StatusID, K1.ActualEffectiveSalary, K1.Disabled, K1.CreateUserID, K1.LastModifyUserID, K1.CreateDate
		, K1.LastModifyDate, A1.FullName AS EmployeeName, A2.DepartmentName, CONCAT(K1.TranMonth, ''/'', K1.TranYear) AS CheckListPeriodControl
	FROM KPIT2040 K1 WITH (NOLOCK)
		LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = K1.EmployeeID AND A1.DivisionID = K1.DivisionID
		LEFT JOIN AT1102 A2 WITH (NOLOCK) ON A2.DepartmentID = K1.DepartmentID
	WHERE ' + @sWhere + '
) A
ORDER BY TranMonth DESC, TranYear, EmployeeID
OFFSET ' + CONVERT(NVARCHAR(10), (@PageNumber - 1) * @PageSize) + ' ROWS
FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'

--PRINT @sSQL
EXEC (@sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
