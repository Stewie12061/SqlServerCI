 IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP3001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
 DROP PROCEDURE [DBO].[OOP3001]
 GO
 SET QUOTED_IDENTIFIER ON
 GO
 SET ANSI_NULLS ON
 GO
 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Load danh sách nhân viên trong Báo cáo cơm
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by: Bảo Thy, Date: 14/01/2016
 ---- Modified by Bảo Thy on 06/09/2016: Lấy Khối, Phòng từ danh mục phòng ban, tổ nhóm
 ---- Modified by Phương Thảo on 22/05/2017: Sửa danh mục dùng chung
 ---- Modify on 23/07/2018 by Bảo Anh: Sửa cách lấy ca làm việc cho trường hợp kỳ kế toán không bắt đầu là ngày 1
 /*-- <Example>
  exec	OOP3001 @DivisionID='MK',@UserID='000001', @TranMonth=2, @TranYear=2016, @DepartmentID='%', @SectionID='%', @SubsectionID='%', 
	@ProcessID='%',@Date='2016-02-25', @Mode=1
 ----*/
 
 
 CREATE PROCEDURE OOP3001
 ( 
   @DivisionID VARCHAR(50),
   @UserID VARCHAR(50),
   @TranMonth INT,
   @TranYear INT,
   @DepartmentID VARCHAR(50),
   @SectionID VARCHAR(50),
   @SubsectionID VARCHAR(50),
   @ProcessID VARCHAR(50),
   @Date DATE,
   @Mode TINYINT --0: Tất cả, 1: Cơm sáng, 2: Cơm trưa, 3: Cơm chiều
 ) 
 AS
 DECLARE @sDay VARCHAR(2),
		 --@sDayBf VARCHAR(2),
		 @ColDay VARCHAR(3),
		 --@ColDayBf VARCHAR(3),
		 @sSQL NVARCHAR(MAX)='',
		 @sSQL1 NVARCHAR(MAX)='',
		 @sSQL2 NVARCHAR(MAX)='',
		 @sBreakfast NVARCHAR(MAX)='',
		 @sBreakfast1 NVARCHAR(MAX)='',
		 @sLunch NVARCHAR(MAX),
		 @sDinner NVARCHAR(MAX),
		 @Day INT,
		 --@DayBf INT,
		 @insert NVARCHAR(250)

IF (@Mode = 0 OR @Mode =1) SET @insert = '' 
ELSE IF (@Mode = 2 OR @Mode =3) SET  @insert = 'INSERT INTO #Report'

--SET @DayBf = (DAY(@Date)-1)
--IF @DayBf < 10 SET @sDayBf = '0' + CONVERT(VARCHAR,@Day)
-- ELSE SET @sDayBf = CONVERT(VARCHAR,@Day)
 
-- SET @ColDayBf = 'D'+@sDayBf

