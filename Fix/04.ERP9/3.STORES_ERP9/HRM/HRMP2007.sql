IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2007]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2007]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load thông tin kế hoạch tuyển dụng 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi, Date: 26/12/2017
----Modified by Khả Vi on 18/03/2018: Bổ sung load thêm trường mục đích tuyển dụng và ghi chú
----Modified by Huỳnh Thử on 11/11/2020: Load Detail cho trường hợp đứng từ màn hình duyệt
----Modified by Thu Hà, Date: 03/08/2023: Bổ sung tab hệ thống load đầu đủ họ tên cho màn hình chi tiết kế hoạch tuyển dụng
----Modified by Phương Thảo, Date: 28/08/2023: [2023/08/IS/0040]Bổ sung lấy thêm thông tin người duyệt, fix lỗi không lấy được thông tin chi tiết
----Modified by Phương Thảo, Date: 14/09/2023: [2023/08/IS/0051]Bổ điều kiện Mã kế hoạch tuyển dụng khi lấy tổng chi phí dự kiến, 
---                                                             Vì chi phí hiện có = sum cột Tổng chi phí dự kiến ,của các phiếu kế hoạch tuyển dụng ,tồn tại trong khoảng thời gian
----Modified by Phương Thảo, Date: 14/09/2023: [2023/08/IS/0053]Điều chỉnh load Master khi sửa( Mode =7)
----Modified by Phương Thảo, Date: 19/09/2023--- [2023_08_IS_0051] Trả Load số lượng, chi phí khi thêm mới (Mode = 0) về như cũ , bổ sung điều kiện nằm trong thời gian của định biên
---                                                                Di chuyển load master sang store HRMP2009 commnet mode = 7
----Modified by Phương Thảo, Date: 21/09/2023--- [2023_08_IS_0051] Fix lỗi load chi tiết, master, màn hình duyệt (khi tạo phiếu KHTD có phòng ban và thời gian, thuộc hơn 1  định biên tuyển dụng -> phải phân biệt bằng DutyID)
/*-- <Example>

	HRMP2007 @DivisionID = 'VF', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @DepartmentID = '0002', @DutyID = '003', @FromDate = '2018-03-01', 
	@ToDate = '2018-03-01', @Mode = 2, @RecruitPlanID = ''

	HRMP2007 @DivisionID, @UserID, @PageNumber, @PageSize, @DepartmentID, @DutyID, @FromDate, @ToDate, @Mode, @RecruitPlanID
----*/

CREATE PROCEDURE HRMP2007
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@PageNumber INT,
	@PageSize INT,
	@DepartmentID VARCHAR(50), 
	@DutyID VARCHAR(50), 
	@FromDate DATETIME, 
	@ToDate DATETIME,
	@Mode TINYINT, -- 0: Load số lượng, chi phí khi thêm mới 
				   -- 1: Load master sửa
				   -- 2: Load detail sửa
				   -- 3: Load master xem thông tin
				   -- 4: Load detail xem thông tin 
				   -- 5: Load thông tin kế hoạch tuyển dụng (đợt tuyển dụng)
				   -- 6: Load detail duyệt
				   -- 7: Load master sửa( Do lúc trước Chuyển luồng không dùng mode1)

	@RecruitPlanID VARCHAR(50) ,
	@LanguageID VARCHAR(50) = ''
)
AS 

DECLARE @sSQL NVARCHAR(MAX) = N'', 
		@TotalRow NVARCHAR(50) = N'', 
		@OrderBy NVARCHAR(MAX), 
		--@LanguageID VARCHAR(50), 
		@sWhere NVARCHAR(MAX) = N''


SET @TotalRow = 'COUNT(*) OVER ()'
SET @OrderBy = N'HRMT2001.DutyID'
--SELECT TOP 1 @LanguageID = ISNULL(LanguageID,'') FROM AT14051 WITH (NOLOCK) WHERE UserID = @UserID
if ISNULL(@LanguageID, '') = '' set @LanguageID = 'vi-VN'

