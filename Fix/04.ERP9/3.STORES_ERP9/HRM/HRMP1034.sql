IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP1034]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP1034]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load phiếu in chi tiết hồ sơ ứng viên(HRMF1030)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phương Thảo, Date: 20/09/2023 - Tham khảo store HRMP1034( Load Hồ sơ ứng viên của MinhTri)
-- <Example>
---- 
/*-- <Example>

    EXEC HRMP1034 @DivisionID=N'BBA-SI',@CandidateID=N'EST',@UserID=N'ADMIN',@IsMode=0,@PageSize=1000,@PageNumber=1
	HRMP1034 @DivisionID, @UserID, @PageNumber, @PageSize, @CandidateID, @IsMode
----*/

CREATE PROCEDURE HRMP1034
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @CandidateID VARCHAR(50),
	 @IsMode INT -- 0: Load Tab Thông tin cá nhân, Thông tin tuyển dụng, Thông tin học vấn
				-- 1: Load Tab Thông tin học vấn: Quá trình đào tạo
				-- 2: Load Tab kinh nghiệm làm việc
                -- 3: Laod Tab DISC
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
		@sSQL2_Extend NVARCHAR (MAX)=N'',
		@sSQL3_Extend  NVARCHAR (MAX)=N'',
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)=N'', 
		@sSQL1 NVARCHAR(MAX),
		@EducationTypeID0 NVARCHAR(MAX) = N'Chính quy tập trung',
		@EducationTypeID1 NVARCHAR(MAX) = N'Tại chức',
		@EducationTypeID2 NVARCHAR(MAX) = N'Cử tuyển',
		@EducationTypeID3 NVARCHAR(MAX) = N'Bổ túc',
		@EducationTypeID4 NVARCHAR(MAX) = N'Khác'

