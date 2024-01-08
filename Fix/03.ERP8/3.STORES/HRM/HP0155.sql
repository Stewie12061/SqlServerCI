IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0155]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0155]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 29/03/2016
--- Modify on 26/05/2016 by Bảo Anh: Lấy TK ngân hàng từ thông tin đơn vị
----Modified by Tiểu Mai on 18/05/2017: Bổ sung WITH (NOLOCK) và chỉnh sửa danh mục dùng chung
----Modified by Bảo Thy on 27/04/2018: Fix lỗi Ambiguous column 
/*-- <Example>
	HP0155 @DivisionID='MK', @FromMonth=2, @FromYear=2016, @ToMonth=2, @ToYear=2016, @DepartmentID='A000000', @ToDepartmentID='S000000', 
	@TeamID=NULL,@IsDetail=1
----*/

CREATE PROCEDURE HP0155
(
  @DivisionID VARCHAR(50),
  @FromMonth INT,
  @FromYear INT,
  @ToMonth INT,
  @ToYear INT,
  @DepartmentID VARCHAR(50),
  @ToDepartmentID VARCHAR(50),
  @TeamID VARCHAR(50),
  @IsDetail TINYINT --0: chi tiết, 1: tổng hợp
) 
AS 
IF @IsDetail = 0
BEGIN
		SELECT DISTINCT BankAccountID, HT2461.EmployeeID, HV1400.FullName,HV1400.TitleName, HV1400.DepartmentName, HV1400.TeamName AS SectionName, 
		A11.AnaName SubsectionName, A12.AnaName ProcessName, HT2461.BaseSalary, HT2461.SAmount, HT2461.SAmount2, HT2461.HAmount, HT2461.HAmount2, HT2461.TAmount, HT2461.TAmount2,
		ISNULL(HT2461.SAmount+HT2461.HAmount+HT2461.TAmount,0) C_Total, ISNULL(HT2461.SAmount2+HT2461.HAmount2+HT2461.TAmount2,0) Emp_Total,
		ISNULL(HT2461.SAmount+HT2461.HAmount+HT2461.TAmount+HT2461.SAmount2+HT2461.HAmount2+HT2461.TAmount2,0) Total
		FROM HT2461 WITH (NOLOCK)
		LEFT JOIN HV1400 ON HT2461.DivisionID = HV1400.DivisionID AND HT2461.EmployeeID=HV1400.EmployeeID  
		LEFT JOIN HT1403 WITH (NOLOCK) ON HV1400.DivisionID = HT1403.DivisionID AND HV1400.EmployeeID = HT1403.EmployeeID
		--LEFT JOIN HT1106 WITH (NOLOCK) ON HT1403.DivisionID = HT1106.DivisionID AND HT1403.TitleID = HT1106.TitleID
		LEFT JOIN AT1011 A11 WITH (NOLOCK) ON A11.AnaID=Ana04ID AND A11.AnaTypeID='A04'
		LEFT JOIN AT1011 A12 WITH (NOLOCK) ON A12.AnaID=Ana05ID AND A12.AnaTypeID='A05'
		LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = HT2461.DivisionID
		WHERE HT2461.TranMonth BETWEEN @FromMonth AND @ToMonth
		AND HT2461.TranYear BETWEEN @FromYear AND @ToYear
		AND ISNULL(HT2461.DepartmentID,'') BETWEEN @DepartmentID AND @ToDepartmentID
		AND ISNULL(HT2461.TeamID,'') LIKE ISNULL(@TeamID,'%')
	
END
ELSE 
IF @IsDetail = 1
BEGIN
		SELECT DISTINCT  HT2461.EmployeeID, HV1400.FullName, HV1400.IdentifyCardNo, HV1400.IdentifyDate, HV1400.TitleName, HV1400.PermanentAddress,
		HV1400.HospitalID, HV1400.HospitalName, HT2460.Notes, (CASE IsMale WHEN 0 THEN 0 ELSE NULL END) IsMale
		FROM HT2461 WITH (NOLOCK) 
		Left JOIN HT2460 WITH (NOLOCK) ON HT2461.DivisionID = HT2460.DivisionID AND HT2461.EmployeeID=HT2460.EmployeeID  
		LEFT JOIN HV1400 ON HT2460.DivisionID = HV1400.DivisionID AND HT2460.EmployeeID=HV1400.EmployeeID  
		LEFT JOIN HT1403 WITH (NOLOCK) ON HV1400.DivisionID = HT1403.DivisionID AND HV1400.EmployeeID = HT1403.EmployeeID
		--LEFT JOIN HT1106 WITH (NOLOCK) ON HT1403.DivisionID = HT1106.DivisionID AND HT1403.TitleID = HT1106.TitleID
		WHERE HT2461.TranMonth BETWEEN @FromMonth AND @ToMonth
		AND HT2461.TranYear BETWEEN @FromYear AND @ToYear
		AND ISNULL(HT2460.DepartmentID,'') BETWEEN @DepartmentID AND @ToDepartmentID
		AND ISNULL(HT2460.TeamID,'') LIKE ISNULL(@TeamID,'%')
END
	
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
