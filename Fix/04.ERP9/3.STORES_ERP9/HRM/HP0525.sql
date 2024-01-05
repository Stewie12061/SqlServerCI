IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0525]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0525]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load grid số quyết định (HF0502)
-- <History>
---- Created by Bảo Thy on 27/07/2017
---- Modified by on
-- <Example>
/* 
 EXEC HP0525 @DivisionID = 'CH', @UserID = 'ASOFTADMIN', @RecDecisionNo = NULL, @RecruitPeriodID = NULL,@DepartmentID = '%',
 @DutyID = '%', @FromDate = '2017-01-01', @ToDate = '2017-10-31'
 */
 
CREATE PROCEDURE HP0525
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@RecDecisionNo AS VARCHAR(250),
	@RecruitPeriodID AS VARCHAR(250),
	@DepartmentID AS VARCHAR(50),
	@DutyID AS VARCHAR(50),
	@FromDate DATETIME,
	@ToDate DATETIME
) 
AS
DECLARE @sSQL NVARCHAR(MAX) = N'', 
		@sWhere NVARCHAR(MAX) = N'', 
		@GroupBy NVARCHAR(MAX) = N'', 
		@Having NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(MAX) = N''

SET @sWhere = @sWhere + N'  
HRMT2050.DivisionID = '''+@DivisionID+'''
--AND ISNULL(HRMT2050.[Status],0) = 1
AND HRMT1031.RecruitStatus = 5'

SET @GroupBy = @GroupBy + N' HRMT2050.APK, HRMT2050.DivisionID, HRMT2050.RecDecisionID, HRMT2050.RecDecisionNo, HRMT2050.Description, HRMT2050.DecisionDate'
SET @Having = @Having + N' COUNT(HRMT1031.CandidateID) > COUNT(HT1400.CandidateID)'
SET @OrderBy = @OrderBy + N' HRMT2050.RecDecisionNo'

IF ISNULL(@RecDecisionNo, '') <> '' SET @sWhere = @sWhere + N'
AND HRMT2050.RecDecisionNo LIKE ''%'+@RecDecisionNo+'%'''
IF ISNULL(@RecruitPeriodID, '') <> '' SET @sWhere = @sWhere + N'
AND HRMT2051.RecruitPeriodID LIKE ''%'+@RecruitPeriodID+'%'''
IF ISNULL(@DepartmentID, '') <> '' AND @DepartmentID <> '%' SET @sWhere = @sWhere + N'
AND HRMT2020.DepartmentID = '''+@DepartmentID+''''
IF ISNULL(@DutyID, '') <> '' AND @DutyID <> '%' SET @sWhere = @sWhere + N'
AND HRMT2020.DutyID = '''+@DutyID+''''
IF ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '' SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE, HRMT2050.DecisionDate, 120), 126) >= '''+CONVERT(VARCHAR(10),@FromDate,126)+''' '
IF ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '' SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE, HRMT2050.DecisionDate, 120), 126) <= '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '
IF ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '' SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2050.DecisionDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '


SET @sSQL = N'
SELECT HRMT2050.APK, HRMT2050.DivisionID, HRMT2050.RecDecisionID, HRMT2050.RecDecisionNo, HRMT2050.Description, HRMT2050.DecisionDate
FROM HRMT2050 WITH (NOLOCK)
INNER JOIN HRMT2051 WITH (NOLOCK) ON HRMT2051.DivisionID = HRMT2050.DivisionID AND HRMT2051.RecDecisionID = HRMT2050.RecDecisionID
LEFT JOIN HRMT2020 WITH (NOLOCK) ON HRMT2051.DivisionID = HRMT2020.DivisionID AND HRMT2051.RecruitPeriodID = HRMT2020.RecruitPeriodID
LEFT JOIN HT1400 WITH (NOLOCK) ON HRMT2051.DivisionID = HT1400.DivisionID AND HRMT2051.RecDecisionID = HT1400.RecDecisionID 
INNER JOIN HRMT1031 WITH (NOLOCK) ON HRMT2051.DivisionID = HRMT1031.DivisionID AND HRMT2051.CandidateID = HRMT1031.CandidateID
WHERE '+@sWhere+'
GROUP BY '+@GroupBy+'
HAVING '+@Having+'
ORDER BY '+@OrderBy+'
'

--PRINT @sSQL
EXEC (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
