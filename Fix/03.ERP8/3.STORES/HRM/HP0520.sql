IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0520]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP0520]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Tính lương năng suất (NEWTOYO)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT-HRM \ Danh mục \ Thông tin chấm công \ Tính lương năng suất \ Tính lương hoặc Hủy bỏ
-- <History>
----Created by Bảo Thy on 28/09/2017
----Modified by Khả Vi on 18/10/2017: Bổ sung tính lương theo ngày (Hỗ trợ báo cáo tính sản lượng vượt và ngoài giờ) 
----Modified by Bảo Thy on 12/01/2018: Nếu TG làm việc của máy <= TG chuẩn của máy => lấy TG làm việc của máy, ngược lại thì lấy TG chuẩn của máy
----Modified by Bảo Thy on 15/01/2018: Sửa cách tính sản lượng và thành tiền vượt ngoài giờ của nhân viên
----Modified by Khả Vi on 22/01/2018: Sửa công thức tính lương cho báo cáo tính sản lượng vượt ngoài giờ
----Modified by Bảo Thy on 24/01/2018: Fix lại công thức tính SL ngoài giờ theo bản modify 15/01/2018

/*-- <Example>
	HP0520 @DivisionID='CH', @UserID = 'ASOFTADMIN', @TranMonth=1, @TranYear=2017, @FromDepartmentID='PB1', @ToDepartmentID='Z1', @TeamID = '%',
	@VoucherDate = '2017-09-29 09:23:18.657', @Mode = 1

----*/
CREATE PROCEDURE [dbo].[HP0520]
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@FromDepartmentID VARCHAR(50), 
	@ToDepartmentID VARCHAR(50), 
	@TeamID VARCHAR(50),
	@VoucherDate DATETIME,
	@Mode TINYINT --0:tính lương, 1:hủy bỏ
	
)
AS
DECLARE @AbsentDecimals INT

SELECT @AbsentDecimals = AbsentDecimals
FROM HT0000
WHERE DivisionID = @DivisionID

IF EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[Temp_HP0520]') AND TYPE IN (N'U'))
DROP TABLE Temp_HP0520

CREATE TABLE Temp_HP0520 (DivisionID VARCHAR(50), EmployeeID VARCHAR(50), TranMonth INT, TranYear INT, DepartmentID VARCHAR(50), 
TeamID VARCHAR(50), BaseSalary DECIMAL(28,8), ExcessQuantity DECIMAL(28,8), ExcessAmount DECIMAL(28,8), OTQuantity DECIMAL(28,8), 
OTAmount DECIMAL(28,8), C05 DECIMAL(28,8))

INSERT INTO Temp_HP0520 (DivisionID, TranMonth, TranYear, EmployeeID, DepartmentID, TeamID, BaseSalary, C05)
SELECT T1.DivisionID, T2.TranMonth, T2.TranYear, T2.EmployeeID, T2.DepartmentID, T2.TeamID, T2.BaseSalary, T2.C05
FROM HT1400 T1 WITH (NOLOCK)
INNER JOIN HT2400 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID 
AND T1.DepartmentID = T2.DepartmentID AND ISNULL(T1.TeamID,'') = ISNULL(T2.TeamID,'')
WHERE T1.DivisionID = @DivisionID
AND T2.TranMonth = @TranMonth AND T2.TranYear = @TranYear
AND T1.DepartmentID BETWEEN @FromDepartmentID AND @ToDepartmentID
AND ISNULL(T1.TeamID,'') LIKE ISNULL(@TeamID,'%')
AND (EXISTS (SELECT TOP 1 1 FROM HT1113 WHERE HT1113.DivisionID = T2.DivisionID AND HT1113.EmployeeID = T2.EmployeeID 
											AND HT1113.TranMonth = T2.TranMonth AND HT1113.TranYear = T2.TranYear)
	OR EXISTS (SELECT TOP 1 1 FROM HT1114 WHERE HT1114.DivisionID = T2.DivisionID AND HT1114.EmployeeID = T2.EmployeeID 
											AND HT1114.TranMonth = T2.TranMonth AND HT1114.TranYear = T2.TranYear)
	)

---- Modified by Khả Vi on 18/10/2017: Tạo bảng tạm, thông tin nhân viên cho báo cáo 
IF EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[Temp_HP0524]') AND TYPE IN (N'U'))
DROP TABLE Temp_HP0524
CREATE TABLE Temp_HP0524 (DivisionID VARCHAR(50), EmployeeID VARCHAR(50), TranMonth INT, TranYear INT, BaseSalary DECIMAL(28,8), 
ExcessQuantity DECIMAL(28,8), OTQuantity DECIMAL(28,8), [Date] DATETIME, DutyID VARCHAR(50), MachineID VARCHAR(50), DepartmentID VARCHAR(50), 
TeamID VARCHAR(50))

