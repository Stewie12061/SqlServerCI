IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP3009]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP3009]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo thống kê quyết định tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi, Date: 04/10/2017
-- <Example>
---- 
/*-- <Example>
	EXEC [HRMP3009] @DivisionID = 'CH', @DivisionList = '', @FromRecruitPeriod = 'Period1', @ToRecruitPeriod = 'Period5',
	 @FromDate='2017-01-01', @ToDate='2017-12-01', @DepartmentList = NULL, @DutyList = NULL
	
----*/
CREATE PROCEDURE HRMP3009
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList NVARCHAR(MAX),
	 @FromRecruitPeriod VARCHAR(50),
	 @ToRecruitPeriod VARCHAR(50),
	 @DepartmentList NVARCHAR(MAX),
	 @DutyList NVARCHAR(MAX),
	 @FromDate DATETIME,
	 @ToDate DATETIME
)
AS 


DECLARE @sSQL1 NVARCHAR (MAX)=N'',
		@Orderby NVARCHAR(MAX) = N'',
		@sWhere NVARCHAR(MAX) = N''

SET @Orderby = 'HRMT2051.CandidateID'
IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + ' HRMT2050.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' HRMT2050.DivisionID = '''+@DivisionID+''' '


	
BEGIN
IF (@FromRecruitPeriod IS NOT NULL AND @ToRecruitPeriod IS NULL) SET @sWhere = @sWhere + '
AND HRMT2051.RecruitPeriodID  >= '''+@FromRecruitPeriod+''' '
IF (@FromRecruitPeriod IS NULL AND @ToRecruitPeriod IS NOT NULL) SET @sWhere = @sWhere + '
AND HRMT2051.RecruitPeriodID <= '''+@ToRecruitPeriod+''' '
IF (@FromRecruitPeriod IS NOT NULL AND @ToRecruitPeriod IS NOT NULL) SET @sWhere = @sWhere + '
AND HRMT2051.RecruitPeriodID BETWEEN '''+@FromRecruitPeriod+''' AND '''+@ToRecruitPeriod+''' '	

IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2050.DecisionDate,120), 126) >= '''+CONVERT(VARCHAR(10),@FromDate,126)+''' '
IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2050.DecisionDate,120), 126) <= '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '
IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2050.DecisionDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+''' 	'

IF ISNULL(@DepartmentList,'') <> '' SET @sWhere = @sWhere + 'AND HRMT2020.DepartmentID IN ('''+@DepartmentList+''')'

IF ISNULL(@DutyList,'') <> '' SET @sWhere = @sWhere + 'AND HRMT2020.DutyID IN ('''+@DutyList+''')'
END



SET @sSQL1 = '
SELECT DISTINCT HRMT2050.DivisionID, HRMT2050.RecDecisionNo, HRMT2050.DecisionDate, HRMT2051.Status, HRMT2051.CandidateID, 
(CASE 
WHEN ISNULL(HRMT1030.MiddleName,'''') = '''' THEN LTRIM(RTRIM(ISNULL(HRMT1030.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,''''))) 
WHEN ISNULL(HRMT1030.MiddleName,'''') <> '''' THEN LTRIM(RTRIM(ISNULL(HRMT1030.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName,''''))) + '' '' +  LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,''''))) 
END) AS CandidateName, HRMT1030.Birthday, HRMT2051.RecruitPeriodID, HRMT2020.RecruitPeriodName, HRMT2020.DepartmentID, AT1102.DepartmentName, 
HRMT2020.DutyID, HT1102.DutyName, HT0099.Description AS Status
FROM HRMT2050 WITH (NOLOCK)
LEFT JOIN HRMT2051 WITH (NOLOCK) ON HRMT2050.DivisionID = HRMT2051.DivisionID AND HRMT2050.RecDecisionID = HRMT2051.RecDecisionID
LEFT JOIN HRMT1030 WITH (NOLOCK) ON HRMT2051.DivisionID = HRMT1030.DivisionID AND HRMT2051.CandidateID = HRMT1030.CandidateID
LEFT JOIN HRMT2020 WITH (NOLOCK) ON HRMT2051.DivisionID = HRMT2020.DivisionID AND HRMT2051.RecruitPeriodID = HRMT2020.RecruitPeriodID
LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT2020.DepartmentID = AT1102.DepartmentID AND AT1102.DivisionID IN ('''+@DivisionID+''', ''@@@'')
LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT2020.DivisionID = HT1102.DivisionID AND HRMT2020.DutyID = HT1102.DutyID
LEFT JOIN HT0099 WITH (NOLOCK) ON HRMT2051.Status = HT0099.ID AND HT0099.CodeMaster = ''Status''
WHERE '+@sWhere+'
ORDER BY '+@OrderBy+'
'



--PRINT @sSQL1


EXEC (@sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
