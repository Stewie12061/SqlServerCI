IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'KPIP20009') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE KPIP20009
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Form KPIF2005 Xem chi tiết kết quả thực hiện KPI
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
--- Created on 25/02/2019 by Bảo Anh
--- Modified on 11/10/2022 by Nhựt Trường: [2022/07/IS/0030] - Bổ sung trường Tần suất đo - FrequencyName.
-- <Example> EXEC KPIP20009 'NTY','DDB66241-3978-4246-B25B-7357EA98FF3A',0,1,20

CREATE PROCEDURE KPIP20009
( 
  @DivisionID VARCHAR(50),  
  @APK VARCHAR(50),
  @Mode TINYINT,		--- 0: load master, 1: load detail
  @PageNumber INT,
  @PageSize INT
)

AS 

IF @Mode = 0
BEGIN
	SELECT M.APK
	, M.DivisionID
	, M.EmployeeID
	, LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(D5.LastName,'')))+ ' ' + LTRIM(RTRIM(ISNULL(D5.MiddleName,''))) + ' ' + LTRIM(RTRIM(ISNULL(D5.FirstName,''))),' ',' '))) AS EmployeeName
	, D4.EvaluationPhaseName
	, D4.FromDate
	, D4.ToDate
	, M.EvaluationSetID
	, D9.EvaluationSetName
	, D1.DepartmentName
	, D2.DutyName
	, D3.TitleName
	, Ltrim(RTrim(isnull(D6.LastName,'')))+ ' ' + LTrim(RTrim(isnull(D6.MiddleName,''))) + ' ' + LTrim(RTrim(Isnull(D6.FirstName,''))) AS ConfirmUserName
	, D8.DutyID AS ConfirmDutyID
	, D7.DutyName as ConfirmDutyName
	, M.TotalPerformPoint
	, M.TotalPerformPercent
	, M.CreateUserID +'_'+ Ltrim(RTrim(isnull(A1.LastName,'')))+ ' ' + LTrim(RTrim(isnull(A1.MiddleName,''))) + ' ' + LTrim(RTrim(Isnull(A1.FirstName,''))) as CreateUserID
	, M.CreateDate
	, M.LastModifyUserID +'_'+ Ltrim(RTrim(isnull(A3.LastName,'')))+ ' ' + LTrim(RTrim(isnull(A3.MiddleName,''))) + ' ' + LTrim(RTrim(Isnull(A3.FirstName,''))) as LastModifyUserID
	, M.LastModifyDate, 34 as RelatedToTypeID
	FROM KPIT20003 M WITH (NOLOCK)
	LEFT JOIN AT1102 D1 WITH (NOLOCK) on M.DepartmentID = D1.DepartmentID
	LEFT JOIN HT1102 D2 WITH (NOLOCK) on M.DutyID = D2.DutyID
	LEFT JOIN HT1106 D3 WITH (NOLOCK) on M.TitleID = D3.TitleID
	LEFT JOIN KPIT10601 D4 WITH (NOLOCK) on M.EvaluationPhaseID = D4.EvaluationPhaseID
	LEFT JOIN KPIT10701 D9 WITH (NOLOCK) on M.EvaluationSetID = D9.EvaluationSetID
	LEFT JOIN HT1400 D5 WITH (NOLOCK) on M.EmployeeID = D5.EmployeeID
	LEFT JOIN HT1400 D6 WITH (NOLOCK) on M.ConfirmUserID = D6.EmployeeID
	LEFT JOIN HT1403 D8 WITH (NOLOCK) on M.ConfirmUserID = D8.EmployeeID
	LEFT JOIN HT1102 D7 WITH (NOLOCK) on D8.DutyID = D7.DutyID
	LEFT JOIN HT1400 A1 With (NOLOCK) on A1.EmployeeID =  M.CreateUserID 
	LEFT JOIN HT1400 A3 With (NOLOCK) on A3.EmployeeID =  M.LastModifyUserID
	WHERE M.DivisionID = @DivisionID AND M.APK = @APK
END

ELSE
BEGIN
	SELECT ROW_NUMBER() OVER (ORDER BY D1.OrderNo, D6.OrderNo) AS RowNum, COUNT(*) OVER () AS TotalRow
	, M.APK 
	, M.APKMaster
	, M.DivisionID
	, M.TargetsID
	, M.TargetsName
	, M.TargetsGroupID, Cast(D1.OrderNo as varchar(200)) + ' - ' + D1.TargetsGroupName as TargetsGroupName, M.TargetsGroupPercentage
	, M.UnitKpiID, D2.UnitKpiName
	, M.FormulaName
	, D5.Description as FrequencyName
	, M.TargetsPercentage
	, M.Revenue
	, M.GoalLimit
	, M.Benchmark
	, M.PerformTotal
	, M.PerformPointTotal
	, M.PerformPercent
	, M.DeleteFlg
	, M.OrderNo
	FROM KPIT20004 M WITH (NOLOCK)
	LEFT JOIN KPIT10101 D1 WITH (NOLOCK) ON M.TargetsGroupID = D1.TargetsGroupID
	LEFT JOIN KPIT10401 D2 WITH (NOLOCK) ON M.UnitKpiID = D2.UnitKpiID
	LEFT JOIN AT0099 D5 WITH (NOLOCK) ON M.FrequencyID = D5.ID and D5.CodeMaster = 'AT00000042'
	LEFT JOIN KPIT10501 D6 WITH (NOLOCK) ON M.TargetsID = D6.TargetsID
	WHERE M.DivisionID = @DivisionID AND M.APKMaster = @APK and M.DeleteFlg = 0
	ORDER BY D1.OrderNo, D6.OrderNo
	
	OFFSET (@PageNumber-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