INSERT INTO Temp_HP0524 (DivisionID, TranMonth, TranYear, EmployeeID, BaseSalary, DepartmentID, TeamID)
SELECT T1.DivisionID, T2.TranMonth, T2.TranYear, T2.EmployeeID, T2.BaseSalary, T2.DepartmentID, T2.TeamID
FROM HT1400 T1 WITH (NOLOCK)
INNER JOIN HT2400 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID 
AND T1.DepartmentID = T2.DepartmentID AND ISNULL(T1.TeamID,'') = ISNULL(T2.TeamID,'')
WHERE T1.DivisionID = @DivisionID
AND T2.TranMonth = @TranMonth AND T2.TranYear = @TranYear
AND T1.DepartmentID BETWEEN @FromDepartmentID AND @ToDepartmentID
AND ISNULL(T1.TeamID,'') LIKE ISNULL(@TeamID,'%')
AND (EXISTS (SELECT TOP 1 1 FROM HT1113 WHERE HT1113.DivisionID = T2.DivisionID AND HT1113.EmployeeID = T2.EmployeeID 
											AND HT1113.TranMonth = T2.TranMonth AND HT1113.TranYear = T2.TranYear)
	OR EXISTS (SELECT TOP 1 1 FROM HT1114 WHERE HT1114.DivisionID = T2.DivisionID AND HT1114.EmployeeID = T2.EmployeeID 
											AND HT1114.TranMonth = T2.TranMonth AND HT1114.TranYear = T2.TranYear)
	)

IF @Mode = 0 --tính lương
BEGIN
	---Danh sách NV tính lương năng suất
	IF EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[Employee_HP0520]') AND TYPE IN (N'U'))
	DROP TABLE Employee_HP0520
	
	SELECT TranMonth, TranYear, DivisionID, EmployeeID, MachineID, FromDate, ToDate, DutyID, BaseSalary, ActFromTime, ActToTime, FromTime, ToTime
	INTO Employee_HP0520
	FROM
	(
		SELECT DISTINCT T1.TranMonth, T1.TranYear, T1.DivisionID,T1.EmployeeID, T1.MachineID, T1.[Date] AS FromDate, NULL AS ToDate, 'NV' AS DutyID, T2.BaseSalary,
		ISNULL(T1.ActFromTime, T3.FromTime) AS ActFromTime, ISNULL(T1.ActToTime, T3.ToTime) AS ActToTime, T3.FromTime, T3.ToTime
		FROM HT1113 T1 WITH (NOLOCK) ----NV đứng máy
		INNER JOIN HT2400 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID 
											AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear
		LEFT JOIN 
		(	SELECT HT1110.DivisionID, HT1110.TranMonth, HT1110.TranYear, HT1110.MachineID, HT1111.[Date], HT1111.FromTime, HT1111.ToTime
			FROM HT1110 WITH (NOLOCK) 
			LEFT JOIN HT1111 WITH (NOLOCK) ON CONVERT(VARCHAR(50),HT1110.APK) = HT1111.APKMaster AND HT1111.DivisionID = HT1110.DivisionID
			WHERE HT1110.DivisionID = @DivisionID
			AND HT1110.TranMonth = @TranMonth AND HT1110.TranYear = @TranYear
		)T3 ON T1.DivisionID = T3.DivisionID AND T1.MachineID = T3.MachineID AND T1.TranMonth = T3.TranMonth AND T1.TranYear = T3.TranYear AND T1.[Date] = T3.[Date]
		WHERE T1.DivisionID = @DivisionID
		AND T1.TranMonth = @TranMonth AND T1.TranYear = @TranYear
		UNION ALL
		SELECT DISTINCT T1.TranMonth, T1.TranYear, T1.DivisionID,T1.EmployeeID, T1.MachineID, T1.FromDate, T1.ToDate, 'GS' AS DutyID, T2.BaseSalary, 
		NULL AS ActFromTime, NULL AS ActToTime, NULL AS FromTime, NULL AS ToTime
		FROM HT1114 T1 WITH (NOLOCK) ----Giám sát
		INNER JOIN HT2400 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID 
											AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear
		WHERE T1.DivisionID = @DivisionID
		AND T1.TranMonth = @TranMonth AND T1.TranYear = @TranYear
	)Temp

	---Tính số lượng vượt trong giờ
	/*Sum số lượng vượt trong giờ (Nhật ký sản xuất) các máy mà nhân viên đó được phân công (Phân công - chấm công)*/

---- Modified by Khả Vi on 18/10/2017: Danh sách nhận viên giám sát theo ngày 
	---- Bảng tạm cho nhân viên giám sát 
	IF EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[Employee_HP0524_GS]') AND TYPE IN (N'U'))
	DROP TABLE Employee_HP0524_GS
	CREATE TABLE Employee_HP0524_GS (TranMonth INT, TranYear INT, DivisionID VARCHAR(50), EmployeeID VARCHAR(50), MachineID VARCHAR(50), 
	FromDate DATETIME, ToDate DATETIME, DutyID VARCHAR(50), BaseSalary DECIMAL(28,8), Date DATETIME)
	-- Danh sách nhân viên giám sát theo từng ngày
	SELECT DISTINCT T1.TranMonth, T1.TranYear, T1.DivisionID,T1.EmployeeID, T1.MachineID, T1.FromDate , 
	T1.ToDate, 'GS' AS DutyID, T2.BaseSalary, T1.FromDate AS [Date]
	INTO #TamGS
	FROM HT1114 T1 WITH (NOLOCK) 
	INNER JOIN HT2400 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear
	WHERE T1.DivisionID = @DivisionID AND T1.TranMonth = @TranMonth AND T1.TranYear = @TranYear

	DECLARE @Cur_GS CURSOR,
			@TranMonth_Cur_GS INT,
			@TranYear_Cur_GS INT,
			@DivisionID_Cur_GS VARCHAR(50),
			@EmployeeID_Cur_GS VARCHAR(50),
			@MachineID_Cur_GS VARCHAR(50),
			@FromDate_Cur_GS DATETIME,
			@ToDate_Cur_GS DATETIME,
			@DutyID_Cur_GS VARCHAR(50),
			@BaseSalary_Cur_GS DECIMAL (28,8),
			@Date_Cur_GS DATETIME

	SET @Cur_GS = CURSOR SCROLL KEYSET FOR
	SELECT TranMonth, TranYear, DivisionID, EmployeeID, MachineID, FromDate, ToDate, DutyID, BaseSalary, [Date]
	FROM #TamGS  
	OPEN @Cur_GS
	FETCH NEXT FROM @Cur_GS INTO @TranMonth_Cur_GS, @TranYear_Cur_GS, @DivisionID_Cur_GS, @EmployeeID_Cur_GS, @MachineID_Cur_GS, @FromDate_Cur_GS, 
	@ToDate_Cur_GS, @DutyID_Cur_GS, @BaseSalary_Cur_GS, @Date_Cur_GS
	WHILE @@FETCH_STATUS = 0
	BEGIN
		DECLARE @CountFrom DATETIME,
				@CountTo DATETIME
		
		SET @CountFrom = @FromDate_Cur_GS
		SET @CountTo = @ToDate_Cur_GS

		WHILE (@CountFrom <= @CountTo)
		BEGIN
			
			INSERT INTO Employee_HP0524_GS (TranMonth, TranYear, DivisionID, EmployeeID, MachineID, FromDate, ToDate, DutyID, BaseSalary, [Date])
			SELECT TranMonth, TranYear, DivisionID, EmployeeID, MachineID, FromDate, ToDate, DutyID, BaseSalary, @CountFrom AS [Date]
			FROM #TamGS
			WHERE EmployeeID = @EmployeeID_Cur_GS AND MachineID = @MachineID_Cur_GS AND FromDate = @FromDate_Cur_GS AND ToDate = @ToDate_Cur_GS
			
			SET  @CountFrom = @CountFrom + 1 
		END
	
	FETCH NEXT FROM @Cur_GS INTO @TranMonth_Cur_GS, @TranYear_Cur_GS, @DivisionID_Cur_GS, @EmployeeID_Cur_GS, @MachineID_Cur_GS, @FromDate_Cur_GS, 
	@ToDate_Cur_GS, @DutyID_Cur_GS, @BaseSalary_Cur_GS, @Date_Cur_GS
	END
	CLOSE @Cur_GS
	-- Danh sách nhân viên giám sát và đứng máy theo ngày 
	IF EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[Employee_HP0524]') AND TYPE IN (N'U'))
	DROP TABLE Employee_HP0524
	
	SELECT DISTINCT TranMonth, TranYear, DivisionID, EmployeeID, MachineID, FromDate, ToDate, DutyID, BaseSalary, [Date], ActFromTime, ActToTime, FromTime, ToTime
	INTO Employee_HP0524
	FROM
	(
		SELECT TranMonth, TranYear, DivisionID, EmployeeID, MachineID, FromDate, ToDate, DutyID, BaseSalary, FromDate AS [Date], ActFromTime, ActToTime, FromTime, ToTime
		FROM Employee_HP0520 ----NV đứng máy
		WHERE DutyID = 'NV'
		UNION ALL
		SELECT DISTINCT TranMonth, TranYear, DivisionID, EmployeeID, MachineID, FromDate, ToDate, DutyID, BaseSalary, [Date], NULL AS ActFromTime, 
		NULL AS ActToTime, NULL AS FromTime, NULL AS ToTime
		FROM Employee_HP0524_GS
	)Temp
	-- Insert vào bảng Temp_HP0524
	DELETE Temp_HP0524
	WHERE EXISTS (SELECT TOP 1 1 EmployeeID FROM Employee_HP0524 WHERE DutyID = 'GS' AND EmployeeID = Temp_HP0524.EmployeeID)

	INSERT INTO Temp_HP0524 (DivisionID, EmployeeID, TranMonth, TranYear, [Date], MachineID, DutyID)
	SELECT DivisionID, EmployeeID, TranMonth, TranYear, [Date], MachineID, DutyID
	FROM Employee_HP0524
	WHERE DutyID = 'GS'

	UPDATE T1
	SET T1.[Date] = T2.[Date],
		T1.DutyID = T2.DutyID,
		T1.MachineID = T2.MachineID
	FROM Temp_HP0524 T1
	INNER JOIN Employee_HP0524 T2 ON T1.EmployeeID = T2.EmployeeID AND T2.DutyID = 'NV'

	INSERT INTO Temp_HP0524 (DivisionID, TranMonth, TranYear, EmployeeID, BaseSalary, DepartmentID, TeamID, [Date], MachineID, DutyID)
	SELECT  T1.DivisionID, T1.TranMonth, T1.TranYear, T1.EmployeeID, T1.BaseSalary, T1.DepartmentID, T1.TeamID, T2.[Date], T2.MachineID, T2.DutyID
	FROM Temp_HP0524 T1
	INNER JOIN Employee_HP0524 T2 ON T1.EmployeeID = T2.EmployeeID AND T2.DutyID = 'NV'
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM Temp_HP0524 T3 WHERE T3.EmployeeID = T2.EmployeeID AND T3.[Date] = T2.[Date] AND  T2.DutyID = 'NV')


	--Thông tin của máy có sx trong kỳ
	SELECT DISTINCT T1.MachineID, T1.TranMonth, T1.TranYear, T1.Date, CASE WHEN ISNULL(T1.InVariance,0) <= 0 THEN 0 ELSE ISNULL(T1.InVariance,0) END AS InVariance, T6.UnitID, T1.OutQuantity,
	CONVERT(DECIMAL(28,8),DATEDIFF(mi,CONVERT(TIME(0),T4.FromTime), CONVERT(TIME(0),T4.ToTime)))/60 - ISNULL(T5.Stoptime,0) - 1 AS MachineTime,
	T6.HourPerDay, T6.DayPerMonth, T6.QuantityPerDay, T4.FromTime, T4.ToTime
	INTO #Machine_HP0520
	FROM HT1117 T1 WITH (NOLOCK)
	INNER JOIN Employee_HP0520 T2 ON T1.MachineID = T2.MachineID AND T2.FromDate = T1.[Date]
	INNER JOIN HT1110 T3 WITH (NOLOCK) ON T1.DivisionID = T3.DivisionID AND T1.MachineID = T3.MachineID AND T1.TranMonth = T3.TranMonth AND T1.TranYear = T3.TranYear
	INNER JOIN HT1111 T4 ON CONVERT(VARCHAR(50),T3.APK)=T4.APKMaster AND T1.Date = T4.Date
	LEFT JOIN 
	(
		SELECT T5.DivisionID, T5.MachineID, T5.TranMonth, T5.TranYear, T5.Date,
		SUM(ISNULL(CONVERT(DECIMAL(28,8),DATEDIFF(mi,CONVERT(TIME(0),T5.FromTime),CONVERT(TIME(0),T5.ToTime))),0)/60) AS Stoptime
		FROM HT1115  T5
		WHERE T5.DivisionID = @DivisionID
		AND T5.TranMonth = @TranMonth AND T5.TranYear = @TranYear
		GROUP BY T5.DivisionID, T5.MachineID, T5.TranMonth, T5.TranYear, T5.Date
	)T5 ON T1.DivisionID = T5.DivisionID AND T1.MachineID = T5.MachineID AND T1.TranMonth = T5.TranMonth AND T1.TranYear = T5.TranYear AND T1.Date = T5.Date
	INNER JOIN HT1109 T6 WITH (NOLOCK) ON T1.DivisionID = T6.DivisionID AND T1.MachineID = T6.MachineID
	WHERE T1.DivisionID = @DivisionID
	AND T1.TranMonth = @TranMonth AND T1.TranYear = @TranYear

	---Nếu TG làm việc của máy <= TG chuẩn của máy => lấy TG làm việc của máy, ngược lại thì lấy TG chuẩn của máy
	UPDATE T1
	SET T1.MachineTime = CASE WHEN T1.MachineTime <= T1.HourPerDay - 1 THEN T1.MachineTime ELSE T1.HourPerDay - 1 END
	FROM #Machine_HP0520 T1

	--TG làm việc của nhân viên
	EXEC HP0521 @DivisionID, @TranMonth, @TranYear

	--select 'Employee_HP0520',* from Employee_HP0520 where employeeid='NTVN0243' order by fromdate
	--select '#Machine_HP0520',* from #Machine_HP0520 where machineid='CONECUON1' order by machineID, date
	--select 'WorkingTime_HP0521',* from WorkingTime_HP0521
	
	---Tính đơn giá cho giám sát
	SELECT DISTINCT EmployeeID, ISNULL(BaseSalary,0) AS BaseSalary, CONVERT(DECIMAL(28,8),0) AS UnitPrice
	INTO #Temp_UnitPrice
	FROM Employee_HP0520
	WHERE DutyID = 'GS'
	
	SELECT DISTINCT EmployeeID, UnitID, 1/ISNULL(SUM(ISNULL(QuantityPerDay,0)),1) AS QuantityPerDay_Unit
	INTO #Temp_Machine
	FROM #Machine_HP0520 T1
	INNER JOIN Employee_HP0520 T2 ON T1.MachineID = T2.MachineID AND T1.[Date] BETWEEN T2.FromDate AND T2.ToDate
	WHERE T2.DutyID = 'GS'
	GROUP BY EmployeeID, UnitID
	
	UPDATE T1
	SET UnitPrice = T1.BaseSalary/T2.TotalUnitID * T2.QuantityPerDay_Unit
	FROM #Temp_UnitPrice T1
	INNER JOIN 
	(
		SELECT EmployeeID, COUNT(UnitID) AS TotalUnitID, SUM(QuantityPerDay_Unit) AS QuantityPerDay_Unit
		FROM #Temp_Machine 
		GROUP BY EmployeeID
	)T2 ON T1.EmployeeID = T2.EmployeeID
	WHERE ISNULL(T2.TotalUnitID,0) <> 0

	---Tính sản lượng và thành tiền cho giám sát
		UPDATE T1
		SET T1.ExcessQuantity = Temp1.TotalInVariance,
			T1.OTQuantity = Temp1.TotalOutQuantity,
			T1.ExcessAmount = Temp1.TotalInVariance * Temp1.UnitPrice*1.5,
			T1.OTAmount = Temp1.TotalOutQuantity * Temp1.UnitPrice*1.5
		FROM Temp_HP0520 T1
		INNER JOIN
		(	SELECT T2.EmployeeID,  T4.UnitPrice, SUM(ISNULL(T3.InVariance,0)) AS TotalInVariance, SUM(ISNULL(T3.OutQuantity,0)) AS TotalOutQuantity
			FROM Employee_HP0520 T2
			INNER JOIN #Machine_HP0520 T3 ON T2.MachineID = T3.MachineID
			INNER JOIN #Temp_UnitPrice T4 ON T2.EmployeeID = T4.EmployeeID
			WHERE T2.DutyID = 'GS'
			GROUP BY T2.EmployeeID, T4.UnitPrice
		)Temp1 ON T1.EmployeeID = Temp1.EmployeeID
