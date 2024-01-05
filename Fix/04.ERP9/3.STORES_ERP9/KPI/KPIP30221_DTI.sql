IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP30221_DTI]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP30221_DTI]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- KPI kết quả làm việc customize cho khách hàng Đức Tín - DTI
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
-- Create on 22/02/2020 by Vĩnh Tâm
-- Modified on 03/04/2020 by Vĩnh Tâm: Bổ sung mode 7 trả về tổng điểm KPI của quản lý
-- Modified on 04/05/2020 by Vĩnh Tâm: Sửa lỗi Điểm tỷ trọng không bị trừ khi công việc bị trễ tiến độ ở mode 3
-- Modified on 05/10/2023 by Kiều Nga: [2023/10/IS/0002] Fix lỗi load thiếu task khi mã cv bị thay đổi
-- Modified on 03/01/2024 by Kiều Nga: [2024/01/IS/0001] Fix lỗi không load dữ liệu cột tỷ lệ hoàn thành

CREATE PROCEDURE [dbo].[KPIP30221_DTI]
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
										INNER JOIN OOT2130 OT2 WITH (NOLOCK) ON OT1.APK = OT2.APKMaster
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
		SET @sSQL = 'SELECT ROW_NUMBER() OVER(ORDER BY T3.TargetsName) STT
						, T3.TargetsName
						, COUNT(T3.TargetsName) AS Quantity
						, T3.TargetsPercentageOrigin
						, SUM(T3.Total) AS Total
						, ''1'' AS TypeData
					FROM (
						SELECT 
							  T2.TargetsName
							, T2.TargetsPercentageOrigin
							, (T2.TargetsPercentage * T2.Percentage / 100.0) ' + @Formula + ' AS Total
						FROM (
							SELECT O.APK, O.TaskID, O.TaskName, O1.Mark
								 , REPLACE(O1.TargetsGroupID, ''.'', '''') AS TargetsGroupID
								 , K1.TargetsName
								 , IIF(O.PlanTime < O.ActualTime AND O.PlanEndDate < O.ActualEndDate, 0, K2.Percentage) AS TargetsPercentage
								 , K2.Percentage AS TargetsPercentageOrigin
								 , K4.Percentage
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
										INNER JOIN OOT2130 OT2 WITH (NOLOCK) ON OT1.APK = OT2.APKMaster
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
						) AS T2
					) AS T3
					GROUP BY T3.TargetsName, T3.TargetsPercentageOrigin'
		EXEC (@sSQL)
		--PRINT(@sSQL)
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
									 , IIF(O.PlanTime < O.ActualTime AND O.PlanEndDate < O.ActualEndDate, 0, K2.Percentage) AS TargetsPercentage
									 , K4.Percentage
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
											INNER JOIN OOT2130 OT2 WITH (NOLOCK) ON OT1.APK = OT2.APKMaster
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
					, T3.TargetsPercentageOrigin, SUM(T3.Total) AS Total, 1 AS TypeData
				FROM (
						SELECT T2.TargetsID AS TargetsGroupID, T2.TargetsName AS TargetsGroupName
							, T2.TargetsPercentageOrigin
							, (T2.TargetsPercentage * T2.Percentage / 100.0) ' + @Formula + ' AS Total
						FROM (	
								SELECT O.APK, O.TaskID, O.TaskName
									, REPLACE(O1.TargetsGroupID, ''.'', '''') AS TargetsGroupID
									, K1.TargetsID, K1.TargetsName
									, IIF(O.PlanTime < O.ActualTime AND O.PlanEndDate < O.ActualEndDate, 0, K2.Percentage) AS TargetsPercentage
									, K2.Percentage AS TargetsPercentageOrigin
									, K4.Percentage
									, O1.Mark
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
											INNER JOIN OOT2130 OT2 WITH (NOLOCK) ON OT1.APK = OT2.APKMaster
										WHERE (OT2.AssessRequired = 0 OR (OT2.AssessRequired = 1 AND OT2.StatusID = 1)) AND ' + @sWhereSub + '
										GROUP BY OT2.APKMaster
									) AS O3 ON O1.APKMaster = O3.APKMaster AND O2.CountSetting = O3.CountAssess
									INNER JOIN KPIT10501 K1 WITH (NOLOCK) ON K1.TargetsID = O.TargetTypeID
									INNER JOIN KPIT10502 K2 WITH (NOLOCK) ON K2.APKMaster = K1.APK
									INNER JOIN KPIT10101 K3 WITH (NOLOCK) ON K3.TargetsGroupID = K2.TargetsGroupID
									INNER JOIN KPIT10102 K4 WITH (NOLOCK) ON K4.APKMaster = K3.APK
									INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = O.AssignedToUserID
										AND A1.DepartmentID = K2.DepartmentID AND A1.DepartmentID = K4.DepartmentID
								WHERE '+ @sWhere +'
								) AS T1
							PIVOT
							(
								SUM(Mark)
								FOR TargetsGroupID IN (' + @ListGroup + ')
							) AS T2
						) AS T3
					GROUP BY T3.TargetsGroupID, T3.TargetsGroupName, T3.TargetsPercentageOrigin'
					
			EXEC (@sSQL)
			PRINT (@sSQL)
		END


	-- Lấy dữ liệu phần trăm chỉ tiêu Kiểm tra, giám sát, hỗ trợ của người quản lý nhận được
	-- Mode 5, 6: Trả về bảng dữ liệu, khác nhau về số lượng cột
	-- Mode 7: Trả về tổng điểm KPI của quản lý
	IF @Mode IN (5, 6, 7)
	BEGIN
		IF ISNULL(@Formula, '') != '' AND EXISTS (SELECT TOP 1 1 FROM AT1102 WHERE ContactPerson = @AssignedToUserID)
		BEGIN
			-- Điểm KPI quản lý
			DECLARE @KPIManager DECIMAL(28, 8) = 0

			SET @sWhere = 'O.AssignedToUserID NOT IN (''' + @AssignedToUserID + ''') AND O.StatusID IN (''TTCV0003'')
						   AND MONTH(O.ActualEndDate) = ' + CAST(@TranMonth AS VARCHAR(10)) + '
						   AND YEAR(O.ActualEndDate) = ' + CAST(@TranYear AS VARCHAR(10)) + '
						   AND CAST(CONCAT(' + CAST(@TranYear AS VARCHAR(10)) + ', ''-'', ' + CAST(@TranMonth AS VARCHAR(10)) + ', ''-01'') AS DATETIME) BETWEEN K5.EffectDate AND K5.ExpiryDate'
	
			SET @sWhereSub = 'OT1.AssignedToUserID NOT IN (''' + @AssignedToUserID + ''') AND OT1.StatusID IN (''TTCV0003'')
							 AND MONTH(OT1.ActualEndDate) = ' + CAST(@TranMonth AS VARCHAR(10)) + ' 
							 AND YEAR(OT1.ActualEndDate) = ' + CAST(@TranYear AS VARCHAR(10)) + '
							 '

			SET @sSQL = 'SELECT @Result = ISNULL(SUM(((T2.TargetsPercentage * T2.Percentage / 100.0) ' + @Formula + ') * (T2.PercentKPIManager / 100)), 0)
							FROM (
								SELECT O.APK
									 , O.TaskID
									 , O.TaskName
									 , O1.Mark
									 , REPLACE(O1.TargetsGroupID, ''.'', '''') AS TargetsGroupID
									 , K1.TargetsName
									 , IIF(O.PlanTime < O.ActualTime AND O.PlanEndDate < O.ActualEndDate, 0, K2.Percentage) AS TargetsPercentage
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
											INNER JOIN OOT2130 OT2 WITH (NOLOCK) ON OT1.APK = OT2.APKMaster
											INNER JOIN AT1103 AT1 WITH (NOLOCK) ON AT1.EmployeeID = ''' + @AssignedToUserID + '''
											INNER JOIN AT1102 AT2 WITH (NOLOCK) ON AT1.DepartmentID = AT2.DepartmentID
											INNER JOIN AT1103 AT3 WITH (NOLOCK) ON AT3.DepartmentID = AT2.DepartmentID
										WHERE (OT2.AssessRequired = 0 OR (OT2.AssessRequired = 1 AND OT2.StatusID = 1))
											AND OT1.AssignedToUserID = AT3.EmployeeID
											AND ' + @sWhereSub + '
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
			EXEC SP_EXECUTESQL @sSQL, N'@Result DECIMAL(28, 8) OUTPUT', @Result = @KPIManager OUTPUT
			PRINT (@sSQL)
			
			IF @Mode = 5
			BEGIN
				SELECT 1 AS STT, K1.TargetsID, K1.TargetsName, 1 AS Quantity, K2.Percentage, @KPIManager AS Total, 11 AS TypeData
				FROM KPIT10501 K1 WITH (NOLOCK)
					INNER JOIN KPIT10502 K2 WITH (NOLOCK) ON K1.APK = K2.APKMaster
					INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = @AssignedToUserID AND A1.DepartmentID = K2.DepartmentID
				-- Mã chỉ tiêu được hardcode cứng trong hệ thống và phải luôn luôn tồn tại trong Danh sách Loại chỉ tiêu KPI
				WHERE K1.TargetsID = 'CT.DTI.QL01'
			END
			
			IF @Mode = 6
			BEGIN
				SELECT 1 AS STT, K1.TargetsName, 1 AS Quantity, K2.Percentage, @KPIManager AS Total, 11 AS TypeData
				FROM KPIT10501 K1 WITH (NOLOCK)
					INNER JOIN KPIT10502 K2 WITH (NOLOCK) ON K1.APK = K2.APKMaster
					INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = @AssignedToUserID AND A1.DepartmentID = K2.DepartmentID
				-- Mã chỉ tiêu được hardcode cứng trong hệ thống và phải luôn luôn tồn tại trong Danh sách Loại chỉ tiêu KPI
				WHERE K1.TargetsID = 'CT.DTI.QL01'
			END

			IF @Mode = 7
			BEGIN
				SELECT @KPIManager AS KPIManager
			END
		END
	END
END



























GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

