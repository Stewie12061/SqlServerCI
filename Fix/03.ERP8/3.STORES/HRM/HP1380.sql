IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP1380]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP1380]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Create VIEW HV1380 để in quyết định thôi việc
-- <History>
----Create on 23/10/2013 by Thanh Sơn
--- Modified by Phương Thảo on 31/05/2016: Bổ sung thêm thông tin Tổ nhóm, khâu, công đoạn (Customize Meiko)
--- Modified by Bảo Thy on 17/08/2016: Bổ sung 20 tham số
--- Modified by Tiểu Mai on 08/12/2016: Bổ sung BaseSalary, InsuranceSalary
---- Modified by Phương Thảo on 18/05/2017: Sửa danh mục dùng chung
---- Modified by Bảo Anh on 15/01/2019: Bổ sung trường Ngày ký hợp đồng, Ngày kết thúc hợp đồng
---- Modified by Văn Minh on 27/02/2020: Bỏ UPPER NAME
-- <Example>
---- 
/* EXEC HP1380 'MK',6,2016
	Select * from HV1380
*/

CREATE PROCEDURE HP1380
( 
	@DivisionID AS NVARCHAR(50),
	@TranMonth INT,
	@TranYear INT
) 
AS 
DECLARE @sSQL1 NVARCHAR (MAX), @sSQL2 NVARCHAR (MAX), @sSQL3 NVARCHAR (MAX)

DECLARE @CustomerName int
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

