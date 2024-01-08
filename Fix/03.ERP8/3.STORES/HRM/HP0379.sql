IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0379]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0379]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load thông tin giấy chứng nhận nghỉ chế độ thai sản
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 29/03/2016
/*-- <Example>
	HP0379 @DivisionID='MK', @UserID='ASOFTADMIN',  @EmployeeID='000199',@DepartmentID='A000000', @FromDate= '2016-02-05 17:40:41.007',@Todate= '2016-04-01 17:40:41.007'
----*/

CREATE PROCEDURE HP0379
(
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @EmployeeID VARCHAR(50),
  @DepartmentID VARCHAR(50),
  @FromDate DATETIME,
  @Todate DATETIME
) 
AS 
SELECT HT1414.EmployeeID, FullName, CompanyName, HV1400.Birthday,HT1414.BeginDate, HT1414.EndDate, DATEDIFF(d,BeginDate,EndDate) RealDayOff, SoInsuranceNo
FROM HT1414
LEFT JOIN HV1400 ON HT1414.DivisionID = HV1400.DivisionID AND HT1414.EmployeeID = HV1400.EmployeeID
LEFT JOIN AT0001 ON HT1414.DivisionID = AT0001.DivisionID
WHERE HT1414.EmployeeID = @EmployeeID
AND DepartmentID LIKE ISNULL(@DepartmentID,'%')
AND EmployeeMode='MT'
AND (BeginDate BETWEEN @FromDate AND @ToDate
OR EndDate BETWEEN @FromDate AND @ToDate)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

