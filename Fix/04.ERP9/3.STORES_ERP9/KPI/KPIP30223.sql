IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP30223]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP30223]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO












-- <Summary>
---- KPI cố tình vi phạm
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 22/08/2019 by Đình Ly

CREATE PROCEDURE [dbo].KPIP30223
(
	@DivisionID VARCHAR(50),
	@AssignedToUserID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@Mode INT
)
AS
BEGIN
	DECLARE @sSQL NVARCHAR (MAX),
			@sWhere NVARCHAR(MAX),
			@sWhere1 NVARCHAR(MAX),
			@OrderBy NVARCHAR(500),
			@TaskList NVARCHAR(MAX)

	-- Điều kiện lọc khi get dữ liệu KPI
	SET @sWhere = 'O.AssignedToUserID IN (''' + @AssignedToUserID + ''') AND O.IsViolated = ''1''
					AND MONTH(O.LastModifyDate) = ' + CAST(@TranMonth AS VARCHAR(10)) + ' AND YEAR(O.LastModifyDate) = ' + CAST(@TranYear AS VARCHAR(10)) + ''

	-- Điều kiện lọc khi get dữ liệu KPI
	SET @sWhere1 = 'O.AssignedToUserID IN (''' + @AssignedToUserID + ''') AND O.IsViolated = ''1''
					AND MONTH(O.LastModifyDate) = ' + CAST(@TranMonth AS VARCHAR(10)) + ' AND YEAR(O.LastModifyDate) = ' + CAST(@TranYear AS VARCHAR(10)) + ''

	-- Lấy ra danh sách công việc cố tình vi phạm và phần trăm KPI bị trừ
	IF @Mode = 1
	BEGIN
		SET @TaskList = 'SELECT O.APK 
							, O.TaskID
							, O.TaskName
							, K1.TargetsName
							, K2.TargetsGroupPercentage
							, K2.TargetsGroupPercentage * 3 AS KPI
						FROM OOT2110 O WITH (NOLOCK)
							INNER JOIN KPIT10501 K1 WITH (NOLOCK) ON K1.TargetsID = O.TargetTypeID
							INNER JOIN KPIT10502 K2 WITH (NOLOCK) ON K2.APKMaster = K1.APK
							INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = ''' + @AssignedToUserID + '''
															AND A1.DepartmentID = K2.DepartmentID
						WHERE ' + @sWhere + ''
		EXEC (@TaskList)
	END

	-- Lấy ra danh sách công việc cố tình vi phạm và phần trăm KPI bị trừ
	IF @Mode = 2
	BEGIN
		SET @TaskList = 'SELECT ROW_NUMBER() OVER(ORDER BY T1.TargetsName) STT
							, T1.TargetsName
							, COUNT(T1.TargetsName) AS Quantity
							, T1.TargetsGroupPercentage
							, ISNULL(SUM(T1.TargetsGroupPercentage * 3), 0) AS Total
							, 3 AS TypeData
						FROM (
							SELECT O.APK
								, O.TaskID
								, O.TaskName
								, K1.TargetsName
								, K2.TargetsGroupPercentage
							FROM OOT2110 O WITH (NOLOCK)
								INNER JOIN KPIT10501 K1 WITH (NOLOCK) ON K1.TargetsID = O.TargetTypeID
								INNER JOIN KPIT10502 K2 WITH (NOLOCK) ON K2.APKMaster = K1.APK
								INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = ''' + @AssignedToUserID + '''
																AND A1.DepartmentID = K2.DepartmentID
							WHERE ' + @sWhere + '
							) AS T1
						GROUP BY T1.TargetsName, T1.TargetsGroupPercentage'
		EXEC (@TaskList)
		PRINT(@TaskList)
	END

	IF @Mode = 3
	BEGIN
		SET @TaskList = 'SELECT ISNULL(SUM(K2.TargetsGroupPercentage * 3), 0) AS SumPunish
						FROM OOT2110 O WITH (NOLOCK) 
							INNER JOIN KPIT10501 K1 WITH (NOLOCK) ON K1.TargetsID = O.TargetTypeID
							INNER JOIN KPIT10502 K2 WITH (NOLOCK) ON K2.APKMaster = K1.APK
							INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = O.AssignedToUserID
															AND A1.DepartmentID = K2.DepartmentID 
						WHERE ' + @sWhere + ''
		EXEC (@TaskList)
	END

	-- Lấy ra danh sách công việc cố tình vi phạm và phần trăm KPI bị trừ
	IF @Mode = 4
	BEGIN
		-- Trường hợp có cố tình vi phạm
		SET @TaskList = N'
			IF EXISTS (SELECT TOP 1 1 FROM OOT2110 O WHERE ' + @sWhere1 + ')
			BEGIN
				SELECT ROW_NUMBER() OVER(ORDER BY T1.TargetsName) STT
					, T1.TargetsID
					, T1.TargetsName
					, T1.Quantity
					-- Tính ra phần trăm bị trễ task
					, T1.TargetsGroupPercentage * 3 AS TargetsGroupPercentage
					, 0 AS Total
					, 3 AS TypeData
				FROM (
					SELECT
						  K1.TargetsID
						, K1.TargetsName
						, COUNT(K1.TargetsID) AS Quantity
						, K2.Percentage AS TargetsGroupPercentage
						, SUM(O.PlanTime) AS PlanTime
						, SUM(O.ActualTime) AS ActualTime
						, O.IsViolated
					FROM OOT2110 O WITH (NOLOCK) 
						INNER JOIN KPIT10501 K1 WITH (NOLOCK) ON K1.TargetsID = O.TargetTypeID
						INNER JOIN KPIT10502 K2 WITH (NOLOCK) ON K2.APKMaster = K1.APK
						INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = ''' + @AssignedToUserID + '''
						INNER JOIN OOT1080 O1 WITH (NOLOCK) ON O1.DivisionID =  O.DivisionID AND O1.APK=''1310C79C-D7AA-49B5-AA37-A085E8357851''
					WHERE ' + @sWhere1 + N'
						AND O.IsViolated = ''1''
					GROUP BY K1.TargetsID, K1.TargetsName, O.IsViolated, K2.Percentage
				) AS T1
			END'
		EXEC (@TaskList)
		PRINT(@TaskList)
	END
END











GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
