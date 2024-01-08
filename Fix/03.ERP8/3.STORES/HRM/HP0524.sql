IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0524]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0524]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
	


 -- <Summary>
---- Bảng tính lương sản lượng vượt và ngoài giờ trong kỳ (NEWTOYO)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi, Date: 18/10/2017
-- <Example>
/*	[HP0524] @DivisionID='CH', @TranMonth=1, @TranYear=2017, @FromDepartment = 'PB001', @ToDepartment = 'PB001', @TeamID = '',  
	@FromEmployeeID='0000000002', @ToEmployeeID = '0000000002', @UserID = ''
*/

--	EXEC HP0524 @DivisionID, @TranMonth, @TranYear, @FromDepartment, @ToDepartment, @TeamID, @FromEmployeeID, @ToEmployeeID, @UserID
---- 

CREATE PROCEDURE [dbo].[HP0524] 
    @DivisionID NVARCHAR(50), 
	@TranMonth INT,
	@TranYear INT,
	@FromDepartment NVARCHAR(50),
	@ToDepartment NVARCHAR(50),
	@TeamID NVARCHAR (50),
	@FromEmployeeID VARCHAR(50), 
	@ToEmployeeID VARCHAR(50), 
	@UserID VARCHAR(50)
	
AS

DECLARE @sSQL NVARCHAR(MAX) = N'',
		@Period INT = 0 


SET @Period = @TranMonth + @TranYear * 100

SET @sSQL = N'
SELECT HT1119.DivisionID, HT1109.QuantityPerMonth, HT1119.EmployeeID, HT1119.MachineID, HT1119.TranMonth, HT1119.TranYear, HT1119.Quantity1, HT1119.Quantity2, HT1119.Quantity3, 
HT1119.Quantity4, HT1119.Quantity5, HT1119.Quantity6, HT1119.Quantity7, HT1119.Quantity8, HT1119.Quantity9, HT1119.Quantity10, HT1119.Quantity11, 
HT1119.Quantity12, HT1119.Quantity13, HT1119.Quantity14, HT1119.Quantity15, HT1119.Quantity16, HT1119.Quantity17, HT1119.Quantity18, HT1119.Quantity19, 
HT1119.Quantity20, HT1119.Quantity21, HT1119.Quantity22, HT1119.Quantity23, HT1119.Quantity24, HT1119.Quantity25, HT1119.Quantity26, HT1119.Quantity27, 
HT1119.Quantity28, HT1119.Quantity29, HT1119.Quantity30, HT1119.Quantity31, HT1119.[Type], HT1119.DepartmentID, HT2400.BaseSalary, HT1109.MachineName, 
(CASE 
WHEN ISNULL(HT1400.MiddleName,'''') = '''' THEN LTRIM(RTRIM(ISNULL(HT1400.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT1400.FirstName,''''))) 
WHEN ISNULL(HT1400.MiddleName,'''') <> '''' THEN LTRIM(RTRIM(ISNULL(HT1400.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT1400.MiddleName,''''))) + '' '' +  LTRIM(RTRIM(ISNULL(HT1400.FirstName,''''))) 
END) AS EmployeeName
FROM HT1119 WITH (NOLOCK)
INNER JOIN HT2400 WITH (NOLOCK) ON HT1119.DivisionID = HT2400.DivisionID AND HT1119.EmployeeID = HT2400.EmployeeID AND HT1119.TranMonth = HT2400.TranMonth AND  HT1119.TranYear = HT2400.TranYear
INNER JOIN HT1109 WITH (NOLOCK) ON HT1119.DivisionID = HT1109.DivisionID AND HT1119.MachineID = HT1109.MachineID
INNER JOIN HT1400 WITH (NOLOCK) ON HT1119.DivisionID = HT1400.DivisionID AND HT1119.EmployeeID = HT1400.EmployeeID
WHERE HT1119.DivisionID = '''+@DivisionID+''' AND (HT1119.TranMonth + HT1119.TranYear * 100) =  '+STR(@Period)+' 
AND HT1119.DepartmentID BETWEEN '''+@FromDepartment+''' AND '''+@ToDepartment+'''
AND HT1119.EmployeeID  BETWEEN '''+@FromEmployeeID+''' AND '''+@ToEmployeeID+'''
AND ISNULL(HT1119.TeamID,'''') LIKE ISNULL('''+@TeamID+''',''%'')'

--PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

