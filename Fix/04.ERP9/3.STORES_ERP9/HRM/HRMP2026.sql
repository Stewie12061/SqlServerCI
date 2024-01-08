IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2026]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2026]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





	
-- <Summary>
---- Load phiếu in Đợt tuyển dụng(HRMF2020)
---- Tham khảo store HRMP2024:Load tab thông tin tuyển dụng của đợt tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phương Thảo on 31/07/2023
----Updated by: Phương Thảo on 10/03/2023 --- Cải tiến load đầy đủ thông tin đợt tuyển dụng
/*-- <Example>
---- exec HRMP2026 @DivisionID=N'BBA-SI',@APK=N'c811591c-0fb4-4b86-8aff-0a2fb55642fa',@IsMode=N'0'
----*/


CREATE PROCEDURE [dbo].[HRMP2026] 
				@DivisionID AS NVARCHAR(50),
				@APK AS NVARCHAR(4000),
				@IsMode INT
AS

DECLARE @sSQL NVARCHAR(MAX) ='',
		@sSQL1 NVARCHAR(MAX) ='',
		@sSQL2 NVARCHAR(MAX) ='',
		@sSQL3 NVARCHAR(MAX) ='',
		@sSQL4 NVARCHAR(MAX) ='',
		@sWhere NVARCHAR(MAX) = N'', 
		@sWhere1 NVARCHAR(MAX) = N''