IF @Mode = 0 --- Load số lượng, chi phí khi thêm mới 
BEGIN 


	IF ISNULL(@DutyID, '') <> ''
	BEGIN
		SET @sWhere = @sWhere + N' AND HRMT1021.DutyID ='''+@DutyID+''' '
	END

	SET @sSQL = N'
	SELECT HRMT1020.DepartmentID, HRMT1020.CostBoundary,HRMT1021.DutyID, HRMT1021.QuantityBoundary, Temp.ActualCost, Temp.ActualQuantity
	FROM  HRMT1020 WITH (NOLOCK)
	LEFT JOIN HRMT1021 WITH (NOLOCK) ON HRMT1020.DivisionID = HRMT1021.DivisionID AND HRMT1020.BoundaryID = HRMT1021.BoundaryID 
	AND '''+CONVERT(VARCHAR(10), CONVERT(DATE, @FromDate,120), 126)+''' BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate 
	AND '''+CONVERT(VARCHAR(10), CONVERT(DATE, @ToDate,120), 126)+''' BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate
	LEFT JOIN (
		SELECT SUM(HRMT2000.TotalCost) AS ActualCost, SUM(HRMT2001.Quantity) AS ActualQuantity, HRMT2001.DutyID, HRMT2000.DepartmentID, HRMT1020.BoundaryID
		FROM HRMT2000 WITH (NOLOCK) 
		LEFT JOIN HRMT2001 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT2001.DivisionID AND HRMT2000.RecruitPlanID = HRMT2001.RecruitPlanID
		LEFT JOIN HRMT1020 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT1020.DivisionID AND HRMT2000.DepartmentID = HRMT1020.DepartmentID
			AND HRMT2000.FromDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate 
			AND HRMT2000.ToDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate 
		WHERE HRMT2000.DivisionID = '''+@DivisionID+''' 
		GROUP BY HRMT2000.DepartmentID,  HRMT2001.DutyID, HRMT1020.BoundaryID
	) AS Temp ON HRMT1020.DepartmentID = Temp.DepartmentID AND HRMT1021.DutyID = Temp.DutyID AND HRMT1020.BoundaryID = Temp.BoundaryID
	WHERE HRMT1020.Disabled!=1 AND HRMT1020.DivisionID = '''+@DivisionID+'''  AND HRMT1020.DepartmentID = '''+@DepartmentID+''' AND '''+CONVERT(VARCHAR(10), CONVERT(DATE, @FromDate,120), 126)+''' BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate 
	AND '''+CONVERT(VARCHAR(10), CONVERT(DATE, @ToDate,120), 126)+''' BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate'+@sWhere



	--SELECT HRMT2000.DepartmentID, HRMT2001.DutyID, HRMT1020.CostBoundary, HRMT1021.QuantityBoundary, Temp.ActualCost, Temp.ActualQuantity
	--FROM HRMT2000 WITH (NOLOCK) 
	--LEFT JOIN HRMT2001 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT2001.DivisionID AND HRMT2000.RecruitPlanID = HRMT2001.RecruitPlanID
	--LEFT JOIN HRMT1020 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT1020.DivisionID AND HRMT2000.DepartmentID = HRMT1020.DepartmentID
	--	AND '''+CONVERT(VARCHAR(10), ISNULL(@FromDate, ''''), 120)+''' BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate 
	--	AND '''+CONVERT(VARCHAR(10), ISNULL(@ToDate, ''''), 120)+''' BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate
	--LEFT JOIN HRMT1021 WITH (NOLOCK) ON HRMT1020.DivisionID = HRMT1021.DivisionID AND HRMT1020.BoundaryID = HRMT1021.BoundaryID 
	--	AND HRMT2001.DutyID = HRMT1021.DutyID
	--LEFT JOIN (
	--	SELECT SUM(HRMT2000.TotalCost) AS ActualCost, SUM(HRMT2001.Quantity) AS ActualQuantity, HRMT2001.DutyID, HRMT2000.DepartmentID, HRMT1020.BoundaryID
	--	FROM HRMT2000 WITH (NOLOCK) 
	--	LEFT JOIN HRMT2001 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT2001.DivisionID AND HRMT2000.RecruitPlanID = HRMT2001.RecruitPlanID
	--	LEFT JOIN HRMT1020 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT1020.DivisionID AND HRMT2000.DepartmentID = HRMT1020.DepartmentID
	--		AND HRMT2000.FromDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate 
	--		AND HRMT2000.ToDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate 
	--	WHERE HRMT2000.DivisionID = '''+@DivisionID+''' 
	--	GROUP BY HRMT2000.DepartmentID,  HRMT2001.DutyID, HRMT1020.BoundaryID
	--) AS Temp ON HRMT2000.DepartmentID = Temp.DepartmentID AND HRMT1021.DutyID = Temp.DutyID AND HRMT1020.BoundaryID = Temp.BoundaryID
	--WHERE HRMT2000.DivisionID = '''+@DivisionID+'''  AND HRMT2000.DepartmentID = '''+@DepartmentID+'''
	--'+@sWhere+'
	--GROUP BY HRMT2000.DepartmentID, HRMT2001.DutyID, HRMT1020.CostBoundary, HRMT1021.QuantityBoundary, Temp.ActualCost, Temp.ActualQuantity'
END 


 
IF @Mode = 1 OR @Mode = 3 ---- Load master 
BEGIN
	SET @sSQL = @sSQL + N'
	SELECT DISTINCT HRMT2000.APK, HRMT2000.DivisionID, HRMT2000.RecruitPlanID, HRMT2000.[Description], HRMT2000.DepartmentID, AT1102.DepartmentName, HRMT2000.TotalCost, 
	HRMT2000.FromDate, HRMT2000.ToDate, HRMT2000.[Status], NULL AS StatusName, 
	--HRMT2000.CreateUserID, 
	HRMT2000.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2000.CreateUserID) CreateUserID,
	HRMT2000.CreateDate,
	--HRMT2000.LastModifyUserID, 
	HRMT2000.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2000.LastModifyUserID) LastModifyUserID,
	HRMT2000.LastModifyDate, 
	HRMT2000.PurposeID, '+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'HT0099.[Description]' ELSE 'HT0099.DescriptionE' END+' AS PurposeName, 
	HRMT2000.Notes As NotesMaster, HRMT1020.CostBoundary, Temp.ActualCost, HRMT2000.Approver1 AS ApprovePerson01ID, T1.Fullname AS ApprovePerson01Name,
	HRMT2000.Approver2 AS ApprovePerson02ID, T2.Fullname AS ApprovePerson02Name, HRMT2000.Approver3 AS ApprovePerson03ID, T3.Fullname AS ApprovePerson03Name,
	HRMT2000.Approver4 AS ApprovePerson04ID, T4.Fullname AS ApprovePerson04Name, HRMT2000.Approver5 AS ApprovePerson05ID, T5.Fullname AS ApprovePerson05Name
	FROM HRMT2000 WITH (NOLOCK) 
	LEFT JOIN HRMT2001 WITH (NOLOCK) ON HRMT2001.DivisionID = HRMT2000.DivisionID AND HRMT2001.RecruitPlanID = HRMT2000.RecruitPlanID 
	LEFT JOIN HRMT1020 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT1020.DivisionID AND HRMT2000.DepartmentID = HRMT1020.DepartmentID
		AND (HRMT2000.FromDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate OR HRMT2000.ToDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate 
		OR (HRMT2000.FromDate <= HRMT1020.FromDate AND HRMT2000.ToDate >= HRMT1020.ToDate))
    INNER JOIN HRMT1021 WITH (NOLOCK) ON HRMT1021.DivisionID = HRMT2000.DivisionID   AND HRMT1021.BoundaryID = HRMT1020.BoundaryID AND HRMT1021.DutyID =HRMT2001.DutyID
	LEFT JOIN (
		SELECT HRMT1020.BoundaryID, SUM(HRMT2000.TotalCost) AS ActualCost
		FROM HRMT2000 WITH (NOLOCK)
		LEFT JOIN HRMT1020 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT1020.DivisionID AND HRMT2000.DepartmentID = HRMT1020.DepartmentID
			AND (HRMT2000.FromDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate OR HRMT2000.ToDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate 
			OR (HRMT2000.FromDate <= HRMT1020.FromDate AND HRMT2000.ToDate >= HRMT1020.ToDate))
		WHERE HRMT2000.DivisionID = '''+@DivisionID+''' 
		'+CASE WHEN @Mode = 1 THEN 'AND HRMT2000.RecruitPlanID <> '''+@RecruitPlanID+'''' WHEN @Mode = 3 THEN '' ELSE '' END+' 
		GROUP BY HRMT1020.BoundaryID
	) AS Temp ON HRMT1020.BoundaryID = Temp.BoundaryID
	LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DivisionID IN (HRMT2000.DivisionID, ''@@@'') AND HRMT2000.DepartmentID = AT1102.DepartmentID
	LEFT JOIN HT0099 WITH (NOLOCK) ON HRMT2000.PurposeID = HT0099.ID AND HT0099.CodeMaster = ''Purpose''
	LEFT JOIN HV1400 T1 WITH (NOLOCK) ON T1.DivisionID IN (HRMT2000.DivisionID,''@@@'') AND T1.EmployeeID = HRMT2000.Approver1
	LEFT JOIN HV1400 T2 WITH (NOLOCK) ON T2.DivisionID IN (HRMT2000.DivisionID,''@@@'') AND T2.EmployeeID = HRMT2000.Approver2
	LEFT JOIN HV1400 T3 WITH (NOLOCK) ON T3.DivisionID IN (HRMT2000.DivisionID,''@@@'') AND T3.EmployeeID = HRMT2000.Approver3
	LEFT JOIN HV1400 T4 WITH (NOLOCK) ON T4.DivisionID IN (HRMT2000.DivisionID,''@@@'') AND T4.EmployeeID = HRMT2000.Approver4
	LEFT JOIN HV1400 T5 WITH (NOLOCK) ON T5.DivisionID IN (HRMT2000.DivisionID,''@@@'') AND T5.EmployeeID = HRMT2000.Approver5
	WHERE HRMT2000.DivisionID = '''+@DivisioNID+'''  AND (HRMT2000.RecruitPlanID = '''+@RecruitPlanID+''' OR CONVERT(NVARCHAR(50), HRMT2000.APK) = '''+@RecruitPlanID+''' )'