---- Modified by Khả Vi on 18/10/2017:Tính sản lượng cho giám sát theo ngày 
		UPDATE T1
		SET T1.ExcessQuantity = Temp1.TotalInVariance,
			T1.OTQuantity = Temp1.TotalOutQuantity
		FROM Temp_HP0524 T1
		INNER JOIN
		(	SELECT T2.EmployeeID,  SUM(ISNULL(T3.InVariance,0)) AS TotalInVariance, SUM(ISNULL(T3.OutQuantity,0)) AS TotalOutQuantity, T2.MachineID, T2.[Date], T2.DutyID
			FROM Employee_HP0524 T2
			INNER JOIN #Machine_HP0520 T3 ON T2.MachineID = T3.MachineID AND T2.[Date] = T3.[Date]
			WHERE T2.DutyID = 'GS'
			GROUP BY T2.EmployeeID, T2.MachineID, T2.[Date], T2.DutyID
		)Temp1 ON T1.EmployeeID = Temp1.EmployeeID AND T1.[Date] = Temp1.[Date] AND T1.MachineID = Temp1.MachineID

--select 'WorkingTime_HP0521', CASE WHEN T4.TotalInTime <= T3.MachineTime THEN T4.TotalInTime ELSE T3.MachineTime END, * 
--FROM Temp_HP0520 T1
--INNER JOIN Employee_HP0520 T2 ON T1.EmployeeID = T2.EmployeeID
--INNER JOIN WorkingTime_HP0521 T4 ON T2.EmployeeID = T4.EmployeeID AND T4.[Date] = T2.Fromdate
--INNER JOIN #Machine_HP0520 T3 ON T2.MachineID = T3.MachineID AND T2.Fromdate = T3.[Date] AND T4.[Date] = T3.[Date]
--where  t1.employeeid='NTVN0230' order by t4.date

