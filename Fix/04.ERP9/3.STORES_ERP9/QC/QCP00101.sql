IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP00101]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP00101]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- <Summary>
---- Load biểu đồ thống kê hàng NG theo Line - QCF0010
-- <History>
---- Created on 31/07/2023 by Viết Toàn
---- Modified by Viết Toàn on 16/08/2023: Bổ sung điều kiện check tuần khi chọn lọc theo tuần
---- Modified by Viết Toàn on 23/08/2023: Lấy dữ liệu đúng theo tuần (Dựa trên thời gian bắt đầu và kết thúc 1 năm theo thiết lập ở bảng AT1101)

CREATE PROCEDURE [dbo].[QCP00101]
( 
	 @DivisionIDs VARCHAR(50),
	 @PeriodList NVARCHAR(MAX) = N'',
	 @WeekList NVARCHAR(MAX) = N'',
	 @IsMonth TINYINT = 1,
	 @Line NVARCHAR(MAX),
	 @ConditionQC NVARCHAR(MAX) = NULL
) 
AS

DECLARE @sSQL NVARCHAR(MAX) = N'',
		@sWhere NVARCHAR(MAX) = N'',
		@sSelect NVARCHAR(MAX) = N'',
		@sGroupBy NVARCHAR(MAX) = N'',
		@APKMaster NVARCHAR(50),
		@week VARCHAR(2),
		@Count INT,
		@Year NVARCHAR(4) = (SELECT TOP 1 BeginYear FROM AT1101)


CREATE TABLE #TargetLine (
	TypeName NVARCHAR(50),-- Tên cột
	Quantity DECIMAL(28, 8), -- Giá trị thực tế
	[Target] DECIMAL(28, 8) -- Giá trị mục tiêu
)

