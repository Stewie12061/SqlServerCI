IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0519]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0519]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Truy vấn lương năng suất (NEWTOYO)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT-HRM \ Danh mục \ Thông tin chấm công \ Tính lương năng suất
-- <History>
----Created by Bảo Thy on 29/09/2017
----Modified by Bảo Thy on 10/01/2018: nếu giá trị <0 thì hiển thị 0
---- Modified by on 

/*-- <Example>
	HP0519 @DivisionID='NTY', @UserID = 'ASOFTADMIN', @TranMonth=7, @TranYear=2017, @FromDepartmentID='PB1', @ToDepartmentID='Z1'
----*/
CREATE PROCEDURE [dbo].[HP0519]
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@FromDepartmentID VARCHAR(50), 
	@ToDepartmentID VARCHAR(50)
)
AS

SELECT T1.APK, T1.DivisionID, T1.TranMonth, T1.TranYear, T1.DepartmentID, T3.DepartmentName, T1.TeamID, T4.TeamName, HT1403.DutyID, T5.DutyName, 
T1.EmployeeID, LTRIM(RTRIM(ISNULL(T2.LastName,'')))+ ' ' + LTRIM(RTRIM(ISNULL(T2.MiddleName,''))) + ' ' + LTRIM(RTRIM(ISNULL(T2.FirstName,''))) AS EmployeeName,
T1.BaseSalary, CASE WHEN T1.ExcessQuantity <=0 THEN 0 ELSE T1.ExcessQuantity END ExcessQuantity, 
CASE WHEN T1.OTQuantity <= 0 THEN 0 ELSE T1.OTQuantity END OTQuantity, CASE WHEN HT1116.RepayTotalAmount <= 0 THEN 0 ELSE HT1116.RepayTotalAmount END RepayTotalAmount,
CASE WHEN ISNULL(T1.ExcessAmount,0) + ISNULL(T1.OTAmount,0) + 
(ISNULL(HT3400.Income11,0)+ISNULL(HT3400.Income13,0)+ISNULL(HT3400.Income15,0)+ISNULL(HT3400.Income17,0) +ISNULL(HT3400.Income19,0)+ISNULL(HT3400.Income21,0)) <=0
THEN 0 ELSE ISNULL(T1.ExcessAmount,0) + ISNULL(T1.OTAmount,0) + 
(ISNULL(HT3400.Income11,0)+ISNULL(HT3400.Income13,0)+ISNULL(HT3400.Income15,0)+ISNULL(HT3400.Income17,0) +ISNULL(HT3400.Income19,0)+ISNULL(HT3400.Income21,0)) END AS CapacitySalary, 
T1.CreateUserID +' - '+ (SELECT TOP 1 UserName FROM AT1405 WITH (NOLOCK) WHERE UserID = T1.CreateUserID) CreateUserID, T1.CreateDate
FROM HT1118 T1 WITH (NOLOCK)
LEFT JOIN HT3400 WITH (NOLOCK) ON T1.DivisionID = HT3400.DivisionID AND T1.EmployeeID = HT3400.EmployeeID AND T1.TranMonth = HT3400.TranMonth AND T1.TranYear = HT3400.TranYear
LEFT JOIN HT1116 WITH (NOLOCK) ON T1.DivisionID = HT1116.DivisionID AND T1.EmployeeID = HT1116.EmployeeID AND T1.TranMonth = HT1116.TranMonth AND T1.TranYear = HT1116.TranYear
LEFT JOIN HT1400 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
LEFT JOIN HT1403 WITH (NOLOCK) ON T1.DivisionID = HT1403.DivisionID AND T1.EmployeeID = HT1403.EmployeeID
LEFT JOIN AT1102 T3 WITH (NOLOCK) ON T1.DepartmentID = T3.DepartmentID
LEFT JOIN HT1101 T4 WITH (NOLOCK) ON T1.DivisionID = T4.DivisionID AND T1.TeamID = T4.TeamID AND T1.DepartmentID = T4.DepartmentID
LEFT JOIN HT1102 T5 WITH (NOLOCK) ON HT1403.DivisionID = T5.DivisionID AND HT1403.DutyID = T5.DutyID
WHERE T1.DivisionID = @DivisionID
AND T1.TranMonth = @TranMonth AND T1.TranYear = @TranYear
AND T1.DepartmentID BETWEEN @FromDepartmentID AND @ToDepartmentID
ORDER BY T1.DepartmentID, T1.EmployeeID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
