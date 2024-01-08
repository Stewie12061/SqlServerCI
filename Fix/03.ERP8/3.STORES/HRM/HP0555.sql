IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0555]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0555]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Thực hiện Hủy tính lương sản phẩm theo công đoạn cho nhân viên - HF0547 Plugin (MAITHU)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Lê Hoàng, Date: 22/05/2021
----Modified by ... on ...
/*-- <Example>
	HP0555 @DivisionID = 'VF', @StrDivisionID = '', @UserID = 'ASOFTADMIN', @TranMonth = 12, @TranYear = 2017, @DepartmentID = '', @TeamID = '', @EmployeeID = '', 
	@FromProductID = '', @ToProductID = ''

	HP0555 @DivisionID, @UserID, @StrDivisionID, @TranMonth, @TranYear, @DepartmentID, @TeamID, @EmployeeID, @FromProductID, @ToProductID
----*/

CREATE PROCEDURE HP0555
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

---Bỏ tính lương sản phẩm
DELETE HT1906 WHERE DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear AND
DepartmentID BETWEEN @FromDepartmentID AND @ToDepartmentID 

---Cập nhật lại giá trị hệ số lương
UPDATE H14 SET H14.C04 = 0
FROM HT1403 H14 
LEFT JOIN HT1906 H96 WITH(NOLOCK) ON H14.DivisionID IN (H96.DivisionID,'@@@') AND H14.EmployeeID = H96.EmployeeID
WHERE H96.DivisionID = @DivisionID AND H96.TranMonth = @TranMonth AND H96.TranYear = @TranYear AND 
H96.DepartmentID BETWEEN @FromDepartmentID AND @ToDepartmentID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
