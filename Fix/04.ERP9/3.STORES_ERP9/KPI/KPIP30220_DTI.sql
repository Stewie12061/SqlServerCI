IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP30220_DTI]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP30220_DTI]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- [KPI] bảng đánh giá KPI customize cho khách hàng Đức Tín - DTI
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
-- Created on 01/06/2021 by Văn Tài
CREATE PROCEDURE [dbo].[KPIP30220_DTI]
(
	@DivisionID VARCHAR(50),
	@DepartmentID VARCHAR(MAX),
	@EmployeeID VARCHAR(MAX) = NULL,
	@TranMonth INT = NULL,
	@TranYear INT = NULL,
	@Period VARCHAR(10) = NULL,
	@ConditionTaskID VARCHAR(MAX) = NULL
)
AS
BEGIN
		-- Tạo biến lưu giá trị tổng
		DECLARE @CustomerIndex INT = -1,
				@sSQL VARCHAR(MAX) = '',
				@sWhere VARCHAR(MAX) = '',
				@sOrderBy VARCHAR(MAX) = ''
		
		-- Lấy Customize Index của khách hàng
		SET @CustomerIndex = (SELECT TOP 1 CustomerName FROM CustomerIndex WITH (NOLOCK))
		
		SELECT VALUE INTO #KPIF90032Department FROM dbo.StringSplit(@DepartmentID, ''',''')
		SELECT VALUE INTO #KPIF90032Employee FROM dbo.StringSplit(@EmployeeID, ',')


		IF (ISNULL(@TranMonth, '') = '' OR ISNULL(@TranYear, '') = '')
		BEGIN
			SET @TranMonth = CAST(SUBSTRING(@Period, 1, 2) AS INT)
			SET @TranYear = CAST(SUBSTRING(@Period, 4, 4) AS INT)
		END

		SET @sOrderBy = ' ORDER BY A2.DepartmentID, A1.EmployeeID'

		IF(EXISTS(SELECT TOP (1) 1 FROM #KPIF90032Department))
		BEGIN
			SET @sWhere = @sWhere + '
							AND A2.DepartmentID IN (SELECT VALUE From #KPIF90032Department) 
							'
		END

		IF(EXISTS(SELECT TOP (1) 1 FROM #KPIF90032Employee))
		BEGIN
			SET @sWhere = @sWhere + '
							AND A1.EmployeeID IN (SELECT VALUE From #KPIF90032Employee) 
							'
		END

		IF ISNULL(@ConditionTaskID, '') <> ''
		BEGIN
			SET @sWhere = @sWhere + ' AND A1.EmployeeID IN (''' + @ConditionTaskID + ''')'
		END

		SET @sSQL = ' SELECT A2.DepartmentID 
			, A2.DepartmentName
			, A1.EmployeeID AS EmployeeID
			, A1.FullName AS EmployeeName
			, K2.CompletionRate			
		FROM AT1103 A1 WITH (NOLOCK)
			LEFT JOIN AT1102 A2 WITH (NOLOCK) ON A2.DivisionID IN (N''@@@'', ''' + @DivisionID + ''') AND A2.DepartmentID = A1.DepartmentID
			LEFT JOIN KPIT2040 K2 WITH (NOLOCK) ON K2.TranYear =  '+ STR(@TranYear) + ' AND K2.TranMonth = ' + STR(@TranMonth) + ' AND K2.EmployeeID = A1.EmployeeID
		WHERE ISNULL(A1.Disabled, 0) = 0 
		'
				
	  PRINT (@sSQL)
	  PRINT (@sWhere)
	  PRINT (@sOrderBy)
	  EXEC (@sSQL + @sWhere + @sOrderBy)

	--DEBUG  
	--SELECT * FROM #KPIF90032Department
	--SELECT * FROM #KPIF90032Employee
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
