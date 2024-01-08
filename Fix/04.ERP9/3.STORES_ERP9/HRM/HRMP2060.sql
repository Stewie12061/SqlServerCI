IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2060]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2060]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form HRF2060: Nghiệp vụ lập ngân sách đào tạo
-- <Param>
-- <Return>
-- <Reference>
-- <History>
----Created by: Hải Long, Date: 07/09/2017
----Modified on 04/10/2019 by Bảo Toàn: Cập nhật phân quyền
----Update  by: Thu Hà,  Date: 06/07/2023 - Bổ sung lọc theo kỳ, format định dạng tiền tuệ.
----Update  by: Thu Hà,  Date: 06/09/2023 - Cập nhật sắp xếp giảm dần theo mã ngân sách
----Update  by: Minh Trí, Date: 17/10/2023 -[2023/10/IS/0012] Cập nhật bổ sung điều kiện lọc ( DeleteFlg = 0 )
-- <Example>
/*-- <Example>
	HRMP2060 @DivisionID='AS',@DivisionList='',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=0,@DepartmentID=NULL,@EmployeeID=null
----*/

CREATE PROCEDURE [dbo].[HRMP2060]
( 
	 @DivisionID NVARCHAR(50),
	 @BudgetID NVARCHAR(MAX),
	 @AssignedToUserName NVARCHAR(MAX),
	 @DivisionList NVARCHAR(MAX),
	 @UserID NVARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT,
	 @IsPeriod TINYINT,
	 @IsBugetYear TINYINT,
	 @TranQuarterYear NVARCHAR(MAX),
	 @DepartmentID NVARCHAR(50),
	 @EmployeeID NVARCHAR(50),
	 @ConditionBudgetID VARCHAR(MAX),
	 @FromDate DATETIME ,
	 @ToDate DATETIME ,
	 @PeriodList NVARCHAR(MAX) = ''
)
AS 
DECLARE @sSQL1 NVARCHAR (MAX) = N'',
		@sSQL2 NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'BudgetID DESC ,CreateDate',
        @TotalRow NVARCHAR(500) = N'',
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)

SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

-- Lấy chi phí đào tạo thực tế        
SET @sSQL1 = '        
SELECT HRMT2130.DivisionID, HRMT2100.IsAll, NULL AS DepartmentID, HRMT2130.CostAmount, 
DATEPART(QUARTER, HRMT2130.FromDate) AS TranQuarter, DATEPART(YEAR, HRMT2130.FromDate) AS TranYear
INTO #TEMP
FROM HRMT2131 WITH (NOLOCK)
INNER JOIN HRMT2130 WITH (NOLOCK) ON HRMT2130.DivisionID = HRMT2131.DivisionID AND HRMT2130.TrainingCostID = HRMT2131.TrainingCostID
LEFT JOIN HRMT2100 ON HRMT2100.DivisionID = HRMT2130.DivisionID AND HRMT2100.TrainingScheduleID = HRMT2130.TrainingScheduleID
WHERE HRMT2100.IsAll = 1
GROUP BY HRMT2130.DivisionID, HRMT2100.IsAll, HRMT2130.CostAmount, DATEPART(QUARTER, HRMT2130.FromDate), DATEPART(YEAR, HRMT2130.FromDate) 

UNION ALL

SELECT HRMT2130.DivisionID, 0 AS IsAll, HRMT2131.DepartmentID, SUM(HRMT2131.CostAmount) AS CostAmount,
DATEPART(QUARTER, HRMT2130.FromDate) AS TranQuarter, DATEPART(YEAR, HRMT2130.FromDate) AS TranYear
FROM HRMT2130 WITH (NOLOCK)
INNER JOIN 
(
	SELECT DivisionID, DepartmentID, TrainingCostID, SUM(CostAmount) AS CostAmount
	FROM HRMT2131 WITH (NOLOCK)
	GROUP BY DivisionID, DepartmentID, TrainingCostID
) HRMT2131 ON HRMT2130.DivisionID = HRMT2131.DivisionID AND HRMT2130.TrainingCostID = HRMT2131.TrainingCostID
LEFT JOIN HRMT2100 ON HRMT2100.DivisionID = HRMT2130.DivisionID AND HRMT2100.TrainingScheduleID = HRMT2130.TrainingScheduleID
WHERE HRMT2100.IsAll = 0
GROUP BY HRMT2130.DivisionID, HRMT2131.DepartmentID, DATEPART(QUARTER, HRMT2130.FromDate), DATEPART(YEAR, HRMT2130.FromDate)'        
            
IF @PageNumber = 1 SET @TotalRow = N'COUNT(*) OVER ()' ELSE SET @TotalRow = N'NULL' 	
       
    
IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + 'AND
	HRMT2060.DivisionID IN ('''+@DivisionList+''',''@@@'')'
ELSE 
	SET @sWhere =@sWhere + 'AND
	HRMT2060.DivisionID IN ('''+@DivisionID+''', ''@@@'')'
