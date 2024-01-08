IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2005]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2005]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Kiểm tra định biên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 21/07/2017
---- Modified: Khả Vi on 26/12/2017: Sửa kiểm tra định biên cho đợt tuyển dụng 
/*-- <Example>
	HRMP2005 @DivisionID='MK',@UserID='000054', @XML = @XML, @ScreenID, @RecruitPlanID
----*/

CREATE PROCEDURE HRMP2005
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@XML XML,
	@ScreenID VARCHAR(50),
	@RecruitPlanID VARCHAR(50)
)
AS 

CREATE TABLE #TBL_Recruit (DepartmentID VARCHAR(50), DutyID VARCHAR(50), Quantity INT, Cost DECIMAL(18,8), FromDate DATETIME, ToDate DATETIME,
Status_Quantity TINYINT, Status_Cost TINYINT)

INSERT INTO #TBL_Recruit (DepartmentID, DutyID, Quantity, Cost, FromDate, ToDate)
SELECT X.Data.query('DepartmentID').value('.', 'NVARCHAR(50)') AS DepartmentID,
	   X.Data.query('DutyID').value('.', 'NVARCHAR(50)') AS DutyID,
	   (CASE WHEN X.Data.query('Quantity').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('Quantity').value('.', 'INT') END) AS Quantity,
	   (CASE WHEN X.Data.query('Cost').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('Cost').value('.', 'DECIMAL(28,8)') END) AS Cost,
	  (CASE WHEN X.Data.query('FromDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('FromDate').value('.', 'DATETIME') END) AS FromDate,
	  (CASE WHEN X.Data.query('ToDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('ToDate').value('.', 'DATETIME') END) AS ToDate
FROM @XML.nodes('//Data') AS X (Data)

DECLARE @ID VARCHAR(50),
		@DepartmentID VARCHAR(50),
		@DutyID VARCHAR(50),
		@Quantity INT,
		@Cost DECIMAL(28,8),
		@FromDate DATETIME,
		@ToDate DATETIME,
		@Quantity_DB INT,
		@Cost_DB DECIMAL(28,8),
		@Quantity_DTD INT,
		@Cost_DTD DECIMAL(28,8)

---Lấy thông tin từ định biên tuyển dụng
SELECT T1.DepartmentID, T2.DutyID, T1.CostBoundary, T2.QuantityBoundary, T3.Status_Quantity, T3.Status_Cost
INTO #Temp_Boundary
FROM HRMT1020 T1 WITH (NOLOCK)
LEFT JOIN HRMT1021 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.APK = T2.BoundaryID
INNER JOIN #TBL_Recruit T3 ON T1.DepartmentID = T3.DepartmentID AND T2.DutyID = T3.DutyID
AND (T3.FromDate Between T1.FromDate and T1.ToDate
	OR T3.ToDate Between T1.FromDate and T1.ToDate
	OR (T3.FromDate <= T1.FromDate AND T3.ToDate >= T1.ToDate))
WHERE T1.DivisionID = @DivisionID



IF @ScreenID = 'HRMF2001' ---Ke hoach tuyen dung
BEGIN
	---Lấy dữ liệu từ kế hoạch tuyển dụng
	SELECT T1.DepartmentID, T2.DutyID, SUM(T2.RecruitCost) AS Cost_KHTD, SUM(T2.Quantity) AS Quantity_KHTD
	INTO #Temp_KHTD
	FROM HRMT2000 T1 WITH (NOLOCK)
	LEFT JOIN HRMT2001 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.APK = T2.RecruitPlanID
	INNER JOIN #TBL_Recruit T3 ON T1.DepartmentID = T3.DepartmentID AND T2.DutyID = T3.DutyID
	AND (T3.FromDate Between T1.FromDate and T1.ToDate
		OR T3.ToDate Between T1.FromDate and T1.ToDate
		OR (T3.FromDate <= T1.FromDate AND T3.ToDate >= T1.ToDate))
	WHERE T1.DivisionID = @DivisionID
	AND T1.RecruitPlanID <> @RecruitPlanID AND ISNULL(T1.DeleteFlg,0) = 0 AND T1.Status = 1
	GROUP BY T1.DepartmentID, T2.DutyID
	

	-----Kiem tra vuot so luong dinh bien
	UPDATE 	T1
	SET T1.Status_Quantity = 1
	FROM #TBL_Recruit T1
	LEFT JOIN #Temp_Boundary T2 ON T1.DepartmentID = T2.DepartmentID AND T1.DutyID = T2.DutyID
	LEFT JOIN #Temp_KHTD T3 ON T1.DepartmentID = T3.DepartmentID AND T1.DutyID = T3.DutyID
	WHERE isnull(QuantityBoundary,0) - isnull(Quantity_KHTD,0) - Quantity < 0


	-----Kiem tra vuot chi phí dinh bien
	UPDATE 	T1
	SET T1.Status_Cost = 1
	FROM #TBL_Recruit T1
	LEFT JOIN #Temp_Boundary T2 ON T1.DepartmentID = T2.DepartmentID AND T1.DutyID = T2.DutyID
	LEFT JOIN #Temp_KHTD T3 ON T1.DepartmentID = T3.DepartmentID AND T1.DutyID = T3.DutyID
	WHERE isnull(CostBoundary,0) - isnull(Cost_KHTD,0) - isnull(Cost,0) < 0

	
	SELECT * FROM #TBL_Recruit
	WHERE ISNULL(Status_Quantity,0) <> 0 OR ISNULL(Status_Cost,0) <> 0
	
	DROP TABLE #TBL_Recruit
	DROP TABLE #Temp_Boundary
	DROP TABLE #Temp_KHTD

END
ELSE
IF @ScreenID = 'HRMF2021' ---Dot tuyen dung
BEGIN
	IF ISNULL(@RecruitPlanID,'') <> ''
	BEGIN
		SELECT T1.DepartmentID, T2.DutyID, SUM(T2.RecruitCost) AS Cost_KHTD, SUM(T2.Quantity) AS Quantity_KHTD
		INTO #Temp_KHTD_HRMF2021
		FROM HRMT2000 T1 WITH (NOLOCK)
		LEFT JOIN HRMT2001 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.APK = T2.RecruitPlanID
		INNER JOIN #TBL_Recruit T3 ON T1.DepartmentID = T3.DepartmentID AND T2.DutyID = T3.DutyID
		AND (T3.FromDate Between T1.FromDate and T1.ToDate
			OR T3.ToDate Between T1.FromDate and T1.ToDate
			OR (T3.FromDate <= T1.FromDate AND T3.ToDate >= T1.ToDate))
		WHERE T1.DivisionID = @DivisionID
		AND T1.RecruitPlanID = @RecruitPlanID
		GROUP BY T1.DepartmentID, T2.DutyID

		UPDATE 	T1
		SET T1.Status_Quantity = 1
		FROM #TBL_Recruit T1
		LEFT JOIN #Temp_KHTD_HRMF2021 T2 ON T1.DepartmentID = T2.DepartmentID AND T1.DutyID = T2.DutyID
		WHERE Quantity_KHTD - Quantity < 0
		
		UPDATE 	T1
		SET T1.Status_Cost = 1
		FROM #TBL_Recruit T1
		LEFT JOIN #Temp_KHTD_HRMF2021 T2 ON T1.DepartmentID = T2.DepartmentID AND T1.DutyID = T2.DutyID
		WHERE Cost_KHTD - Cost < 0

		SELECT * FROM #TBL_Recruit
		WHERE ISNULL(Status_Quantity,0) <> 0 OR ISNULL(Status_Cost,0) <> 0
		
		DROP TABLE #TBL_Recruit
		DROP TABLE #Temp_KHTD_HRMF2021
	END
	ELSE --ISNULL(@RecruitPlanID,'') = ''
	BEGIN	

		---Lấy dữ liệu từ đợt tuyển dụng
		SELECT T1.DepartmentID, T1.DutyID, SUM(T1.Cost) AS Cost_DTD, SUM(T1.RecruitQuantity) AS Quantity_DTD
		INTO #Temp_DTD
		FROM HRMT2020 T1 WITH (NOLOCK)
		INNER JOIN #TBL_Recruit T2 ON T1.DepartmentID = T2.DepartmentID AND T1.DutyID = T2.DutyID
		AND (T2.FromDate Between T1.PeriodFromDate and T1.PeriodToDate
			OR T2.ToDate Between T1.PeriodFromDate and T1.PeriodToDate
			OR (T2.FromDate <= T1.PeriodFromDate AND T2.ToDate >= T1.PeriodToDate))
		WHERE T1.DivisionID = @DivisionID
		AND T1.RecruitPeriodID <> @RecruitPlanID
		GROUP BY T1.DepartmentID, T1.DutyID

		UPDATE 	T1
		SET T1.Status_Quantity = 1
		FROM #Temp_Boundary T1
		LEFT JOIN #Temp_DTD T2 ON T1.DepartmentID = T2.DepartmentID AND T1.DutyID = T2.DutyID
		WHERE QuantityBoundary - Quantity_DTD < 0
		
		UPDATE 	T1
		SET T1.Status_Cost = 1
		FROM #Temp_Boundary T1
		LEFT JOIN #Temp_DTD T2 ON T1.DepartmentID = T2.DepartmentID AND T1.DutyID = T2.DutyID
		WHERE CostBoundary - Cost_DTD < 0

		SELECT * FROM #Temp_Boundary
		WHERE ISNULL(Status_Quantity,0) <> 0 OR ISNULL(Status_Cost,0) <> 0
		
		DROP TABLE #TBL_Recruit
		DROP TABLE #Temp_DTD
	
	END
END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