END 

ELSE IF @Mode = 2 OR @Mode = 4 ---- Load detail 
BEGIN
	SET @sSQL = @sSQL + N'
	SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
	HRMT2001.APK, HRMT2001.DivisionID, HRMT2001.RecruitPlanID, HRMT2001.DutyID, HT1102.DutyName, HRMT2001.WorkPlace, HRMT2001.Quantity, 
	HRMT2001.WorkType, 
	'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'HT090.[Description]' ELSE 'HT090.DescriptionE' END+' AS WorkTypeName, 
	HRMT2001.RecruitCost, HRMT2001.RequireDate, HRMT2001.Note, HRMT2001.[Status], NULL AS StatusName, 
	HRMT1021.QuantityBoundary, ISNULL(Temp.ActualQuantity, 0) AS ActualQuantity
	FROM HRMT2000 WITH (NOLOCK) 
	LEFT JOIN HRMT2001 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT2001.DivisionID AND HRMT2000.RecruitPlanID = HRMT2001.RecruitPlanID
	LEFT JOIN HRMT1020 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT1020.DivisionID AND HRMT2000.DepartmentID = HRMT1020.DepartmentID
		AND (HRMT2000.FromDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate OR HRMT2000.ToDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate 
		OR (HRMT2000.FromDate <= HRMT1020.FromDate AND HRMT2000.ToDate >= HRMT1020.ToDate))
	INNER JOIN HRMT1021 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT1021.DivisionID AND HRMT1020.BoundaryID = HRMT1021.BoundaryID
		AND HRMT2001.DutyID = HRMT1021.DutyID
	LEFT JOIN(
		SELECT HRMT1020.BoundaryID, HRMT2001.DutyID, SUM(HRMT2001.Quantity) AS ActualQuantity
		FROM HRMT2000 WITH (NOLOCK)
		LEFT JOIN HRMT1020 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT1020.DivisionID AND HRMT2000.DepartmentID = HRMT1020.DepartmentID
			AND (HRMT2000.FromDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate OR HRMT2000.ToDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate 
			OR (HRMT2000.FromDate <= HRMT1020.FromDate AND HRMT2000.ToDate >= HRMT1020.ToDate))
		LEFT JOIN HRMT2001 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT2001.DivisionID AND HRMT2000.RecruitPlanID = HRMT2001.RecruitPlanID
		WHERE HRMT2000.DivisionID = '''+@DivisionID+''' 
		-- Bỏ'+CASE WHEN @Mode = 2 THEN 'AND HRMT2000.RecruitPlanID <> '''+@RecruitPlanID+'''' WHEN @Mode = 4 THEN '' ELSE '' END+' 
		'+CASE WHEN @Mode IN (2,4) THEN 'AND HRMT2000.RecruitPlanID <> '''+@RecruitPlanID+''''ELSE '' END+' 

		GROUP BY HRMT1020.BoundaryID, HRMT2001.DutyID
	) AS Temp ON HRMT1020.BoundaryID = Temp.BoundaryID AND HRMT1021.DutyID = Temp.DutyID
	LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT2001.DivisionID = HT1102.DivisionID AND HRMT2001.DutyID = HT1102.DutyID
	LEFT JOIN HT0099 HT090 WITH (NOLOCK) ON HRMT2001.WorkType = HT090.ID AND HT090.CodeMaster = ''WorkType''
	WHERE HRMT2000.DivisionID = '''+@DivisionID+''' AND (HRMT2000.RecruitPlanID = '''+@RecruitPlanID+''' OR CONVERT(NVARCHAR(50), HRMT2000.APK) = '''+@RecruitPlanID+''' )
	ORDER BY '+@OrderBy+' 

	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
