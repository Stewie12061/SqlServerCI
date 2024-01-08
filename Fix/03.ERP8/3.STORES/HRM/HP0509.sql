IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0509]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0509]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load danh sách thời gian đứng máy thực tế (NEWTOYO)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT-HRM \ Danh mục \ Thông tin chấm công \ Thời gian đứng máy thực tế
-- <History>
----Created by Bảo Thy on 15/09/2017
---- Modified by on 

/*-- <Example>
	HP0509 @DivisionID='CH', @TranMonth=6, @TranYear=2017, @DepartmentID='%', @TeamID='%', @EmployeeID='%', @EmployeeList = NULL
----*/

CREATE PROCEDURE [dbo].[HP0509]
(
	@DivisionID AS VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@DepartmentID AS VARCHAR(50),
	@TeamID AS VARCHAR(50),
	@EmployeeID AS VARCHAR(50),
	@EmployeeList XML
)
AS
DECLARE @sSQL NVARCHAR(max) = '',
		@sSQL1 NVARCHAR(max) = '',
		@sSQL2 NVARCHAR(max) = '',
		@sSQL3 NVARCHAR(max) = '',
		@sSQL4 NVARCHAR(max) = '',
		@sSQL5 NVARCHAR(max) = '',
		@sSQL6 NVARCHAR(max) = '',
		@sSQL7 NVARCHAR(max) = '',
		@sSQL8 NVARCHAR(max) = '',
		@sSQL9 NVARCHAR(max) = '',
		@FromTime NVARCHAR(max) = '',
		@ToTime NVARCHAR(max) = '',
		@ActFromTime NVARCHAR(max) = '',
		@ActToTime NVARCHAR(max) = ''

IF @EmployeeList IS NOT NULL
BEGIN
	CREATE TABLE #HP0509_Employee (EmployeeID VARCHAR(50))
	
	INSERT INTO #HP0509_Employee
	SELECT X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID
	FROM @EmployeeList.nodes('//Data') AS X (Data)
END

CREATE TABLE #Temp1 (APKMaster VARCHAR(50), TranMonth INT, TranYear INT, EmployeeID VARCHAR(50), MachineID VARCHAR(50), FromTime DATETIME, ToTime DATETIME,
ActFromTime DATETIME, ActToTime DATETIME, EmployeeName NVARCHAR(250), FromTimeCol VARCHAR(50), ToTimeCol VARCHAR(50), ActFromTimeCol VARCHAR(50),
ActToTimeCol VARCHAR(50), DepartmentID VARCHAR(50), TeamID VARCHAR(50))--, [Date] DATETIME)

