IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0383_MK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0383_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
---- Báo cáo tổng hợp công (Meiko)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference> HRM\Báo cáo\Công
---- Tổng hợp công - HF0384
-- <History>
---- Create on 07/01/2016 by Trương Ngọc Phương Thảo
---- Modified on 14/11/2016 by Bảo Thy: Bổ sung xử lý tách bảng nghiệp vụ
---- Modified on 17/03/2021 by Huỳnh Thử: Bổ sung cột đếm số ngày được phân ca
---- Modified on 
-- <Example>
----  EXEC HP0383_MK 'MK', 11, 2016,  '%', '%', '%', '%', 'BCCT'
CREATE PROCEDURE HP0383_MK	
(
	@DivisionID Nvarchar(50),	
	@TranMonth int,
	@TranYear int,	
	@DepartmentID NVarchar(50),
	@TeamID Nvarchar(50),
	@SectionID Nvarchar(50),
	@ProcessID Nvarchar(50),
	@ReportID Varchar(50)
)
AS
SET NOCOUNT ON

DECLARE @SQL01 Varchar(8000), @i int, @N int, @si Varchar(10),
		@TimeConvert decimal(28, 8), 
		@FirstDate datetime, @LastDate datetime,
		@sSQL000 Nvarchar(MAX) ='',
		@sSQL001 Nvarchar(4000) ='',
		@sSQL002 Nvarchar(4000) ='',
		@sSQL003 Nvarchar(4000) ='',
		@TableHT2400 Varchar(50),
		@TableHT2401 Varchar(50),
		@TableHT2402 Varchar(50),
		@sTranMonth Varchar(2)

SELECT TOP 1 @TimeConvert = TimeConvert
FROM HT0000
WHERE DivisionID = @DivisionID

SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WITH (NOLOCK) WHERE IsSplitTable = 1)	
BEGIN
	SELECT  @TableHT2400 = 'HT2400M'+@sTranMonth+Convert(Varchar(4),@TranYear),
			@TableHT2401 = 'HT2401M'+@sTranMonth+Convert(Varchar(4),@TranYear),
			@TableHT2402 = 'HT2402M'+@sTranMonth+Convert(Varchar(4),@TranYear)
END
ELSE
BEGIN
	SELECT	@TableHT2400 = 'HT2400',
			@TableHT2401 = 'HT2401',
			@TableHT2402 = 'HT2402'
END

-- Lấy ra ngày cuối của tháng in
SET @FirstDate = CONVERT(Datetime,STR(@TranMonth)+'/'+'1'+'/'++STR(@TranYear)) 
--print @Date
SET @LastDate = DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,@FirstDate)+1,0))

--print @LastDate

CREATE TABLE #HP0383_MK 
(
EmployeeID VARCHAR(50),
DivisionID VARCHAR(50),
EmployeeName NVARCHAR(250),
DepartmentID VARCHAR(50),
DepartmentName NVARCHAR(250),
TeamID VARCHAR(50),
TeamName NVARCHAR(250),
SectionID VARCHAR(50),
SectionName NVARCHAR(250),
ProcessID VARCHAR(50),
ProcessName NVARCHAR(250),
TitleID VARCHAR(50),
TitleName NVARCHAR(250),
StatusID VARCHAR(50),
Status NVARCHAR(250),
WorkDate DATETIME,
C_T VARCHAR(10), 
StandardAmount DECIMAL(28,8), 
ActualAmount DECIMAL(28,8),
Amount01 DECIMAL(28,8),
Amount02 DECIMAL(28,8),
Amount03 DECIMAL(28,8),
Amount04 DECIMAL(28,8),
Amount05 DECIMAL(28,8),
Amount06 DECIMAL(28,8),
Amount07 DECIMAL(28,8),
Amount08 DECIMAL(28,8),
Amount09 DECIMAL(28,8),
Amount10 DECIMAL(28,8),
Amount11 DECIMAL(28,8),
Amount12 DECIMAL(28,8),
Amount13 DECIMAL(28,8),
Amount14 DECIMAL(28,8),
Amount15 DECIMAL(28,8),
Amount16 DECIMAL(28,8),
Amount17 DECIMAL(28,8),
Amount18 DECIMAL(28,8),
Amount19 DECIMAL(28,8),
Amount20 DECIMAL(28,8),
Amount21 DECIMAL(28,8),
Amount22 DECIMAL(28,8),
Amount23 DECIMAL(28,8),
Amount24 DECIMAL(28,8),
Amount25 DECIMAL(28,8),
Amount26 DECIMAL(28,8),
Amount27 DECIMAL(28,8),
Amount28 DECIMAL(28,8),
Amount29 DECIMAL(28,8),
Amount30 DECIMAL(28,8),
Amount31 DECIMAL(28,8),
ForgetScanTimes DECIMAL(28,8), 
RemainDay DECIMAL(28,8),
RemainHours DECIMAL(28,8),
Notes NVARCHAR(250),
SubAssiduityTimes DECIMAL(28,8),
LunchDays DECIMAL(28,8),
CountShift INT 
)