END 

ELSE IF @Mode = 5 ---- Load thông tin kế hoạch tuyển dụng (đợt tuyển dụng)
BEGIN	
	SET @sSQL = @sSQL + N'
	SELECT HRMT2000.FromDate PeriodFromDate, HRMT2000.ToDate PeriodToDate, HRMT1020.CostBoundary, Temp1.ActualCost, HRMT1021.QuantityBoundary, Temp.ActualQuantity, 
	HRMT2001.Quantity AS RecruitQuantity, HRMT2001.WorkPlace, HRMT2001.WorkType, HT090.DescriptionE AS WorkTypename, HRMT2001.RequireDate, HRMT2001.RecruitCost AS Cost, 
	HRMT2001.Note
	FROM HRMT2000 WITH (NOLOCK) 
	LEFT JOIN HRMT2001 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT2001.DivisionID AND HRMT2000.RecruitPlanID = HRMT2001.RecruitPlanID
	LEFT JOIN HRMT1020 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT1020.DivisionID AND HRMT2000.DepartmentID = HRMT1020.DepartmentID
		AND (HRMT2000.FromDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate OR HRMT2000.ToDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate 
		OR (HRMT2000.FromDate <= HRMT1020.FromDate AND HRMT2000.ToDate >= HRMT1020.ToDate))
	INNER JOIN HRMT1021 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT1021.DivisionID AND HRMT1020.BoundaryID = HRMT1021.BoundaryID
		AND HRMT2001.DutyID = HRMT1021.DutyID
	LEFT JOIN(
		SELECT HRMT1020.BoundaryID, HRMT2001.DutyID, SUM(HRMT2001.Quantity) AS ActualQuantity
		FROM HRMT2000 WITH (NOLOCK)
		LEFT JOIN HRMT1020 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT1020.DivisionID AND HRMT2000.DepartmentID = HRMT1020.DepartmentID
			AND (HRMT2000.FromDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate OR HRMT2000.ToDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate 
			OR (HRMT2000.FromDate <= HRMT1020.FromDate AND HRMT2000.ToDate >= HRMT1020.ToDate))
		LEFT JOIN HRMT2001 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT2001.DivisionID AND HRMT2000.RecruitPlanID = HRMT2001.RecruitPlanID
		WHERE HRMT2000.DivisionID = '''+@DivisionID+''' 
		GROUP BY HRMT1020.BoundaryID, HRMT2001.DutyID
	) AS Temp ON HRMT1020.BoundaryID = Temp.BoundaryID AND HRMT1021.DutyID = Temp.DutyID
	LEFT JOIN (
	SELECT HRMT1020.BoundaryID, SUM(HRMT2000.TotalCost) AS ActualCost
	FROM HRMT2000 WITH (NOLOCK)
	LEFT JOIN HRMT1020 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT1020.DivisionID AND HRMT2000.DepartmentID = HRMT1020.DepartmentID
		AND (HRMT2000.FromDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate OR HRMT2000.ToDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate 
		OR (HRMT2000.FromDate <= HRMT1020.FromDate AND HRMT2000.ToDate >= HRMT1020.ToDate))
	WHERE HRMT2000.DivisionID = '''+@DivisionID+''' 
	GROUP BY HRMT1020.BoundaryID
	) AS Temp1 ON HRMT1020.BoundaryID = Temp1.BoundaryID
	LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT2001.DivisionID = HT1102.DivisionID AND HRMT2001.DutyID = HT1102.DutyID
	LEFT JOIN HT0099 HT090 WITH (NOLOCK) ON HRMT2001.WorkType = HT090.ID AND HT090.CodeMaster = ''WorkType''
	LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DivisionID IN (HRMT2000.DivisionID, ''@@@'') AND HRMT2000.DepartmentID = AT1102.DepartmentID
	WHERE HRMT2000.DivisionID = '''+@DivisionID+''' AND HRMT2000.RecruitPlanID = '''+@RecruitPlanID+''''
