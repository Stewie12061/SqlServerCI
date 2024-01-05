IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2056]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2056]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load edit Quyết định tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Anh, Date: 19/12/2019
---- Modified on Huỳnh Thử Update câu query
---- Modified by Huỳnh Thử on 11/01/2021: Update câu query
-- <Example>
---- 
/*
   exec HRMP2056 'NTY', '4b9d0d76-178e-4de6-870e-2187da0da3f2'
*/

CREATE PROCEDURE HRMP2056
( 
	@DivisionID VARCHAR(50),
	@APK VARCHAR(50),
	@Mode TINYINT
)
AS
DECLARE @Cur CURSOR,
		@sSQL VARCHAR(MAX),
		@sSQL1 VARCHAR(MAX) = '',
		@sSQL2 VARCHAR(MAX) = '',
		@sSQLSL VARCHAR(MAX) = '',
		@sSQLJon VARCHAR(MAX) = '',
		@OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50) = '',
		@EmployeeID VARCHAR(50),
		@Date DATETIME,
		@i INT = 1, @s VARCHAR(2)

WHILE @i < 6
BEGIN
	IF @i < 10 
		SET @s = '0' + CONVERT(VARCHAR, @i)
	ELSE 
		SET @s = CONVERT(VARCHAR, @i)
	SET @sSQLSL= @sSQLSL+'
			, ApprovePerson'+@s+'ID, ApprovePerson'+@s+'Name, ApprovePerson'+@s+'Status, ApprovePerson'+@s+'StatusName, ApprovePerson'+@s+'Note'
	SET @sSQLJon = @sSQLJon+ '
			LEFT JOIN (SELECT ApprovePersonID ApprovePerson'+@s+'ID,OOT1.APKMaster,OOT1.DivisionID,OOT1.Status,
			LTRIM(RTRIM(ISNULL(HT14.LastName,'''')))
				+ '' '' + LTRIM(RTRIM(ISNULL(HT14.MiddleName,''''))) 
				+ '' '' + LTRIM(RTRIM(ISNULL(HT14.FirstName,''''))) AS ApprovePerson'+@s+'Name,
			OOT1.Status ApprovePerson'+@s+'Status, O99.Description ApprovePerson'+@s+'StatusName,
			OOT1.Note ApprovePerson'+@s+'Note
		FROM OOT9001 OOT1
			INNER JOIN HT1400 HT14 ON HT14.DivisionID=OOT1.DivisionID AND HT14.EmployeeID=OOT1.ApprovePersonID
			LEFT JOIN OOT0099 O99 ON O99.ID1 = ISNULL(OOT1.Status,0) AND O99.CodeMaster=''Status''
		WHERE OOT1.Level='+STR(@i)+'
		) APP'+@s+' ON APP'+@s+'.DivisionID = HRMT2050.DivisionID AND APP'+@s+'.APKMaster = H51.APKMaster'
	SET @i = @i + 1		
END	

IF @Mode = 0
	BEGIN
		--- Dataset 1: Trả ra master
		SET @sSQL = '
		SELECT	HRMT2050.APK, HRMT2050.APKMaster, HRMT2050.DivisionID, 
			HRMT2050.RecDecisionID, HRMT2050.RecDecisionNo, HRMT2050.Description, HRMT2050.DecisionDate,
			HRMT2050.CreateUserID +'' - ''+ (
					SELECT TOP 1 UserName 
					FROM AT1405 WITH (NOLOCK) 
					WHERE DivisionID = HRMT2050.DivisionID AND UserID = HRMT2050.CreateUserID
				) CreateUserID, 
			HRMT2050.CreateDate, 
			HRMT2050.LastModifyUserID +'' - ''+ (
					SELECT TOP 1 UserName 
					FROM AT1405 WITH (NOLOCK)
					WHERE DivisionID = HRMT2050.DivisionID AND UserID = HRMT2050.LastModifyUserID
				) LastModifyUserID, 
			HRMT2050.LastModifyDate ' + @sSQLSL + ''
		SET @sSQL1 = '
		FROM HRMT2050 HRMT2050 WITH (NOLOCK)
			LEFT JOIN HRMT2051 H51 WITH (NOLOCK) ON HRMT2050.DivisionID = H51.DivisionID 
				AND HRMT2050.RecDecisionID = H51.RecDecisionID
			LEFT JOIN OOT9001 O91 WITH (NOLOCK) ON H51.DivisionID = O91.DivisionID 
				AND H51.APKMaster = O91.APKMaster
			' + @sSQLJon + '
		WHERE HRMT2050.DivisionID = ''' + @DivisionID + '''
			AND HRMT2050.APK = ''' + @APK + ''' OR HRMT2050.RecDecisionID = ''' + @APK + '''
		GROUP BY HRMT2050.APK, HRMT2050.APKMaster, HRMT2050.DivisionID, 
			HRMT2050.RecDecisionID, HRMT2050.RecDecisionNo, HRMT2050.Description, HRMT2050.DecisionDate, 
			HRMT2050.CreateUserID, HRMT2050.CreateDate, HRMT2050.LastModifyUserID, HRMT2050.LastModifyDate
			' + @sSQLSL + '
		'
		--PRINT (@sSQL+@sSQL1)
		EXEC (@sSQL+@sSQL1)
	END
ELSE
	BEGIN
		--- Dataset 2: Trả ra detail
		SELECT HRMT2051.APK, HRMT2051.RecruitPeriodID, HRMT2020.DepartmentID, AT1102.DepartmentName, HRMT2020.DutyID, HT1102.DutyName, HRMT2051.CandidateID, HRMT2051.[Status], H09.Description AS StatusName,
			LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HRMT1030.LastName,'')))+ ' ' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName,''))) + ' ' + LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,''))),'  ',' '))) AS CandidateName,
			HRMT1030.Gender, H10.Description AS GenderName, HRMT1030.Birthday, IsSingle, CASE WHEN ISNULL(IsSingle,0) = 0 THEN N'Đã kết hôn' ELSE N'Độc thân' END AS MaterialStatus,
			HRMT1031.WorkType, H11.Description AS WorkTypeName, HRMT2040.RequireSalary, HRMT2040.DealSalary, HRMT2040.TrialFromDate, HRMT2040.TrialToDate,
			HRMT2051.ApproveLevel, HRMT2051.ApprovingLevel, HRMT2051.DivisionID,
			CASE WHEN O91.Level = 1 THEN ApprovePersonID ELSE '' END AS ApprovePerson01ID,
			CASE WHEN O91.Level = 2 THEN ApprovePersonID ELSE '' END AS ApprovePerson02ID,
			CASE WHEN O91.Level = 3 THEN ApprovePersonID ELSE '' END AS ApprovePerson03ID,
			CASE WHEN O91.Level = 4 THEN ApprovePersonID ELSE '' END AS ApprovePerson04ID,
			CASE WHEN O91.Level = 5 THEN ApprovePersonID ELSE '' END AS ApprovePerson05ID
		INTO #HRMT2051
		FROM HRMT2051 WITH (NOLOCK)
			LEFT JOIN HRMT2020 WITH (NOLOCK) ON HRMT2051.DivisionID = HRMT2020.DivisionID AND HRMT2051.RecruitPeriodID = HRMT2020.RecruitPeriodID
			LEFT JOIN HT0099 H09 WITH (NOLOCK) ON HRMT2051.Status = H09.ID AND H09.CodeMaster = 'RecruitStatus'
			LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT2020.DepartmentID = AT1102.DepartmentID
			LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT2020.DivisionID = HT1102.DivisionID AND HRMT2020.DutyID = HT1102.DutyID
			LEFT JOIN HRMT1030 WITH (NOLOCK) ON HRMT2051.DivisionID = HRMT1030.DivisionID AND HRMT2051.CandidateID = HRMT1030.CandidateID
			LEFT JOIN HT0099 H10 WITH (NOLOCK) ON HRMT1030.Gender = H10.ID AND H10.CodeMaster = 'Gender'
			LEFT JOIN HRMT1031 WITH (NOLOCK) ON HRMT1031.DivisionID = HRMT1030.DivisionID AND HRMT1031.CandidateID = HRMT1030.CandidateID
			LEFT JOIN HT0099 H11 WITH (NOLOCK) ON HRMT1031.WorkType = H11.ID AND H11.CodeMaster = 'WorkType'
			LEFT JOIN HRMT2040 WITH (NOLOCK) ON HRMT2051.DivisionID = HRMT2040.DivisionID AND HRMT2051.CandidateID = HRMT2040.CandidateID
			LEFT JOIN OOT9001 O91 WITH (NOLOCK) ON HRMT2051.DivisionID = O91.DivisionID AND HRMT2051.APKMaster = O91.APKMaster
			LEFT JOIN HRMT2050 WITH(NOLOCK) ON HRMT2050.DivisionID = HRMT2051.DivisionID  AND HRMT2050.RecDecisionID = HRMT2051.RecDecisionID
		WHERE  HRMT2051.DivisionID = @DivisionID
			AND HRMT2050.APK = @APK OR HRMT2050.RecDecisionID = @APK

		SELECT	APK, RecruitPeriodID, DepartmentID, DepartmentName, DutyID, DutyName, CandidateID, [Status], StatusName, CandidateName,
			Gender, GenderName, Birthday, IsSingle, MaterialStatus, WorkType, WorkTypeName, RequireSalary, DealSalary, TrialFromDate, TrialToDate,
			ApproveLevel, ApprovingLevel, DivisionID,
			MAX(ApprovePerson01ID) AS ApprovePerson01ID, MAX(ApprovePerson02ID) As ApprovePerson02ID,
			MAX(ApprovePerson03ID) AS ApprovePerson03ID, MAX(ApprovePerson04ID) AS ApprovePerson04ID, 
			MAX(ApprovePerson05ID) AS ApprovePerson05ID,
			MAX(ApprovePerson01Name) AS ApprovePerson01Name, MAX(ApprovePerson02Name) AS ApprovePerson02Name, 
			MAX(ApprovePerson03Name) AS ApprovePerson03Name, MAX(ApprovePerson04Name) AS ApprovePerson04Name, 
			MAX(ApprovePerson05Name) AS ApprovePerson05Name
		FROM
		(
			SELECT	H1.*,
					V1.FullName AS ApprovePerson01Name, V2.FullName AS ApprovePerson02Name, V3.FullName AS ApprovePerson03Name,
					V4.FullName AS ApprovePerson04Name, V5.FullName AS ApprovePerson05Name
			FROM #HRMT2051 H1
				LEFT JOIN HV1400 V1 ON V1.DivisionID = @DivisionID AND V1.EmployeeID = H1.ApprovePerson01ID
				LEFT JOIN HV1400 V2 ON V2.DivisionID = @DivisionID AND V2.EmployeeID = H1.ApprovePerson02ID
				LEFT JOIN HV1400 V3 ON V3.DivisionID = @DivisionID AND V3.EmployeeID = H1.ApprovePerson03ID
				LEFT JOIN HV1400 V4 ON V4.DivisionID = @DivisionID AND V4.EmployeeID = H1.ApprovePerson04ID
				LEFT JOIN HV1400 V5 ON V5.DivisionID = @DivisionID AND V5.EmployeeID = H1.ApprovePerson05ID
		) A
		GROUP BY APK, RecruitPeriodID, DepartmentID, DepartmentName, DutyID, DutyName, CandidateID, [Status], StatusName, CandidateName,
				Gender, GenderName, Birthday, IsSingle, MaterialStatus, WorkType, WorkTypeName, RequireSalary, DealSalary, TrialFromDate, TrialToDate,
				ApproveLevel, ApprovingLevel, DivisionID
		ORDER BY RecruitPeriodID, CandidateID
	END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
