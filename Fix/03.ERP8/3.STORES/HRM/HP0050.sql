IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0050]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0050]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



--- Created by Hải Long on 15/02/2017: Load mã nhân viên ở màn hình cập nhật đề nghị hợp đồng (ANGEL)
/*
exec HP0050 @DivisionID = 'ANG', @FromDate='2017-02-01 00:00:00',@ToDate='2017-02-28 00:00:00'
*/

CREATE PROCEDURE [dbo].[HP0050] 
(
	@DivisionID nvarchar(50),
	@FromDate DATETIME,
	@ToDate DATETIME
)
AS
DECLARE @sSQL NVARCHAR(MAX)
		
SET @sSQL = '		
SELECT HT1400.EmployeeID, Ltrim(RTrim(isnull(HT1400.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT1400.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT1400.FirstName,''''))) AS EmployeeName,
B.ContractID, B.DepartmentID, B.TeamID, B.ContractNo, B.WorkDate, B.WorkEndDate, B.TestFromDate, B.TestEndDate,
B.DutyID, HT1403.Salary03 AS BaseSalaryOld, B.ContractTypeID, HT1400.Notes AS WorkAddress
FROM HT1400
LEFT JOIN HT1403 ON HT1400.DivisionID = HT1403.DivisionID AND HT1400.EmployeeID = HT1403.EmployeeID   
INNER JOIN 
(
	SELECT DivisionID, EmployeeID, MAX(SignDate) AS SignDate 
	FROM HT1360 WITH (NOLOCK)
	GROUP BY DivisionID, EmployeeID
) A ON HT1400.DivisionID = A.DivisionID AND HT1400.EmployeeID = A.EmployeeID
INNER JOIN HT1360 B ON B.DivisionID = A.DivisionID AND B.EmployeeID = A.EmployeeID AND B.SignDate = A.SignDate
WHERE HT1400.DivisionID = ''' + @DivisionID + '''
AND B.WorkEndDate BETWEEN ''' + Convert(nvarchar(10),@FromDate,21) + ''' AND ''' + convert(nvarchar(10), @ToDate,21) + '''
AND HT1400.EmployeeStatus IN (1,2)
AND (SELECT TOP 1 ContractTypeID FROM HT1360 WITH (NOLOCK) WHERE DivisionID = HT1400.DivisionID  AND EmployeeID = HT1400.EmployeeID ORDER BY SignDate DESC) <> ''I''
ORDER BY HT1400.EmployeeID
'                                       
                                        
                                        
PRINT @sSQL
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
