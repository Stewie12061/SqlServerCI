IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0541]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0541]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Tính lương nhân viên theo sản phẩm (VIETFIRST)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi, Date: 27/02/2018
/*-- <Example>
	HP0541 @DivisionID = 'VF', @UserID = 'ASOFTADMIN', @TranMonth = 12, @TranYear = 2017, @Mode = 1

	HP0541 @DivisionID, @UserID, @TranMonth, @TranYear, @Mode
----*/

CREATE PROCEDURE HP0541
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TranMonth INT, 
	@TranYear INT, 
	@Mode INT ---- 1: Tính lương
			  ---- 0: Hùy bỏ tính lương 
)

AS 
DECLARE @sSQL NVARCHAR(MAX) = N'', 
		@sSQL1 NVARCHAR(MAX) = N'', 
		@sSQL2 NVARCHAR(MAX) = N'', 
		@sSQL3 NVARCHAR(MAX) = N'',
		@sSQL4 NVARCHAR(MAX) = N'',
		@sSQL5 NVARCHAR(MAX) = N'',
		@sSQL6 NVARCHAR(MAX) = N''

IF @Mode = 1 
BEGIN 
	IF EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[Temp_HP0541]') AND TYPE IN (N'U'))
	DROP TABLE Temp_HP0541

	CREATE TABLE Temp_HP0541 (APK VARCHAR(50), [Target] VARCHAR(50), [Min] DECIMAL(28,8), Tar DECIMAL(28,8), [Max] DECIMAL(28,8), [Weight] DECIMAL(28,8))

	SET @sSQL = @sSQL + N'
	SELECT HT1126.APK, HT1124.Target, HT1124.Min, HT1124.Tar, HT1124.Max, HT1124.Weight
	FROM HT1126 WITH (NOLOCK)
	LEFT JOIN HT1123 WITH (NOLOCK) ON HT1126.DivisionID = HT1123.DivisionID AND HT1126.NormID = HT1123.NormID
	LEFT JOIN HT1124 WITH (NOLOCK) ON HT1123.APK = HT1124.APKMaster
	WHERE HT1126.DivisionID = '''+@DivisionID+''' 
	AND HT1126.TranMonth + HT1126.TranYear * 100 = '+STR(@TranMonth + @TranYear * 100)+'
	'

	INSERT INTO Temp_HP0541 (APK, [Target], [Min], Tar, [Max], [Weight]) 
	EXEC sp_executesql @sSQL

	SET @sSQL1 = @sSQL1 + N'
	SELECT *
	INTO #Temp_Quantity 
	FROM (
		SELECT APK, N''Min_''+[Target] AS Min_Target, [Min] 
		FROM Temp_HP0541
		) P 
	PIVOT (MAX([Min]) FOR Min_Target IN (Min_Quantity, Min_TAT, Min_Bounce)) AS PivotTable
	'

	SET @sSQL2 = @sSQL2 + N'
	SELECT *
	INTO #Temp_TAT
	FROM (
		SELECT APK, N''Tar_''+[Target] AS Tar_Target, Tar
		FROM Temp_HP0541
		) P 
	PIVOT (MAX(Tar) FOR Tar_Target IN (Tar_Quantity, Tar_TAT, Tar_Bounce)) AS PivotTable
	'

	SET @sSQL3 = @sSQL3 + N'
	SELECT *
	INTO #Temp_Max
	FROM (
		SELECT APK, N''Max_''+[Target] AS Max_Target, [Max] 
		FROM Temp_HP0541
		) P 
	PIVOT (MAX([Max]) FOR Max_Target IN (Max_Quantity, Max_TAT, Max_Bounce)) AS PivotTable
	'

	SET @sSQL4 = @sSQL4 + N'
	SELECT *
	INTO #Temp_Min
	FROM (
		SELECT APK, N''Weight_''+[Target] AS Weight_Target, [Weight] 
		FROM Temp_HP0541
		) P 
	PIVOT (MAX([Weight]) FOR Weight_Target IN (Weight_Quantity, Weight_TAT, Weight_Bounce)) AS PivotTable
	'
	SET @sSQL5 = @sSQL5 + N'
	SELECT HT1126.APK,
	--T1.Min_Quantity, T1.Min_TAT, T1.Min_Bounce, 
	--T2.Tar_Quantity, T2.Tar_TAT, T2.Tar_Bounce, 
	--T3.Max_Quantity, T3.Max_TAT, T3.Max_Bounce, 
	--T4.Weight_Quantity, T4.Weight_TAT, T4.Weight_Bounce, 
	T4.Weight_Quantity, 
	CASE WHEN HT1126.TAT < T2.Tar_TAT THEN 0 
	WHEN HT1126.TAT < T3.Max_TAT THEN (HT1126.TAT - T2.Tar_TAT) / (T3.Max_TAT - T2.Tar_TAT)
	WHEN HT1126.TAT >= T3.Max_TAT THEN T4.Weight_TAT END AS A, 
	CASE WHEN HT1126.Bounce >= T2.Tar_Bounce THEN 0 
	WHEN HT1126.Bounce < T2.Tar_Bounce THEN ((T2.Tar_Bounce - HT1126.Bounce) / T2.Tar_Bounce) * T4.Weight_Bounce END AS B
	INTO #Temp_HT1126
	FROM HT1126 WITH (NOLOCK)
	INNER JOIN #Temp_Quantity T1 ON HT1126.APK = T1.APK
	INNER JOIN #Temp_TAT T2 ON HT1126.APK = T2.APK
	INNER JOIN #Temp_Max T3 ON HT1126.APK = T3.APK
	INNER JOIN #Temp_Min T4 ON HT1126.APK = T4.APK
	' 
	SET @sSQL6 = @sSQL6 + N'
	---- Tính % số tiền/Máy 
	UPDATE HT1126 
	SET HT1126.PercentAmount = T1.Weight_Quantity + T1.A + T1.B, 
		HT1126.LastModifyUserID = '''+@UserID+''', 
		HT1126.LastModifyDate = GETDATE()
	FROM HT1126 WITH (NOLOCK) 
	INNER JOIN #Temp_HT1126 T1 ON HT1126.APK = T1.APK 

	---- Tính số tiền/Máy
	UPDATE HT1126 
	SET Amount = (PercentAmount/100) * HT1125.UnitPrice, 
		HT1126.LastModifyUserID = '''+@UserID+''', 
		HT1126.LastModifyDate = GETDATE()
	FROM HT1126 WITH (NOLOCK) 
	INNER JOIN #Temp_HT1126 T1 ON HT1126.APK = T1.APK 
	LEFT JOIN HT1902 WITH (NOLOCK) ON HT1126.DivisionID = HT1902.DivisionID AND HT1126.PriceSheetID = HT1902.PriceSheetID
	INNER JOIN HT1125 WITH (NOLOCK) ON HT1902.APK = HT1125.APKMaster AND HT1126.ProductID = HT1125.ProductID

	---- Tính tổng số tiền của nhân viên theo sản phẩm
	UPDATE HT1126 
	SET TotalAmount = Quantity * Amount, 
		HT1126.LastModifyUserID = '''+@UserID+''', 
		HT1126.LastModifyDate = GETDATE()
	FROM HT1126 WITH (NOLOCK) 
	INNER JOIN #Temp_HT1126 T1 ON HT1126.APK = T1.APK 

	SELECT HT1126.DivisionID, HT1126.EmployeeID, HT1126.TranMonth, HT1126.TranYear, SUM (HT1126.TotalAmount) AS TotalAmount
	INTO #Temp_HT2400
	FROM HT1126
	INNER JOIN #Temp_HT1126 T1 ON HT1126.APK = T1.APK 
	GROUP BY  HT1126.DivisionID, EmployeeID, HT1126.TranMonth, HT1126.TranYear

	UPDATE HT2400
	SET HT2400.C06 = T1.TotalAmount
	FROM HT2400 WITH (NOLOCK)
	INNER JOIN #Temp_HT2400 T1 WITH (NOLOCK) ON HT2400.DivisionID = T1.DivisionID AND HT2400.EmployeeID = T1.EmployeeID 
		AND HT2400.TranMonth = T1.TranMonth AND HT2400.TranYear = T1.TranYear
	WHERE HT2400.DivisionID = '''+@DivisionID+''' AND HT2400.TranMonth + HT2400.TranYear * 100 = '+STR(@TranMonth + @TranYear * 100)+'
	'
