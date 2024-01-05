IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP3020]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP3020]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In báo cáo kết quả thực hiện KPI (ERP 9.0)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
--- Created on 12/02/2019 by Bảo Anh
--- Updated on 10/10/2022 by Nhật Thanh: Chưa có kết quả tình hình thực hiện thì trả ra không để tránh lỗi null
--- Updated on 21/10/2022 by Xuân Nguyên: Bổ sung điều kiện khi lấy Revenue,GoalLimit
--- Updated on 15/12/2022 by Xuân Nguyên: Bổ sung điều kiện DeleteFlg để lấy lên phiếu chưa bị xóa
-- <Example>
---- EXEC HRMP3020 'NTVN0021','BDGHCNS2019','10/2017',''
/*-- <Example>

----*/

CREATE PROCEDURE HRMP3020
( 
	@EmployeeID VARCHAR(50),
	@EvaluationSetID VARCHAR(50),
	@DateName VARCHAR(50),
	@TargetsIDList VARCHAR(MAX)
)
AS 
DECLARE @sSQL VARCHAR (MAX)='',
		@sWhere VARCHAR(MAX)='',
		@APK VARCHAR(50),
		@APKEvaluationSetID VARCHAR(50),
		@DepartmentName NVARCHAR(250)

SET @sWhere = ''

IF ISNULL(@TargetsIDList,'') <> ''
BEGIN
	--SET @TargetsIDList = '''' + @TargetsIDList + ''''
	SET @sWhere = ' WHERE TargetsID IN (''' + @TargetsIDList + ''')'
END

SELECT @APK = APK FROM KPIT20003 WITH (NOLOCK) WHERE EvaluationSetID = @EvaluationSetID AND EmployeeID = @EmployeeID and DeleteFlg = 0
SELECT @APKEvaluationSetID = APK FROM KPIT10701 WITH (NOLOCK) WHERE EvaluationSetID = @EvaluationSetID
SELECT @DepartmentName = DepartmentName FROM HV1400 WHERE EmployeeID = @EmployeeID


if LEN(@DateName) <= 7
BEGIN
SELECT	K4.TargetsID, K4.TargetsName, K4.TargetsGroupID, K1.TargetsGroupName, K4.UnitKpiID, K3.UnitKpiName, 
--K4.Revenue,K4.GoalLimit,
Revenue = CASE WHEN K4.FrequencyID = 5 THEN K4.Revenue/12
			 WHEN K4.FrequencyID = 4 THEN K4.Revenue/3
			 WHEN K4.FrequencyID = 3 THEN K4.Revenue
			 WHEN K4.FrequencyID = 2 THEN K4.Revenue*4
			 WHEN K4.FrequencyID = 1 THEN K4.Revenue*(DAY(DATEADD(DD,-1,DATEADD(MM,DATEDIFF(MM,-1,CONVERT(VARCHAR(50), ('01/' + @DateName), 101)),0)))) 
			 END, 
GoalLimit =CASE WHEN K4.FrequencyID = 5 THEN K4.GoalLimit/12
			 WHEN K4.FrequencyID = 4 THEN K4.GoalLimit/3
			 WHEN K4.FrequencyID = 3 THEN K4.GoalLimit
			 WHEN K4.FrequencyID = 2 THEN K4.GoalLimit*4
			 WHEN K4.FrequencyID = 1 THEN K4.GoalLimit*(DAY(DATEADD(DD,-1,DATEADD(MM,DATEDIFF(MM,-1,CONVERT(VARCHAR, '01/' + @DateName, 101)),0)))) 
			 END,
		Perform = CASE WHEN K5.DateName1 = @DateName THEN ISNULL(Perform1,0)
			 WHEN K5.DateName2 = @DateName  THEN ISNULL(Perform2,0)
			 WHEN K5.DateName3 = @DateName  THEN ISNULL(Perform3,0)
			 WHEN K5.DateName4 = @DateName  THEN ISNULL(Perform4,0)
			 WHEN K5.DateName5 = @DateName  THEN ISNULL(Perform5,0)
			 WHEN K5.DateName6 = @DateName  THEN ISNULL(Perform6,0)
			 WHEN K5.DateName7 = @DateName  THEN ISNULL(Perform7,0)
			 WHEN K5.DateName8 = @DateName  THEN ISNULL(Perform8,0)
			 WHEN K5.DateName9 = @DateName  THEN ISNULL(Perform9,0)
			 WHEN K5.DateName10 =@DateName THEN ISNULL(Perform10,0)
			 WHEN K5.DateName11 =@DateName THEN ISNULL(Perform11,0)
			 WHEN K5.DateName12 =@DateName THEN ISNULL(Perform12,0)
			 WHEN K5.DateName13 =@DateName THEN ISNULL(Perform13,0)
			 WHEN K5.DateName14 =@DateName THEN ISNULL(Perform14,0)
			 WHEN K5.DateName15 =@DateName THEN ISNULL(Perform15,0)
			 ELSE 0 END,
		OrderNo = ROW_NUMBER() OVER(ORDER BY K1.OrderNo, K0.OrderNo),
		@DepartmentName AS DepartmentName, K2.FormulaName
INTO #K5
FROM KPIT20004 K4 WITH (NOLOCK)
INNER JOIN KPIT20005 K5 WITH (NOLOCK) ON K4.DivisionID = K5.DivisionID AND K4.APKMaster = K5.APKMaster AND K4.APK = K5.APKDetail
LEFT JOIN KPIT10101 K1 WITH (NOLOCK) on K4.TargetsGroupID = K1.TargetsGroupID
LEFT JOIN KPIT10501 K0 WITH (NOLOCK) on K4.TargetsID = K0.TargetsID
LEFT JOIN KPIT10401 K3 WITH (NOLOCK) on K4.UnitKpiID = K3.UnitKpiID
LEFT JOIN (SELECT * FROM KPIT10702 WITH (NOLOCK) WHERE APKMaster = @APKEvaluationSetID) K2 ON K4.TargetsID = K2.TargetsID
WHERE K4.APKMaster = @APK
SET @sSQL =@sSQL+ 'SELECT * FROM #K5' + @sWhere + ' ORDER BY OrderNo'
print (@sSQL)
EXEC(@sSQL)
END 
ELSE
BEGIN
SELECT	K4.TargetsID, K4.TargetsName, K4.TargetsGroupID, K1.TargetsGroupName, K4.UnitKpiID, K3.UnitKpiName, K4.Revenue,K4.GoalLimit,
		Perform = CASE WHEN K5.DateName1 = @DateName THEN ISNULL(Perform1,0)
			 WHEN K5.DateName2  = @DateName  THEN ISNULL(Perform2,0)
			 WHEN K5.DateName3  = @DateName  THEN ISNULL(Perform3,0)
			 WHEN K5.DateName4  = @DateName  THEN ISNULL(Perform4,0)
			 WHEN K5.DateName5  = @DateName  THEN ISNULL(Perform5,0)
			 WHEN K5.DateName6  = @DateName  THEN ISNULL(Perform6,0)
			 WHEN K5.DateName7  = @DateName  THEN ISNULL(Perform7,0)
			 WHEN K5.DateName8  = @DateName  THEN ISNULL(Perform8,0)
			 WHEN K5.DateName9  = @DateName  THEN ISNULL(Perform9,0)
			 WHEN K5.DateName10 = @DateName THEN ISNULL(Perform10,0)
			 WHEN K5.DateName11 = @DateName THEN ISNULL(Perform11,0)
			 WHEN K5.DateName12 = @DateName THEN ISNULL(Perform12,0)
			 WHEN K5.DateName13 = @DateName THEN ISNULL(Perform13,0)
			 WHEN K5.DateName14 = @DateName THEN ISNULL(Perform14,0)
			 WHEN K5.DateName15 = @DateName THEN ISNULL(Perform15,0)
			 ELSE 0 END,
		OrderNo = ROW_NUMBER() OVER(ORDER BY K1.OrderNo, K0.OrderNo),
		@DepartmentName AS DepartmentName, K2.FormulaName
INTO #K4
FROM KPIT20004 K4 WITH (NOLOCK)
INNER JOIN KPIT20005 K5 WITH (NOLOCK) ON K4.DivisionID = K5.DivisionID AND K4.APKMaster = K5.APKMaster AND K4.APK = K5.APKDetail
LEFT JOIN KPIT10101 K1 WITH (NOLOCK) on K4.TargetsGroupID = K1.TargetsGroupID
LEFT JOIN KPIT10501 K0 WITH (NOLOCK) on K4.TargetsID = K0.TargetsID
LEFT JOIN KPIT10401 K3 WITH (NOLOCK) on K4.UnitKpiID = K3.UnitKpiID
LEFT JOIN (SELECT * FROM KPIT10702 WITH (NOLOCK) WHERE APKMaster = @APKEvaluationSetID) K2 ON K4.TargetsID = K2.TargetsID
WHERE K4.APKMaster = @APK


SET @sSQL = 'SELECT * FROM #K4' + @sWhere + ' ORDER BY OrderNo'
print (@sSQL)
EXEC(@sSQL)
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
