IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0383]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0383]
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
---- Modified by Phương Thảo on 18/05/2017: Sửa danh mục dùng chung 
---- Modified on 10/09/2020 by Nhựt Trường: tách store cho customer Meiko.
-- <Example>
----  EXEC HP0383 'MK', 2, 2016,  '%', '%', '%', '%', 'BCT2'
CREATE PROCEDURE HP0383	
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

DECLARE @CustomerName INT
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF @CustomerName = 50 ---- Customize Meiko
BEGIN
	EXEC HP0383_MK @DivisionID, @TranMonth, @TranYear, @DepartmentID, @TeamID, @SectionID, @ProcessID, @ReportID
END
ELSE
BEGIN

DECLARE @SQL01 Varchar(8000), @i int, @N int, @si Varchar(10),
		@TimeConvert decimal(28, 8), @Date datetime

SELECT TOP 1 @TimeConvert = TimeConvert
FROM HT0000
WHERE DivisionID = @DivisionID


-- Lấy ra ngày cuối của tháng in
SET @Date = CONVERT(Datetime,STR(@TranMonth)+'/'+'1'+'/'++STR(@TranYear)) 
print @Date
SET @Date = DATEADD(mm,DATEDIFF(mm,0,@Date)+1,0)

print @Date

SELECT  DISTINCT H00.EmployeeID, H00.DivisionID, 
		Ltrim(RTrim(isnull(H02.LastName,'')))+ ' ' + LTrim(RTrim(isnull(H02.MiddleName,''))) + ' ' + LTrim(RTrim(Isnull(H02.FirstName,''))) As EmployeeName,
		H02.DepartmentID, 
		Convert(NVarchar(250),'') AS DepartmentName,
		H02.TeamID, 
		Convert(NVarchar(250),'') AS TeamName,
		H02.[Ana04ID] AS SectionID, 
		Convert(NVarchar(250),'') AS SectionName,
		H02.[Ana05ID] AS ProcessID, 
		Convert(NVarchar(250),'') AS ProcessName,		
		H03.TitleID, 
		Convert(NVarchar(250),'') AS TitleName,		
		Convert(Varchar(50),'') AS StatusID,
		Convert(NVarchar(250),'') AS Status,
		H03.WorkDate, 
		--CASE H03.EmployeeStatus WHEN 1 THEN 'C'  WHEN 2 THEN 'T' ELSE '' END AS C_T,
		Convert(Varchar(10),'') AS C_T,
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
		-- Số lần quên quẹt thẻ trong tháng
		Convert(decimal(28, 8),0) AS ForgetScanTimes, 	
		-- Số ngày phép năm còn dư (đã bao gồm tháng hiện tại)
		Convert(decimal(28, 8),0) AS RemainDay, 
		-- Số giờ nghỉ bù còn dư
		Convert(decimal(28, 8),0) AS RemainHours, 
		Convert(NVarchar(250),'') AS Notes
INTO	#HP0383
FROM	HT2401 H00 
INNER JOIN	HT1013 H01 ON H00.AbsentTypeID = H01.AbsentTypeID AND H00.DivisionID = H01.DivisionID
LEFT JOIN HT1400 H02 ON H00.DivisionID = H02.DivisionID AND H00.EmployeeID = H02.EmployeeID
LEFT JOIN HT1403 H03 WITH (NOLOCK) ON H02.EmployeeID = H03.EmployeeID and H02.DivisionID = H03.DivisionID
WHERE	H00.DivisionID = @DivisionID and
		Isnull(H02.DepartmentID,'') LIKE Isnull(@DepartmentID,'')  and
		Isnull(H02.TeamID, '') like Isnull(@TeamID, '') and
		TranMonth + TranYear*100 = @TranMonth + @TranYear * 100
		 AND Isnull(H02.[Ana04ID],'') like Isnull(@SectionID,'') AND Isnull(H02.[Ana05ID],'') like ISnull(@ProcessID,'')

--select * from #HP0383
-- Update ten Khoi: DepartmentName
Update	T1
set		T1.DepartmentName = T2.DepartmentName
from	#HP0383 T1
inner join AT1102 T2 WITH (NOLOCK) on T1.DepartmentID = T2.DepartmentID

-- Update ten Phong : TeamName
Update	T1
set		T1.TeamName = T2.TeamName
from	#HP0383 T1
inner join HT1101 T2 WITH (NOLOCK) on T1.TeamID = T2.TeamID and T1.DivisionID = T2.DivisionID

-- Update ten Ban: SectionName
Update	T1
set		T1.SectionName = T2.AnaName
from	#HP0383 T1
inner join AT1011 T2 WITH (NOLOCK) on T1.SectionID = T2.AnaID and T2.AnaTypeID = 'A04'