SET @sSQL1 = N'
WITH HT1380_KQ
AS
(
SELECT HT1380.DecidingNo, HT1380.DecidingDate, HT1380.DecidingPerson,
(SELECT Fullname FROM HV1400 WHERE HV1400.EmployeeID = HT1380.DecidingPerson And HV1400.DivisionID = HT1380.DivisionID ) AS DecidingPersonName, 
HT1380.DecidingPersonDuty, HT1380.Proposer,
(SELECT Fullname FROM HV1400 WHERE HV1400.EmployeeID = HT1380.Proposer And HV1400.DivisionID = HT1380.DivisionID) AS ProposerName, 
HT1380.ProposerDuty, HT1380.EmployeeID, HV1400.FullName, HV1400.IsMaleID, HT1380.DutyName,
HT03.DepartmentID,A02.DepartmentName,
HT1380.WorkDate, HT1380.LeaveDate, HT1380.QuitJobID, HT1107.QuitJobName, HT1380.Allowance, HT1380.Notes,
HT1380.DivisionID,
HV1400.Birthday, HV1400.IdentifyCardNo, HV1400.IdentifyDate , HV1400.IdentifyPlace, 
(ISNULL(ISNULL(HT13.SalaryAmounts,HT03.BaseSalary),0)+
ISNULL(ISNULL(HT14.SalaryAmounts,HT03.BaseSalary),0)+
ISNULL(ISNULL(HT15.SalaryAmounts,HT03.BaseSalary),0)+
ISNULL(ISNULL(HT16.SalaryAmounts,HT03.BaseSalary),0)+
ISNULL(ISNULL(HT17.SalaryAmounts,HT03.BaseSalary),0)+
ISNULL(ISNULL(HT18.SalaryAmounts,HT03.BaseSalary),0))/6 AS BaseSalaryAverage,HT03.SalaryCoefficient,
(CASE WHEN DATEDIFF(MONTH, HT03.WorkDate, ''2008-12-31'') - (12 * (DATEDIFF(YEAR, HT03.WorkDate, ''2008-12-31'')))+ 1 >= 6 
     THEN DATEDIFF(YEAR, HT03.WorkDate, ''2008-12-31'') + 1 
     ELSE DATEDIFF(YEAR, HT03.WorkDate, ''2008-12-31'') END) AS YearsNo,
LTRIM(STR(MONTH(HT1380.WorkDate))) + ''/''+LTRIM(STR(YEAR(HT1380.WorkDate))) AS FromMonth,HT1380.Subsidies,
(SELECT TOP 1 ContractNo FROM HT1360 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND EmployeeID =  HT1380.EmployeeID ORDER BY SignDate DESC) ContractNo,
(SELECT TOP 1 SignDate FROM HT1360 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND EmployeeID =  HT1380.EmployeeID ORDER BY SignDate DESC) SignDate,
(SELECT TOP 1 WorkDate FROM HT1360 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND EmployeeID =  HT1380.EmployeeID ORDER BY SignDate DESC) ConWorkDate,
(SELECT TOP 1 WorkEndDate FROM HT1360 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND EmployeeID =  HT1380.EmployeeID ORDER BY SignDate DESC) ConWorkEndDate,
HV1400.PermanentAddress, Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, Parameter06, Parameter07, Parameter08, Parameter09, Parameter10, 
Parameter11, Parameter12, Parameter13, Parameter14, Parameter15, Parameter16, Parameter17, Parameter18, Parameter19, Parameter20,
Isnull(HT03.BaseSalary,0) as BaseSalary, Isnull(HT03.InsuranceSalary,0) as InsuranceSalary
'+ CASE WHEN @CustomerName = 57 THEN ', HV1400.Notes AS AreaName' ELSE '' END + ' 
'+ CASE WHEN @CustomerName = 50 THEN '
, REPLACE(HV1400.DepartmentID,''0'','''') AS DepartmentID1, REPLACE(HV1400.TEAMID,''0'','''') AS TEAMID1, HV1400.Ana04ID AS SectionID, HV1400.Ana05ID AS ProcessID, 
HT1101.TeamName, AT1011_A04.AnaName AS SectionName, AT1011_A05.AnaName AS ProcessName
'
ELSE '' END 

SET @sSQL2 = '
FROM HT1380 WITH (NOLOCK)
LEFT JOIN HT1403 HT03 WITH (NOLOCK) ON HT03.DivisionID = HT1380.DivisionID AND HT03.EmployeeID = HT1380.EmployeeID
LEFT JOIN AT1102 A02 WITH (NOLOCK) ON A02.DepartmentID = HT03.DepartmentID
LEFT JOIN HT1302 HT13 WITH (NOLOCK) ON HT13.DivisionID = HT1380.DivisionID AND HT13.EmployeeID = HT1380.EmployeeID 
   AND '''+STR(@TranYear*100+@TranMonth)+''' BETWEEN HT13.FromYear*100+HT13.FromMonth AND HT13.ToYear*100+HT13.ToMonth
LEFT JOIN HT1302 HT14 WITH (NOLOCK) ON HT14.DivisionID = HT1380.DivisionID AND HT14.EmployeeID = HT1380.EmployeeID 
   AND '''+STR(@TranYear*100+@TranMonth - 1)+''' BETWEEN HT14.FromYear*100+HT14.FromMonth AND HT14.ToYear*100+HT14.ToMonth
LEFT JOIN HT1302 HT15 WITH (NOLOCK) ON HT15.DivisionID = HT1380.DivisionID AND HT15.EmployeeID = HT1380.EmployeeID 
   AND '''+STR(@TranYear*100+@TranMonth - 2)+''' BETWEEN HT15.FromYear*100+HT15.FromMonth AND HT15.ToYear*100+HT15.ToMonth
LEFT JOIN HT1302 HT16 WITH (NOLOCK) ON HT16.DivisionID = HT1380.DivisionID AND HT16.EmployeeID = HT1380.EmployeeID 
   AND '''+STR(@TranYear*100+@TranMonth - 3)+''' BETWEEN HT16.FromYear*100+HT16.FromMonth AND HT16.ToYear*100+HT16.ToMonth
LEFT JOIN HT1302 HT17 WITH (NOLOCK) ON HT17.DivisionID = HT1380.DivisionID AND HT17.EmployeeID = HT1380.EmployeeID 
   AND '''+STR(@TranYear*100+@TranMonth - 4)+''' BETWEEN HT17.FromYear*100+HT17.FromMonth AND HT17.ToYear*100+HT17.ToMonth
LEFT JOIN HT1302 HT18 WITH (NOLOCK) ON HT18.DivisionID = HT1380.DivisionID AND HT18.EmployeeID = HT1380.EmployeeID 
   AND '''+STR(@TranYear*100+@TranMonth - 5)+''' BETWEEN HT18.FromYear*100+HT18.FromMonth AND HT18.ToYear*100+HT18.ToMonth	
INNER JOIN HV1400 ON HT1380.EmployeeID = HV1400.EmployeeID AND HT1380.DivisionID = HV1400.DivisionID	
INNER JOIN HT1107 WITH (NOLOCK) ON HT1380.QuitJobID = HT1107.QuitJobID AND HT1380.DivisionID = HT1107.DivisionID '
+ CASE WHEN @CustomerName = 50 THEN 
'
LEFT JOIN  HT1101 WITH (NOLOCK) on HV1400.TeamID = HT1101.TeamID and HV1400.DivisionID = HT1101.DivisionID
LEFT JOIN AT1011 AT1011_A04 WITH (NOLOCK) on HV1400.Ana04ID = AT1011_A04.AnaID AND AT1011_A04.AnaTypeID = ''A04''
LEFT JOIN AT1011 AT1011_A05 WITH (NOLOCK) on HV1400.Ana05ID = AT1011_A05.AnaID AND AT1011_A05.AnaTypeID = ''A05''
' ELSE '' END + '
)'

SET @sSQL3 = '
SELECT T1.*, CASE WHEN HT1105.Months = 0 THEN NULL ELSE DATEADD(m, HT1105.Months,ISNULL(T1.ConWorkDate, T1.SignDate)) END AS ContractEndDate
FROM HT1380_KQ T1
LEFT JOIN HT1360 WITH (NOLOCK) ON T1.ContractNo = HT1360.ContractNo
LEFT JOIN HT1105 WITH (NOLOCK) ON HT1360.DivisionID = HT1105.DivisionID AND HT1360.ContractTypeID = HT1105.ContractTypeID
'

--print @sSQL1
--print @sSQL2
--print @sSQL3

IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HV1380]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[HV1380]

EXEC('CREATE VIEW HV1380 --Tạo bởi HP1380
AS'+ @sSQL1 + @sSQL2 + @sSQL3)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