SET @sSQL = N'
SELECT T1.APKMaster, T1.TranMonth, T1.TranYear, T1.EmployeeID, T1.MachineID, CONVERT(DATETIME,T3.FromTime,120) AS FromTime, 
CONVERT(DATETIME,T3.ToTime,120) AS ToTime,
CONVERT(DATETIME,ISNULL(T1.ActFromTime,T3.FromTime),120) AS ActFromTime,
CONVERT(DATETIME,ISNULL(T1.ActToTime,T3.ToTime),120) AS ActToTime,
LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(T4.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(T4.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(T4.FirstName,''''))),''  '','' ''))) EmployeeName,
''FromTime''+CASE WHEN CONVERT(VARCHAR(2),DAY(T1.[Date])) <= 9 THEN ''0''+CONVERT(VARCHAR(2),DAY(T1.[Date])) ELSE CONVERT(VARCHAR(2),DAY(T1.[Date])) END AS FromTimeCol,
''ToTime''+CASE WHEN CONVERT(VARCHAR(2),DAY(T1.[Date])) <= 9 THEN ''0''+CONVERT(VARCHAR(2),DAY(T1.[Date])) ELSE CONVERT(VARCHAR(2),DAY(T1.[Date])) END AS ToTimeCol,
''ActFromTime''+CASE WHEN CONVERT(VARCHAR(2),DAY(T1.[Date])) <= 9 THEN ''0''+CONVERT(VARCHAR(2),DAY(T1.[Date])) ELSE CONVERT(VARCHAR(2),DAY(T1.[Date])) END AS ActFromTimeCol,
''ActToTime''+CASE WHEN CONVERT(VARCHAR(2),DAY(T1.[Date])) <= 9 THEN ''0''+CONVERT(VARCHAR(2),DAY(T1.[Date])) ELSE CONVERT(VARCHAR(2),DAY(T1.[Date])) END AS ActToTimeCol,
T4.DepartmentID, T4.TeamID--, T1.[Date]
FROM HT1113 T1 WITH (NOLOCK)
LEFT JOIN HT1110 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.MachineID = T2.MachineID AND T1.TranMonth+T1.TranYear*100 = T2.TranMonth+T2.TranYear*100
LEFT JOIN HT1111 T3 WITH (NOLOCK) ON T3.DivisionID = T2.DivisionID AND T2.APK = T3.APKMaster AND T1.[Date] = T3.[Date]
LEFT JOIN HT1400 T4 WITH (NOLOCK) ON T1.DivisionID = T4.DivisionID AND T1.EmployeeID = T4.EmployeeID
'+CASE WHEN @EmployeeList IS NOT NULL THEN 'INNER JOIN #HP0509_Employee T5 ON T1.EmployeeID = T5.EmployeeID' ELSE '' END+'
WHERE T1.DivisionID = '''+@DivisionID+'''
AND T1.TranMonth+T1.TranYear*100 = '+STR(@TranMonth+@TranYear*100)+'
'+CASE WHEN @EmployeeID IS NOT NULL THEN 'AND T1.EmployeeID LIKE '''+ISNULL(@EmployeeID,'%')+'''' ELSE '' END+'
'
PRINT(@sSQL)
INSERT INTO #Temp1
EXEC sp_executesql @sSQL

SELECT DISTINCT FromTimeCol, ToTimeCol, ActFromTimeCol, ActToTimeCol
INTO #Temp2
FROM #Temp1

SELECT @sSQL1 = @sSQL1 +
	'
	SELECT	*
	INTO #Temp_FromTime
	FROM	
	(
	SELECT APKMaster, TranMonth, TranYear, EmployeeID, EmployeeName, MachineID, DepartmentID, TeamID, FromTime, FromTimeCol FROM #Temp1
	) P
	PIVOT
	(MAX(FromTime) FOR FromTimeCol IN ('
	SELECT	@sSQL2 = @sSQL2 + CASE WHEN @sSQL2 <> '' THEN ',' ELSE '' END + '['+''+FromTimeCol+''+']'
	FROM	#Temp2
	SET @FromTime = @sSQL2
	SELECT	@sSQL2 = @sSQL2 +') ) AS BT'

SELECT @sSQL3 = @sSQL3 +
	'
	SELECT	*
	INTO #Temp_ToTime
	FROM	
	(
	SELECT APKMaster, TranMonth, TranYear, EmployeeID, EmployeeName, MachineID, DepartmentID, TeamID,  ToTime, ToTimeCol FROM #Temp1
	) P
	PIVOT
	(MAX(ToTime) FOR ToTimeCol IN ('
	SELECT	@sSQL4 = @sSQL4 + CASE WHEN @sSQL4 <> '' THEN ',' ELSE '' END + '['+''+ToTimeCol+''+']'
	FROM	#Temp2
	SET @ToTime = @sSQL4
	SELECT	@sSQL4 = @sSQL4 +') ) AS BT'

SELECT @sSQL5 = @sSQL5 +
	'
	SELECT	*
	INTO #Temp_ActFromTime
	FROM	
	(
	SELECT APKMaster, TranMonth, TranYear, EmployeeID, EmployeeName, MachineID, DepartmentID, TeamID,  ActFromTime, ActFromTimeCol FROM #Temp1
	) P
	PIVOT
	(MAX(ActFromTime) FOR ActFromTimeCol IN ('
	SELECT	@sSQL6 = @sSQL6 + CASE WHEN @sSQL6 <> '' THEN ',' ELSE '' END + '['+''+ActFromTimeCol+''+']'
	FROM	#Temp2
	SET @ActFromTime = @sSQL6
	SELECT	@sSQL6 = @sSQL6 +') ) AS BT'

SELECT @sSQL7 = @sSQL7 +
	'
	SELECT	*
	INTO #Temp_ActToTime
	FROM	
	(
	SELECT APKMaster, TranMonth, TranYear, EmployeeID, EmployeeName, MachineID, DepartmentID, TeamID, ActToTime, ActToTimeCol FROM #Temp1
	) P
	PIVOT
	(MAX(ActToTime) FOR ActToTimeCol IN ('
	SELECT	@sSQL8 = @sSQL8 + CASE WHEN @sSQL8 <> '' THEN ',' ELSE '' END + '['+''+ActToTimeCol+''+']'
	FROM	#Temp2
	SET @ActToTime = @sSQL8
	SELECT	@sSQL8 = @sSQL8 +') ) AS BT'

SET @sSQL9 = '
	SELECT  T1.APKMaster, T1.TranMonth, T1.TranYear, T1.DepartmentID, T1.TeamID, T1.EmployeeID, T1.EmployeeName, T1.MachineID '+CASE WHEN ISNULL(@FromTime,'')<>'' THEN ','+@FromTime ELSE '' END +''+CASE WHEN ISNULL(@ToTime,'')<>'' THEN ','+@ToTime ELSE '' END +'
	'+CASE WHEN ISNULL(@ActFromTime,'')<>'' THEN ','+@ActFromTime ELSE '' END +''+CASE WHEN ISNULL(@ActToTime,'')<>'' THEN ','+@ActToTime ELSE '' END +'
	FROM #Temp_FromTime T1
	INNER JOIN #Temp_ToTime T2 ON T1.MachineID = T2.MachineID  AND T1.EmployeeID = T2.EmployeeID
	INNER JOIN #Temp_ActFromTime T3 ON T1.MachineID = T3.MachineID AND T1.EmployeeID = T3.EmployeeID --AND T1.[Date] = T3.[Date] 
	INNER JOIN #Temp_ActToTime T4 ON T1.MachineID = T4.MachineID AND T1.EmployeeID = T4.EmployeeID-- AND T1.[Date] = T4.[Date]
	ORDER BY T1.EmployeeID, T1.MachineID

'
--print @sSQL1
--print @sSQL2
--print @sSQL3
--print @sSQL4
--print @sSQL5
--print @sSQL6
--print @sSQL7
--print @sSQL8
--print @sSQL9

IF ISNULL(@FromTime,'')<>'' AND ISNULL(@ToTime,'')<>'' AND ISNULL(@ActFromTime,'')<>'' AND ISNULL(@ActToTime,'')<>''
EXEC (@sSQL1+@sSQL2+@sSQL3+@sSQL4+@sSQL5+@sSQL6+@sSQL7+@sSQL8+@sSQL9)

DROP TABLE #Temp2
DROP TABLE #Temp1

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