SET @sWhere = @sWhere + N' HRMT1020.DivisionID = '''+@DivisionID+''' AND HRMT1020.Disabled = 0 '
SET @sWhere1 = @sWhere1 + N' HRMT2020.DivisionID = '''+@DivisionID+''''
IF @IsMode = 0 
BEGIN
	-- Lấy chi phí định biên(VND)theo phòng ban 
SET @sSQL = @sSQL + N'
	SELECT HRMT1020.DepartmentID
			, SUM(HRMT1020.CostBoundary) AS CostBoundary
	INTO #HRMP2024_Boundary_Cost 
	FROM HRMT1020 WITH (NOLOCK) 
	WHERE 
		 ' + @sWhere + '
	GROUP BY HRMT1020.DepartmentID
	'
	-- Lấy chi phí hiện có(VND) theo phòng ban 
SET @sSQL1 = @sSQL1 + N'
	SELECT HRMT2020.DepartmentID
			, SUM(ISNULL(HRMT2020.Cost, 0)) AS ActualCost
	INTO #HRMP2024_Actual_Cost
	FROM HRMT2020 WITH (NOLOCK) 
	WHERE 
		' + @sWhere1 + '
	GROUP BY HRMT2020.DepartmentID
'

	-- Lấy số lượng định biên theo phòng ban và vị trí 
SET @sSQL2 = @sSQL2 + N'SELECT HRMT1020.DepartmentID
			, HRMT1021.DutyID
			, SUM(HRMT1021.QuantityBoundary) AS QuantityBoundary
	INTO #HRMP2024_Boundary_Quantity 
	FROM HRMT1020 WITH (NOLOCK) 
	INNER JOIN HRMT1021 WITH (NOLOCK) ON HRMT1020.DivisionID = HRMT1021.DivisionID 
											AND HRMT1020.BoundaryID = HRMT1021.BoundaryID
	WHERE 
		' + @sWhere + '
		
	GROUP BY HRMT1020.DepartmentID
			, HRMT1021.DutyID
'
	-- Lấy số lượng hiện có  theo phòng ban và vị trí
SET @sSQL3 = @sSQL3 + N'
	SELECT HRMT2020.DepartmentID
			, HRMT2020.DutyID
			, SUM(ISNULL(HRMT2020.RecruitQuantity, 0)) AS ActualQuantity
	INTO #HRMP2024_Actual_Quantity
	FROM HRMT2020 WITH (NOLOCK) 
	WHERE 
		' + @sWhere1 + '
	GROUP BY HRMT2020.DepartmentID
			, HRMT2020.DutyID
'
	-- Lấy dữ liệu phiếu in đợt tuyển dụng
SET @sSQL4 = N'----Load form HRMF2020
	SELECT 
	  HRMT2020.RecruitPeriodID
	, HRMT2020.RecruitPeriodName
	, HRMT2000.Description AS RecruitPlanName
	, HRMT2020.DepartmentID
	, AT1102.DepartmentName AS DepartmentName
	, HRMT2020.DutyID
	, HT1102.DutyName
	, HRMT2020.PeriodFromDate
	, HRMT2020.PeriodToDate
	, HRMT2020.ReceiveFromDate
	, HRMT2020.ReceiveToDate
	, HRMT2020.RecruitQuantity
	, #Temp1.ActualCost
	, #Temp1.CostBoundary
	, HRMT2020.WorkPlace
	, HT09.Description AS WorkType
	, HRMT2020.RequireDate
	, HRMT2020.Cost
	, #Temp1.ActualQuantity
	, #Temp1.QuantityBoundary
	, HRMT2020.Note
	FROM HRMT2020 WITH (NOLOCK)
			LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT2020.DepartmentID = AT1102.DepartmentID
			LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT2020.DivisionID = HT1102.DivisionID AND HRMT2020.DutyID = HT1102.DutyID
			LEFT JOIN HRMT2000 WITH (NOLOCK) ON HRMT2020.DivisionID = HRMT2000.DivisionID AND HRMT2020.RecruitPlanID = HRMT2000.RecruitPlanID
			LEFT JOIN (
						SELECT T1.DepartmentID
								, #Temp.DutyID
								, SUM(T1.CostBoundary) AS CostBoundary
								, #Temp.QuantityBoundary
								, SUM(T2.ActualCost) AS ActualCost
								, #Temp.ActualQuantity
						FROM #HRMP2024_Boundary_Cost T1
							LEFT JOIN #HRMP2024_Actual_Cost T2 ON T1.DepartmentID = T2.DepartmentID 
							LEFT JOIN (
										SELECT T1.DepartmentID
										, T1.DutyID
										, SUM(T1.QuantityBoundary) AS QuantityBoundary
										, SUM(T2.ActualQuantity) AS ActualQuantity
										FROM #HRMP2024_Boundary_Quantity T1
											LEFT JOIN #HRMP2024_Actual_Quantity T2 ON T1.DepartmentID = T2.DepartmentID AND T1.DutyID = T2.DutyID
										GROUP BY T1.DepartmentID, T1.DutyID
									  ) AS #Temp ON T1.DepartmentID = #Temp.DepartmentID 
						GROUP BY T1.DepartmentID
								, #Temp.DutyID
								, #Temp.QuantityBoundary
								, #Temp.ActualQuantity
					  ) AS #Temp1 ON HRMT2020.DepartmentID = #Temp1.DepartmentID 
								  AND HRMT2020.DutyID = #Temp1.DutyID
			
			LEFT JOIN HT0099 HT09 WITH (NOLOCK) ON HRMT2020.WorkType = HT09.ID AND HT09.CodeMaster = ''WorkType''
	WHERE HRMT2020.APK = '''+ @APK +'''
	'
END
----Lấy dữ liệu tab yêu cầu tuyển dụng
IF @IsMode = 1
BEGIN
SET @sSQL4 =N'----Lấy dữ liệu tab yêu cầu tuyển dụng
SELECT HRMT2024.APK, HRMT2024.DivisionID,  HRMT2020.DutyID, HT1102.DutyName,
 HT99.Description AS Gender, HRMT2024.FromAge, HRMT2024.ToAge, HRMT2024.Experience, HT1005.EducationLevelName AS EducationLevelName, HRMT2024.Appearance,
 HRMT2024.FromSalary, HRMT2024.ToSalary, HRMT2024.WorkDescription, HT16A.LanguageName Language01Name, HT16B.LanguageName Language02Name, HT16C.LanguageName Language03Name,
 HT17A.LanguageLevelName LanguageLevel01Name, HT17B.LanguageLevelName LanguageLevel02Name, HT17C.LanguageLevelName LanguageLevel03Name, HRMT2024.IsInformatics,
 HRMT2024.InformaticsLevel, HRMT2024.IsCreativeness, HRMT2024.Creativeness, HRMT2024.IsProblemSolving, HRMT2024.ProblemSolving, HRMT2024.IsPrsentation,
 HRMT2024.Prsentation, HRMT2024.IsCommunication, HRMT2024.Communication, HRMT2024.Height, HRMT2024.Weight, HRMT2024.HealthStatus, HRMT2024.Notes
 FROM HRMT2020 WITH (NOLOCK)
 left JOIN HRMT2024 WITH (NOLOCK) ON HRMT2024.DivisionID = HRMT2020.DivisionID AND TRY_CAST(HRMT2024.RecruitPeriodID AS uniqueidentifier) = HRMT2020.APK
 LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT2024.DivisionID = HT1102.DivisionID AND HRMT2020.DutyID = HT1102.DutyID
 LEFT JOIN HT0099 HT99 WITH (NOLOCK) ON HRMT2024.Gender = HT99.ID AND HT99.CodeMaster = ''Gender''
 LEFT JOIN HT1005 WITH (NOLOCK) ON HRMT2024.DivisionID = HT1005.DivisionID AND HRMT2024.EducationLevelID = HT1005.EducationLevelID
 LEFT JOIN HT1006 HT16A WITH (NOLOCK) ON HRMT2024.DivisionID = HT16A.DivisionID AND HRMT2024.Language1ID = HT16A.LanguageID
 LEFT JOIN HT1006 HT16B WITH (NOLOCK) ON HRMT2024.DivisionID = HT16B.DivisionID AND HRMT2024.Language2ID = HT16B.LanguageID
 LEFT JOIN HT1006 HT16C WITH (NOLOCK) ON HRMT2024.DivisionID = HT16C.DivisionID AND HRMT2024.Language3ID = HT16C.LanguageID
 LEFT JOIN HT1007 HT17A WITH (NOLOCK) ON HRMT2024.DivisionID = HT17A.DivisionID AND HRMT2024.LanguageLevel1ID = HT17A.LanguageLevelID
 LEFT JOIN HT1007 HT17B WITH (NOLOCK) ON HRMT2024.DivisionID = HT17B.DivisionID AND HRMT2024.LanguageLevel2ID = HT17B.LanguageLevelID
 LEFT JOIN HT1007 HT17C WITH (NOLOCK) ON HRMT2024.DivisionID = HT17C.DivisionID AND HRMT2024.LanguageLevel3ID = HT17C.LanguageLevelID
 WHERE HRMT2020.APK = '''+ @APK +'''
'
END
----Lấy dữ liệu tab phỏng vấn
IF @IsMode = 2
BEGIN

SET @sSQL4 =N'----Lấy dữ liệu tab phỏng vấn
	SELECT DISTINCT
		         T21.InterviewAddress,
		         T21.InterviewTypeID,
		         T10.InterviewTypeName,
		         T21.InterviewLevel,
		         T22.TotalInterviewer,
		         Temp.InterviewerName
	FROM dbo.HRMT2021 T21 WITH (NOLOCK)
		INNER JOIN HRMT2020 T20 WITH (NOLOCK) ON T21.DivisionID IN (T20.DivisionID, ''@@@'') AND TRY_CAST(T21.RecruitPeriodID AS UNIQUEIDENTIFIER) = T20.APK
		INNER JOIN HRMT2022 T22 WITH (NOLOCK) ON T22.DivisionID IN (T20.DivisionID, ''@@@'') AND TRY_CAST(T22.RecruitPeriodID AS UNIQUEIDENTIFIER) = T20.APK AND T21.InterviewLevel = T22.InterviewLevel
	LEFT JOIN (
		SELECT
			T1.InterviewLevel,
			T1.TotalInterviewer,
			STRING_AGG(LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HT14.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HT14.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT14.FirstName,''''))),''  '','' ''))), '', '') AS InterviewerName
		FROM HRMT2022 T1 WITH (NOLOCK)
			LEFT JOIN HRMT2020 WITH (NOLOCK) ON HRMT2020.DivisionID IN (T1.DivisionID, ''@@@'') AND HRMT2020.RecruitPeriodID = T1.RecruitPeriodID
			LEFT JOIN HT1400 HT14 ON HT14.DivisionID = T1.DivisionID AND HT14.EmployeeID = T1.InterviewerID
		WHERE T1.DivisionID = '''+@DivisionID+'''AND (T1.RecruitPeriodID = '''+@APK+''' OR HRMT2020.APK = TRY_CAST('''+@APK+''' AS UNIQUEIDENTIFIER))
		GROUP BY T1.InterviewLevel, T1.TotalInterviewer
	) AS Temp ON T21.InterviewLevel = Temp.InterviewLevel
	LEFT JOIN HRMT1010 T10 WITH (NOLOCK) ON T10.DivisionID IN (T21.DivisionID, ''@@@'') AND T10.InterviewTypeID = T21.InterviewTypeID
	WHERE T20.APK = '''+@APK+''';'
END
----Lấy dữ liệu tab chi phí
IF @IsMode = 3
BEGIN
SET @sSQL4 =N'----Lấy dữ liệu tab chi phí
SELECT HRMT2023.APK, HRMT2023.DivisionID, HRMT2023.RecruitPeriodID, HRMT2023.Content, HRMT2023.Cost, HRMT2023.Notes 
FROM HRMT2023 WITH (NOLOCK)
LEFT JOIN HRMT2020 WITH(NOLOCK) ON HRMT2020.DivisionID = HRMT2023.DivisionID AND HRMT2020.RecruitPeriodID = HRMT2023.RecruitPeriodID
WHERE HRMT2023.DivisionID = '''+@DivisionID+''' AND (HRMT2023.RecruitPeriodID = '''+@APK+''' OR HRMT2020.APK = TRY_CAST( '''+@APK+''' AS UNIQUEIDENTIFIER))
ORDER BY HRMT2023.Content'

END





PRINT @sSQL 
PRINT @sSQL1 
PRINT @sSQL2 
PRINT @sSQL3 
PRINT @sSQL4 
EXEC (@sSQL+@sSQL1+@sSQL2+@sSQL3+@sSQL4)








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
