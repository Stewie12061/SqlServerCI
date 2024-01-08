IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Kiểm tra trùng thời gian định biên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 21/07/2017
/*-- <Example>
	HRMP2002 @DivisionID='MK',@UserID='000054', @XML = @XML
----*/

CREATE PROCEDURE HRMP2002
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@XML XML
)
AS 

CREATE TABLE #TBL_RecruitPlanID (RecruitPlanID VARCHAR(50), DepartmentID VARCHAR(50), DutyID VARCHAR(50), FromDate DATETIME, ToDate DATETIME, MessageID VARCHAR(50))

INSERT INTO #TBL_RecruitPlanID (RecruitPlanID, DepartmentID, DutyID, FromDate, ToDate)
SELECT X.Data.query('RecruitPlanID').value('.', 'NVARCHAR(50)') AS RecruitPlanID,
	   X.Data.query('DepartmentID').value('.', 'NVARCHAR(50)') AS DepartmentID,
	   X.Data.query('DutyID').value('.', 'NVARCHAR(50)') AS DutyID,
	  (CASE WHEN X.Data.query('FromDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('FromDate').value('.', 'DATETIME') END) AS FromDate,
	  (CASE WHEN X.Data.query('ToDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('ToDate').value('.', 'DATETIME') END) AS ToDate
FROM @XML.nodes('//Data') AS X (Data)

--select * from #TBL_RecruitPlanID

DECLARE @Cur CURSOR,
		@RecruitPlanID VARCHAR(50),
		@DepartmentID VARCHAR(50),
		@DutyID VARCHAR(50),
		@FromDate DATETIME,
		@ToDate DATETIME,
		@i INT
		
SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT RecruitPlanID, DepartmentID, DutyID, FromDate, ToDate FROM #TBL_RecruitPlanID

OPEN @Cur
FETCH NEXT FROM @Cur INTO @RecruitPlanID,@DepartmentID,@DutyID,@FromDate,@ToDate
WHILE @@FETCH_STATUS = 0
BEGIN
	
	IF NOT EXISTS (SELECT TOP 1 1 FROM HRMT2000 T1 WITH (NOLOCK)
				   LEFT JOIN HRMT2001 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.APK = T2.RecruitPlanID
				   WHERE T1.DivisionID = @DivisionID
				   AND T1.RecruitPlanID <> @RecruitPlanID AND IsNULL(T1.DeleteFlg,0) = 0 AND T1.Status = 1
				   AND T1.DepartmentID = @DepartmentID
				   AND T2.DutyID = @DutyID
				   AND (@FromDate Between T1.FromDate and T1.ToDate
						OR @ToDate Between T1.FromDate and T1.ToDate
						OR (@FromDate <= T1.FromDate AND @ToDate >= ToDate)) )
	BEGIN 
		DELETE #TBL_RecruitPlanID 
		WHERE RecruitPlanID = @RecruitPlanID
		AND DepartmentID = @DepartmentID
		AND DutyID = @DutyID
	END

FETCH NEXT FROM @Cur INTO @RecruitPlanID,@DepartmentID,@DutyID,@FromDate,@ToDate
END 
Close @Cur 

UPDATE #TBL_RecruitPlanID
SET MessageID = 'HRMFML000014'

SELECT * FROM #TBL_RecruitPlanID

DROP TABLE #TBL_RecruitPlanID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
