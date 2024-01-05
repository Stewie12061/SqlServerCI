IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'KPIP20004') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE KPIP20004
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load chi tiết chỉ tiêu của bảng đánh giá ở màn hình xem chi tiết KPIF2002
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created om 21/02/2019 by Bảo Anh
--- Modified on
-- <Example> EXEC KPIP20004 @DivisionID=N'NTY',@APK='2F6AD2D8-7E35-40F2-B863-C5B7291D28FD',@PageNumber=1,@PageSize=50

CREATE PROCEDURE KPIP20004
(
	  @DivisionID VARCHAR(50),  
	  @APK VARCHAR(50),
	  @PageNumber INT,
	  @PageSize INT
)
AS

DECLARE @KPIWarningMarks INT

SELECT @KPIWarningMarks = ISNULL(KPIWarningMarks,0)	FROM HT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID
		
SELECT ROW_NUMBER() OVER (ORDER BY D1.OrderNo, D6.OrderNo) AS RowNum, COUNT(*) OVER () AS TotalRow
, M.APK 
, M.APKMaster
, M.DivisionID
, M.TargetsID
, M.TargetsName
, M.TargetsGroupID, Cast(D1.OrderNo as varchar(200)) + ' - ' + D1.TargetsGroupName as TargetsGroupName, M.TargetsGroupPercentage
, M.UnitKpiID, D2.UnitKpiName
, M.FormulaName
, M.FrequencyID, D5.Description as FrequencyName
, M.SourceID, D3.SourceName
, M.Note
, M.Categorize, D4.Description as CategorizeName
, M.TargetsPercentage
, M.Revenue
, M.GoalLimit
, M.Benchmark
, M.Perform
, M.PerformPoint
, M.Reevaluated
, M.ReevaluatedPoint
, M.UnifiedPoint
, M.DeleteFlg
, M.OrderNo
, M.CreateUserID
, M.CreateDate
, M.LastModifyUserID
, M.LastModifyDate
, M.ReevaluatedNote
, (CASE WHEN @KPIWarningMarks > 0 AND M.Reevaluated IS NOT NULL AND ABS(M.PerformPoint - M.ReevaluatedPoint) > @KPIWarningMarks THEN 1 ELSE 0 END) AS IsColor
From KPIT20002 M WITH (NOLOCK) LEFT JOIN KPIT10101 D1 WITH (NOLOCK) ON M.TargetsGroupID = D1.TargetsGroupID
LEFT JOIN KPIT10401 D2 WITH (NOLOCK) ON M.UnitKpiID = D2.UnitKpiID
LEFT JOIN KPIT10301 D3 WITH (NOLOCK) ON M.SourceID = D3.SourceID
LEFT JOIN AT0099 D4 WITH (NOLOCK) ON M.Categorize = D4.ID and D4.CodeMaster = 'AT00000041'
LEFT JOIN AT0099 D5 WITH (NOLOCK) ON M.FrequencyID = D5.ID and D5.CodeMaster = 'AT00000042'
LEFT JOIN KPIT10501 D6 WITH (NOLOCK) ON M.TargetsID = D6.TargetsID
Where M.DivisionID = @DivisionID AND M.APKMaster =@APK and M.DeleteFlg = 0
Order By  D1.OrderNo, D6.OrderNo
OFFSET  (@PageNumber-1) * @PageSize ROWS
FETCH NEXT @PageSize ROWS ONLY



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO