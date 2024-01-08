IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP30222]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP30222]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO












-- <Summary>
---- KPI doanh số NET
-- <Param>
---- 
-- <Return>
---- 
---- <Reference>

-- <History>
----Create on 23/08/2019 by Đình Ly
----update on 08/01/2021 by  Bổ sung điều kiện trạng thái báo giá sale đã hoàn tất

CREATE PROCEDURE [dbo].KPIP30222
(
	@DivisionID varchar(50),
	@AssignedToUserID varchar(50),
	@TranMonth INT,
	@TranYear INT,
	@Mode INT
)
AS
BEGIN
	DECLARE @sSQL NVARCHAR (MAX),
			@sWhere NVARCHAR(MAX),
			@sWhere1 NVARCHAR(MAX),
			@sWhereSale NVARCHAR(MAX) = '',
			@OrderBy NVARCHAR(500),
			@TaskList NVARCHAR (MAX),
			@TaskList2 NVARCHAR (MAX),
			@SystemFunctionID INT,
			@ListGroup NVARCHAR(MAX) = '',
			@Formula NVARCHAR(MAX) = '',
			@Cur CURSOR,
			@ListGroup1 NVARCHAR(MAX) = '',
			@Formula1 NVARCHAR(MAX) = '',
			@Cur1 CURSOR

	DECLARE @TargetsGroupID NVARCHAR(50),
			@Percentage DECIMAL(28,2) = 0,
			@TargetPercentProject DECIMAL(28,2) = 0

			
	-- Trường hợp có sử dụng Đánh giá dự án
	IF NOT EXISTS(SELECT TOP 1 1 FROM OOT0051 WITH (NOLOCK) WHERE ObjectID = 'DA' AND ISNULL(NotUseAssess, 1) = 0)
	BEGIN

		---- Thực hiện get dữ liệu % của dự án trong nhóm chỉ tiêu
		SELECT @TargetPercentProject = ISNULL(K2.Percentage, 0)
		FROM KPIT10101 K1 WITH (NOLOCK)
			INNER JOIN KPIT10102 K2 WITH (NOLOCK) ON K1.APK = K2.APKMaster
			INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID IN (@AssignedToUserID) AND A1.DepartmentID =  K2.DepartmentID
		WHERE NOT EXISTS (
			SELECT 1
			FROM OOT0050 O1
				INNER JOIN OOT0051 O2 WITH (NOLOCK) ON O1.APKMaster = O2.APK
			WHERE O2.ObjectID = 'DA' AND K1.TargetsGroupID = O1.TargetsGroupID
		)

		-- Lặp danh sách các Nhóm chỉ tiêu được Đánh giá điểm KPI để tạo thành công thức tính
		SET @Cur = CURSOR SCROLL KEYSET FOR
		SELECT REPLACE(O1.TargetsGroupID, '.', '') AS TargetsGroupID, K2.Percentage
		FROM OOT0050 O1 WITH (NOLOCK)
			INNER JOIN OOT0051 O2 WITH (NOLOCK) ON O1.APKMaster = O2.APK --AND ISNULL(O2.NotUseAssess, 1) = 0
			INNER JOIN KPIT10101 K1 WITH (NOLOCK) ON O1.TargetsGroupID = K1.TargetsGroupID
			INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = @AssignedToUserID
			INNER JOIN KPIT10102 K2 WITH (NOLOCK) ON K1.APK = K2.APKMaster AND K2.DivisionID = @DivisionID AND K2.DepartmentID = A1.DepartmentID
		WHERE ISNULL(O1.NoDisplay, 0) = 0 AND O2.ObjectID = 'DA'
		OPEN @Cur
		FETCH NEXT FROM @Cur INTO @TargetsGroupID, @Percentage
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @ListGroup = @ListGroup + ',' + REPLACE(@TargetsGroupID, '.', '')
			SET @Formula = @Formula + '+ (T2.Total * ' + CAST(@Percentage AS NVARCHAR(50)) + ' / 100.0) * (ISNULL(' + @TargetsGroupID + ', 100) / 100.0)'
			FETCH NEXT FROM @Cur INTO @TargetsGroupID, @Percentage
		END
		CLOSE @Cur

		-- Loại bỏ dấu phẩy (,) dư ở đầu chuỗi
		SET @ListGroup = SUBSTRING(@ListGroup, 2, LEN(@ListGroup))
		--PRINT(@ListGroup)
	END

	SET @OrderBy = ' O.ProjectName '

	SELECT @SystemFunctionID = A.ID
	FROM AT0099 A WITH (NOLOCK)
		INNER JOIN AT1102 A1 WITH (NOLOCK) ON A1.SystemFunctionID = A.ID
		INNER JOIN AT1103 A2 WITH (NOLOCK) ON A2.DepartmentID = A1.DepartmentID
	WHERE A2.EmployeeID = @AssignedToUserID AND A.CodeMaster = 'SystemFunctionID'

	-- Trường hợp là nhân viên sale thì gắn thêm điều kiện lọc Cơ hội của user đăng nhập
	IF (@SystemFunctionID = 6)
	BEGIN
		SET @sWhereSale = 'C1.AssignedToUserID = ''' + @AssignedToUserID + ''' AND '
	END

	-- Điều kiện lọc khi get dữ liệu KPI
	SET @sWhere1 = @sWhereSale + 'A1.EmployeeID = ''' + @AssignedToUserID + ''' AND MONTH(O.CreateDate) = ' + CAST(@TranMonth AS NVARCHAR(10)) + ' AND YEAR(O.CreateDate) = ' + CAST(@TranYear AS NVARCHAR(10)) + '
					AND CAST(CONCAT(' + CAST(@TranYear AS NVARCHAR(10)) + ', ''-'', ' + CAST(@TranMonth AS NVARCHAR(10)) + ', ''-01'') AS DATETIME) BETWEEN K1.EffectDate AND K1.ExpiryDate'

	IF (@Mode = 2)
	BEGIN
		-- Trường hợp đây là nhân viên sales
		IF(@SystemFunctionID = 6)
		BEGIN
			-- Điều kiện lọc khi get dữ liệu KPI
			SET @sWhere = 'O.DivisionID = ''' + @DivisionID + '''
						AND ISNULL(O.DeleteFlg, 0) = 0
						AND MONTH(O.CreateDate) = ' + CAST(@TranMonth AS VARCHAR(10)) + '
						AND YEAR(O.CreateDate) = ' + CAST(@TranYear AS VARCHAR(10)) + '
						AND C1.AssignedToUserID IN (''' + @AssignedToUserID + ''') '

			-- Lấy ra danh sách dự án và KPI doanh số NET của từng dự án
			SET @TaskList = 'SELECT ROW_NUMBER() OVER(ORDER BY ' + @OrderBy +') STT
							, O.ProjectName
							, K1.TargetSalesRate
							, O.NetSales
							, (K1.TargetSalesRate * O.NetSales) AS Total
							, 2 AS TypeData
						FROM OOT2100 O WITH (NOLOCK)
							INNER JOIN CRMT20501 C1 WITH (NOLOCK) ON O.OpportunityID = C1.OpportunityID
							INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = C1.AssignedToUserID
							INNER JOIN AT1102 A2 WITH (NOLOCK) ON A2.DepartmentID = A1.DepartmentID
							INNER JOIN KPIT2020 K1 WITH (NOLOCK) ON K1.EmployeeID = C1.AssignedToUserID
						WHERE ' + @sWhere + '
						ORDER BY ' + @OrderBy + ''
			EXEC (@TaskList)
			--PRINT (@TaskList)
		END
		ELSE
		BEGIN
			-- Điều kiện lọc khi get dữ liệu KPI
			SET @sWhere = 'O.DivisionID = ''' + @DivisionID + ''' AND  ISNULL(O.DeleteFlg, 0) = 0
							AND MONTH(O.CreateDate) = ' + CAST(@TranMonth AS VARCHAR(10)) + '
							AND YEAR(O.CreateDate) = ' + CAST(@TranYear AS VARCHAR(10)) + ''
			SET @OrderBy = ' T1.ProjectName '

			-- Lấy ra danh sách dự án và KPI doanh số NET của từng dự án
			SET @TaskList = '
					SELECT ROW_NUMBER() OVER(ORDER BY ' + @OrderBy +') STT, T1.*
					FROM (
						SELECT DISTINCT
							  O.ProjectName
							, K1.TargetSalesRate
							, O.NetSales
							, (K1.TargetSalesRate * O.NetSales) AS Total
							, 2 AS TypeData
						FROM OOT2100 O WITH (NOLOCK)
							INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.DivisionID = O.DivisionID AND ISNULL(A1.Disabled, 0) = 0
							INNER JOIN KPIT2020 K1 WITH (NOLOCK) ON K1.EmployeeID = ''' + @AssignedToUserID + '''
						WHERE ' + @sWhere + ') AS T1
					ORDER BY ' + @OrderBy + ''
			EXEC (@TaskList)
			--PRINT (@TaskList)
		END
	END

	IF(@Mode = 4)
	BEGIN
		-- Trường hợp đây là nhân viên sales
		IF(@SystemFunctionID = 6)
		BEGIN
			SET @OrderBy = 'T3.TypeData'
			-- Lấy ra danh sách dự án và KPI doanh số NET của từng dự án
			SET @TaskList = N'
						SELECT
							O.ProjectID
							, O.ProjectName AS TargetsGroupName
							, K1.TargetSalesRate AS Quantity
							, (S1.PlusCost / ISNULL(S1.Factor, 1) + S1.PlusCost) AS TargetSalesRate
							, (K1.TargetSalesRate * (S1.PlusCost / ISNULL(S1.Factor, 1) + S1.PlusCost)) AS Total
							, 1 AS TypeData
							, ISNULL(O1.Mark, 100) AS Mark
							, REPLACE(O1.TargetsGroupID, ''.'', '''') AS TargetsGroupID
						FROM OOT2100 O WITH (NOLOCK)
							LEFT JOIN OOT2150 O1 WITH (NOLOCK) ON O.APK = O1.APKMaster
							INNER JOIN CRMT20501 C1 WITH (NOLOCK) ON O.OpportunityID = C1.OpportunityID	
							INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = C1.AssignedToUserID
							INNER JOIN AT1102 A2 WITH (NOLOCK) ON A2.DepartmentID = A1.DepartmentID
							INNER JOIN KPIT2020 K1 WITH (NOLOCK) ON K1.EmployeeID = C1.AssignedToUserID
							INNER JOIN AT0099 A WITH (NOLOCK) ON A2.SystemFunctionID = A.ID AND A.CodeMaster = ''SystemFunctionID'' AND A.ID = ''6''
							LEFT JOIN OT2101 O2 WITH (NOLOCK) ON O2.DivisionID = C1.DivisionID AND O2.OpportunityID = C1.OpportunityID AND O2.OrderStatus = 1
						    AND O2.ClassifyID = ''SALE'' AND O2.QuotationStatus=3 -- Lấy báo giá sale đã hoàn tất
							LEFT JOIN SOT2062 S1 WITH (NOLOCK) ON O2.APK = S1.APK_OT2101
						WHERE ' + @sWhere1 + N'
						GROUP BY O.ProjectID, O.ProjectName, K1.TargetSalesRate, S1.PlusCost, S1.Factor, C1.OpportunityID, O1.Mark, O1.TargetsGroupID
						UNION ALL
						SELECT
							O.ProjectID
							-- Giá trị cộng thêm của SALE
							, (SELECT Name FROM A00001 WHERE ID = ''SOF2062B.PlusSaleCost'' AND LanguageID = ''vi-VN'') + N'' '' + O.ProjectName AS TargetsGroupName
							, 1 AS Quantity
							, ISNULL(S1.PlusSaleCost, 0) AS TargetSalesRate
							, ISNULL(S1.PlusSaleCost, 0) AS Total
							, 2 AS TypeData
							, ISNULL(O1.Mark, 100) AS Mark
							, REPLACE(O1.TargetsGroupID, ''.'', '''') AS TargetsGroupID
						FROM OOT2100 O WITH (NOLOCK)
							LEFT JOIN OOT2150 O1 WITH (NOLOCK) ON O.APK = O1.APKMaster
							INNER JOIN CRMT20501 C1 WITH (NOLOCK) ON O.OpportunityID = C1.OpportunityID
							INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = C1.AssignedToUserID
							INNER JOIN AT1102 A2 WITH (NOLOCK) ON A2.DepartmentID = A1.DepartmentID
							INNER JOIN KPIT2020 K1 WITH (NOLOCK) ON K1.EmployeeID = C1.AssignedToUserID
							INNER JOIN AT0099 A WITH (NOLOCK) ON A2.SystemFunctionID = A.ID AND A.CodeMaster = ''SystemFunctionID'' AND A.ID = ''6''
							LEFT JOIN OT2101 O2 WITH (NOLOCK) ON O2.DivisionID = C1.DivisionID AND O2.OpportunityID = C1.OpportunityID AND O2.OrderStatus = 1 
							AND O2.ClassifyID = ''SALE'' AND O2.QuotationStatus=3 -- Lấy báo giá sale đã hoàn tất
							LEFT JOIN SOT2062 S1 WITH (NOLOCK) ON O2.APK = S1.APK_OT2101
						WHERE ' + @sWhere1 + ''
		END
		ELSE
		BEGIN
			SET @OrderBy = 'T3.TargetsGroupName'
			-- Lấy ra danh sách dự án và KPI doanh số NET của từng dự án
			SET @TaskList = '
						SELECT 
							  O.ProjectID
							, O.ProjectName AS TargetsGroupName
							, K1.TargetSalesRate AS Quantity
							, (S1.PlusCost / ISNULL(S1.Factor, 1) + S1.PlusCost) AS TargetSalesRate
							, (K1.TargetSalesRate * (S1.PlusCost / ISNULL(S1.Factor, 1) + S1.PlusCost)) AS Total
							, 1 AS TypeData
							, ISNULL(O1.Mark, 100) AS Mark
							, REPLACE(O1.TargetsGroupID, ''.'', '''') AS TargetsGroupID
						FROM OOT2100 O WITH (NOLOCK)
							LEFT JOIN OOT2150 O1 WITH (NOLOCK) ON O.APK = O1.APKMaster
							INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.DivisionID = O.DivisionID AND ISNULL(A1.Disabled, 0) = 0
							INNER JOIN KPIT2020 K1 WITH (NOLOCK) ON K1.EmployeeID = A1.EmployeeID
							LEFT JOIN OT2101 O2 WITH (NOLOCK) ON O2.DivisionID = O.DivisionID AND O2.OpportunityID = O.ProjectID AND O2.OrderStatus = 1 AND O2.ClassifyID = ''SALE'' AND O2.QuotationStatus=3 -- Lấy báo giá sale đã hoàn tất
							LEFT JOIN SOT2062 S1 WITH (NOLOCK) ON O2.APK = S1.APK_OT2101
						WHERE ' + @sWhere1 + ''

		END

		-- Trường hợp có dùng Đánh giá dự án
		IF (@ListGroup != '')
		BEGIN
			SET @TaskList = N'
				SELECT ROW_NUMBER() OVER(ORDER BY  ' + @OrderBy +') STT
					, T3.TargetsGroupID
					, T3.TargetsGroupName
					, T3.Quantity
					, T3.TargetSalesRate
					, T3.Total
					, 2 AS TypeData
				FROM (
					SELECT T2.ProjectID AS TargetsGroupID
						, T2.TargetsGroupName
						, T2.Quantity
						, T2.TargetSalesRate
						, (T2.Total * ' + CAST(@TargetPercentProject AS NVARCHAR(10)) + ' / 100) ' + @Formula + ' AS Total
						, 2 AS TypeData
					FROM (
						' + @TaskList + '
					) AS T1
					PIVOT
					(
						SUM(Mark)
						FOR TargetsGroupID IN (' + @ListGroup + N')
					) AS T2
				) AS T3
				ORDER BY ' + @OrderBy + ''
		END
		ELSE -- Trường hợp không sử dụng đánh giá dự án
		BEGIN
			SET @TaskList = N'
				SELECT ROW_NUMBER() OVER(ORDER BY  ' + @OrderBy +') STT
					, T3.TargetsGroupID
					, T3.TargetsGroupName
					, T3.Quantity
					, T3.TargetSalesRate
					, T3.Total
					, 2 AS TypeData
				FROM (
					' + @TaskList + '
				) AS T3
				ORDER BY ' + @OrderBy + ''
		END
		
		EXEC (@TaskList)
		-- PRINT(@TaskList)
	END
END











GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
