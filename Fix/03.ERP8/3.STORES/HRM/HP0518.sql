IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0518]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0518]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Tính tiền trừ hàng trả lại (NEWTOYO)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT-HRM \ Danh mục \ Thông tin chấm công \ Sản phẩm trả về
-- <History>
----Created by Bảo Thy on 26/09/2017
---- Modified by on 

/*-- <Example>
	HP0518 @DivisionID='CH', @UserID = 'ASOFTADMIN', @TranMonth=1, @TranYear=2017, @FromDepartmentID='PB1', @ToDepartmentID='Z1', @TeamID = '%', @DutyID = '%', @EmployeeID = '%'
	select * from ht1116
	select * from ht11161
----*/
CREATE PROCEDURE [dbo].[HP0518]
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@FromDepartmentID VARCHAR(50), 
	@ToDepartmentID VARCHAR(50), 
	@TeamID VARCHAR(50)
	
)
AS
DECLARE @AbsentDecimals INT

SELECT @AbsentDecimals = AbsentDecimals
FROM HT0000
WHERE DivisionID = @DivisionID

/*
Số tiền trừ của từng máy theo từng nhân viên:
+ Công nhân = Số lượng trả * LCB/26/Chuẩn sản xuất ngày của máy đó
+ Giám sát = Số lượng trả * (100%/Tổng số loại máy khác đơn vị tính * LCB/Sum (chuẩn SX tháng của các máy giám sát cùng đơn vị tính)
*/
/* =====########## Tính Số tiền trừ của từng máy theo của nhân viên giám sát (RepayAmount) ##########===== */
--Tính đơn giá cho giám sát (đơn giá các máy bằng nhau)

SELECT DISTINCT T1.APK, T1.DivisionID, T1.TranMonth, T1.TranYear, T2.DepartmentID, T2.TeamID, T1.EmployeeID, T1.MachineID, T3.UnitID, T3.QuantityPerDay
INTO #Temp_GS
FROM HT1116 WITH (NOLOCK)
INNER JOIN HT11161 DT WITH (NOLOCK) ON DT.DivisionID = HT1116.DivisionID AND DT.APKMaster = HT1116.TransactionID
INNER JOIN HT1114 T1 WITH (NOLOCK) ON T1.DivisionID = HT1116.DivisionID AND T1.EmployeeID = HT1116.EmployeeID AND T1.TranMonth = HT1116.TranMonth AND T1.TranYear = HT1116.TranYear
AND T1.MachineID = DT.MachineID
INNER JOIN HT1400 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
LEFT JOIN HT1109 T3 WITH (NOLOCK) ON T1.DivisionID = T3.DivisionID AND T1.MachineID = T3.MachineID
INNER JOIN HT2400 T4 WITH (NOLOCK) ON T1.DivisionID = T4.DivisionID AND T1.EmployeeID = T4.EmployeeID AND T1.TranMonth = T4.TranMonth AND T1.TranYear = T4.TranYear
AND T2.DepartmentID = T4.DepartmentID AND ISNULL(T2.TeamID,'') = ISNULL(T4.TeamID,'')
INNER JOIN HT1110 WITH (NOLOCK) ON T1.DivisionID = HT1110.DivisionID AND T1.MachineID = HT1110.MachineID AND T1.TranMonth = HT1110.TranMonth AND T1.TranYear = HT1110.TranYear
INNER JOIN HT1111 WITH (NOLOCK) ON CONVERT(VARCHAR(50),HT1110.APK)=HT1111.APKMaster AND HT1111.Date BETWEEN T1.FromDate AND ISNULL(T1.ToDate,T1.FromDate)
WHERE HT1116.DivisionID = @DivisionID
AND HT1116.TranMonth+HT1116.TranYear*100 = @TranMonth+@TranYear*100
AND T2.DepartmentID BETWEEN @FromDepartmentID AND @ToDepartmentID
AND ISNULL(T2.TeamID,'') LIKE ISNULL(@TeamID,'%')