IF @IsMode = 0 
BEGIN 
	SET @sSQL = N'
		SELECT  --Thông tin cá nhân
			HRMT1030.APK,
			HRMT1030.DivisionID,
			HRMT1030.CandidateID,
			HRMT1030.FirstName,
			HRMT1030.MiddleName,
			HRMT1030.LastName,
			CONCAT (HRMT1030.LastName,'' '', HRMT1030.MiddleName,'' '',HRMT1030.FirstName) AS FullName,
			HRMT1030.ImageID,
			HRMT1030.Gender,
			HRMT1030.Birthday,
			HRMT1030.BornPlace,
			HRMT1030.NationalityID,
			AT1001.CountryName,
			HRMT1030.ReligionID,
			HT1002.ReligionName,
			HRMT1030.NativeCountry,
			HRMT1030.IdentifyCardNo, 
			HRMT1030.IdentifyPlace,
			HRMT1030.IdentifyCityID,
			AT1002.CityName,
			HRMT1030.IdentifyDate,
			CASE WHEN HRMT1030.IsSingle = 0 THEN CONVERT(NVARCHAR(MAX), N''Độc thân'') WHEN HRMT1030.IsSingle = 1 THEN CONVERT(NVARCHAR(MAX), N''Đã kết hôn'') ELSE '''' END AS IsSingle,
			HRMT1030.HealthStatus,
			HRMT1030.Height,
			HRMT1030.Weight, 
			HRMT1030.PassportNo,
			HRMT1030.PassportDate,
			HRMT1030.PassportEnd,
			HRMT1030.PermanentAddress,
			HRMT1030.TemporaryAddress, 
			HRMT1030.EthnicID,
			HT1001.EthnicName,
			HRMT1030.PhoneNumber,
			HRMT1030.Email,
			HRMT1030.Fax,
			HRMT1030.Note,
            --Thông tin tuyển dụng
			HRMT1031.RecPeriodID,
			HRMT2020.RecruitPeriodName AS RecPeriodName,
			HRMT1031.DepartmentID,
			AT1102.DepartmentName,
			HRMT1031.DutyID,
			HT1102.DutyName,
			HT90.Description AS RecruitStatusName,
			HRMT1031.ReceiveFileDate,
			HRMT1031.ReceiveFilePlace,
			HRMT1031.ResourceID,
			HRMT1000.ResourceName,
			HT92.Description AS WorkType,
			HRMT1031.Startdate,
			HRMT1031.RequireSalary,
			HRMT1031.RecReason,
			HRMT1031.Strength,
			HRMT1031.Weakness,
			HRMT1031.CareerAim,
			HRMT1031.PersonalAim,
			HRMT1031.Aptitude,
			HRMT1031.Hobby,
			HRMT1032.EducationLevelID,
			HT1005.EducationLevelName,
			HT93.Description AS InformaticsLevel,
			HRMT1032.PoliticsID,
			HT1010.PoliticsName,
            --Thông tin học vấn
			HRMT1032.Language1ID,
			H1.LanguageName AS Language1Name,
			HRMT1032.Language2ID,
			H2.LanguageName AS Language2Name,
			HRMT1032.Language3ID,
			H3.LanguageName AS Language3Name, 
			HRMT1032.LanguageLevel1ID,
			H71.LanguageLevelName AS LanguageLevel1Name,
			HRMT1032.LanguageLevel2ID,
			H72.LanguageLevelName AS LanguageLevel2Name,
			HRMT1032.LanguageLevel3ID, 
			H73.LanguageLevelName AS LanguageLevel3Name,
			A1.UserName AS CreateUserID,
			HRMT1030.CreateDate,
			A2.UserName AS LastModifyUserID,
			HRMT1030.LastModifyDate,
			HRMT1031.EvaluationKitID,
			PAT10201.EvaluationKitName,
			HRMT1031.RecruitStatus,
			HT91.Description AS GenderName,
			A3.CityName AS IdentifyCityName
		FROM HRMT1030 WITH (NOLOCK)'
	SET @sSQL2_Extend =N'	
			LEFT JOIN HRMT1031 WITH (NOLOCK) ON HRMT1030.DivisionID = HRMT1031.DivisionID AND CAST( HRMT1030.APK AS VARCHAR(250)) = HRMT1031.CandidateID 
			LEFT JOIN HRMT1032 WITH (NOLOCK) ON HRMT1030.DivisionID = HRMT1032.DivisionID AND CAST( HRMT1030.APK AS VARCHAR(250)) = HRMT1032.CandidateID 
			LEFT JOIN HT1001 WITH (NOLOCK) ON HRMT1030.DivisionID = HT1001.DivisionID AND HRMT1030.EthnicID = HT1001.EthnicID 
			LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT1030.DivisionID = HT1102.DivisionID AND HRMT1031.DutyID = HT1102.DutyID 
			LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT1031.DepartmentID = AT1102.DepartmentID AND AT1102.DivisionID IN ('''+@DivisionID+''' , ''@@@'')
			LEFT JOIN HT0099 HT90 WITH (NOLOCK) ON HT90.ID = HRMT1031.RecruitStatus AND HT90.CodeMaster = ''RecruitStatus''
			LEFT JOIN HT0099 HT91 WITH (NOLOCK) ON HT91.ID = HRMT1030.Gender AND HT91.CodeMaster = ''Gender''
			LEFT JOIN HT0099 HT93 WITH (NOLOCK) ON HT93.ID = HRMT1031.WorkType AND HT93.CodeMaster = ''Proficient''
			LEFT JOIN HT0099 HT92 WITH (NOLOCK) ON HT92.ID = HRMT1031.WorkType AND HT92.CodeMaster = ''WorkType''
			LEFT JOIN AT1001 WITH (NOLOCK) ON HRMT1030.NationalityID = AT1001.CountryID '
	SET @sSQL3_Extend =N'	
			LEFT JOIN HT1002 WITH (NOLOCK) ON HRMT1030.DivisionID = HT1002.DivisionID AND HRMT1030.ReligionID = HT1002.ReligionID 
			LEFT JOIN AT1002 WITH (NOLOCK) ON AT1002.DivisionID IN (HRMT1030.DivisionID, ''@@@'') AND HRMT1030.IdentifyCityID = AT1002.CityID
			LEFT JOIN HRMT2020 WITH (NOLOCK) ON HRMT1030.DivisionID = HRMT2020.DivisionID AND HRMT1031.RecPeriodID = HRMT2020.RecruitPeriodID 
			LEFT JOIN HT1005 WITH (NOLOCK) ON HRMT1030.DivisionID = HT1005.DivisionID AND HRMT1032.EducationLevelID = HT1005.EducationLevelID
			LEFT JOIN HRMT1000 WITH(NOLOCK) ON HRMT1031.ResourceID = HRMT1000.ResourceID AND HRMT1000.DivisionID IN ('''+@DivisionID+''' , ''@@@'')
			LEFT JOIN HT1010 WITH (NOLOCK) ON  HRMT1030.DivisionID = HT1010.DivisionID AND HRMT1032.PoliticsID = HT1010.PoliticsID
			LEFT JOIN PAT10201 WITH (NOLOCK) ON HRMT1031.DivisionID = PAT10201.DivisionID AND HRMT1031.EvaluationKitID = PAT10201.EvaluationKitID
			LEFT JOIN HT1006 H1 WITH (NOLOCK) ON H1.LanguageID = HRMT1032.Language1ID AND H1.DivisionID IN (HRMT1032.DivisionID, ''@@@'')
			LEFT JOIN HT1006 H2 WITH (NOLOCK) ON H2.LanguageID = HRMT1032.Language2ID AND H2.DivisionID IN (HRMT1032.DivisionID, ''@@@'')
			LEFT JOIN HT1006 H3 WITH (NOLOCK) ON H3.LanguageID = HRMT1032.Language3ID AND H3.DivisionID IN (HRMT1032.DivisionID, ''@@@'')
			LEFT JOIN HT1007 H71 WITH (NOLOCK) ON H71.LanguageLevelID = HRMT1032.LanguageLevel1ID AND H71.DivisionID IN (HRMT1032.DivisionID, ''@@@'')
			LEFT JOIN HT1007 H72 WITH (NOLOCK) ON H72.LanguageLevelID = HRMT1032.LanguageLevel2ID AND H72.DivisionID IN (HRMT1032.DivisionID, ''@@@'')
			LEFT JOIN HT1007 H73 WITH (NOLOCK) ON H73.LanguageLevelID = HRMT1032.LanguageLevel3ID AND H73.DivisionID IN (HRMT1032.DivisionID, ''@@@'')
			LEFT JOIN AT1405 A1 WITH (NOLOCK) ON A1.UserID = HRMT1030.CreateUserID AND A1.DivisionID IN (HRMT1030.DivisionID, ''@@@'')
			LEFT JOIN AT1405 A2 WITH (NOLOCK) ON A2.UserID = HRMT1030.LastModifyUserID AND A2.DivisionID IN (HRMT1030.DivisionID, ''@@@'')
			LEFT JOIN AT1002 A3 WITH (NOLOCK) ON A3.CityID = HRMT1030.IdentifyCityID AND A3.DivisionID IN (HRMT1030.DivisionID, ''@@@'')
		WHERE HRMT1030.DivisionID = '''+@DivisionID+''' 
		AND HRMT1030.APK = '''+@CandidateID+'''
		'
END

IF  @IsMode = 1
BEGIN
	SET @TotalRow = 'COUNT(*) OVER ()'
	SET @sSQL1 = 'OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			  FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
	SET @OrderBy = 'HRMT1034.EducationFromDate'
	SET @sSQL = N'
	SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, 
	HRMT1034.DivisionID, HRMT1034.CandidateID, HRMT1034.EducationCenter, HRMT1034.EducationMajor,
	CASE WHEN HRMT1034.EducationTypeID = 0 THEN N''' + @EducationTypeID0 + '''
		 WHEN HRMT1034.EducationTypeID = 1 THEN N''' + @EducationTypeID1 + '''
		 WHEN HRMT1034.EducationTypeID = 2 THEN N''' + @EducationTypeID2 + '''
		 WHEN HRMT1034.EducationTypeID = 3 THEN N''' + @EducationTypeID3 + '''
		 WHEN HRMT1034.EducationTypeID = 4 THEN N''' + @EducationTypeID4 + '''ELSE N'''' END AS EducationTypeName
	, HRMT1034.EducationFromDate, HRMT1034.Description, HRMT1034.EducationToDate, HRMT1034.Note
	FROM HRMT1034
	WHERE HRMT1034.DivisionID = '''+@DivisionID+'''
	AND HRMT1034.CandidateID = '''+@CandidateID+'''
