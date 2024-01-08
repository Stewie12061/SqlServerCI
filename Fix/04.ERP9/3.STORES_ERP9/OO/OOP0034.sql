IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP0034]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP0034]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--	Đếm số ngày đi trễ của nhân viên dựa theo dữ liệu chấm công và đơn xin phép
-- <Param>
-- <Return>
-- <Reference>
-- <History>
--	Created by: Vĩnh Tâm, Date: 23/04/2020
--	Modified by: Vĩnh Tâm, Date: 28/05/2020: Xử lý trường hợp Đơn xin nghỉ phép cho nhiều ngày
-- <Example>
/*
	DECLARE @NumberWorkLate INT
	EXEC OOP0034 @DivisionID = 'DTI', @EmployeeID = 'D31003', @StartDate = '2020-04-01', @EndDate = '2020-04-30', @NumberWorkLate = @NumberWorkLate OUTPUT
 */

CREATE PROCEDURE [dbo].[OOP0034] (
	@DivisionID VARCHAR(50),
	@EmployeeID VARCHAR(50),
	@StartDate VARCHAR(20),
	@EndDate VARCHAR(20),
	@NumberWorkLate INT OUTPUT
)
AS
BEGIN
	CREATE TABLE #ListWorkDate (
		WorkDate DATETIME,
		BeginTime VARCHAR(10),
		EndTime VARCHAR(10)
	)
	INSERT INTO #ListWorkDate
	EXEC OOP0033 @DivisionID, @StartDate, @EndDate
	
	SELECT T1.WorkDate, CONVERT(TIME, MIN(T1.BeginTime)) AS BeginTime, CONVERT(TIME, H3.Date) AS AdditionTime
			, CONVERT(TIME, MIN(H1.AbsentTime)) AS CheckIn, H2.AbsentTypeID
			, CASE
				-- Trường hợp có đơn xin bổ sung quẹt thẻ thì tính là không trễ
				WHEN CONVERT(TIME, H3.Date) <= CONVERT(TIME, MIN(T1.BeginTime))
					THEN 0
				-- Trường hợp không có dữ liệu chấm công và không có đơn xin nghỉ phép
				WHEN MIN(H1.AbsentTime) IS NULL AND ISNULL(H2.AbsentTypeID, '') != 'DXP'
					THEN 1
				-- Trường hợp không có dữ liệu chấm công và không có đơn xin nghỉ phép
				WHEN CONVERT(TIME, MIN(H1.AbsentTime)) > CONVERT(TIME, MIN(T1.BeginTime))
						AND (H3.Date IS NULL OR CONVERT(TIME, H3.Date) > CONVERT(TIME, MIN(T1.BeginTime)))
						AND ISNULL(H2.AbsentTypeID, '') != 'DXP'
					THEN 1
				ELSE 0
			  END AS IsLate
	INTO #TableWorkDate
	FROM #ListWorkDate T1
		-- Dữ liệu chấm công
		LEFT JOIN HT2408 H1 WITH (NOLOCK) ON H1.AbsentDate = T1.WorkDate AND H1.EmployeeID = @EmployeeID
		-- Đơn xin phép
		LEFT JOIN OOT2010 H2 WITH (NOLOCK) ON H2.EmployeeID = @EmployeeID
											AND T1.WorkDate BETWEEN CAST(H2.LeaveFromDate AS DATE) AND LeaveToDate
											AND H2.ApproveLevel = H2.ApprovingLevel -- Chỉ lấy đơn xin phép đã được duyệt
		-- Đơn xin bổ sung quẹt thẻ
		LEFT JOIN OOT2040 H3 WITH (NOLOCK) ON H3.WorkingDate = T1.WorkDate AND H3.EmployeeID = @EmployeeID
											AND H3.ApproveLevel = H3.ApprovingLevel -- Chỉ lấy đơn xin phép đã được duyệt
	WHERE T1.WorkDate < GETDATE()
	GROUP BY T1.WorkDate, T1.BeginTime, H2.AbsentTypeID, H3.Date
	ORDER BY T1.WorkDate

	SELECT @NumberWorkLate = SUM(IsLate)
	FROM #TableWorkDate

	-- SELECT *
	-- FROM #TableWorkDate
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