SELECT DISTINCT T1.EmployeeID, ISNULL(T2.BaseSalary,0) AS BaseSalary, CONVERT(DECIMAL(28,8),0) AS UnitPrice
INTO #Temp_UnitPrice
FROM #Temp_GS T1
INNER JOIN HT2400 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear
AND T2.DepartmentID = T2.DepartmentID AND ISNULL(T1.TeamID,'') = ISNULL(T2.TeamID,'')

SELECT DISTINCT EmployeeID, UnitID, 1/ISNULL(SUM(ISNULL(QuantityPerDay,0)),1) AS QuantityPerDay_Unit
INTO #Temp_Machine
FROM #Temp_GS
GROUP BY EmployeeID, UnitID

---Tính đơn giá giám sát
UPDATE T2
SET T2.UnitPrice = T2.BaseSalary/T3.TotalUnitID * T3.QuantityPerDay_Unit
FROM #Temp_GS T1
INNER JOIN #Temp_UnitPrice T2 ON T1.EmployeeID = T2.EmployeeID
INNER JOIN 
(
	SELECT EmployeeID, COUNT(UnitID) AS TotalUnitID, SUM(QuantityPerDay_Unit) AS QuantityPerDay_Unit
	FROM #Temp_Machine 
	GROUP BY EmployeeID
)T3 ON T2.EmployeeID = T3.EmployeeID
WHERE ISNULL(T3.TotalUnitID,0) <> 0

---update tiền hàng trả về
UPDATE HT11161
SET HT11161.RepayAmount = ROUND(HT11161.RepayQuantity * T2.UnitPrice,@AbsentDecimals)
FROM HT11161 WITH (NOLOCK)
INNER JOIN HT1116 MT WITH (NOLOCK) ON MT.DivisionID = HT11161.DivisionID AND HT11161.APKMaster = MT.TransactionID
INNER JOIN #Temp_GS T1 ON T1.DivisionID = MT.DivisionID AND T1.EmployeeID = MT.EmployeeID AND T1.TranMonth = MT.TranMonth 
AND T1.TranYear = MT.TranYear AND T1.MachineID = HT11161.MachineID
INNER JOIN #Temp_UnitPrice T2 ON MT.EmployeeID = T2.EmployeeID

/* =====########## Tính Số tiền trừ của từng máy theo của nhân viên đứng máy (RepayAmount) ##########=====*/

UPDATE DT
SET DT.RepayAmount = ROUND(ISNULL(DT.RepayQuantity,0)*ISNULL(T4.BaseSalary,0)/ISNULL(DayPerMonth,1)/ISNULL(QuantityPerDay,1),@AbsentDecimals)
FROM HT11161 DT WITH (NOLOCK)
INNER JOIN HT1116 T1 WITH (NOLOCK) ON DT.DivisionID = T1.DivisionID AND DT.APKMaster = T1.TransactionID
INNER JOIN HT1113 WITH (NOLOCK) ON T1.DivisionID = HT1113.DivisionID AND T1.EmployeeID = HT1113.EmployeeID AND T1.TranMonth = HT1113.TranMonth AND T1.TranYear = HT1113.TranYear
AND DT.MachineID = HT1113.MachineID
INNER JOIN HT1400 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
LEFT JOIN HT1109 T3 WITH (NOLOCK) ON T1.DivisionID = T3.DivisionID AND DT.MachineID = T3.MachineID
INNER JOIN HT2400 T4 WITH (NOLOCK) ON T1.DivisionID = T4.DivisionID AND T1.EmployeeID = T4.EmployeeID AND T1.TranMonth = T4.TranMonth AND T1.TranYear = T4.TranYear
AND T2.DepartmentID = T4.DepartmentID AND ISNULL(T2.TeamID,'') = ISNULL(T4.TeamID,'')
WHERE DT.DivisionID = @DivisionID
AND T1.TranMonth+T1.TranYear*100 = @TranMonth+@TranYear*100
AND T2.DepartmentID BETWEEN @FromDepartmentID AND @ToDepartmentID
AND ISNULL(T2.TeamID,'') LIKE ISNULL(@TeamID,'%')


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