'
END

IF  @IsMode = 2
BEGIN 
	SET @TotalRow = 'COUNT(*) OVER ()'
	SET @sSQL1 = 'OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			  FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
	SET @OrderBy = 'HRMT1033.FromDate'
	SET  @sSQL = N'
		SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, 
		HRMT1033.DivisionID
		, HRMT1033.CandidateID
		, HRMT1033.CompanyName
		, HRMT1033.CompanyAddress
		, HRMT1033.CountryID
		, AT1001.CountryName
		, HRMT1033.FromDate
		, HRMT1033.ToDate
		, HRMT1033.Duty
		, HRMT1033.Reason
		, HRMT1033.Notes
		FROM HRMT1033
		LEFT JOIN AT1001 WITH (NOLOCK) ON AT1001.CountryID = HRMT1033.CountryID 
		WHERE HRMT1033.DivisionID = '''+@DivisionID+'''
		AND HRMT1033.CandidateID = '''+@CandidateID+'''
	'
END

IF  @IsMode = 3
BEGIN 
    SELECT TOP 1 * FROM HRMT21101 WITH (NOLOCK)
    WHERE DivisionID = @DivisionID
	AND EXISTS (SELECT TOP 1 1 FROM HRMT1030 WHERE CandidateID = HRMT21101.EmployeeID AND CandidateID = @CandidateID AND DivisionID = HRMT21101.DivisionID)

END
PRINT (@sSQL + @sSQL2_Extend + @sSQL3_Extend)
EXEC (@sSQL + @sSQL2_Extend + @sSQL3_Extend)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
