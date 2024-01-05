IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP3008]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP3008]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo thống kê nguồn tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi, Date: 03/10/2017
-- <Example>
---- 
/*-- <Example>
	EXEC [HRMP3008] @DivisionID = 'CH', @DivisionList = '',
	@FromRecruitPeriod = 'Period1', @ToRecruitPeriod = 'Period2', @ResourceList = NULL, @FromDate='2017-01-01', @ToDate='2017-12-01'
	
----*/
CREATE PROCEDURE HRMP3008
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList NVARCHAR(MAX),
	 @FromRecruitPeriod VARCHAR(50),
	 @ToRecruitPeriod VARCHAR(50),
	 @ResourceList NVARCHAR(MAX),
	 @FromDate DATETIME,
	 @ToDate DATETIME
)
AS 


DECLARE @sSQL1 NVARCHAR (MAX)=N'',
		@sSQL2 NVARCHAR (MAX)=N'',
		@Orderby NVARCHAR(MAX) = N'',
		@sWhere NVARCHAR(MAX) = N''

SET @Orderby = 'HRMT1031.RecPeriodID'
IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + ' HRMT1031.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' HRMT1031.DivisionID = '''+@DivisionID+''' '

BEGIN



IF ISNULL(@ResourceList,'') <> '' SET @sWhere = @sWhere + 'AND HRMT1031.ResourceID IN ('''+@ResourceList+''')'
IF (@FromRecruitPeriod IS NOT NULL AND @ToRecruitPeriod IS NULL) SET @sWhere = @sWhere + '
AND HRMT1031.RecPeriodID  >= '''+@FromRecruitPeriod+''' '
IF (@FromRecruitPeriod IS NULL AND @ToRecruitPeriod IS NOT NULL) SET @sWhere = @sWhere + '
AND HRMT1031.RecPeriodID <= '''+@ToRecruitPeriod+''' '
IF (@FromRecruitPeriod IS NOT NULL AND @ToRecruitPeriod IS NOT NULL) SET @sWhere = @sWhere + '
AND HRMT1031.RecPeriodID BETWEEN '''+@FromRecruitPeriod+''' AND '''+@ToRecruitPeriod+''' '	
IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2020.PeriodFromDate,120), 126) >= '''+CONVERT(VARCHAR(10),@FromDate,126)+''' '
IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2020.PeriodToDate,120), 126) <= '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '
IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2020.PeriodFromDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+''' 
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2020.PeriodToDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '	
END


SET @sSQL1 = @sSQL1 + '
SELECT * 
INTO #Temp_Gender
FROM
(
	SELECT COUNT(DescriptionE) AS Count_Gender, DescriptionE, HRMT1031.ResourceID
	FROM HT0099
	LEFT JOIN HRMT1030 WITH (NOLOCK) ON HRMT1030.RecruitStatus = HT0099.ID AND HT0099.CodeMaster = ''Gender''
	LEFT JOIN HRMT1031 WITH (NOLOCK) ON HRMT1030.DivisionID = HRMT1031.DivisionID AND HRMT1030.CandidateID = HRMT1031.CandidateID
	WHERE HRMT1030.DivisionID = '''+@DivisionID+'''
	GROUP BY DescriptionE, HRMT1031.ResourceID
) AS Temp_Count_Gender
PIVOT 
(
	SUM(Count_Gender) FOR DescriptionE IN ([Male], [Female])
) AS PIVOTTABLE
'





SET @sSQL2 = '
SELECT DISTINCT HRMT1031.RecPeriodID, HRMT2020.RecruitPeriodName, HRMT1031.ResourceID, HRMT1000.ResourceName, #Temp_Gender.*, Temp_Count_Candidate.Count_Candidate
FROM HRMT1031 WITH (NOLOCK)
LEFT JOIN HRMT1000 WITH (NOLOCK) ON HRMT1031.DivisionID = HRMT1000.DivisionID AND HRMT1031.ResourceID = HRMT1000.ResourceID
LEFT JOIN HRMT2020 WITH (NOLOCK) ON HRMT1031.DivisionID = HRMT2020.DivisionID AND HRMT2020.RecruitPeriodID = HRMT1031.RecPeriodID 
LEFT JOIN #Temp_Gender ON HRMT1031.ResourceID = #Temp_Gender.ResourceID
LEFT JOIN 
(
	SELECT COUNT(CandidateID) AS Count_Candidate, DivisionID, ResourceID 
	FROM HRMT1031 
	--WHERE CandidateID = HRMT1031.CandidateID AND DivisionID='''+@DivisionID+'''
	GROUP BY DivisionID, ResourceID 
) AS Temp_Count_Candidate ON HRMT1031.DivisionID = Temp_Count_Candidate.DivisionID AND HRMT1031.ResourceID = Temp_Count_Candidate.ResourceID
WHERE '+@sWhere+'
ORDER BY '+@OrderBy+'
'



--PRINT @sSQL1
--PRINT @sSQL2

EXEC (@sSQL1+@sSQL2)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
