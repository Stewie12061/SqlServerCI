IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2034]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2034]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Chọn Đợt tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 23/08/2017
--- Modifyed by: Khả Vi on 25/12/2017: Bổ sung chọn đợt tuyển dụng cho báo cáo kết quả phỏng vấn 
--- Modifyed by: Thu Hà on 22/18/2023: Xử lý hiển thị dữ liệu của đợt tuyển dụng cho màn hình  @ScreenID = 'HRMF2031'
--- Modifyed by: Phương Thảo on 15/09/2022: Bỏ case when số vòng phỏng vấn
-- <Example>
---- 
/*-- <Example>
	HRMP2034 @DivisionID='CH',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25, @ScreenID = 'HRMF3111', @TxtSearch=''

	@DivisionID,@UserID,@PageNumber,@PageSize,@IsSearch, @RecruitPlanID, @DepartmentID, @DutyID,@FromDate,@ToDate, @Status
----*/

CREATE PROCEDURE HRMP2034
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @ScreenID VARCHAR(50) = '',
	 @TxtSearch NVARCHAR(250)
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N''

SET @OrderBy = 'T1.DepartmentID, T1.DutyID, T1.RecruitPeriodID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF @ScreenID = 'HRMF1031' ---Cap nhat hồ sơ ứng viên 
BEGIN
	SET @sSQL = N'
SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, T1.DivisionID, T1.RecruitPeriodID, T1.RecruitPeriodName, 
T1.RecruitPlanID, T1.DepartmentID, T1.DepartmentID +'' - ''+  AT1102.DepartmentName AS DepartmentName, T1.DutyID, T1.DutyID +'' - ''+  HT1102.DutyName AS DutyName
FROM HRMT2020 T1 WITH (NOLOCK)
LEFT JOIN AT1102 WITH (NOLOCK) ON T1.DepartmentID = AT1102.DepartmentID
LEFT JOIN HT1102 WITH (NOLOCK) ON T1.DivisionID = HT1102.DivisionID AND T1.DutyID = HT1102.DutyID
WHERE T1.DivisionID = '''+@DivisionID+'''
AND (ISNULL(T1.RecruitPeriodID,'''') LIKE ''%'+ISNULL(@TxtSearch,'')+'%'' OR ISNULL(T1.RecruitPeriodName,'''') LIKE ''%'+ISNULL(@TxtSearch,'')+'%''
	OR T1.DepartmentID +'' - ''+  AT1102.DepartmentName LIKE ''%'+ISNULL(@TxtSearch,'')+'%''
	OR T1.DutyID +'' - ''+  HT1102.DutyName LIKE ''%'+ISNULL(@TxtSearch,'')+'%''
	) 
ORDER BY '+@OrderBy+'

OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
'
END

IF @ScreenID = 'HRMF2031' ---Cap nhat lich phong van
BEGIN
        SET @sSQL = N'
SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, T1.DivisionID, T1.RecruitPeriodID, T1.RecruitPeriodName, 
T1.RecruitPlanID, T1.DepartmentID, AT1102.DepartmentName AS DepartmentName, T1.DutyID,  HT1102.DutyName AS DutyName,
T2.InterviewLevel,T2.InterviewAddress
FROM HRMT2020 T1 WITH (NOLOCK)
INNER JOIN
(
	SELECT DivisionID, RecruitPeriodID, MAX(InterviewLevel)+1 AS InterviewLevel
	FROM HRMT2030 WITH (NOLOCK)
	GROUP BY DivisionID, RecruitPeriodID
	UNION ALL
	SELECT HRMT2020.DivisionID, HRMT2020.RecruitPeriodID, 1 AS InterviewLevel
	FROM HRMT2020 WITH (NOLOCK)
	LEFT JOIN HRMT1031 WITH (NOLOCK) ON HRMT2020.DivisionID = HRMT1031.DivisionID AND HRMT2020.RecruitPeriodID = HRMT1031.RecPeriodID
	WHERE HRMT1031.CandidateID NOT IN (
	(SELECT HRMT2031.CandidateID
	FROM HRMT2030 WITH (NOLOCK) 
	INNER JOIN HRMT2031 WITH (NOLOCK) ON HRMT2030.DivisionID = HRMT2031.DivisionID AND HRMT2030.InterviewScheduleID = HRMT2031.InterviewScheduleID
	INNER JOIN HRMT1031 WITH (NOLOCK) ON  HRMT2031.DivisionID = HRMT1031.DivisionID AND HRMT2031.CandidateID = HRMT1031.CandidateID
	WHERE HRMT2030.DivisionID = HRMT2020.DivisionID AND HRMT2030.RecruitPeriodID = HRMT2020.RecruitPeriodID))
)Temp_HRMT2030 ON T1.DivisionID = Temp_HRMT2030.DivisionID AND T1.RecruitPeriodID = Temp_HRMT2030.RecruitPeriodID
LEFT JOIN HRMT2021 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND CONVERT(NVARCHAR(50), T1.APK) = T2.RecruitPeriodID
LEFT JOIN AT1102 WITH (NOLOCK) ON T1.DepartmentID = AT1102.DepartmentID
LEFT JOIN HT1102 WITH (NOLOCK) ON T1.DivisionID = HT1102.DivisionID AND T1.DutyID = HT1102.DutyID
WHERE T1.DivisionID = '''+@DivisionID+'''
AND (ISNULL(T1.RecruitPeriodID,'''') LIKE ''%'+ISNULL(@TxtSearch,'')+'%'' OR ISNULL(T1.RecruitPeriodName,'''') LIKE ''%'+ISNULL(@TxtSearch,'')+'%'' 
	OR T1.DepartmentID +'' - ''+  AT1102.DepartmentName LIKE ''%'+ISNULL(@TxtSearch,'')+'%''
	OR T1.DutyID +'' - ''+  HT1102.DutyName LIKE ''%'+ISNULL(@TxtSearch,'')+'%''
	) 
GROUP BY T1.DivisionID, T1.RecruitPeriodID, T1.RecruitPeriodName, 
T1.RecruitPlanID, T1.DepartmentID, T1.DepartmentID, AT1102.DepartmentName, T1.DutyID, T1.DutyID, HT1102.DutyName,T2.InterviewLevel, T2.InterviewAddress
ORDER BY '+@OrderBy+'


OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
'
END

ELSE IF @ScreenID = 'HRMF2041' ---Cap nhat ket qua phong van 
BEGIN
	SET @sSQL = N'
SELECT DISTINCT T1.DivisionID, T1.RecruitPeriodID, T1.InterviewLevel, COUNT(T3.CandidateID) AS CandidateID_Total
INTO #CandidateID_Total
FROM HRMT2030 T1
INNER JOIN 
(
	SELECT HRMT2030.DivisionID, HRMT2030.RecruitPeriodID, MAX(HRMT2030.InterviewLevel) InterviewLevel
	FROM HRMT2030
	
	WHERE HRMT2030.DivisionID = '''+@DivisionID+'''
	
	GROUP BY HRMT2030.DivisionID, HRMT2030.RecruitPeriodID
)T2 ON T1.DivisionID = T2.DivisionID AND T1.RecruitPeriodID = T2.RecruitPeriodID AND T1.InterviewLevel = T2.InterviewLevel
LEFT JOIN HRMT2031 T3 ON T1.DivisionID = T3.DivisionID AND CONVERT(NVARCHAR(50), T1.APK) = T3.InterviewScheduleID
WHERE T1.DivisionID = '''+@DivisionID+'''
AND T3.ConfirmID = 1
GROUP BY T1.DivisionID, T1.RecruitPeriodID, T1.InterviewLevel

SELECT DivisionID, RecruitPeriodID, COUNT(CandidateID) AS CandidateID_File
INTO #CandidateID_File
FROM HRMT2040 WITH (NOLOCK)
WHERE DivisionID = '''+@DivisionID+'''
GROUP BY DivisionID, RecruitPeriodID

SELECT ROW_NUMBER() OVER (ORDER BY T3.DepartmentID, T3.DutyID, T1.RecruitPeriodID) AS RowNum, '+@TotalRow+' AS TotalRow, T1.DivisionID, T1.RecruitPeriodID, T1.InterviewLevel,
T3.RecruitPeriodName, T3.DepartmentID, T3.DepartmentID +'' - ''+  AT1102.DepartmentName AS DepartmentName, T3.DutyID, T3.DutyID +'' - ''+  HT1102.DutyName AS DutyName
FROM #CandidateID_Total T1 WITH (NOLOCK)
LEFT JOIN #CandidateID_File T2 ON T1.DivisionID = T2.DivisionID AND T1.RecruitPeriodID = T2.RecruitPeriodID
LEFT JOIN HRMT2020 T3 ON T1.DivisionID = T3.DivisionID AND T1.RecruitPeriodID = T3.RecruitPeriodID
LEFT JOIN AT1102 WITH (NOLOCK) ON T3.DepartmentID = AT1102.DepartmentID
LEFT JOIN HT1102 WITH (NOLOCK) ON T3.DivisionID = HT1102.DivisionID AND T3.DutyID = HT1102.DutyID
WHERE T1.DivisionID = '''+@DivisionID+'''
AND ISNULL(T1.CandidateID_Total,0) - ISNULL(T2.CandidateID_File,0) > 0
AND (ISNULL(T1.RecruitPeriodID,'''') LIKE ''%'+ISNULL(@TxtSearch,'')+'%'' OR ISNULL(T3.RecruitPeriodName,'''') LIKE ''%'+ISNULL(@TxtSearch,'')+'%'' 
	OR T3.DepartmentID +'' - ''+  AT1102.DepartmentName LIKE ''%'+ISNULL(@TxtSearch,'')+'%''
	OR T3.DutyID +'' - ''+  HT1102.DutyName LIKE ''%'+ISNULL(@TxtSearch,'')+'%''
	) 
ORDER BY T3.DepartmentID, T3.DutyID, T1.RecruitPeriodID
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY

DROP TABLE #CandidateID_Total
'
END
ELSE IF @ScreenID = 'HRMF3011'  -- Báo cáo kết quả phỏng vấn 
BEGIN 
SET @sSQL = N'
SELECT ROW_NUMBER() OVER (ORDER BY HRMT2020.DepartmentID, HRMT2020.DutyID, HRMT2040.RecruitPeriodID) AS RowNum, '+@TotalRow+' AS TotalRow, 
HRMT2040.DivisionID, HRMT2040.RecruitPeriodID, HRMT2020.RecruitPeriodName, HRMT2020.DepartmentID, HRMT2020.DepartmentID +'' - ''+  AT1102.DepartmentName AS DepartmentName, 
HRMT2020.DutyID +'' - ''+  HT1102.DutyName AS DutyID
FROM HRMT2040 WITH (NOLOCK)
LEFT JOIN HRMT2020 WITH (NOLOCK) ON HRMT2040.DivisionID = HRMT2020.DivisionID AND HRMT2040.RecruitPeriodID = HRMT2020.RecruitPeriodID
LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT2020.DepartmentID = AT1102.DepartmentID
LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT2040.DivisionID = HT1102.DivisionID AND HRMT2020.DutyID = HT1102.DutyID
WHERE HRMT2040.DivisionID = '''+@DivisionID+'''
GROUP BY HRMT2040.DivisionID, HRMT2040.RecruitPeriodID, HRMT2020.RecruitPeriodName, HRMT2020.DepartmentID, AT1102.DepartmentName, 
HRMT2020.DutyID, HT1102.DutyName
ORDER BY HRMT2020.DepartmentID, HRMT2020.DutyID, HRMT2040.RecruitPeriodID

OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY

'
END 
PRINT(@sSQL)
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
