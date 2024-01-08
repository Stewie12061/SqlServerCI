IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2213]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2213]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load hồ sơ nhân viên(màn hình cập nhật và xem chi tiết)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phương Thảo, Date: 14/11/2023
-- <Example>
---- 
/*-- <Example>
	HRMP2213 @DivisionID = 'AS', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @APK = 'UV00001', @IsMode = 0

	HRMP2213 @DivisionID, @UserID, @PageNumber, @PageSize, @APK, @IsMode
----*/

CREATE PROCEDURE HRMP2213
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @APK VARCHAR(50),
	 @IsMode INT -- 0: Load Tab TTCN, TTTD, TTHV
				-- 1: Load Tab TTHV: Quá trình đào tạo
				-- 2: Load Tab kinh nghiệm làm việc
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
		@sSQL_Extend NVARCHAR (MAX)=N'',
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)=N'', 
		@sSQL1 NVARCHAR(MAX)

IF @IsMode = 0 
BEGIN 
	SET @sSQL = N'
		SELECT  
			HT14.APK, HT14.DivisionID, HT14.EmployeeID, HT14.FirstName, HT14.MiddleName, HT14.LastName
			, HT14.LastName + '' '' + ISNULL(HT14.MiddleName, '''') + '' '' + HT14.FirstName AS EmployeeName, HT14.ImageID
			, HT14.IsMale, HT91.Description AS IsMaleName, HT14.Birthday, HT14.BornPlace, HT14.CountryID, AT01.CountryName AS CountryName
			, HT14.ReligionID, HT02.ReligionName AS ReligionName, HT14.NativeCountry
			, HT14.IdentifyCardNo, HT14.IdentifyPlace, HT14.IdentifyCityID, HT14.IdentifyDate
			, CASE WHEN HT14.IsSingle = 0 THEN N''Độc thân'' WHEN HT14.IsSingle = 1 THEN N''Đã kết hôn'' ELSE '''' END AS IsSingle, HT14.HealthStatus
			, HT14.PassportNo, HT14.PassportDate, HT14.PassportEnd, HT14.PermanentAddress, HT14.TemporaryAddress
			, HT14.EthnicID, HT01.EthnicName AS EthnicName, HT14.HomePhone, HT14.Email, HT14.HomeFax, HT14.Notes
			, HT43.EmployeeStatus, HT92.Description AS EmployeeStatusName, HT43.RecruitPlace,HT43.RecruitDate
			, HT43.CompanyDate AS CompanyDate1, HT43.WorkDate AS WorkDate1,HT43.DutyID, HT12.DutyName AS DutyName, HT43.TitleID
			, HT43.TimeCoefficient, HT43.DutyCoefficient, HT43.SalaryCoefficient, HT43.LeaveDate, HT43.LeaveToDate, HT43.AbsentReason
			, OT01.Description AS AbsentReasonName, HT43.StatusNotes, HT43.SuggestSalary,HT43.BaseSalary, HT43.InsuranceSalary
			, HT43.Salary01, HT43.Salary02,HT43.Salary03, HT14.DivisionID AS DivisionID2, HT43.DepartmentID, HT43.TeamID
			, HT43.Target01ID, HT43.Target02ID, HT43.Target03ID, HT43.Target04ID, HT43.Target05ID, HT43.Target06ID, HT43.Target07ID
			, HT43.Target08ID, HT43.Target09ID,HT43.Target10ID, HT43.TargetAmount01, HT43.TargetAmount02, HT43.TargetAmount03
			, HT43.TargetAmount04, HT43.TargetAmount05, HT43.TargetAmount06, HT43.TargetAmount07, HT43.TargetAmount08, HT43.TargetAmount09, HT43.TargetAmount10
			, HT42.SoInsuranceNo, HT42.SoInsurBeginDate, HT42.HeInsuranceNo, HT42.HFromDate, HT42.HToDate
			, HT42.HospitalID, HT93.Description AS HospitalName, HT42.Height,HT42.Weight
			, HT42.BankID, HT94.Description AS BankName, HT42.BankAddress, HT42.BankAccountNo, HT42.PersonalTaxID
			, HT14.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HT14.CreateUserID) CreateUserID, HT14.CreateDate
			, HT14.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HT14.LastModifyUserID) LastModifyUserID, HT14.LastModifyDate
		FROM HT1400  HT14 WITH (NOLOCK)'
	SET @sSQL_Extend =N'
	  LEFT JOIN HT1403 HT43 WITH (NOLOCK) ON HT43.DivisionID IN (''@@@'', HT14.DivisionID ) AND HT43.EmployeeID = HT14.EmployeeID		
	  LEFT JOIN HT1402 HT42 WITH (NOLOCK) ON HT42.DivisionID IN (''@@@'', HT14.DivisionID ) AND HT42.EmployeeID = HT14.EmployeeID		
	  LEFT JOIN HT0099 HT91 WITH (NOLOCK) ON HT91.ID = HT14.IsMale AND HT91.CodeMaster = ''IsMale'' AND HT91.Disabled = 0
	  LEFT JOIN AT1001 AT01 WITH (NOLOCK) ON AT01.DivisionID IN (''@@@'', HT14.DivisionID ) AND AT01.CountryID = HT14.CountryID 
	  LEFT JOIN HT1001 HT01 WITH (NOLOCK) ON HT01.DivisionID IN (''@@@'', HT14.DivisionID ) AND HT01.EthnicID = HT14.EthnicID
	  LEFT JOIN HT1002 HT02 WITH (NOLOCK) ON HT02.DivisionID IN (''@@@'', HT14.DivisionID ) AND HT02.ReligionID = HT14.ReligionID
	  LEFT JOIN HT0099 HT92 WITH (NOLOCK) ON HT92.ID = HT43.EmployeeStatus AND HT92.CodeMaster = ''EmployeeStatus''
	  LEFT JOIN HT1102 HT12 WITH (NOLOCK) ON HT12.DivisionID IN (''@@@'', HT14.DivisionID ) AND HT12.DutyID = HT43.DutyID
	  LEFT JOIN OOT1000 OT01 WITH (NOLOCK) ON OT01.DivisionID IN (''@@@'', HT14.DivisionID ) AND  OT01.AbsentTypeID = HT43.AbsentReason 
	  LEFT JOIN HT0099 HT93 WITH (NOLOCK) ON HT93.ID = HT42.HospitalID AND HT93.CodeMaster = ''HospitalID''
	  LEFT JOIN HT0099 HT94 WITH (NOLOCK) ON HT94.ID = HT42.BankID AND HT94.CodeMaster = ''BankID''
			
		WHERE HT14.DivisionID = '''+@DivisionID+''' 
		AND HT14.APK = '''+@APK+'''
		'
		
