IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP30224]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP30224]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO












-- <Summary>
---- Dữ liệu KPI load chart
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 26/08/2019 by Đình Ly
----Modified on 26/11/2020 by Vĩnh Tâm	: Fix lỗi syntax khi không thiết lập Đánh giá công việc cho Mode 1
----Modified on 07/07/2021 by Văn Tài	: Mode 4 bổ sung lấy BHYT, BHXH, Kinh phí công đoàn.

CREATE PROCEDURE [dbo].[KPIP30224]
(
	@DivisionID varchar(50),
	@AssignedToUserID varchar(50),
	@TranDay INT,
	@TranMonth INT,
	@TranYear INT,
	@Mode INT
)
AS
BEGIN
	DECLARE @sSQL NVARCHAR (MAX),
			@sWhere NVARCHAR(MAX),
			@sWhereSub NVARCHAR(MAX),
			@OrderBy NVARCHAR(500),
			@DataKPI NVARCHAR (MAX),
			@SystemFunctionID INT,
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
		INNER JOIN OOT0051 O2 WITH (NOLOCK) ON O1.APKMaster = O2.APK AND ISNULL(O2.NotUseAssess, 0) = 0
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

	SET @ListGroup = SUBSTRING(@ListGroup, 2, LEN(@ListGroup))

	-- Kiểm tra phòng ban nhân viên 
	SELECT @SystemFunctionID = A.ID
	FROM AT0099 A
		INNER JOIN AT1102 A1 ON A1.SystemFunctionID = A.ID
		INNER JOIN AT1103 A2 ON A2.DepartmentID = A1.DepartmentID
	WHERE A2.EmployeeID = @AssignedToUserID AND A.CodeMaster = 'SystemFunctionID'
		-- Điều kiện lọc dữ liệu KPI hoàn thành công việc
		SET @sWhere = 'O.AssignedToUserID = ''' + @AssignedToUserID + ''' AND O.StatusID IN (''TTCV0003'')
						AND MONTH(O.ActualEndDate) = ' + CAST(@TranMonth AS VARCHAR(10)) + ' AND YEAR(O.ActualEndDate) = ' + CAST(@TranYear AS VARCHAR(10)) + ''

		SET @sWhereSub = 'OT1.AssignedToUserID IN (''' + @AssignedToUserID + ''') AND OT1.StatusID IN (''TTCV0003'')
						AND MONTH(OT1.ActualEndDate) = ' + CAST(@TranMonth AS VARCHAR(10)) + ' AND YEAR(OT1.ActualEndDate) = ' + CAST(@TranYear AS VARCHAR(10)) + ''


	DECLARE @PunishTable TABLE (
		StartHour DECIMAL(28,8),
		EndHour DECIMAL(28,8),
		PunishRate DECIMAL(28,8)
	)

	-- Lấy dữ liệu Bảng giờ công vi phạm
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

	-- Model 1: Dữ liệu KPI hoàn thành công việc
	IF @Mode = 1
	BEGIN

		IF ISNULL(@ListGroup, '') = ''
		BEGIN
			SELECT TOP 0 NULL AS RedLimit, NULL AS WarningLimit, NULL AS PercentCompleteTask
			RETURN
		END

		-- Lấy ra tổng phần trăm KPI hoàn thành công việc
		-- Giới hạn đỏ và giới hạn cảnh báo up&down của nhân viên đó
		SET @DataKPI = 'SELECT T2.RedLimit, T2.WarningLimit
							, SUM((100 - ISNULL(T2.PunishRate, 0)) / 100 * ((T2.TargetsPercentage * T2.Percentage / 100.0) ' + @Formula + ')) AS PercentCompleteTask
						FROM (
							SELECT O.APK
								, O.TaskID
								, O.TaskName
								, O1.Mark
								, REPLACE(O1.TargetsGroupID, ''.'', '''') AS TargetsGroupID
								, K1.TargetsName
								, K2.Percentage AS TargetsPercentage
								, K4.Percentage 
								, K5.RedLimit
								, K5.WarningLimit
								, T01.PunishRate
							FROM OOT2110 O WITH (NOLOCK)
								INNER JOIN OOT2130 O1 WITH (NOLOCK) ON O1.APKMaster = O.APK
								INNER JOIN (
									SELECT OO1.DivisionID, COUNT(*) AS CountSetting
									FROM OOT0050 OO1 WITH (NOLOCK)
										INNER JOIN OOT0051 OO2 WITH (NOLOCK) ON OO1.APKMaster = OO2.APK AND ISNULL(OO2.NotUseAssess, 0) = 0
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
								INNER JOIN KPIT2020 K5 WITH (NOLOCK) ON K5.EmployeeID = O.AssignedToUserID
								INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = ''' + @AssignedToUserID + '''
																	AND A1.DepartmentID = K2.DepartmentID
																	AND A1.DepartmentID = K4.DepartmentID
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
						GROUP BY T2.RedLimit, T2.WarningLimit'
		EXEC (@DataKPI)
	END

	-- Model 2: Dữ liệu KPI doanh số NET
	IF(@Mode = 2)
	BEGIN
		-- Trường hợp đây là nhân viên sales
		IF(@SystemFunctionID = 6)
		BEGIN
			-- Điều kiện lọc khi get dữ liệu KPI doanh số NET
			SET @sWhere = 'O.DivisionID = ''' + @DivisionID + '''
						AND  ISNULL(O.DeleteFlg, 0) = 0
						AND MONTH(O.CreateDate) = ' + CAST(@TranMonth AS VARCHAR(10)) + '
						AND YEAR(O.CreateDate) = ' + CAST(@TranYear AS VARCHAR(10)) + '
						AND C1.AssignedToUserID IN (''' + @AssignedToUserID + ''') '

			-- Lấy ra tổng doanh thu doanh số NET cho tất cả các dự án
			SET @DataKPI = 'SELECT SUM((K1.TargetSalesRate * O.NetSales)) AS TotalSaleNet
						FROM OOT2100 O WITH (NOLOCK)
							INNER JOIN CRMT20501 C1 WITH (NOLOCK) ON O.OpportunityID = C1.OpportunityID
							INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = C1.AssignedToUserID
							INNER JOIN AT1102 A2 WITH (NOLOCK) ON A2.DepartmentID = A1.DepartmentID
							INNER JOIN KPIT2020 K1 WITH (NOLOCK) ON K1.EmployeeID = C1.AssignedToUserID
						WHERE ' + @sWhere + ''
			EXEC (@DataKPI)
		END
		ELSE
		BEGIN
			-- Điều kiện lọc khi get dữ liệu KPI
			SET @sWhere = 'O.DivisionID = ''' + @DivisionID + ''' AND  ISNULL(O.DeleteFlg, 0) = 0
							AND MONTH(O.CreateDate) = ' + CAST(@TranMonth AS VARCHAR(10)) + '
							AND YEAR(O.CreateDate) = ' + CAST(@TranYear AS VARCHAR(10)) + ''

			-- Lấy ra tổng doanh thu doanh số NET cho tất cả các dự án
			SET @DataKPI = '
					SELECT T1.*
					FROM (
						SELECT DISTINCT SUM((K1.TargetSalesRate * O.NetSales)) AS TotalSaleNet
						FROM OOT2100 O WITH (NOLOCK)
							INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.DivisionID = O.DivisionID AND ISNULL(A1.Disabled, 0) = 0
							INNER JOIN KPIT2020 K1 WITH (NOLOCK) ON K1.EmployeeID = ''' + @AssignedToUserID + '''
						WHERE ' + @sWhere + ') AS T1'
			EXEC (@DataKPI)
		END
	END

	-- Mode 3: Tổng phần trăm KPI bị trừ cho các công việc cố tình vi phạm
	IF @Mode = 3
		BEGIN
			-- Điều kiện lọc khi get dữ liệu KPI cố tình vi phạm
			SET @sWhere = 'O.AssignedToUserID IN (''' + @AssignedToUserID + ''')
							AND O.IsViolated IN (''1'') AND DAY(O.ActualEndDate) <= ' + CAST(@TranDay AS VARCHAR(10)) + '
							AND MONTH(O.ActualEndDate) = ' + CAST(@TranMonth AS VARCHAR(10)) + ' AND YEAR(O.ActualEndDate) = ' + CAST(@TranYear AS VARCHAR(10)) + ''

			-- Lấy ra danh sách tổng phần trăm KPI cố tình vi phạm
			SET @DataKPI = 'SELECT H1.BaseSalary
									, SUM(K2.Percentage * 3) AS ViolatedPercent
									, (H1.BaseSalary / 100) * SUM(K2.Percentage * 3) AS ViolatedSalary
								FROM OOT2110 O WITH (NOLOCK)
									INNER JOIN KPIT10501 K1 WITH (NOLOCK) ON K1.TargetsID = O.TargetTypeID
									INNER JOIN KPIT10502 K2 WITH (NOLOCK) ON K2.APKMaster = K1.APK
									INNER JOIN HT2400 H1 WITH (NOLOCK) ON H1.EmployeeID = ''' + @AssignedToUserID + '''
																	AND H1.DepartmentID = K2.DepartmentID
									INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = ''' + @AssignedToUserID + '''
																	AND A1.DepartmentID = K2.DepartmentID
								WHERE ' + @sWhere + '
								GROUP BY H1.BaseSalary'
			EXEC (@DataKPI)
		END

	-- Mode 4: Dữ liệu tiền bảo hiểm và thu nhập cá nhân
	IF @Mode = 4
		BEGIN
			-- Điều kiện lấy dữ liệu tiền bảo hiển và thu nhập cá nhân
			SET @sWhere = 'H1.EmployeeID IN (''' + @AssignedToUserID + ''') AND CAST(H1.TranMonth AS VARCHAR(10)) = ' + CAST(@TranMonth AS VARCHAR(10)) + '
																			AND CAST(H1.TranYear AS VARCHAR(10)) = ' + CAST(@TranYear AS VARCHAR(10)) + ''
			-- Lấy ra dữ liệu tiền bảo hiểm và thu nhập cá nhân
			SET @DataKPI = 'SELECT (H1.SRate + H1.HRate + H1.TRate) AS InsurrancePercent
								 , (H1.SAmount + H1.HAmount + H1.TAmount) AS InsurranceMoney
								 , H2.IncomeTax AS PersonalIncome
							FROM HT2461 H1 WITH (NOLOCK)
									LEFT JOIN HT0338 H2 WITH (NOLOCK) ON H2.EmployeeID = H1.EmployeeID AND H2.TranMonth = H1.TranMonth AND H2.TranYear = H1.TranYear
							WHERE ' + @sWhere + ' '
			EXEC (@DataKPI)
		END


	-- Mode 5: Dữ liệu lương mềm và thu nhập cá nhân
	IF @Mode = 5
		BEGIN
			-- Điều kiện lấy dữ liệu lương mềm, thu nhập cá nhân
			SET @sWhere = 'K.EmployeeID IN (''' + @AssignedToUserID + ''') AND CAST(K.TranMonth AS VARCHAR(10)) = ' + CAST(@TranMonth AS VARCHAR(10)) + '
																			AND CAST(K.TranYear AS VARCHAR(10)) = ' + CAST(@TranYear AS VARCHAR(10)) + ''
			-- Lấy ra dữ liệu lương mềm và thu nhập cá nhân
			SET @DataKPI = 'SELECT K.ActualEffectiveSalary AS IncurredSalary
							FROM KPIT2040 K WITH (NOLOCK)
							WHERE ' + @sWhere + ' '
			EXEC (@DataKPI)
		END

	-- Mode 6: Dữ liệu lương mềm tháng trước nếu chưa được nhận
	IF @Mode = 6
	BEGIN
		-- Điều kiện lấy ra lương mềm tháng trước nếu chưa được nhận
		SET @sWhere = 'K.EmployeeID IN (''' + @AssignedToUserID + ''') AND CAST(K.TranMonth AS VARCHAR(10)) = ' + CAST((@TranMonth - 1) AS VARCHAR(10)) + '
																		AND CAST(K.TranYear AS VARCHAR(10)) = ' + CAST(@TranYear AS VARCHAR(10)) + ''
		-- Lấy ra dữ liệu lương mềm tháng trước nếu chưa được nhận
		SET @DataKPI = 'SELECT K.ActualEffectiveSalary AS IncurredSalary, K.GetSortSalary
						FROM KPIT2040 K WITH (NOLOCK)
						WHERE ' + @sWhere + ' '
		EXEC (@DataKPI)
	END

	-- Model 7: Dữ liệu KPI hoàn thành công việc customize DTI
	IF @Mode = 7
	BEGIN
		DECLARE @KPIPoint DECIMAL(28, 8) = 0
		-- Create table để chứa store 3 KPI
		DECLARE @KPI AS TABLE (STT VARCHAR(10),
								TargetsID NVARCHAR(250),
								TargetsName NVARCHAR(250),
								Quantity DECIMAL(28,4),
								TargetsGroupPercentage DECIMAL(28,4),
								Total DECIMAL(28,4),
								TypeData VARCHAR(10),
								EmployeeID VARCHAR(50)
		)

		INSERT INTO @KPI (STT, TargetsID, TargetsName, Quantity, TargetsGroupPercentage, Total, TypeData)
		EXEC KPIP30221_DTI @DivisionID, @AssignedToUserID, @TranMonth, @TranYear, '4'

		-- Lấy dữ liệu KPI quản lý
		INSERT INTO @KPI (STT, TargetsID, TargetsName, Quantity, TargetsGroupPercentage, Total, TypeData)
		EXEC KPIP30221_DTI @DivisionID, @AssignedToUserID, @TranMonth, @TranYear, '5'

		SELECT @KPIPoint = ISNULL(SUM(T1.Total), 0) FROM @KPI AS T1

		SELECT K1.RedLimit, K1.WarningLimit, @KPIPoint AS PercentCompleteTask
		FROM KPIT2020 K1 WITH (NOLOCK)
		WHERE K1.EmployeeID = @AssignedToUserID
			AND CAST(CONCAT(@TranYear, '-', @TranMonth, '-01') AS DATETIME) BETWEEN K1.EffectDate AND K1.ExpiryDate
	END

END
PRINT(@DataKPI)











GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