--SELECT MachineID, Date, InVariance, MachineTime, DayPerMonth, QuantityPerDay, OutQuantity
--FROM #Machine_HP0520 
--where  MachineID='Conebo6' order by date
	DECLARE @Cur CURSOR,
			@MachineID_Cur VARCHAR(50),
			@Date_Cur DATETIME,
			@InVariance_Cur DECIMAL(28,8),
			@MachineTime_Cur DECIMAL(28,8),
			@DayPerMonth_Cur DECIMAL(28,8),
			@QuantityPerDay_Cur DECIMAL(28,8),
			@OutQuantity_Cur DECIMAL(28,8),
			@ToTime_Cur NVARCHAR(50),
			@FromTime_Cur NVARCHAR(50),
			@EndInTime NVARCHAR(50)

	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT MachineID, Date, ISNULL(InVariance,0) AS InVariance, MachineTime, DayPerMonth, QuantityPerDay, ISNULL(OutQuantity,0) AS OutQuantity, FromTime, ToTime
	FROM #Machine_HP0520  
	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @MachineID_Cur,@Date_Cur,@InVariance_Cur,@MachineTime_Cur,@DayPerMonth_Cur,@QuantityPerDay_Cur,@OutQuantity_Cur, @FromTime_Cur, @ToTime_Cur
	WHILE @@FETCH_STATUS = 0
	BEGIN
	--select @MachineID_Cur MachineID_Cur,@Date_Cur Date_Cur,@InVariance_Cur InVariance_Cur,@MachineTime_Cur MachineTime_Cur
		SET @EndInTime = CONVERT(TIME(0),DATEADD(hh,8,@FromTime_Cur))
		---Tính sản lượng của NV
		IF ISNULL(@MachineTime_Cur,0) <> 0
		BEGIN
			UPDATE T1
			SET T1.ExcessQuantity = ISNULL(T1.ExcessQuantity,0) + @InVariance_Cur*(CASE WHEN T4.TotalInTime <= @MachineTime_Cur THEN T4.TotalInTime ELSE @MachineTime_Cur END)/@MachineTime_Cur,
				T1.OTQuantity = ISNULL(T1.OTQuantity,0) + @OutQuantity_Cur * CASE WHEN @ToTime_Cur <= @EndInTime THEN 0
																			 ELSE CASE WHEN T2.ActToTime > @ToTime_Cur THEN 1
																					  ELSE CASE WHEN @EndInTime >= T2.ActToTime THEN 0 ELSE (CONVERT(DECIMAL(28,8),DATEDIFF(mi,@EndInTime,T2.ActToTime))/60) / (CONVERT(DECIMAL(28,8),DATEDIFF(mi,@EndInTime,@ToTime_Cur))/60) END END END
			FROM Temp_HP0520 T1
			INNER JOIN Employee_HP0520 T2 ON T1.EmployeeID = T2.EmployeeID AND T2.Fromdate = @Date_Cur
			INNER JOIN WorkingTime_HP0521 T4 ON T2.EmployeeID = T4.EmployeeID AND T4.[Date] = @Date_Cur
			INNER JOIN #Machine_HP0520 T3 ON T2.MachineID = T3.MachineID AND T2.Fromdate = T3.[Date] AND T4.[Date] = T3.[Date]
			WHERE T2.DutyID = 'NV' AND T2.MachineID = @MachineID_Cur AND T2.Fromdate = @Date_Cur

			-- Modified by Khả Vi on 18/10/2017: Tính sản lượng của nhân viên đứng máy theo ngày 
			UPDATE T1 
			SET T1.ExcessQuantity = ISNULL(T1.ExcessQuantity, 0) + @InVariance_Cur * (CASE WHEN T3.TotalInTime <= @MachineTime_Cur THEN T3.TotalInTime ELSE @MachineTime_Cur END) / @MachineTime_Cur,
			T1.OTQuantity= ISNULL(T1.OTQuantity,0) + @OutQuantity_Cur * CASE WHEN @ToTime_Cur <= @EndInTime THEN 0
				ELSE CASE WHEN T2.ActToTime > @ToTime_Cur THEN 1
				ELSE (CONVERT(DECIMAL(28,8),DATEDIFF(mi, @EndInTime, T2.ActToTime))/60) / (CONVERT(DECIMAL(28,8),DATEDIFF(mi, @EndInTime, @ToTime_Cur))/60) END END
			FROM Temp_HP0524 T1
			INNER JOIN Employee_HP0524 T2 ON T1.EmployeeID = T2.EmployeeID AND T1.[Date] = T2.[Date] AND T1.MachineID = T2.MachineID
			INNER JOIN WorkingTime_HP0521 T3 ON T1.EmployeeID = T3.EmployeeID AND T1.[Date] = T3.[Date] AND T1.MachineID = T3.MachineID
			WHERE T2.DutyID = 'NV' 
			AND T1.MachineID = @MachineID_Cur 
			AND T1.[Date] = @Date_Cur
		END
		---Tính thành tiền sản lượng của NV
		IF ISNULL(@MachineTime_Cur,0) <> 0
		BEGIN
			UPDATE T1
			SET T1.ExcessAmount = ISNULL(T1.ExcessAmount,0) + (@InVariance_Cur*(CASE WHEN T4.TotalInTime <= @MachineTime_Cur THEN T4.TotalInTime ELSE @MachineTime_Cur END)/@MachineTime_Cur) * (ISNULL(T2.BaseSalary,0)/ISNULL(@DayPerMonth_Cur,1)/ISNULL(@QuantityPerDay_Cur,1))*1.5,
				T1.OTAmount = ISNULL(T1.OTAmount,0) + (@OutQuantity_Cur*CASE WHEN @ToTime_Cur <= @EndInTime THEN 0
																			ELSE CASE WHEN T2.ActToTime > @ToTime_Cur THEN 1
																					  ELSE CASE WHEN @EndInTime>=T2.ActToTime THEN 0 ELSE (CONVERT(DECIMAL(28,8),DATEDIFF(mi,@EndInTime,T2.ActToTime))/60) / (CONVERT(DECIMAL(28,8),DATEDIFF(mi,@EndInTime,@ToTime_Cur))/60) END END END) * (ISNULL(T2.BaseSalary,0)/ISNULL(@DayPerMonth_Cur,1)/ISNULL(@QuantityPerDay_Cur,1))*1.5
			FROM Temp_HP0520 T1
			INNER JOIN Employee_HP0520 T2 ON T1.EmployeeID = T2.EmployeeID AND T2.Fromdate = @Date_Cur
			INNER JOIN WorkingTime_HP0521 T4 ON T2.EmployeeID = T4.EmployeeID AND T4.[Date] = @Date_Cur
			WHERE T2.MachineID = @MachineID_Cur
			AND T2.Fromdate = @Date_Cur
			AND T2.DutyID = 'NV'
		END
		SET @EndInTime = NULL

	FETCH NEXT FROM @Cur INTO @MachineID_Cur,@Date_Cur,@InVariance_Cur,@MachineTime_Cur,@DayPerMonth_Cur,@QuantityPerDay_Cur,@OutQuantity_Cur, @FromTime_Cur, @ToTime_Cur
	END
	CLOSE @Cur
	--Insert bảng lương năng suất
	DELETE FROM HT1118
	WHERE EXISTS (SELECT TOP 1 1 FROM Temp_HP0520 T2 
				  WHERE HT1118.DivisionID = T2.DivisionID AND HT1118.EmployeeID = T2.EmployeeID
				  AND HT1118.TranMonth = T2.TranMonth AND HT1118.TranYear = T2.TranYear)
	
	INSERT INTO HT1118 (APK, DivisionID, EmployeeID, TranMonth, TranYear, DepartmentID, TeamID, BaseSalary, ExcessQuantity, ExcessAmount, OTQuantity,
						OTAmount, CreateUserID, CreateDate)
	SELECT NEWID(), @DivisionID,  EmployeeID, TranMonth, TranYear, DepartmentID, TeamID, BaseSalary, ROUND(ExcessQuantity, @AbsentDecimals), ROUND(ExcessAmount, @AbsentDecimals),
	ROUND(OTQuantity, @AbsentDecimals), ROUND(OTAmount, @AbsentDecimals), @UserID, GETDATE()
	FROM Temp_HP0520