END 
ELSE IF @Mode = 0 
BEGIN
	UPDATE HT1126 
	SET PercentAmount = NULL, 
		Amount = NULL, 
		TotalAmount = NULL, 
		LastModifyUserID = @UserID, 
		LastModifyDate = GETDATE()
	WHERE DivisionID = @DivisionID AND TranMonth + TranYear * 100 = (@TranMonth + @TranYear * 100)

	UPDATE HT2400 
	SET HT2400.C06 = NULL
	FROM HT2400 WITH (NOLOCK)
	INNER JOIN HT1126 WITH (NOLOCK) ON HT2400.DivisionID = HT1126.DivisionID AND HT2400.EmployeeID = HT1126.EmployeeID 
		AND HT2400.TranMonth = HT1126.TranMonth AND HT2400.TranYear = HT1126.TranYear
	WHERE HT2400.DivisionID = @DivisionID AND HT2400.TranMonth + HT2400.TranYear * 100 = (@TranMonth + @TranYear * 100)

END 

--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sSQL3
--PRINT @sSQL4
--PRINT @sSQL5
--PRINT @sSQL6
EXEC (@sSQL1+@sSQL2+@sSQL3+@sSQL4+@sSQL5+@sSQL6)

--DROP TABLE #Temp_Quantity
--DROP TABLE #Temp_TAT
--DROP TABLE #Temp_Max
--DROP TABLE #Temp_Min
--DROP TABLE #Temp_TotalAmount


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