IF @IsSearch = 1
BEGIN
	IF @IsPeriod = 0
	BEGIN
		
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		SET @sWhere = @sWhere + ' AND (HRMT2060.CreateDate >= ''' + @FromDateText + '''
												OR HRMT2060.CreateDate >= ''' + @FromDateText + ''')'
		
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		SET @sWhere = @sWhere + ' AND (HRMT2060.CreateDate <= ''' + @ToDateText + ''' 
											OR HRMT2060.CreateDate <= ''' + @ToDateText + ''')'

	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		SET @sWhere = @sWhere + ' AND (HRMT2060.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '

	END
	IF  @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(HRMT2060.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '

	IF ISNULL(@DepartmentID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + N'
		AND HRMT2060.DepartmentID = ''' + @DepartmentID + ''''	
	END
	
	IF ISNULL(@EmployeeID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + N'
		AND HRMT2060.CreateUserID = ''' + @EmployeeID + ''''	
	END	

	IF ISNULL(@BudgetID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + N'
		AND HRMT2060.BudgetID like N''%' + @BudgetID + '%'''	
	END

	IF ISNULL(@AssignedToUserName,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + N'
		AND AT1103.FullName like N''%' + @AssignedToUserName + '%'''	
	END

	IF @IsBugetYear is not null
	BEGIN
		SET @sWhere = @sWhere + N' AND HRMT2060.IsBugetYear = ' + CONVERT(nvarchar,@IsBugetYear)	
		IF ISNULL(@TranQuarterYear,'') <> ''
		BEGIN
			IF @IsBugetYear = 1 
			SET @sWhere = @sWhere + N' AND ''Năm '' + CONVERT(NVARCHAR(5), HRMT2060.TranYear)  = ''' + @TranQuarterYear + ''''	
			ELSE
			SET @sWhere = @sWhere +  N' AND ''Quý '' + CONVERT(NVARCHAR(5), HRMT2060.TranQuarter) + ''/Năm '' + CONVERT(NVARCHAR(5), HRMT2060.TranYear) = ''' + @TranQuarterYear + ''''
		END
	END

	IF Isnull(@ConditionBudgetID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(HRMT2060.CreateUserID,'''') in (N'''+@ConditionBudgetID+''' )'
END
SET @sSQL2 = N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ')) AS RowNum, ' + @TotalRow + N' AS TotalRow, *
FROM
(
	SELECT HRMT2060.APK, HRMT2060.DivisionID, BudgetID, HRMT2060.IsAll, 
	HRMT2060.DepartmentID,
	CASE WHEN HRMT2060.DepartmentID != ''%'' THEN AT1102.DepartmentName ELSE N''Tất cả'' END AS N''DepartmentName'',
	IsBugetYear,
	AT1103.FullName AS AssignedToUserName,
	HRMT2060.Description,
	CASE WHEN IsBugetYear = 1 THEN N''Năm '' + CONVERT(NVARCHAR(5), HRMT2060.TranYear) ELSE N''Quý '' + CONVERT(NVARCHAR(5), HRMT2060.TranQuarter) + ''/'' + CONVERT(NVARCHAR(5), HRMT2060.TranYear) END AS TranQuarterYear,
	HRMT2060.TranQuarter, HRMT2060.TranYear, 
	FORMAT(HRMT2060.BudgetAmount, ''N3'') AS BudgetAmount, 
	FORMAT((BudgetAmount - ISNULL(#TEMP.CostAmount, 0)), ''N3'')  AS RemainBudgetAmount, 
	HRMT2060.CreateUserID+'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2060.CreateUserID) CreateUserID , 
	HRMT2060.CreateDate, HRMT2060.LastModifyUserID, HRMT2060.LastModifyDate
	FROM HRMT2060 WITH (NOLOCK)
	LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = HRMT2060.DepartmentID
	LEFT JOIN AT1103 WITH (NOLOCK) ON HRMT2060.AssignedToUserID = AT1103.EmployeeID
	LEFT JOIN #TEMP ON #TEMP.DivisionID = HRMT2060.DivisionID AND #TEMP.IsAll = HRMT2060.IsAll AND ISNULL(#TEMP.DepartmentID, '''') = ISNULL(HRMT2060.DepartmentID, '''')
	AND 1 = (CASE WHEN IsBugetYear = 1 AND HRMT2060.TranYear = #TEMP.TranYear THEN 1
				  WHEN IsBugetYear = 0 AND HRMT2060.TranYear = #TEMP.TranYear AND HRMT2060.TranQuarter = #TEMP.TranQuarter THEN 1 ELSE 0 END)
	WHERE ISNULL(HRMT2060.DeleteFlg,0) = 0  '+@sWhere +'
) A
ORDER BY ' + @OrderBy + ' 
OFFSET ' + CONVERT(NVARCHAR(10), (@PageNumber - 1) * @PageSize) + ' ROWS
FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'

--PRINT(@sSQL1)	
--PRINT(@sSQL2)
PRINT (@sSQL1 + @sSQL2)
EXEC (@sSQL1 + @sSQL2)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