END 
ELSE IF (@Mode = 6) --- Load detail duyệt
BEGIN
SET @sSQL = @sSQL + N'
	SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
	HRMT2001.APK, HRMT2001.DivisionID, HRMT2001.RecruitPlanID, HRMT2001.DutyID, HT1102.DutyName, HRMT2001.WorkPlace, HRMT2001.Quantity, 
	HRMT2001.WorkType, 
	'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'HT090.[Description]' ELSE 'HT090.DescriptionE' END+' AS WorkTypeName, 
	HRMT2001.RecruitCost, HRMT2001.RequireDate, HRMT2001.Note, HRMT2001.[Status], NULL AS StatusName, 
	HRMT1021.QuantityBoundary, ISNULL(Temp.ActualQuantity, 0) AS ActualQuantity
	FROM HRMT2000 WITH (NOLOCK) 
	LEFT JOIN HRMT2001 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT2001.DivisionID AND HRMT2000.RecruitPlanID = HRMT2001.RecruitPlanID
	LEFT JOIN HRMT1020 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT1020.DivisionID AND HRMT2000.DepartmentID = HRMT1020.DepartmentID
		AND (HRMT2000.FromDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate OR HRMT2000.ToDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate 
		OR (HRMT2000.FromDate <= HRMT1020.FromDate AND HRMT2000.ToDate >= HRMT1020.ToDate))
	INNER JOIN  HRMT1021 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT1021.DivisionID AND HRMT1020.BoundaryID = HRMT1021.BoundaryID
		AND HRMT2001.DutyID = HRMT1021.DutyID
	LEFT JOIN(
		SELECT HRMT1020.BoundaryID, HRMT2001.DutyID, SUM(HRMT2001.Quantity) AS ActualQuantity
		FROM HRMT2000 WITH (NOLOCK)
		LEFT JOIN HRMT1020 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT1020.DivisionID AND HRMT2000.DepartmentID = HRMT1020.DepartmentID
			AND (HRMT2000.FromDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate OR HRMT2000.ToDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate 
			OR (HRMT2000.FromDate <= HRMT1020.FromDate AND HRMT2000.ToDate >= HRMT1020.ToDate))
		LEFT JOIN HRMT2001 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT2001.DivisionID AND HRMT2000.RecruitPlanID = HRMT2001.RecruitPlanID
		WHERE HRMT2000.DivisionID = '''+@DivisionID+''' 
		-- Bỏ'+CASE WHEN @Mode = 2 THEN 'AND HRMT2000.APK <> '''+@RecruitPlanID+'''' WHEN @Mode = 4 THEN '' ELSE '' END+' 
		'+CASE WHEN @Mode IN (2,4) THEN 'AND HRMT2000.APK <> '''+@RecruitPlanID+''''ELSE '' END+' 

		GROUP BY HRMT1020.BoundaryID, HRMT2001.DutyID
	) AS Temp ON HRMT1020.BoundaryID = Temp.BoundaryID AND HRMT1021.DutyID = Temp.DutyID
	LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT2001.DivisionID = HT1102.DivisionID AND HRMT2001.DutyID = HT1102.DutyID
	LEFT JOIN HT0099 HT090 WITH (NOLOCK) ON HRMT2001.WorkType = HT090.ID AND HT090.CodeMaster = ''WorkType''
	WHERE HRMT2000.DivisionID = '''+@DivisionID+''' AND HRMT2000.APK = '''+@RecruitPlanID+'''
	ORDER BY '+@OrderBy+' 

	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
