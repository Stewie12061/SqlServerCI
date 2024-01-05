IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2024]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2024]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load tab thông tin tuyển dụng của đợt tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi, Date: 28/12/2017
----Modified by Văn Tài	on	17/05/2021: Format SQL chưa thay đổi về code.
----Modified by Lê Hoàng on	04/06/2021: @RecruitPeriodID được truyền vào có trường hợp là HRMT2020.APK
----Modified by Phương Thảo on	26/07/2023: Bổ sung  load thêm trường Note
----Modified by Phương Thảo on	31/07/2023: @RecruitPeriodID được truyền vào có trường hợp là HRMT2020.APK chuyển kiểu dữ liệu sang UNIQUEIDENTIFIER
----Modified by Phương Thảo on	05/09/2023: [2023/08/IS/0009] Bổ sung lấy mã yêu cầu  tuyển dụng RecruitRequireID khi cập nhật
-- <Example>
---- 
/*-- <Example>
	EXEC HRMP2024 @DivisionID = 'AS', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @DepartmentID = 'PB004', @DutyID = 'CV001', 
	@FromDate = '2017-12-01', @ToDate = '2018-01-31', @Mode = 1, @RecruitPeriodID = 'DTD/000004/2017/05'

	EXEC HRMP2024 @DivisionID, @UserID, @PageNumber, @PageSize, @DepartmentID, @DutyID, @FromDate, @ToDate, @Mode, @RecruitPeriodID

----*/

CREATE PROCEDURE HRMP2024
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @DepartmentID VARCHAR(50), 
	 @DutyID VARCHAR(50), 
	 @FromDate DATETIME, 
	 @ToDate DATETIME, 
	 @Mode TINYINT, -- 0: Thêm mới
					-- 1: Edit, xem thông tin 
	 @RecruitPeriodID VARCHAR(50)
)
AS

