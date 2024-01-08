IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0554]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0554]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Thực hiện Tính lương sản phẩm theo công đoạn cho nhân viên - HF0546 Plugin (MAITHU)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Lê Hoàng, Date: 22/05/2021
----Modified by Lê Hoàng on 22/10/2021 : Cập nhật Lương sản phẩm sai bảng, HT2400 mới đúng; và bổ sung điều kiện kỳ
/*-- <Example>
	HP0554 @DivisionID = 'VF', @StrDivisionID = '', @UserID = 'ASOFTADMIN', @TranMonth = 12, @TranYear = 2017, @DepartmentID = '', @TeamID = '', @EmployeeID = '', 
	@FromProductID = '', @ToProductID = ''

	HP0554 @DivisionID, @UserID, @StrDivisionID, @TranMonth, @TranYear, @DepartmentID, @TeamID, @EmployeeID, @FromProductID, @ToProductID
----*/

CREATE PROCEDURE HP0554
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50), 
	@FromDepartmentID VARCHAR(50),
	@ToDepartmentID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT, 
	@Date DATETIME
)

AS 
DECLARE @sSQL NVARCHAR(MAX) = N'', 
		@sWhere NVARCHAR(MAX) = N''

--DROP TABLE #DataHT1904MT
SELECT H94.APK, H94.DivisionID, H94.ProductID, H94.PriceSheetID, H94.ProducingProcessID, H94.PhaseID, H94.UnitID, 
H94.TranMonth, H94.TranYear, H94.PeriodID, H94.DepartmentID, H94.TeamID, H94.ProduceDate, 
H94.ProduceQuantity, H94.Values01, H94.Quantity01, H94.UnitPrice01, H94.Values02, H94.Quantity02, H94.UnitPrice02, 
H94.Values03, H94.Quantity03, H94.UnitPrice03, H94.Values04, H94.Quantity04, H94.UnitPrice04, H94.Values05, 
H94.Quantity05, H94.UnitPrice05, H94.Properties01, H94.Properties02, H94.Properties03, H94.Quantity, H94.UnitPrice, 
H94.Amount, H94.MoldID, H94.MoldAmount, H94.Total, H94.Notes, H94.TimekeepingDate, H94.RefAPKMaster, H94.RefAPKDetail,
H94.CreateDate, H94.CreateUserID, H94.LastModifyDate, H94.LastModifyUserID,  
f.Value EmployeeID
INTO #DataHT1904MT
FROM HT1904_MT AS H94 WITH(NOLOCK)
CROSS APPLY dbo.StringSplit(H94.Employee, ',') as f
WHERE H94.DivisionID = @DivisionID AND H94.TranMonth = @TranMonth AND H94.TranYear = @TranYear

INSERT INTO HT1906 ([APK],[DivisionID],[EmployeeID],[DepartmentID],[DutyID],
[TranMonth],[TranYear],[CalculateDate],[PhaseID],[ProductID],[Coefficient],
[Amount],[ProductSalary],[RefAPK],[CreateUserID],[CreateDate],[LastModifyUserID],[LastModifyDate])
SELECT NEWID(), H94.DivisionID, H94.EmployeeID, H14.DepartmentID, H143.DutyID, 
H94.TranMonth, H94.TranYear, @Date, H94.PhaseID, H94.ProductID, 
CASE WHEN H54.Coefficient IS NULL THEN H55.Coefficient ELSE H54.Coefficient END AS Coefficient, 
H94.Total Amount, 
(CASE WHEN H54.Coefficient IS NULL THEN H55.Coefficient ELSE H54.Coefficient END) * H94.Total AS ProductSalary,
H94.APK, @UserID, GETDATE(), @UserID, GETDATE() 
FROM #DataHT1904MT H94 WITH(NOLOCK)
LEFT JOIN HT0541 H54 WITH(NOLOCK) ON H54.DivisionID IN (H94.DivisionID,'@@@') AND H54.EmployeeID = H94.EmployeeID 
AND H54.PhaseID = H94.PhaseID AND H54.InventoryID = H94.ProductID AND H54.IsUsed = 1
LEFT JOIN HT0541 H55 WITH(NOLOCK) ON H55.DivisionID IN (H94.DivisionID,'@@@') AND H55.EmployeeID = H94.EmployeeID 
AND H55.PhaseID = H94.PhaseID AND ISNULL(H55.InventoryID,'') = '' AND H55.IsUsed = 1
LEFT JOIN HT1400 H14 WITH(NOLOCK) ON H14.DivisionID IN (H94.DivisionID,'@@@') AND H14.EmployeeID = H94.EmployeeID
LEFT JOIN HT1403 H143 WITH(NOLOCK) ON H143.DivisionID IN (H94.DivisionID,'@@@') AND H143.EmployeeID = H94.EmployeeID
WHERE H94.DivisionID = @DivisionID AND H94.TranMonth = @TranMonth AND H94.TranYear = @TranYear
AND H14.DepartmentID BETWEEN @FromDepartmentID AND @ToDepartmentID

SELECT DivisionID, EmployeeID, SUM(ProductSalary) ProductSalary INTO #TotalProductSalary FROM HT1906 H96
WHERE H96.DivisionID = @DivisionID AND H96.TranMonth = @TranMonth AND H96.TranYear = @TranYear
AND H96.DepartmentID BETWEEN @FromDepartmentID AND @ToDepartmentID
GROUP BY DivisionID, EmployeeID

---Cập nhật hệ số tính lương sản phẩm
UPDATE H14 SET H14.C04 = H96.ProductSalary
FROM HT2400 H14 
LEFT JOIN #TotalProductSalary H96 WITH(NOLOCK) ON H14.DivisionID IN (H96.DivisionID,'@@@') AND H14.EmployeeID = H96.EmployeeID 
WHERE H96.DivisionID = @DivisionID AND H14.TranMonth = @TranMonth AND H14.TranYear = @TranYear

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