-- Month option
IF @IsMonth = 1
BEGIN
	DECLARE @Period NVARCHAR(10),
			@Month NVARCHAR(2),
			@Year1 NVARCHAR(4)

	SELECT [Name]
	INTO #PeriodTmp 
	FROM Splitstring(REPLACE(@PeriodList, '''', ''), ',')

	WHILE EXISTS (SELECT TOP 1 1 FROM #PeriodTmp)
	BEGIN
		SET @Period = (SELECT TOP 1 [Name] FROM #PeriodTmp)
		SET @Month = (SELECT TOP 1 [Name] FROM SplitString(@Period, '/'))
		SET @Year1 = (SELECT TOP 1 [Name] FROM SplitString(@Period, '/') ORDER BY [Name] DESC)
		SET @sSelect = N''
		SET @sGroupBy = N''
		SET @APKMaster = (SELECT TOP 1 APK FROM QCT2080 WHERE TranYear = @Year AND DeleteFlg <> 1)

		SELECT WeekName
		INTO #week_tmp
		FROM dbo.RangeWeekInMonth(CAST(@Month AS INT), CAST(@Year1 AS INT))
		
		SET @Count = (SELECT COUNT(WeekName) FROM #week_tmp)

		WHILE EXISTS (SELECT TOP 1 1 FROM #week_tmp)
		BEGIN
			SET @week = (SELECT TOP 1 WeekName FROM #week_tmp)
			SET @sSelect = @sSelect + CONCAT('ISNULL(QCT81.Value', @week, ', 0)+')

			SET @sGroupBy = @sGroupBy + CONCAT('QCT81.Value', @week, ',')

			DELETE FROM #week_tmp WHERE WeekName = @week
		END
		
		SET @sSQL = 'SELECT DISTINCT CONCAT(N''Tháng'', '' '', '''+@Period+''') AS TypeName, MT11.Ana06ID, MT10.VoucherNo,
				ISNULL(MT11.ItemReturnedQuantity, 0) AS QuantityNG,
				ISNULL(MT11.ItemActual, 0) AS QuantityOK,
				('+SUBSTRING(@sSelect, 1, LEN(@sSelect) - 1)+') / '+CAST(@Count AS VARCHAR(1))+' AS [Target]
		INTO #TBL_tmp
		FROM 
			MT2211 MT11 WITH (NOLOCK) 
			LEFT JOIN MT2210 MT10 WITH (NOLOCK) ON MT10.APK = MT11.APKMaster
			LEFT JOIN QCT2081 QCT81 WITH (NOLOCK) ON QCT81.PhaseID = MT11.Ana06ID AND QCT81.DeleteFlg <> 1
			LEFT JOIN QCT2080 QCT80 WITH (NOLOCK) ON QCT81.APKMaster = QCT80.APK --AND ISNULL(QCT80.DeleteFlg, 0) = 0 AND QCT80.TranYear = CONVERT(INT, '+@Year+')
		WHERE MT11.DivisionID IN (SELECT [Name] FROM SplitString('''+@DivisionIDs+''', '',''))
			AND MT10.TranMonth = CONVERT(INT, '+@Month+')
			AND MT10.TranYear = CONVERT(INT, '+@Year+')
			AND MT11.Ana06ID IN (SELECT [Name] FROM SplitString('''+@Line+''', '',''))
			AND QCT80.APK = '''+@APKMaster+'''
		GROUP BY '+SUBSTRING(@sGroupBy, 1, LEN(@sGroupBy) - 1)+'
			  , MT11.ItemReturnedQuantity, MT11.ItemActual, MT11.Ana06ID, MT10.VoucherNo

		SELECT MAX([TARGET]) AS [Target], Ana06ID
		INTO #TBL_tmp1
		FROM #TBL_tmp 
		WHERE Ana06ID IN (
			select PhaseID
			FROM  QCT2081 QCT81 WITH (NOLOCK)
			LEFT JOIN QCT2080 QCT80 WITH (NOLOCK) ON QCT81.APKMaster = QCT80.APK
			WHERE QCT81.DeleteFlg <> 1
			AND QCT80.TranYear = CONVERT(INT, '+@Year+')
			AND ISNULL(QCT80.DeleteFlg, 0) = 0
			AND ISNULL(PhaseID, '''') <> ''''
		)
		GROUP BY Ana06ID
		
		SELECT DISTINCT [Target], Ana06ID
		INTO #tmp1
		FROM (
			SELECT  [Target], Ana06ID
			FROM #TBL_tmp1
			UNION ALL
			(SELECT ('+SUBSTRING(@sSelect, 1, LEN(@sSelect) - 1)+') / '+CAST(@Count AS VARCHAR(1))+' AS [Target], QCT81.PhaseID AS Ana06ID
			FROM QCT2081 QCT81
			LEFT JOIN QCT2080 QCT80 WITH (NOLOCK) ON QCT81.APKMaster = QCT80.APK
			WHERE QCT81.DeleteFlg <> 1
			AND QCT80.TranYear = CONVERT(INT, 2023)
			AND ISNULL(QCT80.DeleteFlg, 0) = 0
			AND ISNULL(PhaseID, '''')  IN (SELECT [Name] FROM SplitString('''+@Line+''', '',''))
			AND APKMaster = (SELECT TOP 1 APK FROM QCT2080 WHERE TranYear = '+@Year+' AND ISNULL(DeleteFlg, 0) <> 1))
		) T

		SELECT * 
		INTO #TBL_tmp2
		FROM 
		(
			SELECT tbl.TypeName, tbl.Ana06ID, tbl.VoucherNo, tbl.QuantityNG, tbl.QuantityOK, tbl.Target
			FROM #TBL_tmp tbl
			UNION ALL
			SELECT CONCAT(N''Tháng'', '' '', '''+@Period+''') AS TypeName, QCT81.PhaseID AS Ana06ID, N'''' AS VoucherNo
			, 0 AS QuantityNG, 0 AS QuantityOK
			, ('+SUBSTRING(@sSelect, 1, LEN(@sSelect) - 1)+') / '+CAST(@Count AS VARCHAR(1))+' AS [Target]
			FROM QCT2081 QCT81
			WHERE QCT81.PhaseID IN (SELECT [Name] FROM SplitString('''+@Line+''', '',''))
			AND QCT81.APKMaster = '''+@APKMaster+'''
		) T1

		INSERT INTO #TargetLine
		SELECT TB.TypeName
		, IIF(SUM(TB.QuantityNG) <> 0 OR SUM(TB.QuantityOK) <> 0, (SUM(TB.QuantityNG) / (SUM(TB.QuantityNG) + SUM(TB.QuantityOK))) * 100, 0) AS QuantityNG
		, ROUND((SELECT SUM(Target) FROM #tmp1 WHERE Ana06ID IN (SELECT [Name] FROM SplitString('''+@Line+''', '',''))) / (select COUNT(Ana06ID) from #tmp1), 5) AS [Target]
		FROM #TBL_tmp2 TB
		GROUP BY TB.TypeName

		DROP TABLE #tmp1
		'
		PRINT(@sSQL)
		EXEC (@sSQL)
		
		DROP TABLE #week_tmp
		DELETE FROM #PeriodTmp WHERE [Name] = @Period
	END

	SELECT *, (SELECT SUM(Quantity) FROM #TargetLine) AS Total from #TargetLine

END
 --Week option
ELSE
BEGIN
	DECLARE @StartDate DATETIME,
			@BeginWeek INT,
			@NumWeek INT,
			@EndWeek12 INT 

	SET @StartDate = (CAST((SELECT TOP 1 CONCAT(BeginYear, '-', MONTH(StartDate), '-', DAY(StartDate)) FROM AT1101 ORDER BY BeginYear) AS DATETIME))
	SET @BeginWeek = DATEPART(WW, DATEADD(mm, DATEDIFF(mm, 0, @StartDate),0))
	SET @NumWeek = @BeginWeek - 1 -- Số tuần chênh lệch
	SET @EndWeek12 = DATEPART(WW, CONCAT(YEAR(@StartDate), '-12-31')) -- Tuần kết thúc của tháng 12
	SET @APKMaster = (SELECT TOP 1 APK FROM QCT2080 WHERE TranYear = CONVERT(INT, @Year) AND DeleteFlg <> 1)

	PRINT(CONCAT('@StartDate --- ', @StartDate))
	PRINT(CONCAT('@BeginWeek --- ', @BeginWeek))
	PRINT(CONCAT('@NumWeek --- ', @NumWeek))
	PRINT(CONCAT('@EndWeek12 --- ', @EndWeek12))

	SELECT [Name]
	INTO #tblWeek
	FROM SplitString(REPLACE(@WeekList, '''', ''), ',')

	SET @Count = (SELECT COUNT([Name]) FROM #tblWeek)

	WHILE EXISTS (SELECT TOP 1 1 FROM #tblWeek)
	BEGIN
		SET @week = (SELECT TOP 1 [Name] FROM #tblWeek)


		SELECT DISTINCT CONCAT(N'Tuần ', @week) AS TypeName, MT11.Ana06ID, MT10.VoucherNo, MT10.VoucherDate,
				ISNULL(MT11.ItemReturnedQuantity, 0) AS QuantityNG,
				ISNULL(MT11.ItemActual, 0) AS QuantityOK,
				CASE WHEN CONVERT(INT, ISNULL(@week, 0)) = 1 THEN ISNULL(QCT81.Value1, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 2 THEN ISNULL(QCT81.Value2, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 3 THEN ISNULL(QCT81.Value3, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 4 THEN ISNULL(QCT81.Value4, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 5 THEN ISNULL(QCT81.Value5, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 6 THEN ISNULL(QCT81.Value6, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 7 THEN ISNULL(QCT81.Value7, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 8 THEN ISNULL(QCT81.Value8, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 9 THEN ISNULL(QCT81.Value9, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 10 THEN ISNULL(QCT81.Value10, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 11 THEN ISNULL(QCT81.Value11, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 12 THEN ISNULL(QCT81.Value12, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 13 THEN ISNULL(QCT81.Value13, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 14 THEN ISNULL(QCT81.Value14, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 15 THEN ISNULL(QCT81.Value15, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 16 THEN ISNULL(QCT81.Value16, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 17 THEN ISNULL(QCT81.Value17, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 18 THEN ISNULL(QCT81.Value18, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 19 THEN ISNULL(QCT81.Value19, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 20 THEN ISNULL(QCT81.Value20, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 21 THEN ISNULL(QCT81.Value21, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 22 THEN ISNULL(QCT81.Value22, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 23 THEN ISNULL(QCT81.Value23, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 24 THEN ISNULL(QCT81.Value24, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 25 THEN ISNULL(QCT81.Value25, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 26 THEN ISNULL(QCT81.Value26, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 27 THEN ISNULL(QCT81.Value27, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 28 THEN ISNULL(QCT81.Value28, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 29 THEN ISNULL(QCT81.Value29, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 30 THEN ISNULL(QCT81.Value30, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 31 THEN ISNULL(QCT81.Value31, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 32 THEN ISNULL(QCT81.Value32, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 33 THEN ISNULL(QCT81.Value33, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 34 THEN ISNULL(QCT81.Value34, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 35 THEN ISNULL(QCT81.Value35, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 36 THEN ISNULL(QCT81.Value36, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 37 THEN ISNULL(QCT81.Value37, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 38 THEN ISNULL(QCT81.Value38, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 39 THEN ISNULL(QCT81.Value39, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 40 THEN ISNULL(QCT81.Value40, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 41 THEN ISNULL(QCT81.Value41, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 42 THEN ISNULL(QCT81.Value42, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 43 THEN ISNULL(QCT81.Value43, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 44 THEN ISNULL(QCT81.Value44, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 45 THEN ISNULL(QCT81.Value45, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 46 THEN ISNULL(QCT81.Value46, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 47 THEN ISNULL(QCT81.Value47, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 48 THEN ISNULL(QCT81.Value48, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 48 THEN ISNULL(QCT81.Value48, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 50 THEN ISNULL(QCT81.Value50, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 51 THEN ISNULL(QCT81.Value51, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 52 THEN ISNULL(QCT81.Value52, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 53 THEN ISNULL(QCT81.Value53, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 54 THEN ISNULL(QCT81.Value54, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 55 THEN ISNULL(QCT81.Value55, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 56 THEN ISNULL(QCT81.Value56, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 57 THEN ISNULL(QCT81.Value57, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 58 THEN ISNULL(QCT81.Value58, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 59 THEN ISNULL(QCT81.Value59, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 60 THEN ISNULL(QCT81.Value60, 0)
					ELSE 0 END AS [Target]
					, IIF(MONTH(MT10.VoucherDate) >= MONTH(@StartDate), DATEPART(WW, MT10.VoucherDate) - @NumWeek, @EndWeek12 - @NumWeek + DATEPART(WW, MT10.VoucherDate)) AS Week
		INTO #TBL_tmp
		FROM 
			MT2211 MT11 WITH (NOLOCK) 
			LEFT JOIN MT2210 MT10 WITH (NOLOCK) ON MT10.APK = MT11.APKMaster
			LEFT JOIN QCT2081 QCT81 WITH (NOLOCK) ON QCT81.PhaseID = MT11.Ana06ID AND ISNULL(QCT81.DeleteFlg, 0) = 0
			LEFT JOIN QCT2080 QCT80 WITH (NOLOCK) ON QCT81.APKMaster = QCT80.APK
		WHERE MT11.DivisionID IN (SELECT [Name] FROM SplitString(@DivisionIDs, ','))
			AND IIF(MONTH(MT10.VoucherDate) >= MONTH(@StartDate), DATEPART(WW, MT10.VoucherDate) - @NumWeek, @EndWeek12 - @NumWeek + DATEPART(WW, MT10.VoucherDate)) = CONVERT(INT, @week)
			AND MT11.Ana06ID IN (SELECT [Name] FROM SplitString(@Line, ','))
			AND CONVERT(NVARCHAR(50), QCT80.APK) = @APKMaster
		GROUP BY QCT81.Value1, QCT81.Value2, QCT81.Value3, QCT81.Value4, QCT81.Value5, QCT81.Value6
			  , QCT81.Value7, QCT81.Value8, QCT81.Value9, QCT81.Value10, QCT81.Value11, QCT81.Value12
			  , QCT81.Value13, QCT81.Value14, QCT81.Value15, QCT81.Value16, QCT81.Value17, QCT81.Value18
			  , QCT81.Value19, QCT81.Value20, QCT81.Value21, QCT81.Value22, QCT81.Value23, QCT81.Value24
			  , QCT81.Value25, QCT81.Value26, QCT81.Value27, QCT81.Value28, QCT81.Value29, QCT81.Value30
			  , QCT81.Value31, QCT81.Value32, QCT81.Value33, QCT81.Value34, QCT81.Value35, QCT81.Value36
			  , QCT81.Value37, QCT81.Value38, QCT81.Value39, QCT81.Value40, QCT81.Value41, QCT81.Value42
			  , QCT81.Value43, QCT81.Value44, QCT81.Value45, QCT81.Value46, QCT81.Value47, QCT81.Value48
			  , QCT81.Value49, QCT81.Value50, QCT81.Value51, QCT81.Value52, QCT81.Value53, QCT81.Value54
			  , QCT81.Value55, QCT81.Value56, QCT81.Value57, QCT81.Value58, QCT81.Value59, QCT81.Value60
			  , MT11.ItemReturnedQuantity, MT11.ItemActual, MT11.Ana06ID, MT10.VoucherNo, MT10.VoucherDate

		--SELECT  * FROM #TBL_tmp

		--SELECT MAX([TARGET]) [Target], Ana06ID
		--INTO #tmp1
		--from #TBL_tmp
		--WHERE Ana06ID IN (
		--	select PhaseID
		--	FROM  QCT2081 QCT81 WITH (NOLOCK)
		--	LEFT JOIN QCT2080 QCT80 WITH (NOLOCK) ON QCT81.APKMaster = QCT80.APK
		--	WHERE  QCT81.DeleteFlg <> 1
		--	AND QCT80.TranYear = CONVERT(INT, 2023)
		--	AND ISNULL(QCT80.DeleteFlg, 0) = 0
		--	AND ISNULL(PhaseID, '') <> ''
		--)
		--GROUP BY Ana06ID

		SELECT MAX([TARGET]) AS [Target], Ana06ID
		INTO #TBL_tmp1
		FROM #TBL_tmp 
		WHERE Ana06ID IN (
			select PhaseID
			FROM  QCT2081 QCT81 WITH (NOLOCK)
			LEFT JOIN QCT2080 QCT80 WITH (NOLOCK) ON QCT81.APKMaster = QCT80.APK
			WHERE QCT81.DeleteFlg <> 1
			AND QCT80.TranYear = CONVERT(INT, @Year)
			AND ISNULL(QCT80.DeleteFlg, 0) = 0
			AND ISNULL(PhaseID, '') <> ''
		)
		GROUP BY Ana06ID

		SELECT [Target], Ana06ID
		INTO #tmp1
		FROM (
			SELECT  [Target], Ana06ID
			FROM #TBL_tmp1
			UNION ALL
			(SELECT 
					CASE WHEN CONVERT(INT, ISNULL(@week, 0)) = 1 THEN ISNULL(QCT81.Value1, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 2 THEN ISNULL(QCT81.Value2, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 3 THEN ISNULL(QCT81.Value3, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 4 THEN ISNULL(QCT81.Value4, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 5 THEN ISNULL(QCT81.Value5, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 6 THEN ISNULL(QCT81.Value6, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 7 THEN ISNULL(QCT81.Value7, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 8 THEN ISNULL(QCT81.Value8, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 9 THEN ISNULL(QCT81.Value9, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 10 THEN ISNULL(QCT81.Value10, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 11 THEN ISNULL(QCT81.Value11, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 12 THEN ISNULL(QCT81.Value12, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 13 THEN ISNULL(QCT81.Value13, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 14 THEN ISNULL(QCT81.Value14, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 15 THEN ISNULL(QCT81.Value15, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 16 THEN ISNULL(QCT81.Value16, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 17 THEN ISNULL(QCT81.Value17, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 18 THEN ISNULL(QCT81.Value18, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 19 THEN ISNULL(QCT81.Value19, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 20 THEN ISNULL(QCT81.Value20, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 21 THEN ISNULL(QCT81.Value21, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 22 THEN ISNULL(QCT81.Value22, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 23 THEN ISNULL(QCT81.Value23, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 24 THEN ISNULL(QCT81.Value24, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 25 THEN ISNULL(QCT81.Value25, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 26 THEN ISNULL(QCT81.Value26, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 27 THEN ISNULL(QCT81.Value27, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 28 THEN ISNULL(QCT81.Value28, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 29 THEN ISNULL(QCT81.Value29, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 30 THEN ISNULL(QCT81.Value30, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 31 THEN ISNULL(QCT81.Value31, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 32 THEN ISNULL(QCT81.Value32, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 33 THEN ISNULL(QCT81.Value33, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 34 THEN ISNULL(QCT81.Value34, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 35 THEN ISNULL(QCT81.Value35, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 36 THEN ISNULL(QCT81.Value36, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 37 THEN ISNULL(QCT81.Value37, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 38 THEN ISNULL(QCT81.Value38, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 39 THEN ISNULL(QCT81.Value39, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 40 THEN ISNULL(QCT81.Value40, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 41 THEN ISNULL(QCT81.Value41, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 42 THEN ISNULL(QCT81.Value42, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 43 THEN ISNULL(QCT81.Value43, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 44 THEN ISNULL(QCT81.Value44, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 45 THEN ISNULL(QCT81.Value45, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 46 THEN ISNULL(QCT81.Value46, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 47 THEN ISNULL(QCT81.Value47, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 48 THEN ISNULL(QCT81.Value48, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 48 THEN ISNULL(QCT81.Value48, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 50 THEN ISNULL(QCT81.Value50, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 51 THEN ISNULL(QCT81.Value51, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 52 THEN ISNULL(QCT81.Value52, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 53 THEN ISNULL(QCT81.Value53, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 54 THEN ISNULL(QCT81.Value54, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 55 THEN ISNULL(QCT81.Value55, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 56 THEN ISNULL(QCT81.Value56, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 57 THEN ISNULL(QCT81.Value57, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 58 THEN ISNULL(QCT81.Value58, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 59 THEN ISNULL(QCT81.Value59, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 60 THEN ISNULL(QCT81.Value60, 0)
					ELSE 0 END AS [Target]
				, QCT81.PhaseID AS Ana06ID
			FROM QCT2081 QCT81
			LEFT JOIN QCT2080 QCT80 WITH (NOLOCK) ON QCT81.APKMaster = QCT80.APK
			WHERE PhaseID NOT IN (
						select T1.Ana06ID
						FROM  #TBL_tmp1 T1
			)
			AND QCT81.DeleteFlg <> 1
			AND QCT80.TranYear = CONVERT(INT, 2023)
			AND ISNULL(QCT80.DeleteFlg, 0) = 0
			AND ISNULL(PhaseID, '') <> ''
			AND APKMaster = @APKMaster
			)
		) T

		SELECT * 
		INTO #TBL_tmp2
		FROM 
		(
			SELECT tbl.TypeName, tbl.Ana06ID, tbl.VoucherNo, tbl.VoucherDate, tbl.QuantityNG, tbl.QuantityOK, tbl.Target
			FROM #TBL_tmp tbl
			UNION ALL
			SELECT CONCAT(N'Tuần ', @week) AS TypeName, QCT81.PhaseID AS Ana06ID, N'' AS VoucherNo, N'' AS VoucherDate
			, 0 AS QuantityNG, 0 AS QuantityOK
			, CASE WHEN CONVERT(INT, ISNULL(@week, 0)) = 1 THEN ISNULL(QCT81.Value1, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 2 THEN ISNULL(QCT81.Value2, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 3 THEN ISNULL(QCT81.Value3, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 4 THEN ISNULL(QCT81.Value4, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 5 THEN ISNULL(QCT81.Value5, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 6 THEN ISNULL(QCT81.Value6, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 7 THEN ISNULL(QCT81.Value7, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 8 THEN ISNULL(QCT81.Value8, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 9 THEN ISNULL(QCT81.Value9, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 10 THEN ISNULL(QCT81.Value10, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 11 THEN ISNULL(QCT81.Value11, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 12 THEN ISNULL(QCT81.Value12, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 13 THEN ISNULL(QCT81.Value13, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 14 THEN ISNULL(QCT81.Value14, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 15 THEN ISNULL(QCT81.Value15, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 16 THEN ISNULL(QCT81.Value16, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 17 THEN ISNULL(QCT81.Value17, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 18 THEN ISNULL(QCT81.Value18, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 19 THEN ISNULL(QCT81.Value19, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 20 THEN ISNULL(QCT81.Value20, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 21 THEN ISNULL(QCT81.Value21, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 22 THEN ISNULL(QCT81.Value22, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 23 THEN ISNULL(QCT81.Value23, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 24 THEN ISNULL(QCT81.Value24, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 25 THEN ISNULL(QCT81.Value25, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 26 THEN ISNULL(QCT81.Value26, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 27 THEN ISNULL(QCT81.Value27, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 28 THEN ISNULL(QCT81.Value28, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 29 THEN ISNULL(QCT81.Value29, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 30 THEN ISNULL(QCT81.Value30, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 31 THEN ISNULL(QCT81.Value31, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 32 THEN ISNULL(QCT81.Value32, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 33 THEN ISNULL(QCT81.Value33, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 34 THEN ISNULL(QCT81.Value34, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 35 THEN ISNULL(QCT81.Value35, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 36 THEN ISNULL(QCT81.Value36, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 37 THEN ISNULL(QCT81.Value37, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 38 THEN ISNULL(QCT81.Value38, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 39 THEN ISNULL(QCT81.Value39, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 40 THEN ISNULL(QCT81.Value40, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 41 THEN ISNULL(QCT81.Value41, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 42 THEN ISNULL(QCT81.Value42, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 43 THEN ISNULL(QCT81.Value43, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 44 THEN ISNULL(QCT81.Value44, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 45 THEN ISNULL(QCT81.Value45, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 46 THEN ISNULL(QCT81.Value46, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 47 THEN ISNULL(QCT81.Value47, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 48 THEN ISNULL(QCT81.Value48, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 48 THEN ISNULL(QCT81.Value48, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 50 THEN ISNULL(QCT81.Value50, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 51 THEN ISNULL(QCT81.Value51, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 52 THEN ISNULL(QCT81.Value52, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 53 THEN ISNULL(QCT81.Value53, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 54 THEN ISNULL(QCT81.Value54, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 55 THEN ISNULL(QCT81.Value55, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 56 THEN ISNULL(QCT81.Value56, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 57 THEN ISNULL(QCT81.Value57, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 58 THEN ISNULL(QCT81.Value58, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 59 THEN ISNULL(QCT81.Value59, 0)
					 WHEN CONVERT(INT, ISNULL(@week, 0)) = 60 THEN ISNULL(QCT81.Value60, 0)
					ELSE 0 END AS [Target]
			FROM QCT2081 QCT81
			WHERE QCT81.PhaseID IN (SELECT [Name] FROM SplitString(@Line, ','))
			AND QCT81.APKMaster = @APKMaster
		) T1

		--select * from #TBL_tmp2

		INSERT INTO #TargetLine
		SELECT TB.TypeName
		, IIF(SUM(TB.QuantityNG) <> 0 OR SUM(TB.QuantityOK) <> 0, (SUM(TB.QuantityNG) / (SUM(TB.QuantityNG) + SUM(TB.QuantityOK))) * 100, 0)
		, (SELECT SUM(Target) FROM #tmp1 WHERE Ana06ID IN (SELECT [Name] FROM SplitString(@Line, ','))) / (SELECT COUNT([NAME]) FROM SplitString(@Line, ','))
		FROM #TBL_tmp2 TB
		GROUP BY TB.TypeName

		--select * from #tmp1
		
		DROP TABLE #tmp1
		DROP TABLE #TBL_tmp
		DROP TABLE #TBL_tmp1
		DROP TABLE #TBL_tmp2

		DELETE FROM #tblWeek WHERE [NAME] = @week
	END

	SELECT *, (SELECT SUM(Quantity) FROM #TargetLine) AS Total 
	FROM #TargetLine
END

GO