DECLARE @sSQL NVARCHAR (MAX)=N'',
		@sSQL1 NVARCHAR (MAX)=N'',
		@sSQL2 NVARCHAR (MAX)=N'',
		@sSQL3 NVARCHAR(MAX) = N'', 
		@sSQL4 NVARCHAR(MAX) = N'', 
		@sWhere NVARCHAR(MAX) = N'', 
		@sWhere1 NVARCHAR(MAX) = N'', 
		@sWhere2 NVARCHAR(MAX) = N'', 
		@sWhere3 NVARCHAR(MAX) = N''

		SET @sWhere = @sWhere + N' HRMT1020.DivisionID = '''+@DivisionID+''' AND HRMT1020.Disabled = 0 '
		SET @sWhere1 = @sWhere1 + N' HRMT2020.DivisionID = '''+@DivisionID+''''
-- Lấy chi phí và số lượng của định biên tuyển dụng theo phòng ban trong khoảng thời gian từ ngày đến ngày 
IF ISNULL(@DepartmentID, '') <> '' SET @sWhere = @sWhere + N'
	AND HRMT1020.DepartmentID = ''' + @DepartmentID + ''''

IF ISNULL(@DutyID, '') <> '' SET @sWhere2 = @sWhere2 + N'
	AND HRMT1021.DutyID = ''' + @DutyID + ''''

IF @Mode = 0
BEGIN
	IF ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '' SET @sWhere = @sWhere + N'
	AND CONVERT(VARCHAR(10), CONVERT(DATE, HRMT1020.FromDate, 120), 126) >= ''' + CONVERT(VARCHAR(10), @FromDate, 126) + ''''

	IF ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '' SET @sWhere = @sWhere + N'
	AND CONVERT(VARCHAR(10), CONVERT(DATE, HRMT1020.FromDate, 120), 126) <= ''' + CONVERT(VARCHAR(10), @ToDate, 126) + ''''

	IF ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '' SET @sWhere = @sWhere + N'
	AND CONVERT(VARCHAR(10), CONVERT(DATE, HRMT1020.FromDate), 126) BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 126) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 126) + '''
	AND CONVERT(VARCHAR(10), CONVERT(DATE, HRMT1020.ToDate), 126) BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 126) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 126) + ''''

END 
ELSE IF @Mode = 1 
BEGIN
	SELECT @FromDate = #Temp.FromDate
	FROM HRMT2020 WITH (NOLOCK) 
	LEFT JOIN (
		SELECT HRMT1020.DivisionID
				, HRMT1020.DepartmentID
				, HRMT1021.DutyID
				, HRMT1020.FromDate
				, HRMT1020.ToDate 
		FROM HRMT1020 WITH (NOLOCK)
		INNER JOIN HRMT1021 WITH (NOLOCK) ON HRMT1020.DivisionID = HRMT1021.DivisionID 
												AND HRMT1020.BoundaryID = HRMT1021.BoundaryID
	) #Temp ON HRMT2020.DivisionID = #Temp.DivisionID 
					AND HRMT2020.DepartmentID = #Temp.DepartmentID 
					AND HRMT2020.DutyID = #Temp.DutyID
	WHERE HRMT2020.RecruitPeriodID = @RecruitPeriodID 
	AND HRMT2020.DivisionID = @DivisionID
	AND (
			(HRMT2020.PeriodFromDate >= #Temp.FromDate 
				AND HRMT2020.PeriodToDate <= #Temp.ToDate
			) 
			OR 
				HRMT2020.PeriodFromDate BETWEEN #Temp.FromDate AND #Temp.ToDate 
			AND 
				HRMT2020.PeriodToDate BETWEEN #Temp.FromDate AND #Temp.ToDate
		)


	SELECT @ToDate = #Temp.FromDate
	FROM HRMT2020 WITH (NOLOCK) 
	LEFT JOIN (
				SELECT HRMT1020.DivisionID
						, HRMT1020.DepartmentID
						, HRMT1021.DutyID
						, HRMT1020.FromDate
						, HRMT1020.ToDate 
				FROM HRMT1020 WITH (NOLOCK)
				INNER JOIN HRMT1021 WITH (NOLOCK) ON HRMT1020.DivisionID = HRMT1021.DivisionID 
														AND HRMT1020.BoundaryID = HRMT1021.BoundaryID
	) #Temp ON HRMT2020.DivisionID = #Temp.DivisionID 
				AND HRMT2020.DepartmentID = #Temp.DepartmentID 
				AND HRMT2020.DutyID = #Temp.DutyID
	WHERE HRMT2020.RecruitPeriodID = @RecruitPeriodID 
				AND HRMT2020.DivisionID = @DivisionID
	AND ( 
			(HRMT2020.PeriodFromDate >= #Temp.FromDate 
				AND HRMT2020.PeriodToDate <= #Temp.ToDate
			) 
			OR 
				HRMT2020.PeriodFromDate BETWEEN #Temp.FromDate AND #Temp.ToDate 
			AND 
				HRMT2020.PeriodToDate BETWEEN #Temp.FromDate AND #Temp.ToDate
		)

	IF ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '' SET @sWhere = @sWhere + N'
	AND CONVERT(VARCHAR(10), CONVERT(DATE, HRMT1020.FromDate, 120), 126) >= '''+CONVERT(VARCHAR(10), @FromDate, 126)+''''

	IF ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '' SET @sWhere = @sWhere + N'
	AND CONVERT(VARCHAR(10), CONVERT(DATE, HRMT1020.FromDate, 120), 126) <= '''+CONVERT(VARCHAR(10), @ToDate, 126)+''''

	IF ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '' SET @sWhere = @sWhere + N'
	AND CONVERT(VARCHAR(10), CONVERT(DATE, HRMT1020.FromDate), 126) BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 126) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 126) + '''
	AND CONVERT(VARCHAR(10), CONVERT(DATE, HRMT1020.ToDate), 126) BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 126) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 126) + ''''
END 
	-- Lấy chi phí theo phòng ban 
SET @sSQL = @sSQL + N'
	SELECT HRMT1020.DepartmentID
			, SUM(HRMT1020.CostBoundary) AS CostBoundary
	INTO #HRMP2024_Boundary_Cost 
	FROM HRMT1020 WITH (NOLOCK) 
	WHERE 
		 ' + @sWhere + '
	GROUP BY HRMT1020.DepartmentID
'
	-- Lấy số lượng theo phòng ban và vị trí 
SET @sSQL1 = @sSQL1 + N'
	SELECT HRMT1020.DepartmentID
			, HRMT1021.DutyID
			, SUM(HRMT1021.QuantityBoundary) AS QuantityBoundary
	INTO #HRMP2024_Boundary_Quantity 
	FROM HRMT1020 WITH (NOLOCK) 
	INNER JOIN HRMT1021 WITH (NOLOCK) ON HRMT1020.DivisionID = HRMT1021.DivisionID 
											AND HRMT1020.BoundaryID = HRMT1021.BoundaryID
	WHERE 
		' + @sWhere + '
		' + @sWhere2 + '
	GROUP BY HRMT1020.DepartmentID
			, HRMT1021.DutyID
'


-- Tính chi phí và số lượng hiện có theo phòng ban và ứng viên trong khoảng thời gian từ ngày, đến ngày 
IF ISNULL(@DepartmentID, '') <> '' SET @sWhere1 = @sWhere1 + N'
	AND HRMT2020.DepartmentID = ''' + @DepartmentID + ''''
IF ISNULL(@DutyID, '') <> '' SET @sWhere3 = @sWhere3 + N'
	AND HRMT2020.DutyID = ''' + @DutyID + ''' '

IF @Mode = 0 
BEGIN 
	IF ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '' SET @sWhere1 = @sWhere1 + N'
	AND CONVERT(VARCHAR(10), CONVERT(DATE, HRMT2020.PeriodFromDate, 120), 126) >= ''' + CONVERT(VARCHAR(10), @FromDate, 126) + ''''

	IF ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '' SET @sWhere1 = @sWhere1 + N'
	AND CONVERT(VARCHAR(10), CONVERT(DATE, HRMT2020.PeriodToDate, 120), 126) <= ''' + CONVERT(VARCHAR(10), @ToDate, 126) + ''''

	IF ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '' SET @sWhere1 = @sWhere1 + N'
	AND CONVERT(VARCHAR(10), CONVERT(DATE, HRMT2020.PeriodFromDate), 126) BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 126) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 126) + '''
	AND CONVERT(VARCHAR(10), CONVERT(DATE, HRMT2020.PeriodToDate), 126) BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 126) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 126) + ''''
END 
ELSE IF @Mode = 1 
BEGIN
	SELECT @FromDate = PeriodFromDate FROM HRMT2020 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND RecruitPeriodID = @RecruitPeriodID
	SELECT @ToDate = PeriodToDate FROM HRMT2020 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND RecruitPeriodID = @RecruitPeriodID

	IF ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '' SET @sWhere1 = @sWhere1 + N'
	AND CONVERT(VARCHAR(10), CONVERT(DATE, HRMT2020.PeriodFromDate, 120), 126) >= ''' + CONVERT(VARCHAR(10), @FromDate, 126) + ''''

	IF ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '' SET @sWhere1 = @sWhere1 + N'
	AND CONVERT(VARCHAR(10), CONVERT(DATE, HRMT2020.PeriodToDate, 120), 126) <= ''' + CONVERT(VARCHAR(10), @ToDate, 126) + ''''

	IF ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '' SET @sWhere1 = @sWhere1 + N'
	AND CONVERT(VARCHAR(10), CONVERT(DATE, HRMT2020.PeriodFromDate), 126) BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 126) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 126) + '''
	AND CONVERT(VARCHAR(10), CONVERT(DATE, HRMT2020.PeriodToDate), 126) BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 126) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 126) + ''''
END
	-- Lấy chi phí theo phòng ban 
SET @sSQL2 = @sSQL2 + N'
	SELECT HRMT2020.DepartmentID
			, SUM(ISNULL(HRMT2020.Cost, 0)) AS ActualCost
	INTO #HRMP2024_Actual_Cost
	FROM HRMT2020 WITH (NOLOCK) 
	WHERE 
		' + @sWhere1 + '
	GROUP BY HRMT2020.DepartmentID
'
	-- Lấy số lượng theo phòng ban, chức vụ 
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

IF @Mode = 0 -- Thêm mới
BEGIN
	IF ISNULL(@DepartmentID, '') <> '' AND ISNULL(@DutyID, '') = ''
	SET @sSQL4 = @sSQL4 + N'
		SELECT T1.DepartmentID
				, NULL AS DutyID
				, SUM(T1.CostBoundary) AS CostBoundary
				, NULL AS QuantityBoundary
				, SUM(T2.ActualCost) AS ActualCost
				, NULL AS ActualQuantity
		FROM #HRMP2024_Boundary_Cost T1
		LEFT JOIN #HRMP2024_Actual_Cost T2 ON T1.DepartmentID = T2.DepartmentID
		GROUP BY T1.DepartmentID
		'
	ELSE IF ISNULL(@DepartmentID, '') <> '' AND ISNULL(@DutyID, '') <> ''
	SET @sSQL4 = @sSQL4 + N'
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
					LEFT JOIN #HRMP2024_Actual_Quantity T2 ON T1.DepartmentID = T2.DepartmentID 
																AND T1.DutyID = T2.DutyID
					GROUP BY T1.DepartmentID, T1.DutyID
				 ) AS #Temp ON T1.DepartmentID = #Temp.DepartmentID 
		GROUP BY T1.DepartmentID, #Temp.DutyID, #Temp.QuantityBoundary, #Temp.ActualQuantity
		'
END 

ELSE IF @Mode = 1 -- Edit, Xem chi tiết
BEGIN
	SET @sSQL4 = @sSQL4 + N'
	SELECT   HRMT2020.APK
	        , HRMT2024.RecruitRequireID
	        , HRMT2020.DivisionID
			, HRMT2020.RecruitPeriodID
			, HRMT2020.RecruitPeriodName
			, HRMT2020.RecruitPlanID
			, (HRMT2000.RecruitPlanID + ''_'' + HRMT2000.Description) AS RecruitPlanName
			, HRMT2020.DepartmentID
			, AT1102.DepartmentName
			, HRMT2020.DutyID
			, HT1102.DutyName
			, HRMT2020.PeriodFromDate
			, HRMT2020.PeriodToDate
			, HRMT2020.ReceiveFromDate
			, HRMT2020.ReceiveToDate
			, HRMT2020.RecruitQuantity
			, #Temp1.QuantityBoundary
			, #Temp1.ActualQuantity
			, HRMT2020.WorkPlace
			, HT0099.[Description] AS WorkType
			, HRMT2020.RequireDate
			, HRMT2020.Cost
			, HRMT2020.Note
			, #Temp1.CostBoundary
			, #Temp1.ActualCost
			, HRMT2020.TotalLevel
			, HRMT2020.InheritRecruitPeriodID
			, HRMT2020.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2020.CreateUserID) CreateUserID
			, HRMT2020.CreateDate
			, HRMT2020.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2020.LastModifyUserID) LastModifyUserID
			, HRMT2020.LastModifyDate
	FROM HRMT2020 WITH (NOLOCK) 
	LEFT JOIN HRMT2000 WITH (NOLOCK) ON HRMT2020.RecruitPlanID = HRMT2000.RecruitPlanID
	LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT2020.DepartmentID = AT1102.DepartmentID
	LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT2020.DivisionID = HT1102.DivisionID 
										AND HRMT2020.DutyID = HT1102.DutyID
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
	LEFT JOIN HT0099 WITH (NOLOCK) ON HRMT2020.WorkType = HT0099.ID 
										AND HT0099.CodeMaster = ''WorkType''
    LEFT JOIN HRMT2024  WITH (NOLOCK) ON HRMT2024.RecruitPeriodID = HRMT2020.RecruitPeriodID
	WHERE HRMT2020.DivisionID = ''' + @DivisionID + '''
			AND (HRMT2020.RecruitPeriodID = ''' + @RecruitPeriodID + ''' OR HRMT2020.APK = TRY_CAST(''' + @RecruitPeriodID + ''' AS UNIQUEIDENTIFIER))
	'


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
