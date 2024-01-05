IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2033]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2033]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In hồ sơ phỏng vấn + hồ sơ ứng tuyển của ứng viên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy on 22/08/2017
-- <Example>
---- 
/*-- <Example>
	HRMP2033 @DivisionID='MK',@DivisionList='MK'',''MK1',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1,
	@InterviewScheduleID=NULL,@DutyID='LD',@Disabled=0

	EXEC HRMP2033 @DivisionID='CH',@DivisionList=NULL,@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1, 
	@InterviewScheduleID = 'aaa', @DepartmentID = NULL, @DutyID = NULL, @CandidateID=NULL, @InterviewLevel = 1,@InterviewFromDate = NULL, 
	@InterviewToDate = '2017-08-05', @IsCheckAll = 1, @InterviewScheduleList = NULL
----*/

CREATE PROCEDURE HRMP2033
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT,
	 @InterviewScheduleID VARCHAR(50),
	 @DepartmentID VARCHAR(50),
	 @DutyID VARCHAR(50),
	 @CandidateID VARCHAR(50),
	 @CandidateName NVARCHAR(250),
	 @InterviewLevel VARCHAR(1),
	 @InterviewFromDate DATETIME,
	 @InterviewToDate DATETIME,
	 @IsCheckAll TINYINT,
	 @InterviewScheduleList XML
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
		@sSQL1 NVARCHAR (MAX)=N'',
        @sWhere NVARCHAR(MAX)=N'',
		@sJoin NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N''

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF Isnull(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + ' HRMT2030.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' HRMT2030.DivisionID = '''+@DivisionID+''' '

IF @IsSearch = 1
BEGIN
	
	IF ISNULL(@InterviewScheduleID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2030.InterviewScheduleID LIKE ''%'+@InterviewScheduleID+'%'' '
	IF ISNULL(@DepartmentID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2020.DepartmentID LIKE ''%'+@DutyID+'%'' '
	IF ISNULL(@DutyID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2020.DutyID LIKE ''%'+@DutyID+'%'' '
	IF ISNULL(@CandidateID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2031.CandidateID LIKE ''%'+@CandidateID+'%'' '
	IF ISNULL(@CandidateName,'') <> '' SET @sWhere = @sWhere + '
	AND LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HRMT1030.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,''''))),''  '','' ''))) LIKE N''%'+@CandidateName+'%'' '
	IF ISNULL(@InterviewLevel,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2030.InterviewLevel LIKE ''%'+@InterviewLevel+'%'' '
	IF (@InterviewFromDate IS NOT NULL AND @InterviewToDate IS NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2031.InterviewDate,120), 126) >= '''+CONVERT(VARCHAR(10),@InterviewFromDate,126)+''' '
	IF (@InterviewFromDate IS NULL AND @InterviewToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2031.InterviewDate,120), 126) <= '''+CONVERT(VARCHAR(10),@InterviewToDate,126)+''' '
	IF (@InterviewFromDate IS NOT NULL AND @InterviewToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2031.InterviewDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@InterviewFromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@InterviewToDate,126)+''' '	

END

IF ISNULL(@IsCheckAll,0) = 0
BEGIN
	CREATE TABLE #InterviewScheduleList (DivisionID VARCHAR(50), InterviewScheduleID VARCHAR(50))
	INSERT INTO #InterviewScheduleList (DivisionID, InterviewScheduleID)
	SELECT X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		   X.Data.query('InterviewScheduleID').value('.', 'NVARCHAR(50)') AS InterviewScheduleID
	FROM	@InterviewScheduleList.nodes('//Data') AS X (Data)
	ORDER BY InterviewScheduleID

	SET @sJoin = @sJoin + N'
	INNER JOIN #InterviewScheduleList T1 ON HRMT2020.DivisionID = T1.DivisionID AND HRMT2030.InterviewScheduleID = T1.InterviewScheduleID'
END

----Thông tin hồ sơ phỏng vấn của ứng viên
SET @sSQL = N'
SELECT HRMT2030.APK, HRMT2030.DivisionID, HRMT2030.InterviewScheduleID, HRMT2030.Description, HRMT2030.RecruitPeriodID, HRMT2020.RecruitPeriodName, HRMT2020.DepartmentID, 
	AT1102.DepartmentName, HRMT2020.DutyID, HT1102.DutyName, HRMT2021.InterviewAddress, 
	CASE WHEN HRMT2030.InterviewLevel = 1 THEN N''Vòng 1''
		 WHEN HRMT2030.InterviewLevel = 2 THEN N''Vòng 2''
		 WHEN HRMT2030.InterviewLevel = 3 THEN N''Vòng 3''
		 WHEN HRMT2030.InterviewLevel = 4 THEN N''Vòng 4''
		 WHEN HRMT2030.InterviewLevel = 5 THEN N''Vòng 5'' END AS InterviewLevel, HRMT2031.CandidateID,
	LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HRMT1030.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,''''))),''  '','' ''))) AS CandidateName,
	HRMT2031.InterviewDate, H99.Description AS ConfirmID,
	HRMT2030.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2030.CreateUserID) CreateUserID, HRMT2030.CreateDate, 
	HRMT2030.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2030.LastModifyUserID) LastModifyUserID, HRMT2030.LastModifyDate
INTO #InterviewFile
FROM HRMT2030 WITH (NOLOCK)
LEFT JOIN HRMT2031 WITH (NOLOCK) ON HRMT2030.DivisionID = HRMT2031.DivisionID AND HRMT2030.InterviewScheduleID = HRMT2031.InterviewScheduleID
LEFT JOIN HRMT2020 WITH (NOLOCK) ON HRMT2030.DivisionID = HRMT2020.DivisionID AND HRMT2030.RecruitPeriodID = HRMT2020.RecruitPeriodID
LEFT JOIN HRMT2021 WITH (NOLOCK) ON HRMT2021.DivisionID = HRMT2020.DivisionID AND HRMT2021.RecruitPeriodID = HRMT2020.RecruitPeriodID AND HRMT2021.InterviewLevel = HRMT2030.InterviewLevel
LEFT JOIN HRMT1030 WITH (NOLOCK) ON HRMT2031.DivisionID = HRMT1030.DivisionID AND HRMT2031.CandidateID = HRMT1030.CandidateID
LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT2020.DepartmentID = AT1102.DepartmentID
LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT2020.DivisionID = HT1102.DivisionID AND HRMT2020.DutyID = HT1102.DutyID
LEFT JOIN HT0099 H99 WITH (NOLOCK) ON HRMT2031.ConfirmID = H99.ID AND H99.CodeMaster = ''InterviewConfirm''
'+@sJoin+'
WHERE '+@sWhere+'
AND ISNULL(HRMT2031.ConfirmID,0) = 1
ORDER BY HRMT2020.DepartmentID, HRMT2020.DutyID, HRMT2030.RecruitPeriodID, HRMT2030.InterviewLevel'

SET @sSQL1 = N'
SELECT HRMT2021.APK, HRMT2021.DivisionID, HRMT2021.RecruitPeriodID, HRMT2021.TotalInterviewer, HRMT2021.InterviewLevel,
HRMT2021.InterviewTypeID, HRMT1010.InterviewTypeName, HRMT2021.InterviewAddress, HRMT2021.DetailTypeID, HRMT1011.Description AS DetailTypeName, HRMT2022.InterviewerID,
LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HT14.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HT14.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT14.FirstName,''''))),''  '','' ''))) AS InterviewerName
FROM HRMT2030 WITH (NOLOCK)
INNER JOIN HRMT2021 WITH (NOLOCK) ON HRMT2030.DivisionID = HRMT2021.DivisionID AND HRMT2021.RecruitPeriodID = HRMT2030.RecruitPeriodID AND HRMT2030.InterviewLevel = HRMT2021.InterviewLevel
LEFT JOIN HRMT1010 WITH (NOLOCK) ON HRMT1010.DivisionID = HRMT2021.DivisionID AND HRMT2021.InterviewTypeID = HRMT1010.InterviewTypeID
LEFT JOIN HRMT1011 WITH (NOLOCK) ON HRMT1011.DivisionID = HRMT2021.DivisionID AND HRMT2021.DetailTypeID = HRMT1011.DetailTypeID
LEFT JOIN HT1400 HT14 ON HRMT2022.DivisionID = HT14.DivisionID AND HRMT2022.InterviewerID = HT14.EmployeeID
WHERE '+@sWhere +''


----Thông tin hồ sơ tuyển dụng của ứng viên
SET @sSQL1 = N'
SELECT HRMT1030.APK, HRMT1030.DivisionID, HRMT1030.CandidateID, HRMT1030.ImageID, HT91.Description AS Gender, 
LTRIM(RTRIM(ISNULL(HRMT1030.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,''''))) AS CandidateName, 
HRMT1030.Birthday, HRMT1030.BornPlace, HRMT1030.NationalityID, HRMT1030.ReligionID, HRMT1030.NativeCountry, HRMT1030.IdentifyCardNo, 
HRMT1030.IdentifyPlace, HRMT1030.IdentifyCityID, HRMT1030.IdentifyDate, HRMT1030.IdentifyEnd, HRMT1030.IsSingle, HRMT1030.HealthStatus, 
HRMT1030.Height, HRMT1030.Weight, HRMT1030.PassportNo, HRMT1030.PassportDate, HRMT1030.PassportEnd, HRMT1030.PermanentAddress, HRMT1030.TemporaryAddress, 
HRMT1030.EthnicID, HRMT1030.PhoneNumber, HRMT1030.Email, HRMT1030.Fax, HRMT1030.Note, HRMT1031.RecPeriodID, '''' AS RecPeriodName,
HRMT1031.DepartmentID, AT1102.DepartmentName, HRMT1031.DutyID, HT1102.DutyName, HT90.Description AS RecruitStatus, HRMT1031.ReceiveFileDate,
HRMT1031.ReceiveFilePlace, HRMT1031.ResourceID, HRMT1031.WorkType, HRMT1031.Startdate, HRMT1031.RequireSalary, HRMT1031.RecReason, HRMT1031.Strength,
HRMT1031.Weakness, HRMT1031.CareerAim, HRMT1031.PersonalAim, HRMT1031.Aptitude, HRMT1031.Hobby, HRMT1032.EducationLevelID, HRMT1032.InformaticsLevel,
HRMT1032.PoliticsID, HRMT1032.Language1ID, HRMT1032.Language2ID, HRMT1032.Language3ID, HRMT1032.LanguageLevel1ID, HRMT1032.LanguageLevel2ID, HRMT1032.LanguageLevel3ID,
HRMT1033.CompanyName, HRMT1033.CompanyAddress, HRMT1033.CountryID, AT1001.CountryName, HRMT1033.FromDate, HRMT1033.ToDate, HRMT1033.Duty, HRMT1033.Reason,
HRMT1033.Notes, HRMT1034.EducationCenter, HRMT1034.EducationMajor, HRMT1034.EducationTypeID, HRMT1034.EducationFromDate, HRMT1034.Description, HRMT1034.EducationToDate,
HRMT1030.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT1030.CreateUserID) CreateUserID, HRMT1030.CreateDate, 
HRMT1030.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT1030.LastModifyUserID) LastModifyUserID, HRMT1030.LastModifyDate
FROM HRMT1030 WITH (NOLOCK)
LEFT JOIN HRMT1031 WITH (NOLOCK) ON HRMT1030.DivisionID = HRMT1031.DivisionID AND HRMT1030.CandidateID = HRMT1031.CandidateID 
LEFT JOIN HRMT1032 WITH (NOLOCK) ON HRMT1030.DivisionID = HRMT1032.DivisionID AND HRMT1030.CandidateID = HRMT1032.CandidateID 
LEFT JOIN HRMT1033 WITH (NOLOCK) ON HRMT1030.DivisionID = HRMT1033.DivisionID AND HRMT1030.CandidateID = HRMT1033.CandidateID 
LEFT JOIN HRMT1034 WITH (NOLOCK) ON HRMT1030.DivisionID = HRMT1034.DivisionID AND HRMT1030.CandidateID = HRMT1034.CandidateID 
LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT1031.DutyID = HT1102.DutyID 
LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT1031.DepartmentID = AT1102.DepartmentID 
LEFT JOIN AT1001 WITH (NOLOCK) ON AT1001.CountryID = HRMT1033.CountryID 
LEFT JOIN HT0099 HT90 WITH (NOLOCK) ON HT90.ID = HRMT1031.RecruitStatus AND HT90.CodeMaster = ''RecruitStatus''
LEFT JOIN HT0099 HT91 WITH (NOLOCK) ON HT91.ID = HRMT1031.RecruitStatus AND HT91.CodeMaster = ''Gender''
INNER JOIN 
(
	SELECT DISTINCT DivisionID, CandidateID FROM #InterviewFile
)Temp ON HRMT1030.DivisionID = Temp.DivisionID AND HRMT1030.CandidateID = Temp.CandidateID 
ORDER BY HRMT1031.DepartmentID, HRMT1031.DutyID, HRMT1030.CandidateID

DROP TABLE #InterviewFile
'

--PRINT(@sSQL)
--PRINT(@sSQL1)

EXEC (@sSQL+@sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
