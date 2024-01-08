IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP3002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP3002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo kế hoạch tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi, Date: 18/09/2017
-- <Example>
---- 
/*-- <Example>
	EXEC [HRMP3002] @DivisionID ='CH', @DivisionList = '', 
	@DepartmentList ='PSX', @FromDate = '2017-01-01', @ToDate = '2017-12-01', @FromRecruitPeriodPlan = 'Plan1', 
	@ToRecruitPeriodPlan = 'Plan4', @DutyList =''
----*/


CREATE PROCEDURE HRMP3002
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @DepartmentList VARCHAR(MAX),
	 @DutyList VARCHAR(MAX),
	 @FromRecruitPeriodPlan VARCHAR(50),
	 @ToRecruitPeriodPlan VARCHAR(50),
	 @FromDate DATETIME,
	 @ToDate DATETIME
)

AS

DECLARE 
	@sSQL NVARCHAR (MAX)=N'',
    @sWhere NVARCHAR(MAX)=N'',
    @OrderBy NVARCHAR(500)=N'',
    @TotalRow NVARCHAR(50)=N''

SET @OrderBy = 'HRMT2000.RecruitPlanID'

IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + ' HRMT2000.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' HRMT2000.DivisionID = '''+@DivisionID+''' '


BEGIN
IF ISNULL(@DepartmentList,'') <> '' SET @sWhere = @sWhere + 'AND HRMT2000.DepartmentID IN ('''+@DepartmentList+''')'
IF ISNULL(@DutyList,'') <> '' SET @sWhere = @sWhere + 'AND HRMT2001.DutyID IN ('''+@DutyList+''') '
IF (@FromRecruitPeriodPlan IS NOT NULL AND @ToRecruitPeriodPlan IS NULL) SET @sWhere = @sWhere + '
AND HRMT2000.RecruitPlanID  >= '''+@FromRecruitPeriodPlan+''' '
IF (@FromRecruitPeriodPlan IS NULL AND @ToRecruitPeriodPlan IS NOT NULL) SET @sWhere = @sWhere + '
AND HRMT2000.RecruitPlanID <= '''+@ToRecruitPeriodPlan+''' '
IF (@FromRecruitPeriodPlan IS NOT NULL AND @ToRecruitPeriodPlan IS NOT NULL) SET @sWhere = @sWhere + '
AND HRMT2000.RecruitPlanID BETWEEN '''+@FromRecruitPeriodPlan+''' AND '''+@ToRecruitPeriodPlan+''' '	
IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2000.FromDate,120), 126) >= '''+CONVERT(VARCHAR(10),@FromDate,126)+''' '
IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2000.ToDate,120), 126) <= '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '
IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2000.FromDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+''' 
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2000.ToDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '	
END

SET @sSQL = N'
SELECT DISTINCT HRMT2000.APK, HRMT2000.DivisionID, HRMT2000.RecruitPlanID, HRMT2000.Description, HRMT2000.DepartmentID, AT1102.DepartmentName,
HRMT2001.DutyID, HT1102.DutyName, HRMT2001.Quantity, HRMT1021.QuantityBoundary, HRMT1020.CostBoundary, HRMT2001.RecruitCost, Temp.Count_Employee
FROM HRMT2000 WITH (NOLOCK) 
LEFT JOIN HRMT2001 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT2001.DivisionID AND HRMT2000.RecruitPlanID = HRMT2001.RecruitPlanID
LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT2000.DepartmentID = AT1102.DepartmentID AND AT1102.DepartmentID IN ('''+@DivisionID+''', ''@@@'')
LEFT JOIN HRMT1020 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT1020.DivisionID AND HRMT2000.DepartmentID = HRMT1020.DepartmentID
LEFT JOIN HRMT1021 WITH (NOLOCK) ON HRMT1020.DivisionID = HRMT1021.DivisionID AND HRMT1020.BoundaryID = HRMT1021.BoundaryID
LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT2001.DivisionID = HT1102.DivisionID AND HRMT2001.DutyID = HT1102.DutyID 
LEFT JOIN 
(SELECT COUNT(EmployeeID) AS Count_Employee, HRMT2001.DutyID, HT1403.DepartmentID, HT1403.DivisionID 
FROM HT1403 
RIGHT JOIN HRMT2001 ON HRMT2001.DivisionID = HT1403.DivisionID AND HRMT2001.DutyID = HT1403.DutyID
LEFT JOIN HRMT2000 ON HRMT2000.RecruitPlanID = HRMT2001.RecruitPlanID
GROUP BY HRMT2001.DutyID, HT1403.DepartmentID, HT1403.DivisionID) AS Temp
ON HRMT2001.DutyID = Temp.DutyID AND HRMT2000.DivisionID = Temp.DivisionID 
WHERE '+@sWhere+'
ORDER BY '+@OrderBy+'
'


EXEC (@sSQL)
PRINT (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