--SET @Day = DAY(@Date)
SELECT @Day = DateOrder FROM dbo.[GetDayOfMonth] (@DivisionID, @TranMonth, @TranYear) WHERE [Date] = @Date

 IF @Day < 10 SET @sDay = '0' + CONVERT(VARCHAR,@Day)
 ELSE SET @sDay = CONVERT(VARCHAR,@Day)

 SET @ColDay = 'D'+@sDay
 CREATE TABLE #Report (EmployeeID VARCHAR(50), EmployeeName NVARCHAR(250),DepartmentID VARCHAR(50),DepartmentName NVARCHAR(250),SectionID VARCHAR(50),SectionName NVARCHAR(250),
 SubsectionID VARCHAR(50),SubsectionName NVARCHAR(250), ProcessID VARCHAR(50), ProcessName NVARCHAR(250),Breakfast TINYINT, Lunch TINYINT, Dinner TINYINT)
 -----Load danh sách nhân viên ăn cơm sáng------
 IF (@Mode=0 OR @Mode=1)
 BEGIN
 	SET @sBreakfast = '
 		----Danh sách nhân viên ca ngày----
 		INSERT INTO #Report
 		SELECT DISTINCT HV1400.EmployeeID, HV1400.FullName EmployeeName, DepartmentID, HV1400.DepartmentName, 
 		ISNULL(TEAMID,'''') SectionID, HV1400.TeamName SectionName, ISNULL(Ana04ID,'''') SubsectionID, A13.AnaName SubsectionName,ISNULL(Ana05ID,'''') ProcessID, A14.AnaName ProcessName,
 		1 AS Breakfast, 0 As Lunch, 0 AS Dinner				
		FROM HV1400
		LEFT JOIN HT2408 ON HT2408.DivisionID = HV1400.DivisionID AND HT2408.EmployeeID = HV1400.EmployeeID
		--LEFT JOIN AT1102 A11 WITH (NOLOCK) ON A11.DepartmentID=HV1400.DepartmentID 
		--LEFT JOIN HT1101 A12 WITH (NOLOCK) ON A12.DivisionID = OOT20.DivisionID AND A12.TeamID=HV1400.TeamID
		LEFT JOIN AT1011 A13 ON A13.AnaID=HV1400.Ana04ID AND A13.AnaTypeID=''A04''
		LEFT JOIN AT1011 A14 ON A14.AnaID=HV1400.Ana05ID AND A14.AnaTypeID=''A05'' 
		WHERE HV1400.StatusID NOT IN (3,9)
			AND TranMonth = '+STR(@TranMonth)+' AND TranYear ='+STR(@TranYear)+'
			AND HV1400.EmployeeID IN (SELECT DISTINCT EmployeeID FROM HT2408 WHERE Convert(DATE,AbsentDate,120)= '''+Convert(NVarchar(10),@Date,120)+''')
			AND HV1400.EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM OOT2020 WHERE '''+Convert(NVarchar(10),@Date,120)+''' BETWEEN CONVERT(DATE,GoFromDate,120) AND CONVERT(DATE,GoToDate,120))
			AND HV1400.EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM OOT2010 WHERE '''+Convert(NVarchar(10),@Date,120)+''' BETWEEN CONVERT(DATE,LeaveFromDate,120) AND CONVERT(DATE,LeaveToDate,120))
			AND HV1400.DepartmentID LIKE '''+@DepartmentID+'''
			AND ISNULL(HV1400.TEAMID,'''') LIKE ISNULL('''+@SectionID+''',''%'')
			AND ISNULL(HV1400.Ana04ID,'''') LIKE  ISNULL('''+@SubsectionID+''',''%'')
			AND ISNULL(HV1400.Ana05ID,'''') LIKE  ISNULL('''+@ProcessID+''',''%'')
			AND HV1400.EmployeeID IN 
			(SELECT DISTINCT  EmployeeID FROM HT1025 
			 WHERE '+@ColDay+' IN ( SELECT DISTINCT ShiftID FROM HT1021
									GROUP BY IsNextDay,DateTypeID,ShiftID
									HAVING IsNextDay=0 
									AND MIN(FromMinute) <= ''12:00:00''
									AND LEFT(DATENAME(DW,'''+Convert(NVarchar(10),@Date,120)+'''),3)=DateTypeID) 
			AND TranMonth = '+STR(@TranMonth)+' AND TranYear ='+STR(@TranYear)+') '
	--SET @sBreakfast1 = '
	--	UNION
	--	----Danh sách nhân viên ca đêm----
	--	SELECT DISTINCT HV1400.EmployeeID, HV1400.FullName EmployeeName,DepartmentID, A11.AnaName DepartmentName, 
 --		ISNULL(TEAMID,'''') SectionID, A12.AnaName SectionName, ISNULL(Ana04ID,'''') SubsectionID, A13.AnaName SubsectionName,ISNULL(Ana05ID,'''') ProcessID, A14.AnaName ProcessName,
 --		1 AS Breakfast, 0 As Lunch, 0 AS Dinner					
	--	FROM HV1400
	--	LEFT JOIN HT2408 ON HT2408.DivisionID = HV1400.DivisionID AND HT2408.EmployeeID = HV1400.EmployeeID
	--	LEFT JOIN AT1011 A11 ON A11.DivisionID = HV1400.DivisionID AND A11.AnaID=HV1400.DepartmentID AND A11.AnaTypeID=''A02''
	--	LEFT JOIN AT1011 A12 ON A12.DivisionID = HV1400.DivisionID AND A12.AnaID=HV1400.DepartmentID AND A12.AnaTypeID=''A03''
	--	LEFT JOIN AT1011 A13 ON A13.DivisionID = HV1400.DivisionID AND A13.AnaID=HV1400.DepartmentID AND A13.AnaTypeID=''A04''
	--	LEFT JOIN AT1011 A14 ON A14.DivisionID = HV1400.DivisionID AND A14.AnaID=HV1400.DepartmentID AND A14.AnaTypeID=''A05'' 
	--	WHERE HV1400.StatusID NOT IN (3,9)
	--		AND TranMonth = '+STR(@TranMonth)+' AND TranYear ='+STR(@TranYear)+'
	--		AND HV1400.EmployeeID IN (SELECT DISTINCT EmployeeID FROM HT2408 WHERE Convert(DATE,AbsentDate,120)= '''+Convert(NVarchar(10),@Date,120)+''')
	--		AND HV1400.EmployeeID NOT IN (SELECT DISTINCT  EmployeeID FROM OOT2020 WHERE '''+Convert(NVarchar(10),@Date,120)+''' BETWEEN CONVERT(DATE,GoFromDate,120) AND CONVERT(DATE,GoToDate,120))
	--		AND HV1400.EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM OOT2010 WHERE '''+Convert(NVarchar(10),@Date,120)+''' BETWEEN CONVERT(DATE,LeaveFromDate,120) AND CONVERT(DATE,LeaveToDate,120))
	--		AND HV1400.DepartmentID LIKE '''+@DepartmentID+'''
	--		AND ISNULL(HV1400.TEAMID,'''') LIKE ISNULL('''+@SectionID+''',''%'')
	--		AND ISNULL(HV1400.Ana04ID,'''') LIKE  ISNULL('''+@SubsectionID+''',''%'')
	--		AND ISNULL(HV1400.Ana05ID,'''') LIKE  ISNULL('''+@ProcessID+''',''%'')
	--		AND HV1400.EmployeeID IN 
	--		(SELECT DISTINCT EmployeeID FROM HT1025 
	--								WHERE '+@ColDayBf+' IN (SELECT ShiftID FROM HT1021
	--								GROUP BY IsNextDay,DateTypeID,ShiftID
	--								HAVING IsNextDay=1
	--								AND LEFT(DATENAME(DW,'''+Convert(NVarchar(10),DATEADD(d,@Date,-1),120)+'''),3)=DateTypeID) 
	--		AND TranMonth = '+STR(@TranMonth)+' AND TranYear ='+STR(@TranYear)+') 
	--'
 END
  
	
 ------Load danh sách nhân viên ăn cơm trưa------
IF (@Mode=0 OR @Mode=2)
BEGIN
	SET @sLunch = '
		'+@insert+'
		SELECT DISTINCT HV1400.EmployeeID, HV1400.FullName EmployeeName, DepartmentID, HV1400.DepartmentName, 
 		ISNULL(TEAMID,'''') SectionID, HV1400.TeamName SectionName, ISNULL(Ana04ID,'''') SubsectionID, A13.AnaName SubsectionName,ISNULL(Ana05ID,'''') ProcessID,
 		A14.AnaName ProcessName, 0 AS Breakfast, 1 As Lunch, 0 AS Dinner					----Danh sách nhân viên ca đêm----
		FROM HV1400
		LEFT JOIN HT2408 ON HT2408.DivisionID = HV1400.DivisionID AND HT2408.EmployeeID = HV1400.EmployeeID
		--LEFT JOIN AT1102 A11 WITH (NOLOCK) ON A11.DepartmentID=HV1400.DepartmentID 
		--LEFT JOIN HT1101 A12 WITH (NOLOCK) ON A12.DivisionID = OOT20.DivisionID AND A12.TeamID=HV1400.TeamID
		LEFT JOIN AT1011 A13 ON A13.AnaID=HV1400.Ana04ID AND A13.AnaTypeID=''A04''
		LEFT JOIN AT1011 A14 ON A14.AnaID=HV1400.Ana05ID AND A14.AnaTypeID=''A05'' 
		WHERE HV1400.StatusID NOT IN (3,9)
			AND TranMonth = '+STR(@TranMonth)+' AND TranYear ='+STR(@TranYear)+'
			AND HV1400.EmployeeID IN (SELECT DISTINCT EmployeeID FROM HT2408 WHERE Convert(DATE,AbsentDate,120)= '''+Convert(NVarchar(10),@Date,120)+''')
			AND HV1400.EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM OOT2020 WHERE '''+Convert(NVarchar(10),@Date,120)+''' BETWEEN CONVERT(DATE,GoFromDate,120) AND CONVERT(DATE,GoToDate,120))
			AND HV1400.EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM OOT2010 WHERE '''+Convert(NVarchar(10),@Date,120)+''' BETWEEN CONVERT(DATE,LeaveFromDate,120) AND CONVERT(DATE,LeaveToDate,120))
			AND HV1400.DepartmentID LIKE '''+@DepartmentID+'''
			AND ISNULL(HV1400.TEAMID,'''') LIKE ISNULL('''+@SectionID+''',''%'')
			AND ISNULL(HV1400.Ana04ID,'''') LIKE  ISNULL('''+@SubsectionID+''',''%'')
			AND ISNULL(HV1400.Ana05ID,'''') LIKE  ISNULL('''+@ProcessID+''',''%'')
			AND HV1400.EmployeeID IN 
			(SELECT DISTINCT EmployeeID FROM HT1025 
									WHERE '+@ColDay+' IN (SELECT DISTINCT ShiftID FROM HT1021
									GROUP BY IsNextDay,DateTypeID,ShiftID
									HAVING IsNextDay=0
									AND LEFT(DATENAME(DW,'''+Convert(NVarchar(10),@Date,120)+'''),3)=DateTypeID) 
			AND TranMonth = '+STR(@TranMonth)+' AND TranYear ='+STR(@TranYear)+')
	'
END
	
---Load danh sách nhân viên ăn cơm chiều------
IF (@Mode=0 OR @Mode=3)
BEGIN
	SET @sDinner ='
		'+@insert+'
		SELECT DISTINCT HV1400.EmployeeID, HV1400.FullName EmployeeName, DepartmentID,  HV1400.DepartmentName, 
 		ISNULL(TEAMID,'''') SectionID, HV1400.TeamName SectionName, ISNULL(Ana04ID,'''') SubsectionID, A13.AnaName SubsectionName,ISNULL(Ana05ID,'''') ProcessID,
 		A14.AnaName ProcessName, 0 AS Breakfast, 0 As Lunch, 1 AS Dinner	
		FROM HV1400
		LEFT JOIN HT2408 ON HT2408.DivisionID = HV1400.DivisionID AND HT2408.EmployeeID = HV1400.EmployeeID
		--LEFT JOIN AT1102 A11 WITH (NOLOCK) ON A11.DepartmentID=HV1400.DepartmentID 
		--LEFT JOIN HT1101 A12 WITH (NOLOCK) ON A12.DivisionID = OOT20.DivisionID AND A12.TeamID=HV1400.TeamID
		LEFT JOIN AT1011 A13 ON A13.AnaID=HV1400.Ana04ID AND A13.AnaTypeID=''A04''
		LEFT JOIN AT1011 A14 ON A14.AnaID=HV1400.Ana05ID AND A14.AnaTypeID=''A05''  
		WHERE HV1400.StatusID NOT IN (3,9)
			AND TranMonth = '+STR(@TranMonth)+' AND TranYear ='+STR(@TranYear)+'
			AND HV1400.EmployeeID IN (SELECT DISTINCT EmployeeID FROM HT2408 WHERE Convert(DATE,AbsentDate,120)= '''+Convert(NVarchar(10),@Date,120)+''')
			AND HV1400.EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM OOT2020 WHERE '''+Convert(NVarchar(10),@Date,120)+''' BETWEEN CONVERT(DATE,GoFromDate,120) AND CONVERT(DATE,GoToDate,120))
			AND HV1400.EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM OOT2010 WHERE '''+Convert(NVarchar(10),@Date,120)+''' BETWEEN CONVERT(DATE,LeaveFromDate,120) AND CONVERT(DATE,LeaveToDate,120))
			AND HV1400.DepartmentID LIKE '''+@DepartmentID+'''
			AND ISNULL(HV1400.TEAMID,'''') LIKE ISNULL('''+@SectionID+''',''%'')
			AND ISNULL(HV1400.Ana04ID,'''') LIKE  ISNULL('''+@SubsectionID+''',''%'')
			AND ISNULL(HV1400.Ana05ID,'''') LIKE  ISNULL('''+@ProcessID+''',''%'')
			AND HV1400.EmployeeID IN (SELECT DISTINCT EmployeeID FROM HT1025
										WHERE '+@ColDay+' IN (	SELECT DISTINCT HT1021.ShiftID FROM HT1021
																LEFT JOIN HT1020 ON HT1021.ShiftID=HT1020.ShiftID
																WHERE LEFT(DATENAME(DW,'''+Convert(NVarchar(10),@Date,120)+'''),3)=DateTypeID
																AND Workingtime=12 AND IsNextDay=0 
																GROUP BY HT1021.ShiftID,datetypeid ,HT1021.orders 
																HAVING MAX(ToMinute) < ''19:00:00''
															) 
										AND TranMonth = '+STR(@TranMonth)+' AND TranYear ='+STR(@TranYear)+')
		'
END

IF @Mode = 0
	BEGIN
		SET @sSQL = @sBreakfast
		SET @sSQL1 = @sBreakfast1 + 'UNION' 
		SET @sSQL2 =  @sLunch +'UNION' + @sDinner
	END
ELSE IF @Mode=1
	BEGIN
		SET @sSQL = @sBreakfast 
		SET @sSQL1 = @sBreakfast1 
	END
ELSE IF @Mode=2
	SET @sSQL = @sLunch
ELSE IF @Mode=3
	SET @sSQL = @sDinner

EXEC (@sSQL+@sSQL1+@sSQL2)
--PRINT (@sSQL)
--PRINT (@sSQL1)
--PRINT (@sSQL2)

SELECT ROW_NUMBER() OVER (ORDER BY EmployeeID) AS STT, *
FROM #Report

  
 GO
 SET QUOTED_IDENTIFIER OFF 
 GO
 SET ANSI_NULLS ON
 GO

 