IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0553]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0553]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load dữ liệu bảng lương sản phẩm theo công đoạn của nhân viên - HF0545 Plugin (MAITHU)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Lê Hoàng, Date: 22/05/2021
/*-- <Example>
	HP0553 @DivisionID = 'VF', @StrDivisionID = '', @UserID = 'ASOFTADMIN', @TranMonth = 12, @TranYear = 2017, @DepartmentID = '', @TeamID = '', @EmployeeID = '', 
	@FromProductID = '', @ToProductID = ''

	HP0553 @DivisionID, @UserID, @StrDivisionID, @TranMonth, @TranYear, @DepartmentID, @TeamID, @EmployeeID, @FromProductID, @ToProductID
----*/

CREATE PROCEDURE HP0553
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50), 
	@FromDepartmentID VARCHAR(50),
	@ToDepartmentID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT
)

AS 
DECLARE @sSQL NVARCHAR(MAX) = N'', 
		@sWhere NVARCHAR(MAX) = N''

SELECT H96.EmployeeID, SUM(H96.ProductSalary) AS Total
INTO #HT1906Total
FROM HT1906 H96 WITH(NOLOCK)
WHERE H96.DivisionID = @DivisionID AND H96.TranMonth = @TranMonth AND H96.TranYear = @TranYear AND
H96.DepartmentID BETWEEN @FromDepartmentID AND @ToDepartmentID
GROUP BY H96.EmployeeID

SELECT H96.*, CONCAT(H14.LastName,' ',H14.MiddleName,' ',H14.FirstName) EmployeeName, A26.PhaseName, H15.ProductName, A12.DepartmentName, H12.DutyName, H1.Total 
FROM HT1906 H96 WITH(NOLOCK)
LEFT JOIN HT1015 H15 WITH(NOLOCK) ON H15.DivisionID IN (H96.DivisionID,'@@@') AND H15.ProductID = H96.ProductID
LEFT JOIN AT1102 A12 WITH(NOLOCK) ON A12.DivisionID IN (H96.DivisionID,'@@@') AND A12.DepartmentID = H96.DepartmentID
LEFT JOIN HT1102 H12 WITH(NOLOCK) ON H12.DivisionID IN (H96.DivisionID,'@@@') AND H12.DutyID = H96.DutyID
LEFT JOIN HT1400 H14 WITH(NOLOCK) ON H14.DivisionID IN (H96.DivisionID,'@@@') AND H14.EmployeeID = H96.EmployeeID
LEFT JOIN AT0126 A26 WITH(NOLOCK) ON A26.DivisionID IN (H96.DivisionID,'@@@') AND A26.PhaseID = H96.PhaseID
LEFT JOIN #HT1906Total H1 WITH(NOLOCK) ON H1.EmployeeID = H96.EmployeeID
WHERE H96.DivisionID = @DivisionID AND H96.TranMonth = @TranMonth AND H96.TranYear = @TranYear AND
H96.DepartmentID BETWEEN @FromDepartmentID AND @ToDepartmentID
ORDER BY EmployeeID, EmployeeName, DepartmentName, DutyName, Total, PhaseName, ProductID, Coefficient

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
