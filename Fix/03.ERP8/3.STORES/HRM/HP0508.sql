IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0508]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0508]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load cập nhật phân công nhân viên đứng máy (NEWTOYO)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT-HRM \ Danh mục \ Thông tin chấm công \ Phân công nhân viên đứng máy \ Thêm,Sửa,xem
-- <History>
----Created by Bảo Thy on 18/09/2017
---- Modified by on 

/*-- <Example>
	HP0508 @DivisionID='CH', @TranMonth=1, @TranYear=2017, @APKMaster='EE9790C6-8440-4E70-B7B6-821474D3C481'
----*/

CREATE PROCEDURE [dbo].[HP0508]
(
	@DivisionID AS VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@APKMaster AS VARCHAR(50)
)
AS

SELECT ROW_NUMBER() OVER(PARTITION BY T1.[Date] ORDER BY T1.[Date],T1.EmployeeID DESC) AS OrderNo,
T1.DivisionID, T1.TranMonth, T1.TranYear, T1.MachineID, T2.MachineName, T1.EmployeeID,
T1.EmployeeID +' - '+ LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(T3.LastName,'')))+ ' ' + LTRIM(RTRIM(ISNULL(T3.MiddleName,''))) + ' ' + LTRIM(RTRIM(ISNULL(T3.FirstName,''))),'  ',' '))) AS EmployeeName,
'Date'+CASE WHEN CONVERT(VARCHAR(2),DAY(T1.[Date])) <= 9 THEN '0'+CONVERT(VARCHAR(2),DAY(T1.[Date])) ELSE CONVERT(VARCHAR(2),DAY(T1.[Date])) END AS [Date], 
'Employee'+CASE WHEN CONVERT(VARCHAR(2),DAY(T1.[Date])) <= 9 THEN '0'+CONVERT(VARCHAR(2),DAY(T1.[Date])) ELSE CONVERT(VARCHAR(2),DAY(T1.[Date])) END AS Employee,
T1.CreateUserID, T1.CreateDate
INTO #Temp1
FROM HT1113 T1 WITH (NOLOCK)
LEFT JOIN HT1109 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.MachineID = T2.MachineID
LEFT JOIN HT1400 T3 WITH (NOLOCK) ON T1.DivisionID = T3.DivisionID AND T1.EmployeeID = T3.EmployeeID
WHERE T1.DivisionID = @DivisionID
AND T1.APKMaster = @APKMaster

SELECT [Date]
INTO #Temp2
FROM
(
	SELECT DISTINCT [Date]
	FROM #Temp1
)Temp

SELECT DISTINCT Employee
INTO #Temp3
FROM #Temp1

DECLARE @sSQL1 NVARCHAR(max) = '',
		@sSQL2 NVARCHAR(max) = '',
		@sSQL3 NVARCHAR(max) = '',
		@sSQL4 NVARCHAR(max) = '',
		@sSQL5 NVARCHAR(max) = '',
		@Date NVARCHAR(max) = '',
		@Employee NVARCHAR(max) = ''

SELECT @sSQL1 = @sSQL1 +
	'
	SELECT	*
	INTO #Temp_Date
	FROM	
	(
	SELECT OrderNo, DivisionID, TranMonth, TranYear, EmployeeName, MachineID, MachineName, CreateUserID, CreateDate, [Date] FROM #Temp1
	) P
	PIVOT
	(MAX(EmployeeName) FOR [Date] IN ('
	SELECT	@sSQL2 = @sSQL2 + CASE WHEN @sSQL2 <> '' THEN ',' ELSE '' END + '['+''+[Date]+''+']'
	FROM	#Temp2
	SET @Date = @sSQL2
	SELECT	@sSQL2 = @sSQL2 +') ) AS BT'


SELECT @sSQL3 = @sSQL3 +
	'
	SELECT	*
	INTO #Temp_Employee
	FROM	
	(
	SELECT OrderNo, DivisionID, TranMonth, TranYear, EmployeeID, MachineID, Employee FROM #Temp1
	) P
	PIVOT
	(MAX(EmployeeID) FOR Employee IN ('
	SELECT	@sSQL4 = @sSQL4 + CASE WHEN @sSQL4 <> '' THEN ',' ELSE '' END + '['+''+Employee+''+']'
	FROM	#Temp3
	SET @Employee = @sSQL4
	SELECT	@sSQL4 = @sSQL4 +') ) AS BT'

SET @sSQL5 = '
SELECT T1.*
'+CASE WHEN ISNULL(@Employee,'')<>'' THEN ','+@Employee ELSE '' END +'
FROM #Temp_Date T1
INNER JOIN #Temp_Employee T2 ON T1.OrderNo = T2.OrderNo
ORDER BY T1.OrderNo
'

--print @sSQL1
--print @sSQL2
--print @sSQL3
--print @sSQL4
--print @sSQL5

IF ISNULL(@Date,'')<>''
EXEC (@sSQL1+@sSQL2+@sSQL3+@sSQL4+@sSQL5)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