END 
--ELSE IF (@Mode = 7 )--- Load Master khi sửa
--BEGIN 
--	IF ISNULL(@DutyID, '') <> ''
--	BEGIN
--		SET @sWhere = @sWhere + N' AND HRMT1021.DutyID ='''+@DutyID+''' '
--	END

--	SET @sSQL = N'
--	SELECT 
--	 Temp.Description
--	, Temp.TotalCost --Tổng chi phí định biên
--	, Temp.ActualCost--- Chi phí hiện có
--	, HRMT1020.CostBoundary-- chi phí định biên lấy từ định biên tuyển dụng
--	, Temp.ApprovePerson01Status
--	, Temp.ApprovePerson01StatusName
--	, Temp.ApprovePerson01ID
--	, Temp.ApprovePerson01Name
--	, Temp.ApprovePerson01Note
--	FROM  HRMT1020 WITH (NOLOCK)
--	LEFT JOIN HRMT1021 WITH (NOLOCK) ON HRMT1020.DivisionID = HRMT1021.DivisionID AND HRMT1020.BoundaryID = HRMT1021.BoundaryID 
--	AND '''+CONVERT(VARCHAR(10), CONVERT(DATE, @FromDate,120), 126)+''' BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate 
--	AND '''+CONVERT(VARCHAR(10), CONVERT(DATE, @ToDate,120), 126)+''' BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate
--	LEFT JOIN (
--		SELECT HRMT2000.Description, HRMT2000.TotalCost,SUM(HRMT2000.TotalCost) AS ActualCost, SUM(HRMT2001.Quantity) AS ActualQuantity, HRMT2001.DutyID, HRMT2000.DepartmentID, HRMT1020.BoundaryID
--        ,APP01.ApprovePerson01ID, APP01.ApprovePerson01Name, APP01.ApprovePerson01Status, APP01.ApprovePerson01StatusName, APP01.ApprovePerson01Note
--		FROM HRMT2000 WITH (NOLOCK) 
--		LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON HRMT2000.APK = OOT90.APK
--		LEFT JOIN HRMT2001 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT2001.DivisionID AND HRMT2000.RecruitPlanID = HRMT2001.RecruitPlanID
--		LEFT JOIN HRMT1020 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT1020.DivisionID AND HRMT2000.DepartmentID = HRMT1020.DepartmentID
--			AND HRMT2000.FromDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate 
--			AND HRMT2000.ToDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate 
--			LEFT JOIN (SELECT ApprovePersonID ApprovePerson01ID,OOT1.APKMaster,OOT1.DivisionID,OOT1.Status,
--						 HT14.FullName As ApprovePerson01Name, 
--						OOT1.Status ApprovePerson01Status, O99.Description ApprovePerson01StatusName,
--						OOT1.Note ApprovePerson01Note
--						FROM OOT9001 OOT1 WITH (NOLOCK)
--						INNER JOIN AT1103 HT14 WITH (NOLOCK) ON (HT14.DivisionID=OOT1.DivisionID OR ISNULL(HT14.DivisionID,'''') = ''@@@'') AND HT14.EmployeeID=OOT1.ApprovePersonID
--						LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(OOT1.Status,0) AND O99.CodeMaster=''Status''
--						WHERE OOT1.Level=         1
--						)APP01 ON APP01.DivisionID= OOT90.DivisionID  AND APP01.APKMaster=OOT90.APK

--		WHERE HRMT2000.DivisionID = '''+@DivisionID+'''  and  HRMT2000.RecruitPlanID = '''+@RecruitPlanID+'''
--		GROUP BY HRMT2000.Description, HRMT2000.TotalCost, HRMT2000.DepartmentID,  HRMT2001.DutyID, HRMT1020.BoundaryID, APP01.ApprovePerson01ID, APP01.ApprovePerson01Name, APP01.ApprovePerson01Status, APP01.ApprovePerson01StatusName, APP01.ApprovePerson01Note
--	) AS Temp ON HRMT1020.DepartmentID = Temp.DepartmentID AND HRMT1021.DutyID = Temp.DutyID AND HRMT1020.BoundaryID = Temp.BoundaryID
--	WHERE HRMT1020.Disabled!=1 AND HRMT1020.DivisionID = '''+@DivisionID+'''  AND HRMT1020.DepartmentID = '''+@DepartmentID+''' '+@sWhere

--END 
PRINT @sSQL
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
