IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0544]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0544]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- In đề xuất tính lương năng suất cho kỹ thuật (VIETFIRST)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi, Date: 09/03/2018
/*-- <Example>
	HP0544 @DivisionID = 'VF', @StrDivisionID = '', @UserID = 'ASOFTADMIN', @TranMonth = 12, @TranYear = 2017, @DepartmentID = '', @TeamID = '', @EmployeeID = '', 
	@FromProductID = '', @ToProductID = ''

	HP0544 @DivisionID, @UserID, @StrDivisionID, @TranMonth, @TranYear, @DepartmentID, @TeamID, @EmployeeID, @FromProductID, @ToProductID
----*/

CREATE PROCEDURE HP0544
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@StrDivisionID VARCHAR(4000), 
	@TranMonth INT, 
	@TranYear INT, 
	@DepartmentID VARCHAR(50), 
	@TeamID VARCHAR(50), 
	@EmployeeID VARCHAR(50), 
	@FromProductID VARCHAR(50), 
	@ToProductID VARCHAR(50)
)

AS 
DECLARE @sSQL NVARCHAR(MAX) = N'', 
		@sSQL1 NVARCHAR(MAX) = N'', 
		@sSQL2 NVARCHAR(MAX) = N'', 
		@sSQL3 NVARCHAR(MAX) = N'',
		@sSQL4 NVARCHAR(MAX) = N'',
		@sSQL5 NVARCHAR(MAX) = N'',
		@sSQL6 NVARCHAR(MAX) = N'', 
		@sWhere NVARCHAR(MAX) = N''


IF EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[Temp_HP0544]') AND TYPE IN (N'U'))
DROP TABLE Temp_HP0544

CREATE TABLE Temp_HP0544 (APK VARCHAR(50), [Target] VARCHAR(50), [Min] DECIMAL(28,8), Tar DECIMAL(28,8), [Max] DECIMAL(28,8), [Weight] DECIMAL(28,8))