SET @sSQL000 = '
INSERT INTO #HP0383_MK 
(EmployeeID,DivisionID,EmployeeName,DepartmentID,DepartmentName,TeamID,TeamName,SectionID,SectionName,ProcessID,ProcessName,TitleID,TitleName,StatusID,
Status,WorkDate,C_T, StandardAmount, ActualAmount,Amount01,Amount02,Amount03,Amount04,Amount05,Amount06,Amount07,Amount08,Amount09,Amount10,Amount11,
Amount12,Amount13,Amount14,Amount15,Amount16,Amount17,Amount18,Amount19,Amount20,Amount21,Amount22,Amount23,Amount24,Amount25,Amount26,Amount27,Amount28,
Amount29,Amount30,Amount31,ForgetScanTimes, RemainDay,RemainHours,Notes,SubAssiduityTimes,LunchDays, CountShift)

SELECT  DISTINCT H00.EmployeeID, H00.DivisionID, 
		Ltrim(RTrim(isnull(H02.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(H02.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(H02.FirstName,''''))) As EmployeeName,
		H04.DepartmentID, 
		Convert(NVarchar(250),'''') AS DepartmentName,
		H04.TeamID, 
		Convert(NVarchar(250),'''') AS TeamName,
		CASE WHEN ISNULL(H04.[Ana04ID],'''') <> '''' THEN H04.[Ana04ID] ELSE H02.Ana04ID END AS SectionID, 
		Convert(NVarchar(250),'''') AS SectionName,
		CASE WHEN ISNULL(H04.[Ana05ID],'''') <> '''' THEN H04.[Ana05ID] ELSE H02.Ana05ID END AS ProcessID, 
		Convert(NVarchar(250),'''') AS ProcessName,		
		CASE WHEN ISNULL(H04.DutyID,'''') <> '''' THEN H04.DutyID ELSE H03.TitleID END  AS TitleID, 
		Convert(NVarchar(250),'''') AS TitleName,		
		Convert(Varchar(50),'''') AS StatusID,
		Convert(NVarchar(250),'''') AS Status,
		H03.WorkDate, 
		--CASE H03.EmployeeStatus WHEN 1 THEN ''C''  WHEN 2 THEN ''T'' ELSE '''' END AS C_T,
		Convert(Varchar(10),'''') AS C_T,
		Convert(decimal(28, 8),0) AS StandardAmount,
		Convert(decimal(28, 8),0) AS ActualAmount,
		Convert(decimal(28, 8),0) AS Amount01, Convert(decimal(28, 8),0) AS Amount02, Convert(decimal(28, 8),0) AS Amount03,
		Convert(decimal(28, 8),0) AS Amount04, Convert(decimal(28, 8),0) AS Amount05, Convert(decimal(28, 8),0) AS Amount06,
		Convert(decimal(28, 8),0) AS Amount07, Convert(decimal(28, 8),0) AS Amount08, Convert(decimal(28, 8),0) AS Amount09,
		Convert(decimal(28, 8),0) AS Amount10, Convert(decimal(28, 8),0) AS Amount11, Convert(decimal(28, 8),0) AS Amount12,
		Convert(decimal(28, 8),0) AS Amount13, Convert(decimal(28, 8),0) AS Amount14, Convert(decimal(28, 8),0) AS Amount15,
		Convert(decimal(28, 8),0) AS Amount16, Convert(decimal(28, 8),0) AS Amount17, Convert(decimal(28, 8),0) AS Amount18,
		Convert(decimal(28, 8),0) AS Amount19, Convert(decimal(28, 8),0) AS Amount20, Convert(decimal(28, 8),0) AS Amount21,
		Convert(decimal(28, 8),0) AS Amount22, Convert(decimal(28, 8),0) AS Amount23, Convert(decimal(28, 8),0) AS Amount24, 
		Convert(decimal(28, 8),0) AS Amount25,
		Convert(decimal(28, 8),0) AS Amount26,
		Convert(decimal(28, 8),0) AS Amount27,
		Convert(decimal(28, 8),0) AS Amount28,
		Convert(decimal(28, 8),0) AS Amount29,
		Convert(decimal(28, 8),0) AS Amount30,
		Convert(decimal(28, 8),0) AS Amount31,
		-- Số lần quên quẹt thẻ trong tháng
		Convert(decimal(28, 8),0) AS ForgetScanTimes, 	
		-- Số ngày phép năm còn dư (đã bao gồm tháng hiện tại)
		Convert(decimal(28, 8),0) AS RemainDay, 
		-- Số giờ nghỉ bù còn dư
		Convert(decimal(28, 8),0) AS RemainHours, 
		Convert(NVarchar(250),'''') AS Notes,
		Convert(decimal(28, 8),0) AS SubAssiduityTimes,
		Convert(decimal(28, 8),0) AS LunchDays,
		(SELECT COUNT(*)
		FROM   
		   (SELECT EmployeeID, D01,
							   D02,
							   D03,
							   D04,
							   D05,
							   D06,
							   D07,
							   D08,
							   D09,
							   D10,
							   D11,
							   D12,
							   D13,
							   D14,
							   D15,
							   D16,
							   D17,
							   D18,
							   D19,
							   D20,
							   D21,
							   D22,
							   D23,
							   D24,
							   D25,
							   D26,
							   D27,
							   D28,
							   D29,
							   D30,
							   D31,
							   D32,
							   D33
		   FROM HT1025 WHERE TranMonth + TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+' AND EmployeeID = H00.EmployeeID ) p  
		UNPIVOT  
		   (Orders FOR Employee IN   
			(
				D01,
				D02,
				D03,
				D04,
				D05,
				D06,
				D07,
				D08,
				D09,
				D10,
				D11,
				D12,
				D13,
				D14,
				D15,
				D16,
				D17,
				D18,
				D19,
				D20,
				D21,
				D22,
				D23,
				D24,
				D25,
				D26,
				D27,
				D28,
				D29,
				D30,
				D31,
				D32,
				D33
			)

		)AS unpvt
		GROUP BY unpvt.EmployeeID) AS CountShift
  '
SET @sSQL001 = N'
FROM	'+@TableHT2401+' H00 
INNER JOIN	HT1013 H01 ON H00.AbsentTypeID = H01.AbsentTypeID AND H00.DivisionID = H01.DivisionID
LEFT JOIN HT1400 H02 ON H00.DivisionID = H02.DivisionID AND H00.EmployeeID = H02.EmployeeID
LEFT JOIN HT1403 H03 WITH (NOLOCK) ON H02.EmployeeID = H03.EmployeeID and H02.DivisionID = H03.DivisionID
LEFT JOIN '+@TableHT2400+' H04 WITH (NOLOCK) ON H00.EmployeeID = H04.EmployeeID and H00.DivisionID = H04.DivisionID
WHERE	H00.DivisionID = '''+@DivisionID+''' and
		Isnull(H02.DepartmentID,'''') LIKE Isnull('''+@DepartmentID+''','''')  and
		Isnull(H02.TeamID, '''') like Isnull('''+@TeamID+''', '''') and
		H00.TranMonth + H00.TranYear*100 = '+STR(@TranMonth+ @TranYear * 100)+'
		AND Isnull(H02.[Ana04ID],'''') like Isnull('''+@SectionID+''','''') AND Isnull(H02.[Ana05ID],'''') like ISnull('''+@ProcessID+''','''')	 
		AND
		(H04.EndDate IS NULL
		OR (H04.EndDate IS NOT NULL AND Convert(Date,H04.EndDate) >=  '''+Convert(Varchar(10),@FirstDate,101)+''')
		)		
		 --AND H00.EmployeeID = ''008802''

'

EXEC (@sSQL000+@sSQL001)
PRINT (@sSQL000)
PRINT (@sSQL001)

--select * from #HP0383_MK
-- Update ten Khoi: DepartmentName
Update	T1
set		T1.DepartmentName = T2.DepartmentName
from	#HP0383_MK T1
inner join AT1102 T2 WITH (NOLOCK) on T1.DepartmentID = T2.DepartmentID and T1.DivisionID = T2.DivisionID

-- Update ten Phong : TeamName
Update	T1
set		T1.TeamName = T2.TeamName
from	#HP0383_MK T1
inner join HT1101 T2 WITH (NOLOCK) on T1.TeamID = T2.TeamID and T1.DivisionID = T2.DivisionID

-- Update ten Ban: SectionName
Update	T1
set		T1.SectionName = T2.AnaName
from	#HP0383_MK T1
inner join AT1011 T2 WITH (NOLOCK) on T1.SectionID = T2.AnaID and T1.DivisionID = T2.DivisionID AND T2.AnaTypeID = 'A04'

-- Update ten Cong doan: ProcessName
Update	T1
set		T1.ProcessName = T2.AnaName
from	#HP0383_MK T1
inner join AT1011 T2 WITH (NOLOCK) on T1.ProcessID = T2.AnaID and T1.DivisionID = T2.DivisionID AND T2.AnaTypeID = 'A05'

-- Update trạng thái/chế độ
Update	T1
set		T1.StatusID = CASE WHEN ISNULL(T2.EmployeeMode,'') <> '' THEN  T2.EmployeeMode ELSE T2.EmployeeStatus END
from	#HP0383_MK T1
left join HT1414 T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
WHERE	@LastDate BETWEEN ISNULL(T2.BeginDate,T1.WorkDate) AND Isnull(T2.EndDate,@LastDate) 

Update	T1
set		T1.Status = T2.EmployeeStatusName
from	#HP0383_MK T1
inner join
(	SELECT ID AS StatusID, [Description] AS EmployeeStatusName FROM AT0099 WHERE CodeMaster = 'AT00000010'
	UNION ALL
	SELECT  '1', N'NV đang làm'
	UNION ALL
	SELECT  '2', N'NV thử việc'
	UNION ALL
	SELECT  '3', N'Tạm nghỉ'
	UNION ALL
	SELECT  '4', N'CN thời vụ'	)T2 ON T1.StatusID = T2.StatusID

Update	T1
set		T1.C_T = CASE T1.StatusID  WHEN '1' THEN 'C' WHEN '2' THEN 'T'  ELSE '' END
from	#HP0383_MK T1

--- Update ten chuc danh: TitleName
--- Tính số giờ công tiêu chuẩn
Update	T1
set		T1.TitleName = T2.TitleName,
		T1.StandardAmount = T2.StandardAbsentAmount
from	#HP0383_MK T1
inner join HT1106 T2 WITH (NOLOCK) on T1.TitleID = T2.TitleID and T1.DivisionID = T2.DivisionID

SET @sSQL002 ='
--- Tính số giờ công thực tế
Update	T1
set		T1.ActualAmount = T2.ActualAmount
from	#HP0383_MK T1
inner join (
		SELECT	DivisionID, EmployeeID, SUM(AbsentAmount) AS ActualAmount
		FROM	'+@TableHT2401+'
		WHERE	TranMonth = '+STR(@TranMonth)+' AND TranYear = '+STR(@TranYear)+' AND DivisionID = '''+@DivisionID+'''
		GROUP BY DivisionID, EmployeeID
		) T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
'

EXEC (@sSQL002)
--PRINT (@sSQL002)
---- Tính số lần quên quẹt thẻ
--Update	T1
--set		T1.ForgetScanTimes = T2.Times
--from	#HP0383_MK T1
--inner join (
--		SELECT	DivisionID, EmployeeID, Count(EmployeeID) AS Times
--		FROM	OOT2060
--		WHERE	TranMonth = @TranMonth AND TranYear = @TranYear	AND Fact = 'BT0001' AND DivisionID = @DivisionID			 	
--		GROUP BY DivisionID, EmployeeID
--		) T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
Update	T1
set		T1.ForgetScanTimes = T2.Times
from	#HP0383_MK T1
inner join (
SELECT	T1.DivisionID, T1.EmployeeID, Count(EmployeeID) AS Times
FROM	OOT2040 T1
INNER JOIN OOT9000 T2 on T1.APKmaster = T2.APK and T1.DivisionID = T2.DivisionID
WHERE	T2.TranMonth = @TranMonth AND T2.TranYear = @TranYear	AND T1.DivisionID = @DivisionID	
AND T1.Status = 1 AND T2.Status =1		 	
GROUP BY T1.DivisionID, T1.EmployeeID
) T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID




--- Tính số phép năm còn dư
UPDATE T1
set		T1.RemainDay = T2.DaysRemained
from	#HP0383_MK T1
inner join HT2803 T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
					AND T2.TranMonth = @TranMonth AND T2.TranYear = @TranYear

SET @sSQL002 = '
 --Tính số giờ NB còn dư
UPDATE T1
set		T1.RemainHours = T2.AbsentHour
from	#HP0383_MK T1
inner join
(
SELECT T1.EmployeeID, T1.DivisionID,
		SUM(CASE WHEN T2.UnitID = ''H'' THEN AbsentAmount ELSE AbsentAmount/'+Convert(Varchar(50),@TimeConvert)+' END  ) AS AbsentHour
FROM '+@TableHT2401+' T1
LEFT JOIN HT1013 T2 ON T1.DivisionID = T2.DivisionID AND T1.AbsentTypeID = T2.AbsentTypeID
WHERE T2.TypeID = ''NB'' AND T1.TranMonth = '+STR(@TranMonth)+' AND T1.TranYear = '+STR(@TranYear)+' AND T1.DivisionID = '''+@DivisionID+'''
GROUP BY T1.EmployeeID, T1.DivisionID
) T2  ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
'
EXEC(@sSQL002)
--PRINT ('11111'+ @sSQL002)

CREATE TABLE #AbsentType (DataID Varchar(10), AbsentTypeID Varchar(50))
--Create Table #tmpFromToAbsentType (DataID Varchar(10), FromAbsentTypeID Varchar(50),ToAbsentTypeID Varchar(50))

SELECT @SQL01 = '', @i = 1, @N = 25
WHILE (@i <= 31)
BEGIN
	IF @i < 10 SET @si = LTRIM(RTRIM('0' + CONVERT(VARCHAR(10), @i)))
	ELSE SET @si = LTRIM(RTRIM(CONVERT(VARCHAR(10), @i)))
	
	SET @SQL01 = '
		
	SELECT FromAbsentTypeID, ToAbsentTypeID
	into #tmp
	FROM	HT0383 
	WHERE	DivisionID = '''+@DivisionID+''' AND ReportID = '''+@ReportID+''' AND DataTypeID =  ''Amount'+@si+'''


	INSERT INTO #AbsentType (DataID, AbsentTypeID )
	SELECT ''Amount'+@si+''', HT1013.AbsentTypeID
	FROM HT1013 left join #tmp on HT1013.AbsentTypeID between #tmp.FromAbsentTypeID and #tmp.ToAbsentTypeID
	WHERE  #tmp.FromAbsentTypeID is not null and #tmp.ToAbsentTypeID  is not null

	UPDATE	T1
	SET		T1.Amount'+@si+' = Amount
	FROM	#HP0383_MK T1
	INNER JOIN
	(
	SELECT	HT2401.DivisionID, HT2401.EmployeeID, 
			-- SUM(AbsentHour) AS Amount
			SUM(CASE WHEN HT1013.UnitID = ''H'' THEN 
					CASE WHEN HT1013.TypeID = ''NB'' THEN  
						CASE WHEN HT2401.AbsentAmount < 0 THEN ABS(HT2401.AbsentAmount) ELSE 0 END
					ELSE ABS(HT2401.AbsentAmount) END
				ELSE ABS(HT2401.AbsentAmount)/'+STR(@TimeConvert)+' END  )  AS Amount
	FROM	'+@TableHT2401+' AS HT2401
	LEFT JOIN HT1013 ON HT2401.DivisionID = HT1013.DivisionID AND HT2401.AbsentTypeID = HT1013.AbsentTypeID
	WHERE	HT2401.TranMonth = '+STR(@TranMonth)+' AND HT2401.TranYear = '+STR(@TranYear)+'
			AND HT2401.AbsentTypeID In (SELECT AbsentTypeID FROM #AbsentType WHERE DataID = ''Amount'+@si+''')
	GROUP BY HT2401.DivisionID, HT2401.EmployeeID
	) T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
	
		drop table #tmp
	'
	
	SET @i = @i + 1
	--PRINT @SQL01
	EXEC (@SQL01)	
	
END

SET @sSQL002 = '
---- Số lần nghỉ trừ tiền thưởng
UPDATE T1
set		T1.SubAssiduityTimes = T2.Amount
from	#HP0383_MK T1
INNER JOIN
	(
	SELECT	HT2401.DivisionID, HT2401.EmployeeID, 			
			COUNT(EmployeeID) AS Amount
	FROM	'+@TableHT2401+' AS HT2401
	LEFT JOIN HT1013 ON HT2401.DivisionID = HT1013.DivisionID AND HT2401.AbsentTypeID = HT1013.AbsentTypeID
	WHERE	HT2401.TranMonth = '+STR(@TranMonth)+' AND HT2401.TranYear = '+STR(@TranYear)+'
			AND HT2401.AbsentTypeID In (SELECT AbsentTypeID 
										FROM HT1013 
										LEFT JOIN HT0383 on HT1013.AbsentTypeID between HT0383.FromAbsentTypeID and HT0383.ToAbsentTypeID AND HT1013.DivisionID = HT0383.DivisionID
										WHERE HT0383.FromAbsentTypeID is not null and HT0383.ToAbsentTypeID  is not null
										AND HT1013.DivisionID = '''+@DivisionID+'''
										AND HT0383.ReportID = '''+@ReportID+''' AND HT0383.DataTypeID IN (''Amount01'',''Amount04'') )
	GROUP BY HT2401.DivisionID, HT2401.EmployeeID
	) T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID

'
EXEC (@sSQL002)
--PRINT ('22222'+ @sSQL002)
--select @FirstDate, @LastDate
---- Số ngày hưởng trợ cấp ăn trưa
Update	T1
set		T1.LunchDays = T2.Times
from	#HP0383_MK T1
inner join (
		SELECT	T1.DivisionID, T1.EmployeeID, 
		SUM(DateDiff(d,CASE WHEN Month(T1.GoFromDate) <> @TranMonth THEN @FirstDate ELSE T1.GoFromDate END, CASE WHEN Month(T1.GoToDate) <> @TranMonth THEN @LastDate ELSE T1.GoToDate END) + 1) AS Times
		FROM	OOT2020 T1	
		INNER JOIN OOT9000 T2 on T1.APKmaster = T2.APK and T1.DivisionID = T2.DivisionID
		WHERE	
		@TranYear *100 + @TranMonth BETWEEN Year(T1.GoFromDate) * 100 + Month(T1.GoFromDate) AND Year(T1.GoToDate) * 100 + Month(T1.GoToDate)
		AND T2.HaveLunch = 0 AND T1.DivisionID = @DivisionID	
		AND T1.Status = 1 AND T2.Status =1	
		GROUP BY T1.DivisionID, T1.EmployeeID
		) T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID


--select *
--from	#HP0383_MK T1
--WHERE 
--NOT EXISTS 
--(SELECT TOP 1 1 FROM HT1380 T2 WHERE T1.EmployeeID = T2.EmployeeID and T2.LeaveDate < @LastDate)
--OR
--NOT EXISTS
--(SELECT TOP 1 1 FROM HT1403 T3 WHERE T1.EmployeeID = T3.EmployeeID and T3.WorkDate > @FirstDate)
--and EmployeeID = '000199'

--return
---- Xu ly lai gio cong thuc te = gio cong quy dinh neu nv lam du nguyen thang
SET @sSQL002 = N'
UPDATE T1
set		-- T1.Amount23 = CASE WHEN T1.Amount23 >= T1.StandardAmount THEN T1.StandardAmount ELSE T1.Amount23 END
		T1.Amount23 = T2.AbsentAmount
from	#HP0383_MK T1
inner join 
(select DivisionID, EmployeeID, SUM(AbsentAmount) AS AbsentAmount
FROM '+@TableHT2402+' 
WHERE 
AbsentTypeID IN (SELECT  CActAbsentTypeID AS AbsentTypeID
						FROM HT0000
						WHERE HT0000.DivisionID = '''+@DivisionID+'''
						UNION ALL
						SELECT  TActAbsentTypeID AS AbsentTypeID
						FROM HT0000
						WHERE HT0000.DivisionID = '''+@DivisionID+''')
Group by DivisionID, EmployeeID
)T2 ON T1.DivisionID = T2.DivisionID and T1.EmployeeID = T2.EmployeeID

			
			 '
--print @sSQL002
EXEC(@sSQL002)

---- Xu ly lai gio cong nghi bu: cong them so gio nghi bu ton tu thang truoc
DECLARE @MinPeriod Int
--SELECT	@MinPeriod = Min(TranYear*100+TranMonth)
--FROM	HT2400
--WHERE	DivisionID = @DivisionID
SELECT @MinPeriod = 201610


UPDATE	T1
SET		T1.RemainHours = T1.RemainHours + Isnull(Convert(Int,T2.N01),0)
FROM	#HP0383_MK T1
LEFT JOIN HT1413 T2 WITH (NOLOCK) on T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
WHERE @TranMonth+@TranYear*100 = @MinPeriod

SET @sSQL002 ='
UPDATE	T1
SET		T1.RemainHours = T1.RemainHours + Isnull(T3.AbsentAmount,0)
FROM	#HP0383_MK T1		
LEFT JOIN '+@TableHT2402+' T3 WITH (NOLOCK) on T1.EmployeeID = T3.EmployeeID and T1.DivisionID = T3.DivisionID 
								and ( (T3.TranMonth + 1 = '+STR(@TranMonth)+' and T3.TranYear   = '+STR(@TranYear)+') 			
									or (T3.TranYear + 1 = '+STR(@TranYear)+' and T3.TranMonth = 12 ) )		
WHERE 	T3.AbsentTypeID IN (
						SELECT  Distinct ParentID						
						FROM HT1013 WITH (NOLOCK)
						WHERE TypeID = ''NB'' 
						)
AND '+STR(@TranMonth+ @TranYear * 100)+' > '+STR(@MinPeriod)+'


--- So gio tro cap cho nu
UPDATE	T1
SET		T1.Amount09 = T3.AbsentAmount
FROM	#HP0383_MK T1
LEFT JOIN '+@TableHT2402+' T3 WITH (NOLOCK) on T1.EmployeeID = T3.EmployeeID and T1.DivisionID = T3.DivisionID  and T3.TranMonth = '+STR(@TranMonth)+' and T3.TranYear = '+STR(@TranYear)+'								
WHERE 	T3.AbsentTypeID IN (
						SELECT  Distinct ParentID						
						FROM HT1013 left join HT0383 on HT1013.AbsentTypeID between HT0383.FromAbsentTypeID and HT0383.ToAbsentTypeID 
						AND HT1013.DivisionID = HT0383.DivisionID
						WHERE HT0383.FromAbsentTypeID is not null and HT0383.ToAbsentTypeID  is not null
						AND HT1013.DivisionID = '''+@DivisionID+''' AND HT0383.ReportID = '''+@ReportID+''' AND HT0383.DataTypeID = ''Amount09'')
'
EXEC (@sSQL002)
--PRINT ('33333'+ @sSQL002)

--- Xu ly lai gio tro cap di lai: Chi lay len cho nhung nguoi o KTX
UPDATE	T1
SET		T1.Amount19 = CASE WHEN T2.Target01ID = '1' THEN T1.Amount19 ELSE 0 END
FROM	#HP0383_MK T1
INNER JOIN HT1403 T2 ON T1.EmployeeID = T2.EmployeeID AND T1.DivisionID = T2.DivisionID


SELECT * FROM #HP0383_MK order by EmployeeID
DROP TABLE #HP0383_MK






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