-- Update ten Cong doan: ProcessName
Update	T1
set		T1.ProcessName = T2.AnaName
from	#HP0383 T1
inner join AT1011 T2 WITH (NOLOCK) on T1.ProcessID = T2.AnaID and T2.AnaTypeID = 'A05'


-- Update trạng thái/chế độ
Update	T1
set		T1.StatusID = CASE WHEN ISNULL(T2.EmployeeMode,'') <> '' THEN  T2.EmployeeMode ELSE T2.EmployeeStatus END
from	#HP0383 T1
left join HT1414 T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
WHERE	@Date BETWEEN ISNULL(T2.BeginDate,T1.WorkDate) AND Isnull(T2.EndDate,@Date) 

Update	T1
set		T1.Status = T2.EmployeeStatusName
from	#HP0383 T1
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
from	#HP0383 T1

--- Update ten chuc danh: TitleName
--- Tính số giờ công tiêu chuẩn
Update	T1
set		T1.TitleName = T2.TitleName,
		T1.StandardAmount = T2.StandardAbsentAmount
from	#HP0383 T1
inner join HT1106 T2 WITH (NOLOCK) on T1.TitleID = T2.TitleID and T1.DivisionID = T2.DivisionID

--- Tính số giờ công thực tế
Update	T1
set		T1.ActualAmount = T2.ActualAmount
from	#HP0383 T1
inner join (
		SELECT	DivisionID, EmployeeID, SUM(AbsentAmount) AS ActualAmount
		FROM	HT2401
		WHERE	TranMonth = @TranMonth AND TranYear = @TranYear AND DivisionID = @DivisionID				
		GROUP BY DivisionID, EmployeeID
		) T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID


---- Tính số lần quên quẹt thẻ
Update	T1
set		T1.ForgetScanTimes = T2.Times
from	#HP0383 T1
inner join (
		SELECT	DivisionID, EmployeeID, Count(EmployeeID) AS Times
		FROM	OOT2060
		WHERE	TranMonth = @TranMonth AND TranYear = @TranYear	AND Fact = 'BT0001' AND DivisionID = @DivisionID			 	
		GROUP BY DivisionID, EmployeeID
		) T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID

--- Tính số phép năm còn dư
UPDATE T1
set		T1.RemainDay = T2.DaysRemained
from	#HP0383 T1
inner join HT2803 T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
					AND T2.TranMonth = @TranMonth AND T2.TranYear = @TranYear

-- Tính số giờ NB còn dư
UPDATE T1
set		T1.RemainHours = T2.AbsentHour
from	#HP0383 T1
inner join
(
SELECT T1.EmployeeID, T1.DivisionID,
		SUM(CASE WHEN T2.UnitID = 'H' THEN AbsentAmount ELSE AbsentAmount/@TimeConvert END  ) AS AbsentHour
FROM HT2401 T1
LEFT JOIN HT1013 T2 ON T1.DivisionID = T2.DivisionID AND T1.AbsentTypeID = T2.AbsentTypeID
WHERE T2.TypeID = 'NB' AND T1.TranMonth = @TranMonth AND T1.TranYear = @TranYear AND T1.DivisionID = @DivisionID
GROUP BY T1.EmployeeID, T1.DivisionID
) T2  ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID


CREATE TABLE #AbsentType (DataID Varchar(10), AbsentTypeID Varchar(50))
--Create Table #tmpFromToAbsentType (DataID Varchar(10), FromAbsentTypeID Varchar(50),ToAbsentTypeID Varchar(50))

SELECT @SQL01 = '', @i = 1, @N = 25
WHILE (@i <= 25)
BEGIN
	IF @i < 10 SET @si = LTRIM(RTRIM('0' + CONVERT(VARCHAR(10), @i)))
	ELSE SET @si = LTRIM(RTRIM(CONVERT(VARCHAR(10), @i)))

	SET @SQL01 = '
		DECLARE @AbsentTypeFrom Varchar(50), @AbsentTypeTo Varchar(50)

		--SELECT @AbsentTypeFrom = Min(FromAbsentTypeID), @AbsentTypeTo = Max(ToAbsentTypeID)
		--FROM	HT0383 
		--WHERE	DivisionID = '''+@DivisionID+''' AND ReportID = '''+@ReportID+''' AND DataTypeID =  ''Amount'+@si+'''
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
		FROM	#HP0383 T1
		INNER JOIN
		(
		SELECT	HT2401.DivisionID, HT2401.EmployeeID, 
				-- SUM(AbsentHour) AS Amount
				SUM(CASE WHEN HT1013.UnitID = ''H'' THEN HT2401.AbsentAmount ELSE HT2401.AbsentAmount/'+STR(@TimeConvert)+' END  ) AS Amount
		FROM	HT2401
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

SELECT * FROM #HP0383 order by EmployeeID
DROP TABLE #HP0383

END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