END

--IF  @IsMode = 1
--BEGIN
--	SET @TotalRow = 'COUNT(*) OVER ()'
--	SET @sSQL1 = 'OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
--			  FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
--	SET @OrderBy = 'HRMT1034.EducationFromDate'
--	SET @sSQL = N'
--	SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, 
--	HRMT1034.DivisionID, HRMT1034.EmployeeID, HRMT1034.EducationCenter, HRMT1034.EducationMajor, HRMT1034.EducationTypeID, HRMT1034.EducationFromDate, HRMT1034.Description, HRMT1034.EducationToDate, HRMT1034.Notes
--	FROM HRMT1034
--	WHERE HRMT1034.DivisionID = '''+@DivisionID+'''
--	AND CAST(HRMT1034.EmployeeID AS VARCHAR(250)) = '''+@APK+'''
--'
--END

--IF  @IsMode = 2
--BEGIN 
--	SET @TotalRow = 'COUNT(*) OVER ()'
--	SET @sSQL1 = 'OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
--			  FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
--	SET @OrderBy = 'HRMT2213.FromDate'
--	SET  @sSQL = N'
--		SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, 
--		HRMT2213.DivisionID, HRMT2213.EmployeeID, HRMT2213.CompanyName, HRMT2213.CompanyAddress, HRMT2213.CountryID, AT1001.CountryName, HRMT2213.FromDate,
--		HRMT2213.ToDate, HRMT2213.Duty, HRMT2213.Reason, HRMT2213.Notess
--		FROM HRMT2213
--		LEFT JOIN AT1001 WITH (NOLOCK) ON AT1001.CountryID = HRMT2213.CountryID 
--		WHERE HRMT2213.DivisionID = '''+@DivisionID+'''
--		AND CAST(HRMT2213.EmployeeID AS VARCHAR(250)) = '''+@APK+'''
--	'
--END
Print (@sSQL)
Print (@sSQL_Extend)
EXEC (@sSQL+@sSQL_Extend)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
