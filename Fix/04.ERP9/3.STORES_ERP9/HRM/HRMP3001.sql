IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP3001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP3001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo danh sách ứng viên
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
	EXEC [HRMP3001] @DivisionID = 'CH', @DivisionList = '', @DepartmentList = 'PB1' , @FromRecruitPeriodID = 'Period1' , 
	@ToRecruitPeriodID = 'Period3', @DutyList = 'NV',  @FromDate = '2017-01-01', @ToDate = '2017-12-01'
----*/

CREATE PROCEDURE HRMP3001
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @DepartmentList VARCHAR(MAX), 
	 @FromRecruitPeriodID VARCHAR (50),
	 @ToRecruitPeriodID VARCHAR (50), 
	 @DutyList NVARCHAR(MAX),
	 @FromDate DATETIME,
	 @ToDate DATETIME
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
        @sWhere NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N''

SET @OrderBy = 'HRMT1030.CandidateID'

IF Isnull(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + ' HRMT1030.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' HRMT1030.DivisionID = '''+@DivisionID+''' '


BEGIN
	
	IF (@FromRecruitPeriodID IS NOT NULL AND @ToRecruitPeriodID IS NULL) SET @sWhere = @sWhere + '
	AND HRMT1031.RecPeriodID  >= '''+@FromRecruitPeriodID+''' '
	IF (@FromRecruitPeriodID IS NULL AND @ToRecruitPeriodID IS NOT NULL) SET @sWhere = @sWhere + '
	AND HRMT1031.RecPeriodID <= '''+@ToRecruitPeriodID+''' '
	IF (@FromRecruitPeriodID IS NOT NULL AND @ToRecruitPeriodID IS NOT NULL) SET @sWhere = @sWhere + '
	AND HRMT1031.RecPeriodID BETWEEN '''+@FromRecruitPeriodID+''' AND '''+@ToRecruitPeriodID+''' '
	IF ISNULL(@DepartmentList, '') <> ''
	SET @sWhere = @sWhere + ' AND HRMT1031.DepartmentID IN ('''+@DepartmentList+''')'
	IF ISNULL(@DutyList, '') <> ''
	SET @sWhere = @sWhere + ' AND HRMT1031.DutyID IN ('''+@DutyList+''')'
	IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT1030.CreateDate,120), 126) >= '''+CONVERT(VARCHAR(10),@FromDate,126)+''' '
	IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT1030.CreateDate,120), 126) <= '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '
	IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT1030.CreateDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '
END


SET @sSQL= N'
SELECT HRMT1030.DivisionID, HRMT1030.CandidateID, 
(CASE 
WHEN ISNULL(HRMT1030.MiddleName,'''') = '''' THEN LTRIM(RTRIM(ISNULL(HRMT1030.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,''''))) 
WHEN ISNULL(HRMT1030.MiddleName,'''') <> '''' THEN LTRIM(RTRIM(ISNULL(HRMT1030.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName,''''))) + '' '' +  LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,''''))) 
END) AS CandidateName, HRMT1031.RecPeriodID , HRMT2020.RecruitPeriodName,
YEAR(HRMT1030.Birthday) AS Birthday, HT90.Description AS Gender, HRMT1030.PhoneNumber, HRMT1030.Email, HRMT1030.PermanentAddress, HRMT1032.EducationLevelID,
HT1005.EducationLevelName, ISNULL(HRMT1032.Language1ID + '':'' + '' '' + HRMT1032.LanguageLevel1ID,'''') AS Language1,
ISNULL(HRMT1032.Language2ID + '':'' + '' '' + HRMT1032.LanguageLevel2ID,'''') AS Language2, HRMT1031.DepartmentID, AT1102.DepartmentName,
 HRMT1031.DutyID, HT1102.DutyName, 
ISNULL(HRMT1032.Language3ID + '':'' + '' '' + HRMT1032.LanguageLevel3ID,'''') AS Language3, HT91.Description AS InformaticsLevel1, HRMT1031.ResourceID, HRMT1000.ResourceName, 
ISNULL(CONVERT(VARCHAR(15),HRMT1033.FromDate,103)+ ''-'' + '' '' + CONVERT(VARCHAR(15),HRMT1033.ToDate,103) + '':'' + '' '' + '':''+ HRMT1033.CompanyName + '' '' + '' '' +  HRMT1033.Duty,'''') AS Experiences,
HRMT1031.RequireSalary
FROM HRMT1030 WITH (NOLOCK)
LEFT JOIN HRMT1031 WITH (NOLOCK) ON HRMT1030.DivisionID = HRMT1031.DivisionID AND HRMT1030.CandidateID = HRMT1031.CandidateID 
LEFT JOIN HRMT1032 WITH (NOLOCK) ON HRMT1030.DivisionID = HRMT1032.DivisionID AND HRMT1030.CandidateID = HRMT1032.CandidateID 
LEFT JOIN HRMT1033 WITH (NOLOCK) ON HRMT1030.DivisionID = HRMT1033.DivisionID AND HRMT1030.CandidateID = HRMT1033.CandidateID 
LEFT JOIN HRMT1034 WITH (NOLOCK) ON HRMT1030.DivisionID = HRMT1034.DivisionID AND HRMT1030.CandidateID = HRMT1034.CandidateID 
LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT1031.DivisionID = HT1102.DivisionID  AND HRMT1031.DutyID = HT1102.DutyID 
LEFT JOIN HT0099 HT90 WITH (NOLOCK) ON HT90.ID = HRMT1030.Gender AND HT90.CodeMaster = ''Gender''
LEFT JOIN HT0099 HT91 WITH (NOLOCK) ON HT91.ID = HRMT1032.InformaticsLevel AND HT91.CodeMaster = ''Proficient''
LEFT JOIN HRMT1000 WITH (NOLOCK) ON HRMT1000.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND HRMT1031.ResourceID = HRMT1000.ResourceID
LEFT JOIN HRMT2020 WITH (NOLOCK) ON HRMT1031.DivisionID = HRMT2020.DivisionID AND HRMT1031.RecPeriodID = HRMT2020.RecruitPeriodID 
LEFT JOIN HT1005 WITH (NOLOCK) ON HRMT1032.DivisionID = HT1005.DivisionID AND HRMT1032.EducationLevelID = HT1005.EducationLevelID
LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND AT1102.DepartmentID = HRMT1031.DepartmentID
WHERE '+@sWhere+'
ORDER BY '+@OrderBy+'
'



EXEC (@sSQL)
--PRINT @sSQL

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