IF ISNULL(@StrDivisionID, '') <> '' SET @sWhere = @sWhere + N' HT1126.DivisionID IN ('''+@StrDivisionID+''')
AND HT1126.TranMonth + HT1126.TranYear * 100 = '+STR(@TranMonth + @TranYear * 100)+''
ELSE SET @sWhere = @sWhere + N' HT1126.DivisionID = '''+@DivisionID+'''
AND HT1126.TranMonth + HT1126.TranYear * 100 = '+STR(@TranMonth + @TranYear * 100)+''


IF ISNULL(@DepartmentID, '%') <> '%'  SET @sWhere = @sWhere + N'
AND HT1400.DepartmentID = '''+@DepartmentID+''''
IF ISNULL(@TeamID, '%') <> '%' SET @sWhere = @sWhere + N'
AND HT1400.TeamID = '''+@TeamID+''''
IF ISNULL(@EmployeeID, '%') <> '%' SET @sWhere = @sWhere + N'
AND HT1126.EmployeeID = '''+@EmployeeID+''''
IF ISNULL(@FromProductID, '') <> '' AND ISNULL(@ToProductID, '') = '' SET @sWhere = @sWhere + '
AND HT1126.ProductID  >= '''+@FromProductID+''' '
IF ISNULL(@FromProductID, '') = '' AND ISNULL(@ToProductID, '') <> '' SET @sWhere = @sWhere + '
AND HT1126.ProductID <= '''+@ToProductID+''' '

SET @sSQL = @sSQL + N'
SELECT HT1126.APK, HT1124.Target, HT1124.Min, HT1124.Tar, HT1124.Max, HT1124.Weight
FROM HT1126 WITH (NOLOCK)
INNER JOIN HT1400 WITH (NOLOCK) ON HT1126.DivisionID = HT1400.DivisionID AND HT1126.EmployeeID = HT1400.EmployeeID
LEFT JOIN HT1123 WITH (NOLOCK) ON HT1126.DivisionID = HT1123.DivisionID AND HT1126.NormID = HT1123.NormID
LEFT JOIN HT1124 WITH (NOLOCK) ON HT1123.APK = HT1124.APKMaster
WHERE '+@sWhere+' '

INSERT INTO Temp_HP0544 (APK, [Target], [Min], Tar, [Max], [Weight]) 
EXEC sp_executesql @sSQL

SET @sSQL1 = @sSQL1 + N'
SELECT *
INTO #Temp_Quantity 
FROM (
	SELECT APK, N''Min_''+[Target] AS Min_Target, [Min] 
	FROM Temp_HP0544
	) P 
PIVOT (MAX([Min]) FOR Min_Target IN (Min_Quantity, Min_TAT, Min_Bounce)) AS PivotTable
'

SET @sSQL2 = @sSQL2 + N'
SELECT *
INTO #Temp_TAT
FROM (
	SELECT APK, N''Tar_''+[Target] AS Tar_Target, Tar
	FROM Temp_HP0544
	) P 
PIVOT (MAX(Tar) FOR Tar_Target IN (Tar_Quantity, Tar_TAT, Tar_Bounce)) AS PivotTable
'

SET @sSQL3 = @sSQL3 + N'
SELECT *
INTO #Temp_Max
FROM (
	SELECT APK, N''Max_''+[Target] AS Max_Target, [Max] 
	FROM Temp_HP0544
	) P 
PIVOT (MAX([Max]) FOR Max_Target IN (Max_Quantity, Max_TAT, Max_Bounce)) AS PivotTable
'

SET @sSQL4 = @sSQL4 + N'
SELECT *
INTO #Temp_Min
FROM (
	SELECT APK, N''Weight_''+[Target] AS Weight_Target, [Weight] 
	FROM Temp_HP0544
	) P 
PIVOT (MAX([Weight]) FOR Weight_Target IN (Weight_Quantity, Weight_TAT, Weight_Bounce)) AS PivotTable
'

SET @sSQL5 = @sSQL5 + N'
SELECT HT1126.TranMonth, HT1126.TranYear, HT1126.EmployeeID, HT1400.DepartmentID, AT1102.DepartmentName,
CASE WHEN ISNULL(MiddleName,'''') = '''' THEN LTRIM(RTRIM(HT1400.LastName)) + '' '' + LTRIM(RTRIM(HT1400.FirstName))
WHEN ISNULL(MiddleName,'''') <> '''' THEN LTRIM(RTRIM(HT1400.LastName)) + '' '' + LTRIM(RTRIM(HT1400.MiddleName)) + '' '' + LTRIM(RTRIM(HT1400.FirstName))END AS EmployeeName, 
HT1126.ProductID, HT1015.ProductName, HT1126.Quantity, HT1126.TAT, HT1126.Bounce, HT1126.PercentAmount, HT1126.Amount, HT1125.UnitPrice, NULL AS WorkingDay, 
T1.Min_Quantity, T1.Min_TAT, T1.Min_Bounce, 
T2.Tar_Quantity, T2.Tar_TAT, T2.Tar_Bounce, 
T3.Max_Quantity, T3.Max_TAT, T3.Max_Bounce, 
T4.Weight_Quantity, T4.Weight_TAT, T4.Weight_Bounce, HT1126.TotalAmount, HT1403.DutyID, HT1102.DutyName
FROM HT1126 WITH (NOLOCK)
LEFT JOIN HT1400 WITH (NOLOCK) ON HT1126.DivisionID = HT1400.DivisionID AND HT1126.EmployeeID = HT1400.EmployeeID
LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DivisionID IN (HT1126.DivisionID, ''@@@'') AND HT1400.DepartmentID = AT1102.DepartmentID 
LEFT JOIN HT1403 WITH (NOLOCK) ON HT1126.DivisionID = HT1403.DivisionID AND HT1126.EmployeeID = HT1403.EmployeeID
LEFT JOIN HT1102 WITH (NOLOCK) ON HT1126.DivisionID = HT1102.DivisionID AND HT1403.DutyID = HT1102.DutyID 
LEFT JOIN HT1015 WITH (NOLOCK) ON HT1126.DivisionID = HT1015.DivisionID AND HT1126.ProductID = HT1015.ProductID
LEFT JOIN HT1902 WITH (NOLOCK) ON HT1126.DivisionID = HT1902.DivisionID AND HT1126.PriceSheetID = HT1902.PriceSheetID
LEFT JOIN HT1125 WITH (NOLOCK) ON HT1902.APK = HT1125.APKMaster AND HT1126.ProductID = HT1125.ProductID
INNER JOIN #Temp_Quantity T1 ON HT1126.APK = T1.APK
INNER JOIN #Temp_TAT T2 ON HT1126.APK = T2.APK
INNER JOIN #Temp_Max T3 ON HT1126.APK = T3.APK
INNER JOIN #Temp_Min T4 ON HT1126.APK = T4.APK
ORDER BY HT1400.DepartmentID, HT1126.ProductID' 

--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sSQL3
--PRINT @sSQL4
--PRINT @sSQL5
EXEC (@sSQL1+@sSQL2+@sSQL3+@sSQL4+@sSQL5)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