---- Modified by Khả Vi on 18/10/2017: 
	--Pivot sản lượng trong giờ của nhân viên theo ngày
	SELECT * 
	INTO #Temp_HP0524_InVariance
	FROM (SELECT DivisionID, EmployeeID, MachineID, TranMonth, TranYear, BaseSalary, ExcessQuantity, 
	N'Quantity'+CONVERT(NVARCHAR(50),DATEPART(D, Date)) AS Date, DutyID, 1 AS [Type], DepartmentID, TeamID
	FROM Temp_HP0524) AS P
	PIVOT (MAX(ExcessQuantity) FOR Date IN ([Quantity1], [Quantity2], [Quantity3], [Quantity4], [Quantity5], [Quantity6], [Quantity7], [Quantity8],
	[Quantity9], [Quantity10], [Quantity11], [Quantity12], [Quantity13], [Quantity14], [Quantity15], [Quantity16], [Quantity17], 
	[Quantity18], [Quantity19], [Quantity20], [Quantity21], [Quantity22], [Quantity23], [Quantity24], [Quantity25], [Quantity26], 
	[Quantity27], [Quantity28], [Quantity29], [Quantity30], [Quantity31])) AS PivotTable


	--Pivot sản lượng ngoài giờ của nhân viên theo ngày
	SELECT * 
	INTO #Temp_HP0524_Out
	FROM (SELECT DivisionID, EmployeeID, MachineID, TranMonth, TranYear, BaseSalary, OTQuantity, 
	N'Quantity'+CONVERT(NVARCHAR(50),DATEPART(D, Date)) AS Date, DutyID, 2 AS [Type], DepartmentID, TeamID
	FROM Temp_HP0524) AS P
	PIVOT (MAX(OTQuantity) FOR Date IN ([Quantity1], [Quantity2], [Quantity3], [Quantity4], [Quantity5], [Quantity6], [Quantity7], [Quantity8],
	[Quantity9], [Quantity10], [Quantity11], [Quantity12], [Quantity13], [Quantity14], [Quantity15], [Quantity16], [Quantity17], 
	[Quantity18], [Quantity19], [Quantity20], [Quantity21], [Quantity22], [Quantity23], [Quantity24], [Quantity25], [Quantity26], 
	[Quantity27], [Quantity28], [Quantity29], [Quantity30], [Quantity31])) AS PivotTable
	
	
	-- Insert bảng HT1119 ( lương năng suất theo ngày) 
	SELECT *
	INTO #TAM
	FROM (SELECT * FROM #Temp_HP0524_InVariance
	UNION ALL
	SELECT * FROM  #Temp_HP0524_Out) Temp3


	DELETE FROM HT1119
	WHERE EXISTS (SELECT TOP 1 1 FROM #TAM T2 
				  WHERE HT1119.DivisionID = T2.DivisionID AND HT1119.EmployeeID = T2.EmployeeID
				  AND HT1119.TranMonth = T2.TranMonth AND HT1119.TranYear = T2.TranYear AND HT1119.MachineID = T2.MachineID AND HT1119.[Type] = T2.[Type])
	INSERT INTO HT1119 (APK, DivisionID, EmployeeID, MachineID, TranMonth, TranYear, Quantity1, Quantity2, Quantity3, Quantity4, Quantity5, Quantity6, Quantity7, Quantity8,
	Quantity9, Quantity10, Quantity11, Quantity12, Quantity13, Quantity14, Quantity15, Quantity16, Quantity17, Quantity18, Quantity19, Quantity20, Quantity21, Quantity22,
	Quantity23, Quantity24, Quantity25, Quantity26, Quantity27, Quantity28, Quantity29, Quantity30, Quantity31, [Type], CreateUserID, CreateDate, DepartmentID, TeamID)
	
	SELECT NEWID(), @DivisionID, EmployeeID, MachineID, TranMonth, TranYear, Quantity1, Quantity2, Quantity3, Quantity4, Quantity5, Quantity6, Quantity7, Quantity8,
	Quantity9, Quantity10, Quantity11, Quantity12, Quantity13, Quantity14, Quantity15, Quantity16, Quantity17, Quantity18, Quantity19, Quantity20, Quantity21, Quantity22,
	Quantity23, Quantity24, Quantity25, Quantity26, Quantity27, Quantity28, Quantity29, Quantity30, Quantity31, [Type], @UserID, GETDATE(), DepartmentID, TeamID
	FROM #TAM

	---Chuyển thành tiển trong và ngoài giờ sang bảng lương công nhật
	UPDATE T1
	SET T1.Income27 = T2.ExcessAmount,
		T1.Income28 = T2.OTAmount
	FROM HT3400 T1
	INNER JOIN Temp_HP0520 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID 
	AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear
	WHERE T1.DivisionID = @DivisionID
	AND T1.TranMonth = @TranMonth AND T1.TranYear = @TranYear
	AND T1.DepartmentID BETWEEN @FromDepartmentID AND @ToDepartmentID
	AND ISNULL(T1.TeamID,'') LIKE ISNULL(@TeamID,'%')

	/*===###### Tính tổng số tiền trừ trong tháng và tiền trừ chuyển qua tháng sau #####===*/
	
	DECLARE @MinTranMonth INT, @MinTranYear INT
	SELECT TOP 1 @MinTranMonth = TranMonth, @MinTranYear = TranYear
	FROM HT9999
	Where DivisionID = @DivisionID
	ORDER BY TranYear ASC, TranMonth ASC

	IF @TranMonth+@TranYear*100 = @MinTranMonth+@MinTranYear*100 --kỳ đầu tiên
	BEGIN
		UPDATE T1
		SET T1.RepayTotalAmount = CASE WHEN T2.TotalOTAmount >= T2.TotalRepayAmount THEN ROUND(T2.TotalRepayAmount,@AbsentDecimals) ELSE ROUND(T2.TotalOTAmount,@AbsentDecimals) END,
			T1.RemainAmount = CASE WHEN T2.TotalOTAmount >= T2.TotalRepayAmount THEN 0 ELSE ROUND(T2.TotalRepayAmount - T2.TotalOTAmount,@AbsentDecimals) END
		FROM HT1116 T1
		INNER JOIN 
		(
			SELECT EmployeeID, DivisionID, TranMonth, TranYear, ISNULL(OTAmount,0) AS TotalOTAmount, ISNULL(C05,0) AS TotalRepayAmount
			FROM Temp_HP0520 
		)T2 ON T1.DivisionID = T2.DivisionID AND T2.EmployeeID = T1.EmployeeID AND T2.TranMonth = T1.TranMonth AND T2.TranYear = T1.TranYear
	END
	ELSE
	BEGIN
		UPDATE T1
		SET T1.RepayTotalAmount = CASE WHEN T2.TotalOTAmount >= (T3.TotalRepayAmount+T4.RemainAmount)THEN ROUND(T3.TotalRepayAmount+T4.RemainAmount,@AbsentDecimals) ELSE ROUND(T2.TotalOTAmount,@AbsentDecimals) END,
			T1.RemainAmount = CASE WHEN T2.TotalOTAmount >= (T3.TotalRepayAmount+T4.RemainAmount) THEN 0 ELSE ROUND((T3.TotalRepayAmount+T4.RemainAmount) - T2.TotalOTAmount,@AbsentDecimals) END
		FROM HT1116 T1
		INNER JOIN 
		(
			SELECT EmployeeID, DivisionID, TranMonth, TranYear, ISNULL(OTAmount,0) AS TotalOTAmount
			FROM Temp_HP0520 
		)T2 ON T1.DivisionID = T2.DivisionID AND T2.EmployeeID = T1.EmployeeID AND T2.TranMonth = T1.TranMonth AND T2.TranYear = T1.TranYear
		INNER JOIN
		(
			SELECT APKMaster, DivisionID, SUM(ISNULL(RepayAmount,0)) AS TotalRepayAmount
			FROM HT11161 WITH (NOLOCK) 
			WHERE DivisionID = @DivisionID
			GROUP BY APKMaster, DivisionID
		)T3 ON T1.DivisionID = T3.DivisionID AND T1.TransactionID = T3.APKMaster
		LEFT JOIN
		(
			SELECT T1.DivisionID, T1.EmployeeID, MAX(T1.TranMonth+T1.TranYear*100) AS Period, ISNULL(T1.RemainAmount,0) AS RemainAmount
			FROM HT1116 T1 WITH (NOLOCK)
			WHERE T1.TranMonth+T1.TranYear*100 < @TranMonth+@TranYear*100
			AND T1.DivisionID = @DivisionID
			GROUP BY T1.DivisionID, T1.EmployeeID, T1.RemainAmount
		)T4 ON T1.DivisionID = T4.DivisionID AND T1.EmployeeID = T4.EmployeeID

	END

	DROP TABLE #Machine_HP0520
	DROP TABLE Employee_HP0520
	DROP TABLE WorkingTime_HP0521
	DROP TABLE Temp_HP0520
----- Modified by Khả Vi on 18/10/2017: 
	DROP TABLE Employee_HP0524_GS
	DROP TABLE Employee_HP0524
	DROP TABLE Temp_HP0524

	
END
ELSE ---@Mode = 1: hủy bỏ
BEGIN
	DELETE FROM HT1118
	WHERE EXISTS (SELECT TOP 1 1 FROM Temp_HP0520 T2 
				  WHERE HT1118.DivisionID = T2.DivisionID AND HT1118.EmployeeID = T2.EmployeeID
				  AND HT1118.TranMonth = T2.TranMonth AND HT1118.TranYear = T2.TranYear)
	
	DROP TABLE Temp_HP0520
----- Modified by Khả Vi on 18/10/2017: 
	DELETE FROM HT1119 
	WHERE EXISTS (SELECT TOP 1 1 FROM  Temp_HP0524 T2 
				  WHERE HT1119.DivisionID = T2.DivisionID AND HT1119.EmployeeID = T2.EmployeeID
				  AND HT1119.TranMonth = T2.TranMonth AND HT1119.TranYear = T2.TranYear AND HT1119.MachineID = T2.MachineID)

	DROP TABLE Temp_HP0524



END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
