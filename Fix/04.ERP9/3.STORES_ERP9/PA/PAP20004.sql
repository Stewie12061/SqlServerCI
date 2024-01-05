IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'PAP20004') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE PAP20004
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load chi tiết chỉ tiêu của bảng đánh giá ở màn hình xem chi tiết PAF2002
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created om 21/02/2019 by Bảo Anh
--- Modified on
-- <Example> EXEC PAP20004 @DivisionID=N'NTY',@APK='3F7B95B0-835C-4E39-AF83-40DDC063F81A',@PageNumber=1,@PageSize=50

CREATE PROCEDURE PAP20004
(
	  @DivisionID VARCHAR(50),  
	  @APK VARCHAR(50),
	  @PageNumber INT,
	  @PageSize INT
)
AS

DECLARE @AppraisalWarningMarks INT

SELECT @AppraisalWarningMarks = ISNULL(AppraisalWarningMarks,0)	FROM HT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID
		
SELECT ROW_NUMBER() OVER (ORDER BY  D1.OrderNo, P1.OrderNo DESC) AS RowNum, COUNT(*) OVER () AS TotalRow
, M.APK
, M.APKMaster
, M.DivisionID
, M.AppraisalID, M.AppraisalName
, M.AppraisalGroupID, Cast(D1.OrderNo as varchar(200)) + ' - ' + D1.TargetsGroupName as AppraisalGroupName, M.AppraisalGroupGoal
, M.LevelCritical, M.LevelStandardID
, M.Benchmark
, M.Perform
, M.PerformPoint
, M.Reevaluated
, M.ReevaluatedPoint
, M.UnifiedPoint
, M.Note
, M.EvidenceNote
, M.OrderNo
, M.DeleteFlg
, M.CreateUserID
, M.CreateDate
, M.LastModifyUserID
, M.LastModifyDate
, (CASE WHEN @AppraisalWarningMarks > 0 AND M.Reevaluated IS NOT NULL AND ABS(M.PerformPoint - M.ReevaluatedPoint) > @AppraisalWarningMarks THEN 1 ELSE 0 END) AS IsColor
From PAT20002 M  WITH (NOLOCK) LEFT JOIN KPIT10101 D1 WITH (NOLOCK) ON M.AppraisalGroupID = D1.TargetsGroupID
LEFT JOIN PAT10101 P1 WITH (NOLOCK) ON M.AppraisalID = P1.AppraisalID
Where M.APKMaster =@APK and M.DeleteFlg = 0
Order By D1.OrderNo, P1.OrderNo
OFFSET  (@PageNumber-1) * @PageSize ROWS
FETCH NEXT @PageSize ROWS ONLY



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO