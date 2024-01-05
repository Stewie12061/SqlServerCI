IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP30221]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP30221]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



















-- <Summary>
---- KPI kết quả làm việc
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
-- Create on 20/08/2019 by Đình Ly
-- Modified on 06/09/2019 by Vĩnh Tâm: Đọc thiết lập đánh giá công việc để tính điểm KPI

CREATE PROCEDURE [dbo].[KPIP30221]
(
	@DivisionID VARCHAR(50),
	@AssignedToUserID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@Mode INT
)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(MAX),
			@sWhere NVARCHAR(MAX),
			@sWhere1 NVARCHAR(MAX),
			@sWhereSub NVARCHAR(MAX),
			@sWhereSub1 NVARCHAR(MAX),
			@OrderBy NVARCHAR(500),
			@ListGroup NVARCHAR(MAX) = '',
			@Formula NVARCHAR(MAX) = '',
			@Cur CURSOR
			
	DECLARE @TargetsGroupID VARCHAR(50),
			@Percentage DECIMAL(28,8),
			@CustomerIndex INT = -1
			
	-- Lặp danh sách các Nhóm chỉ tiêu được Đánh giá điểm KPI để tạo thành công thức tính
	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT REPLACE(O1.TargetsGroupID, '.', '') AS TargetsGroupID, K2.Percentage
	FROM OOT0050 O1 WITH (NOLOCK)
		INNER JOIN OOT0051 O2 WITH (NOLOCK) ON O1.APKMaster = O2.APK
		INNER JOIN KPIT10101 K1 WITH (NOLOCK) ON O1.TargetsGroupID = K1.TargetsGroupID
		INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = @AssignedToUserID
		INNER JOIN KPIT10102 K2 WITH (NOLOCK) ON K1.APK = K2.APKMaster AND K2.DivisionID = @DivisionID AND K2.DepartmentID = A1.DepartmentID
	WHERE ISNULL(O1.NoDisplay, 0) = 0 AND O2.ObjectID = 'CV'
	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @TargetsGroupID, @Percentage
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @ListGroup = @ListGroup + ',' + REPLACE(@TargetsGroupID, '.', '')
		SET @Formula = @Formula + '+ (T2.TargetsPercentage * ' + CAST(@Percentage AS VARCHAR(50)) + ' / 100.0) * (' + @TargetsGroupID + '/ 100.0)'
		FETCH NEXT FROM @Cur INTO @TargetsGroupID, @Percentage
	END
	CLOSE @Cur

	-- Loại bỏ dấu phẩy (,) dư ở đầu chuỗi
	SET @ListGroup = SUBSTRING(@ListGroup, 2, LEN(@ListGroup))
	--PRINT(@ListGroup)

	-- Điều kiện lọc khi get dữ liệu KPI
	SET @sWhere = 'O.AssignedToUserID IN (''' + @AssignedToUserID + ''') AND O.StatusID IN (''TTCV0003'')
				   AND MONTH(O.ActualEndDate) = ' + CAST(@TranMonth AS VARCHAR(10)) + ' AND YEAR(O.ActualEndDate) = ' + CAST(@TranYear AS VARCHAR(10)) + ''

	SET @sWhereSub = 'OT1.AssignedToUserID IN (''' + @AssignedToUserID + ''') AND OT1.StatusID IN (''TTCV0003'')
				   AND MONTH(OT1.ActualEndDate) = ' + CAST(@TranMonth AS VARCHAR(10)) + ' AND YEAR(OT1.ActualEndDate) = ' + CAST(@TranYear AS VARCHAR(10)) + ''


	DECLARE @PunishTable TABLE (
		StartHour DECIMAL(28,8),
		EndHour DECIMAL(28,8),
		PunishRate DECIMAL(28,8)
	)

	-- Lấy dữ liệu bảng Cố tình vi phạm
	BEGIN
		-- Lấy CustomerIndex của DB
		SELECT @CustomerIndex = CustomerName FROM CustomerIndex
		--PRINT(@CustomerIndex)

		-- Customize xử lý cho Đức Tín
		IF @CustomerIndex = 114
		BEGIN

			INSERT INTO @PunishTable (StartHour, EndHour, PunishRate)
			SELECT O2.NumberHourLate AS StartHour, MIN(O3.NumberHourLate) AS EndHour, O2.PunishRate
			FROM OOT1080 O1 WITH (NOLOCK)
				INNER JOIN OOT1081 O2 WITH (NOLOCK) ON O1.APK = O2.APKMaster
				LEFT JOIN OOT1081 O3 WITH (NOLOCK) ON O3.APKMaster = O2.APKMaster AND O2.NumberHourLate < O3.NumberHourLate
			GROUP BY O2.NumberHourLate, O2.PunishRate
			ORDER BY O2.NumberHourLate, O2.PunishRate
			GOTO Result
		END

		-- Trường hợp không có customize: Lấy dữ liệu Bảng giờ công vi phạm theo nhân viên được lưu tại bảng Up&Down
		INSERT INTO @PunishTable (StartHour, EndHour, PunishRate)
		SELECT O2.NumberHourLate AS StartHour, MIN(O3.NumberHourLate) AS EndHour, O2.PunishRate
		FROM KPIT2020 K1 WITH (NOLOCK) 
			INNER JOIN OOT1080 O1 WITH (NOLOCK) ON K1.TableViolatedID = O1.TableViolatedID
			INNER JOIN OOT1081 O2 WITH (NOLOCK) ON O1.APK = O2.APKMaster
			LEFT JOIN OOT1081 O3 WITH (NOLOCK) ON O3.APKMaster = O2.APKMaster AND O2.NumberHourLate < O3.NumberHourLate
		WHERE K1.EmployeeID = @AssignedToUserID
		GROUP BY O2.NumberHourLate, O2.PunishRate
		ORDER BY O2.NumberHourLate, O2.PunishRate

		Result:

		-- Đưa dữ liệu vào bảng tạm để sử dụng trong EXEC SQL
		SELECT *
		INTO #PunishTable
		FROM @PunishTable
	END


	-- Lấy ra danh sách công việc và phần trăm KPI cho từng công việc
	IF @Mode = 1
	BEGIN
		SET @sSQL = 'SELECT *, (T2.TargetsPercentage * T2.Percentage / 100.0) ' + @Formula + ' AS KPI
						FROM (
							SELECT O.APK
								 , O.TaskID
								 , O.TaskName
								 , O1.Mark
								 , REPLACE(O1.TargetsGroupID, ''.'', '''') AS TargetsGroupID
								 , K1.TargetsName
								 , K2.Percentage AS TargetsPercentage
								 , K3.TargetsGroupName
								 , K4.Percentage
							FROM OOT2110 O WITH (NOLOCK) 
								INNER JOIN OOT2130 O1 WITH (NOLOCK) ON O1.APKMaster = O.APK
								INNER JOIN (
									SELECT DivisionID, COUNT(*) AS CountSetting
									FROM OOT0050 WITH (NOLOCK)
									WHERE DivisionID = ''' + @DivisionID + ''' AND ISNULL(NoDisplay, 0) = 0
									GROUP BY DivisionID
									) AS O2 ON O.DivisionID = O2.DivisionID
								INNER JOIN (
									SELECT OT2.APKMaster, COUNT(*) AS CountAssess
									FROM OOT2110 OT1 WITH (NOLOCK)
										INNER JOIN OOT2130 OT2 WITH (NOLOCK) ON OT1.TaskID = OT2.TaskID
									WHERE (OT2.AssessRequired = 0 OR (OT2.AssessRequired = 1 AND OT2.StatusID = 1)) AND ' + @sWhereSub + '
									GROUP BY OT2.APKMaster
									) AS O3 ON O1.APKMaster = O3.APKMaster AND O2.CountSetting = O3.CountAssess
								INNER JOIN KPIT10501 K1 WITH (NOLOCK) ON K1.TargetsID = O.TargetTypeID
								INNER JOIN KPIT10502 K2 WITH (NOLOCK) ON K2.APKMaster = K1.APK
								INNER JOIN KPIT10101 K3 WITH (NOLOCK) ON K3.TargetsGroupID = K2.TargetsGroupID
								INNER JOIN KPIT10102 K4 WITH (NOLOCK) ON K4.APKMaster = K3.APK
								INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = O.AssignedToUserID
									AND A1.DepartmentID = K2.DepartmentID AND A1.DepartmentID = K4.DepartmentID
							WHERE ' + @sWhere + ') AS T1
						PIVOT
						(
							SUM(Mark)
							FOR TargetsGroupID IN (' + @ListGroup + ')
						) AS T2 ' 
		EXEC (@sSQL)
	END

	-- Lấy ra danh sách loại chỉ tiêu và phần trăm KPI cho từng loại chỉ tiêu
	IF @Mode = 2
	BEGIN
		SET @sSQL = 'SELECT ROW_NUMBER() OVER(ORDER BY T2.TargetsName) STT
							, T2.TargetsName
							, COUNT(T2.TargetsName) AS Quantity
							, T2.TargetsPercentage
							, SUM((100 - ISNULL(T2.PunishRate, 0)) / 100 * ((T2.TargetsPercentage * T2.Percentage / 100.0) ' + @Formula + ')) AS Total
							, ''1'' AS TypeData
						FROM (
							SELECT O.APK
								 , O.TaskID
								 , O.TaskName
								 , O1.Mark
								 , REPLACE(O1.TargetsGroupID, ''.'', '''') AS TargetsGroupID
								 , K1.TargetsName
								 , K2.Percentage AS TargetsPercentage
								 , K4.Percentage, T01.PunishRate
							FROM OOT2110 O WITH (NOLOCK) 
								INNER JOIN OOT2130 O1 WITH (NOLOCK) ON O1.APKMaster = O.APK
								INNER JOIN (
										SELECT OO1.DivisionID, COUNT(*) AS CountSetting
										FROM OOT0050 OO1 WITH (NOLOCK)
										INNER JOIN OOT0051 OO2 WITH (NOLOCK) ON OO1.APKMaster = OO2.APK
										WHERE OO1.DivisionID = ''' + @DivisionID + ''' AND ISNULL(OO1.NoDisplay, 0) = 0 AND OO2.ObjectID = ''CV''
										GROUP BY OO1.DivisionID
									) AS O2 ON O.DivisionID = O2.DivisionID
								INNER JOIN (
									SELECT OT2.APKMaster, COUNT(*) AS CountAssess
									FROM OOT2110 OT1 WITH (NOLOCK)
										INNER JOIN OOT2130 OT2 WITH (NOLOCK) ON OT1.TaskID = OT2.TaskID
									WHERE (OT2.AssessRequired = 0 OR (OT2.AssessRequired = 1 AND OT2.StatusID = 1)) AND ' + @sWhereSub + '
									GROUP BY OT2.APKMaster
									) AS O3 ON O1.APKMaster = O3.APKMaster AND O2.CountSetting = O3.CountAssess
								INNER JOIN KPIT10501 K1 WITH (NOLOCK) ON K1.TargetsID = O.TargetTypeID
								INNER JOIN KPIT10502 K2 WITH (NOLOCK) ON K2.APKMaster = K1.APK
								INNER JOIN KPIT10101 K3 WITH (NOLOCK) ON K3.TargetsGroupID = K2.TargetsGroupID
								INNER JOIN KPIT10102 K4 WITH (NOLOCK) ON K4.APKMaster = K3.APK
								INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = O.AssignedToUserID
									AND A1.DepartmentID = K2.DepartmentID AND A1.DepartmentID = K4.DepartmentID
								LEFT JOIN #PunishTable T01 ON (O.ActualTime - O.PlanTime) > 0
									AND (O.ActualTime - O.PlanTime) / O.PlanTime * 100.0 >= T01.StartHour
									AND (T01.EndHour IS NULL
									OR (O.ActualTime - O.PlanTime) / O.PlanTime * 100.0 < T01.EndHour)
							WHERE ' + @sWhere + ') AS T1
						PIVOT 
						(
							SUM(Mark)
							FOR TargetsGroupID IN (' + @ListGroup + ')
						) AS T2
						GROUP BY T2.TargetsName, T2.TargetsPercentage'
		EXEC (@sSQL)
		PRINT(@sSQL)
	END

	-- Lấy ra tổng phần trăm KPI của tất cả các công việc hoàn thành
	IF @Mode = 3
	BEGIN
		IF ISNULL(@Formula, '') != ''
		BEGIN
			SET @sSQL = 'SELECT SUM((T2.TargetsPercentage * T2.Percentage / 100.0) ' + @Formula + ') AS SUM_KPI
							FROM (
								SELECT O.APK
									 , O.TaskID
									 , O.TaskName
									 , O1.Mark
									 , REPLACE(O1.TargetsGroupID, ''.'', '''') AS TargetsGroupID
									 , K1.TargetsName
									 , K2.Percentage AS TargetsPercentage
									 , K4.Percentage
								FROM OOT2110 O WITH (NOLOCK) 
									INNER JOIN OOT2130 O1 WITH (NOLOCK) ON O1.APKMaster = O.APK
									INNER JOIN (
										SELECT DivisionID, COUNT(*) AS CountSetting
										FROM OOT0050 WITH (NOLOCK)
										WHERE DivisionID = ''' + @DivisionID + ''' AND ISNULL(NoDisplay, 0) = 0
										GROUP BY DivisionID
										) AS O2 ON O.DivisionID = O2.DivisionID
									INNER JOIN (
										SELECT OT2.APKMaster, COUNT(*) AS CountAssess
										FROM OOT2110 OT1 WITH (NOLOCK)
											INNER JOIN OOT2130 OT2 WITH (NOLOCK) ON OT1.TaskID = OT2.TaskID
										WHERE (OT2.AssessRequired = 0 OR (OT2.AssessRequired = 1 AND OT2.StatusID = 1)) AND ' + @sWhereSub + '
										GROUP BY OT2.APKMaster
										) AS O3 ON O1.APKMaster = O3.APKMaster AND O2.CountSetting = O3.CountAssess
									INNER JOIN KPIT10501 K1 WITH (NOLOCK) ON K1.TargetsID = O.TargetTypeID
									INNER JOIN KPIT10502 K2 WITH (NOLOCK) ON K2.APKMaster = K1.APK
									INNER JOIN KPIT10101 K3 WITH (NOLOCK) ON K3.TargetsGroupID = K2.TargetsGroupID
									INNER JOIN KPIT10102 K4 WITH (NOLOCK) ON K4.APKMaster = K3.APK
									INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = O.AssignedToUserID
										AND A1.DepartmentID = K2.DepartmentID AND A1.DepartmentID = K4.DepartmentID
								WHERE ' + @sWhere + ') AS T1
							PIVOT 
							(
								SUM(Mark)
								FOR TargetsGroupID IN (' + @ListGroup + ')
							) AS T2 '
			EXEC (@sSQL)
			--PRINT(@sSQL)
		END
		ELSE
		BEGIN
			SELECT 0.0 AS SUM_KPI
		END
	END

	-- Lấy ra danh sách loại chỉ tiêu và phần trăm KPI cho từng loại chỉ tiêu
	IF @Mode = 4
		BEGIN
			SET @sSQL = '
				SELECT ROW_NUMBER() OVER(ORDER BY T3.TargetsGroupName) STT
					, T3.TargetsGroupID , T3.TargetsGroupName, COUNT(T3.TargetsGroupID) AS Quantity
					, T3.TargetsPercentage, SUM(T3.Total) AS Total, T3.TypeData
				FROM (
						SELECT T2.TargetsID AS TargetsGroupID, T2.TargetsName AS TargetsGroupName
							, T2.TargetsPercentage, 1 AS TypeData, T2.PunishRate
							, (100 - ISNULL(T2.PunishRate, 0)) / 100 * ((T2.TargetsPercentage * T2.Percentage / 100.0) ' + @Formula + ') AS Total
						FROM (	
								SELECT O.APK, O.TaskID, O.TaskName
									, REPLACE(O1.TargetsGroupID, ''.'', '''') AS TargetsGroupID
									, K1.TargetsID, K1.TargetsName
									, K2.Percentage AS TargetsPercentage
									, K4.Percentage
									, O1.Mark, COUNT(O.TaskID) AS Quanlity
									, T01.PunishRate
								FROM OOT2110 O WITH (NOLOCK) 
									INNER JOIN OOT2130 O1 WITH (NOLOCK) ON O1.APKMaster = O.APK
									INNER JOIN (
										SELECT OO1.DivisionID, COUNT(*) AS CountSetting
										FROM OOT0050 OO1 WITH (NOLOCK)
											INNER JOIN OOT0051 OO2 WITH (NOLOCK) ON OO1.APKMaster = OO2.APK
										WHERE OO1.DivisionID = ''' + @DivisionID + ''' AND ISNULL(OO1.NoDisplay, 0) = 0 AND OO2.ObjectID = ''CV''
										GROUP BY OO1.DivisionID
									) AS O2 ON O.DivisionID = O2.DivisionID
									INNER JOIN (
										SELECT OT2.APKMaster, COUNT(*) AS CountAssess
										FROM OOT2110 OT1 WITH (NOLOCK)
											INNER JOIN OOT2130 OT2 WITH (NOLOCK) ON OT1.TaskID = OT2.TaskID
										WHERE (OT2.AssessRequired = 0 OR (OT2.AssessRequired = 1 AND OT2.StatusID = 1)) AND ' + @sWhereSub + '
										GROUP BY OT2.APKMaster
									) AS O3 ON O1.APKMaster = O3.APKMaster AND O2.CountSetting = O3.CountAssess
									INNER JOIN KPIT10501 K1 WITH (NOLOCK) ON K1.TargetsID = O.TargetTypeID
									INNER JOIN KPIT10502 K2 WITH (NOLOCK) ON K2.APKMaster = K1.APK
									INNER JOIN KPIT10101 K3 WITH (NOLOCK) ON K3.TargetsGroupID = K2.TargetsGroupID
									INNER JOIN KPIT10102 K4 WITH (NOLOCK) ON K4.APKMaster = K3.APK
									INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = O.AssignedToUserID
										AND A1.DepartmentID = K2.DepartmentID AND A1.DepartmentID = K4.DepartmentID
									LEFT JOIN #PunishTable T01 ON (O.ActualTime - O.PlanTime) > 0
										AND (O.ActualTime - O.PlanTime) / O.PlanTime * 100.0 >= T01.StartHour
										AND (T01.EndHour IS NULL
										OR (O.ActualTime - O.PlanTime) / O.PlanTime * 100.0 < T01.EndHour)
								WHERE '+ @sWhere +'
								GROUP BY O.APK, O.TaskID, O.TaskName, O1.TargetsGroupID, K1.TargetsName, K2.Percentage
									, K4.Percentage, O1.Mark, K1.TargetsID, T01.PunishRate
								) AS T1
							PIVOT
							(
								SUM(Mark)
								FOR TargetsGroupID IN (' + @ListGroup + ')
							) AS T2
						) AS T3
					GROUP BY T3.TargetsGroupID, T3.TargetsGroupName, T3.TargetsPercentage, T3.TypeData'
					
			EXEC (@sSQL)
			--PRINT (@sSQL)
		END


	-- Lấy dữ liệu phần trăm chỉ tiêu Kiểm tra, giám sát, hỗ trợ của người quản lý nhận được
	IF @Mode = 5
	BEGIN
		IF ISNULL(@Formula, '') != ''
		BEGIN
			SET @sWhere = 'O.AssignedToUserID NOT LIKE (''' + @AssignedToUserID + ''') AND O.StatusID IN (''TTCV0003'')
						   AND MONTH(O.ActualEndDate) = ' + CAST(@TranMonth AS VARCHAR(10)) + '
						   AND YEAR(O.ActualEndDate) = ' + CAST(@TranYear AS VARCHAR(10)) + '
						   AND CAST(CONCAT(' + CAST(@TranYear AS VARCHAR(10)) + ', ''-'', ' + CAST(@TranMonth AS VARCHAR(10)) + ', ''-01'') AS DATETIME) BETWEEN K5.EffectDate AND K5.ExpiryDate'
	
			SET @sWhereSub = 'OT1.AssignedToUserID NOT LIKE (''' + @AssignedToUserID + ''') AND OT1.StatusID IN (''TTCV0003'')
							 AND MONTH(OT1.ActualEndDate) = ' + CAST(@TranMonth AS VARCHAR(10)) + ' 
							 AND YEAR(OT1.ActualEndDate) = ' + CAST(@TranYear AS VARCHAR(10)) + '
							 '

			SET @sSQL = 'SELECT SUM(((T2.TargetsPercentage * T2.Percentage / 100.0) ' + @Formula + ') * (T2.PercentKPIManager / 100)) AS Total
							FROM (
								SELECT O.APK
									 , O.TaskID
									 , O.TaskName
									 , O1.Mark
									 , REPLACE(O1.TargetsGroupID, ''.'', '''') AS TargetsGroupID
									 , K1.TargetsName
									 , K2.Percentage AS TargetsPercentage
									 , K4.Percentage
									 , K5.PercentKPIManager
								FROM OOT2110 O WITH (NOLOCK) 
									INNER JOIN OOT2130 O1 WITH (NOLOCK) ON O1.APKMaster = O.APK
									INNER JOIN (
										SELECT OO1.DivisionID, COUNT(*) AS CountSetting
										FROM OOT0050 OO1 WITH (NOLOCK)
											INNER JOIN OOT0051 OO2 WITH (NOLOCK) ON OO1.APKMaster = OO2.APK
										WHERE OO1.DivisionID = ''' + @DivisionID + ''' AND ISNULL(OO1.NoDisplay, 0) = 0 AND OO2.ObjectID = ''CV''
										GROUP BY OO1.DivisionID
										) AS O2 ON O.DivisionID = O2.DivisionID
									INNER JOIN (
										SELECT OT2.APKMaster, COUNT(*) AS CountAssess
										FROM OOT2110 OT1 WITH (NOLOCK)
											INNER JOIN OOT2130 OT2 WITH (NOLOCK) ON OT1.TaskID = OT2.TaskID
										WHERE (OT2.AssessRequired = 0 OR (OT2.AssessRequired = 1 AND OT2.StatusID = 1)) AND ' + @sWhereSub + '
										GROUP BY OT2.APKMaster
										) AS O3 ON O1.APKMaster = O3.APKMaster AND O2.CountSetting = O3.CountAssess
									INNER JOIN KPIT10501 K1 WITH (NOLOCK) ON K1.TargetsID = O.TargetTypeID
									INNER JOIN KPIT10502 K2 WITH (NOLOCK) ON K2.APKMaster = K1.APK
									INNER JOIN KPIT10101 K3 WITH (NOLOCK) ON K3.TargetsGroupID = K2.TargetsGroupID
									INNER JOIN KPIT10102 K4 WITH (NOLOCK) ON K4.APKMaster = K3.APK
									INNER JOIN KPIT2020 K5 WITH (NOLOCK) ON K5.EmployeeID = ''' + @AssignedToUserID + '''
									INNER JOIN AT1102 A2 WITH (NOLOCK) ON A2.ContactPerson = ''' + @AssignedToUserID + '''
										AND A2.DepartmentID = K2.DepartmentID AND A2.DepartmentID = K4.DepartmentID
								WHERE ' + @sWhere + ') AS T1
							PIVOT 
							(
								SUM(Mark)
								FOR TargetsGroupID IN (' + @ListGroup + ')
							) AS T2 '
			EXEC (@sSQL)
			PRINT (@sSQL)
		END
		ELSE
		BEGIN
			SELECT 0.0 AS Total
		END
	END

END





















GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
