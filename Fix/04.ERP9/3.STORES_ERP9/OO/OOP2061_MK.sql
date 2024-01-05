IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2061_MK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2061_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










 
 -- <Summary>
 ---- 
 ---- Load dữ liệu bất thường
 -- <Param>
 ----  
 /*
 'BT0001' : Quên quẹt thẻ
 'BT0002' : Đi trễ về sớm
 'BT0003' : Bỏ làm
 'BT0006' : Khác (không phân ca nhưng có dữ liệu quét thẻ)
 */
-- <Return>
---- 
-- <Reference> 
---- Chạy tự động vào 8h sáng hàng ngày
-- <History>
----Created by: Phương Thảo, Date: 17/02/2016
---- Modify by Phương Thảo on 23/02/2016: Chỉnh sửa store, bổ sung trường hợp OT và ca đêm
---- Modify by Phương Thảo on 31/03/2016: Bỏ không xét trường hợp OT
---- Modify by Phương Thảo on 14/06/2016: Bỏ vòng lặp, cải tiến tốc độ. Bổ sung loại bất thường "Sai ca làm việc"
---- Modify on 20/08/2016 by Phương Thảo: Bổ sung xử lý tách bảng nghiệp vụ
---- Modify on 12/12/2016 by Phương Thảo: Bổ sung bất thường kiến nghị
---- Modify on 19/10/2020 by Huỳnh Thử:   Lấy thêm ngày xin quẹt thẻ ra của ngày cuối tháng tăng ca
---- Modify on 26/04/2023 by Nhựt Trường: Bổ sung điều kiện check có tồn tại bảng @HT2408_02 hay không để thực hiện Union All.
---- Modify on 29/06/2023 by Kiều Nga: Fix lỗi chạy bất thường chấm công trên HRM không hiển thị lên hết dữ liệu.
/*-- <Example>
	OOP2061 @DivisionID='CTY',@UserID='ASOFTADMIN', @TranMonth=9, @TranYear=2015, @Date=1
----*/
 
CREATE PROCEDURE OOP2061_MK
 ( 
   @DivisionID NVARCHAR(50),
   @UserID NVARCHAR(50),
   @TranMonth INT,
   @TranYear INT,
   @Date Datetime,
   @ToDate Datetime
 ) 
 AS
 SET NOCOUNT ON
 DECLARE @sSQLTime NVARCHAR(MAX),
		 @sSQL NVARCHAR(MAX),
		 @sSQL1 NVARCHAR(MAX),
		 @sSQL1_1 NVARCHAR(MAX),
		 @sSQL2 NVARCHAR(MAX),
		 @sSQL3 VARCHAR(MAX),
		 @sSQL31 VARCHAR(MAX),
		 @sSQL4 VARCHAR(MAX),
		 @sSQL5 VARCHAR(MAX),
		 @sSQL51 VARCHAR(MAX),
		 @sSQL6 VARCHAR(MAX),
		 @sSQL7 VARCHAR(MAX),
		 @sSQL8 VARCHAR(MAX),
		 @sSQL9 VARCHAR(MAX),
		 @sSQL10 VARCHAR(MAX),
		 @sSQL11 VARCHAR(MAX),
 		 @ColDay NVARCHAR(3),
		 @sDay NVARCHAR(2),		
		 @Times Int, 
		 @i Int,
		 @FromDate Datetime
 
DECLARE	@TableHT2408 Varchar(50),		
		@sTranMonth Varchar(2),
		@sTranMonth_02 Varchar(2),
		@TableHT2408_02 NVARCHAR(50)

SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END
SELECT @sTranMonth_02 = CASE WHEN @TranMonth + 1 >9 THEN Convert(Varchar(2),@TranMonth + 1) ELSE '0'+Convert(Varchar(1),@TranMonth + 1) END


IF EXISTS (SELECT TOP 1 1 FROM AT0001 WHERE IsSplitTable = 1)	
BEGIN
	SET  @TableHT2408 = 'HT2408M'+@sTranMonth+Convert(Varchar(4),@TranYear)
	SET  @TableHT2408_02 = 'HT2408M'+@sTranMonth_02+Convert(Varchar(4),@TranYear)
END
ELSE
BEGIN
	SET  @TableHT2408 = 'HT2408'
END		

Select @Times = DATEDIFF(d,@Date,@ToDate)+1,
		@FromDate = @Date
SET @i = 1

CREATE TABLE #HP2061_HT1025 (OrderNo INT IDENTITY(1,1),   DivisionID Nvarchar(50), ShiftID Nvarchar (50), EmployeeID NVarchar(50), 
							AbsentDate Datetime, DateTypeID Varchar(3) ) 
							
CREATE TABLE #HP2061_HT1021 (OrderNo INT IDENTITY(1,1),   DivisionID Nvarchar(50), ShiftID Nvarchar (50), EmployeeID NVarchar(50),
							AbsentTime time, IOCode Tinyint, OrderNo2 Int, TypeID nvarchar (50), IsNextDay Tinyint, 
							AbsentDate datetime, WorkingDate datetime ) 

CREATE TABLE #HP2061_HT2408 (OrderNo INT IDENTITY(1,1), DivisionID Nvarchar(50), EmployeeID nvarchar (50), TranMonth int, TranYear int, AbsentCardNo nvarchar (50),
							AbsentDate datetime, AbsentTime time, MachineCode nvarchar (50), ShiftCode nvarchar (50), IOCode tinyint, InputMethod tinyint, OrderNo2 Int, WorkingDate datetime) 

WHILE (@i <= @Times)
BEGIN
	IF Day(@FromDate) < 10 SET @sDay = '0' + CONVERT(NVARCHAR, Day(@FromDate))
	 ELSE SET @sDay = CONVERT(NVARCHAR, Day(@Date))

	IF Day(@FromDate) < 10 SET @sDay = '0' + CONVERT(NVARCHAR, Day(@FromDate))
		ELSE SET @sDay = CONVERT(NVARCHAR, Day(@FromDate))

	--SELECT @ColDay = CASE WHEN Isnull(@ColDay,'') <> '' THEN  Isnull(@ColDay,'')  +  ',''D'+@sDay+'''' ELSE '''D'+@sDay+'''' END	
	SELECT @ColDay = 'D'+@sDay

	SELECT @sSQL = '
	INSERT INTO #HP2061_HT1025 (DivisionID, EmployeeID, ShiftID, AbsentDate, DateTypeID	)
	SELECT	T1.DivisionID, T1.EmployeeID, '+@ColDay+' AS ShiftID, '''+Convert(Varchar(20),@FromDate,101)+''' AS AbsentDate,
			CASE WHEN ISNULL(Holiday,'''') <> '''' THEN  
				CASE WHEN Isnull(T2.IsTimeOff,0) = 0 THEN ''HOL''  ELSE ''SUN'' END 
			ELSE LEFT(DateName(dw,'''+Convert(NVarchar(10),@FromDate,101)+'''),3) 
			END AS DateTypeID
	FROM	HT1025 T1
	LEFT JOIN HT1026 T2 ON T1.DivisionID = T2.DivisionID AND T1.Tranyear = T2.TranYear AND Holiday = '''+Convert(NVarchar(10),@FromDate,101)+''' 
	WHERE  T1.DivisionID='''+@DivisionID+'''		
		AND T1.TranMonth='+STR(@TranMonth)+'	
		AND T1.TranYear='+STR(@TranYear)+'
		--AND EmployeeID = ''011659''
		--AND 
		--(
		--NOT EXISTS (SELECT TOP 1 1 FROM HT2401_MK T2 WHERE T1.DivisionID = T2.DivisionID  
		--	 										AND T1.EmployeeID = T2.EmployeeID AND T2.AbsentDate = '''+Convert(NVarchar(10),@FromDate,101)+''')
		--)			
	'
	Print @sSQL
	EXEC (@sSQL)
	SET @FromDate = @FromDate + 1
	SET @i = @i + 1
END

SET @sSQL1 = N'

INSERT INTO #HP2061_HT1021 ( DivisionID, EmployeeID, ShiftID, AbsentTime, IOCode, OrderNo2, TypeID, IsNextDay, AbsentDate, WorkingDate)
SELECT	T.DivisionID, T.EmployeeID, T.ShiftID, T.AbsentTime, T.IOCode, 
		(row_number( )over(partition by  T.IOCode order by  T.AbsentTime)) As OrderNo2, HT1013.TypeID, T.IsNextDay, 
		T.AbsentDate, T.AbsentDate AS WorkingDate
FROM (
		SELECT T1.DivisionID, T1.EmployeeID, T1.ShiftID, Convert(Time,T2.FromMinute) AS AbsentTime, 0 AS IOCode, T2.AbsentTypeID, 
				CASE WHEN (T2.IsNextDay = 1 AND Convert(int,LEFT(T2.FromMinute,2))<12) THEN 1  ELSE 0  END AS IsNextDay, T1.AbsentDate
		FROM  #HP2061_HT1025 T1
		INNER JOIN  HT1021 T2 ON T1.DivisionID = T2.DivisionID AND T1.ShiftID = T2.ShiftID AND T1.DateTypeID = T2.DateTypeID			
		UNION ALL
		SELECT T1.DivisionID, T1.EmployeeID, T1.ShiftID, Convert(Time,T2.ToMinute) AS AbsentTime, 1 AS IOCode, T2.AbsentTypeID, 
				CASE WHEN (T2.IsNextDay = 1 AND Convert(int,LEFT(T2.ToMinute,2))<12) THEN 1  ELSE 0  END AS IsNextDay, T1.AbsentDate
		FROM   #HP2061_HT1025 T1
		INNER JOIN  HT1021 T2 ON T1.DivisionID = T2.DivisionID AND T1.ShiftID = T2.ShiftID AND T1.DateTypeID = T2.DateTypeID					
		) T
LEFT JOIN HT1013 On T.DivisionID = HT1013.DivisionID And T.AbsentTypeID = HT1013.AbsentTypeID
LEFT JOIN HT1020 On T.DivisionID = HT1020.DivisionID And T.ShiftID = HT1020.ShiftID
WHERE Isnull(IsAbsentShift,0) = 0
ORDER BY IsNextDay, AbsentDate, AbsentTime

	
UPDATE #HP2061_HT1021
set AbsentDate = AbsentDate + 1
WHERE IsNextDay = 1


SELECT DivisionID, AbsentDate, WorkingDate, EmployeeID, MAX(IsNextDay) AS IsNextDay, ShiftID
INTO #HP2061_HT1021_IsNextDay
FROM	#HP2061_HT1021
--WHERE Isnull(ShiftID,'''') <> ''''
GROUP BY DivisionID, AbsentDate, WorkingDate, EmployeeID, ShiftID

INSERT INTO #HP2061_HT2408 (DivisionID, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, AbsentTime, 
								MachineCode, ShiftCode, IOCode, InputMethod, OrderNo2, WorkingDate)
SELECT	DivisionID, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, 
		Convert(Time,AbsentTime) AS AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod,
		(row_number( )over(partition by  IOCode order by  Convert(Time,AbsentTime))) As OrderNo2, AbsentDate AS WorkingDate 
FROM '+@TableHT2408+' T1
WHERE 
(
	EXISTS (SELECT TOP 1 1 FROM #HP2061_HT1021_IsNextDay T2 
			WHERE T1.DivisionID = T2.DivisionID  
			 		AND T1.EmployeeID = T2.EmployeeID AND T2.IsNextDay = 0 AND T1.AbsentDate = T2.AbsentDate
			) 
	OR EXISTS (	SELECT TOP 1 1 FROM #HP2061_HT1021_IsNextDay T2 
			WHERE T1.DivisionID = T2.DivisionID 
			 	AND T1.EmployeeID = T2.EmployeeID AND T2.IsNextDay = 1 
				AND T1.AbsentDate BETWEEN T2.AbsentDate AND DateAdd(d,1,T2.AbsentDate)
			) 	
)

AND DivisionID = '''+@DivisionID+''' -- and TranMonth = '+STR(@TranMonth)+' and TranYear = '+STR(@TranYear)+'
--ORDER BY AbsentDate, Convert(Time,AbsentTime) 


'

IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(@TableHT2408_02) AND TYPE IN (N'U'))
 -- Lấy thêm ngày xin quẹt thẻ ra của ngày cuối tháng tăng ca
BEGIN
	SET @sSQL1_1 = @sSQL1_1 + '
	UNION ALL
	SELECT	DivisionID, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, 
			Convert(Time,AbsentTime) AS AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod,
			(row_number( )over(partition by  IOCode order by  Convert(Time,AbsentTime))) As OrderNo2, AbsentDate AS WorkingDate 
	FROM '+@TableHT2408_02+' T1
	WHERE 
	(
		EXISTS (SELECT TOP 1 1 FROM #HP2061_HT1021_IsNextDay T2 
				WHERE T1.DivisionID = T2.DivisionID  
			 			AND T1.EmployeeID = T2.EmployeeID AND T2.IsNextDay = 0 AND T1.AbsentDate = T2.AbsentDate
				) 
		OR EXISTS (	SELECT TOP 1 1 FROM #HP2061_HT1021_IsNextDay T2 
				WHERE T1.DivisionID = T2.DivisionID 
			 		AND T1.EmployeeID = T2.EmployeeID AND T2.IsNextDay = 1 
					AND T1.AbsentDate BETWEEN T2.AbsentDate AND DateAdd(d,1,T2.AbsentDate)
				) 	
	)

	AND DivisionID = '''+@DivisionID+'''
	AND DAY(T1.AbsentDate) = 1 AND T1.IOCode = 1 AND T1.IsAO = 1
	 -- and TranMonth = '+STR(@TranMonth+1)+' and TranYear = '+STR(@TranYear+1)+'
	
	ORDER BY AbsentDate, Convert(Time,AbsentTime)'
END

SET @sSQL1_1 = '
		UPDATE T1
	SET		T1.WorkingDate = T1.WorkingDate - 1
	FROM #HP2061_HT2408 T1
	LEFT JOIN #HP2061_HT1021 T2 ON T1.DivisionID = T2.DivisionID  
			 		  AND T1.EmployeeID = T2.EmployeeID AND T1.AbsentDate = T2.AbsentDate
	WHERE Isnull(T2.IsNextDay,0) = 1
	 AND T1.IOCode = 1 
	 AND Convert(int,LEFT(T1.AbsentTime,2))<(select top 1 Convert(int,LEFT(begintime,2)) from HT1020 where HT1020.ShiftID = T2.ShiftID)

	DELETE T1
	FROM #HP2061_HT2408 T1
	WHERE EXISTS (SELECT TOP 1 1 FROM #HP2061_HT1021_IsNextDay T2 
				WHERE T1.DivisionID = T2.DivisionID  
			 			AND T1.EmployeeID = T2.EmployeeID AND T2.IsNextDay = 1 
						AND T1.IOCode = 1 AND 	T1.WorkingDate = T2.WorkingDate AND T1.AbsentDate <> T2.AbsentDate
						AND Convert(int,LEFT(T1.AbsentTime,2))< (select top 1 Convert(int,LEFT(begintime,2)) from HT1020 where HT1020.ShiftID = T2.ShiftID)
				) 
'

SET @sSQL2 = N'	
SELECT	DivisionID, EmployeeID, WorkingDate AS AbsentDate, IOCode,
		CASE WHEN IOCode = 0 THEN MIN(AbsentDate+Cast(AbsentTime as Datetime)) ELSE MAX(AbsentDate+Cast(AbsentTime as Datetime))  END AS AbsentTime,
		ShiftID, Max(IsNextDay) AS IsNextDay
INTO #HT1021_Time
FROM #HP2061_HT1021 T1
GROUP BY DivisionID, EmployeeID, WorkingDate, IOCode, ShiftID 


SELECT T1.DivisionID, T1.EmployeeID, WorkingDate AS AbsentDate, IOCode, 
		CASE WHEN IOCode = 0 THEN MIN(T1.AbsentDate+Cast(T1.AbsentTime as Datetime)) 
		ELSE MAX(T1.AbsentDate+Cast(T1.AbsentTime as Datetime))  END AS AbsentTime		
INTO  #HT2408_Time
FROM #HP2061_HT2408 T1
GROUP BY DivisionID, EmployeeID, WorkingDate, IOCode
	
--select ''#HP2061_HT1021'', * from #HP2061_HT1021 order by EmployeeID, AbsentDate, AbsentTime 
--select ''#HP2061_HT2408'', * from #HP2061_HT2408 order by EmployeeID, AbsentDate, AbsentTime 
select ''#HT1021_Time'', * from #HT1021_Time 
select  ''#HT2408_Time'', *  from #HT2408_Time 

'
print @sSQL1
print @sSQL2

--EXEC (@sSQL1+@sSQL2)

-- return
SET @sSQL31 = N'
---------- Tạo dữ liệu đơn xin phép để xet bất thường kiến nghị ----------------
SELECT	row_number( )over(partition by APKMaster  order by  APKMaster, T1.EmployeeID,  T1.AbsentDate) as orderno,
 
		T1.EmployeeID, T1.AbsentDate, CASE WHEN Min(T1.IOCode) = 0 THEN MIN (T1.AbsentTime) END AS BeginTime, 
		CASE WHEN Max(T1.IOCode) = 1 THEN Max (AbsentTime) END AS EndTime,
		T2.APKMaster, T2.LeaveFromDate AS LeaveFromDate, T2.LeaveToDate AS LeaveToDate
INTO #OOT2010
FROM #HT1021_Time T1
INNER JOIN OOT2010 T2  ON Convert(Date,T1.AbsentDate) BETWEEN ISNULL(Convert(Date,T2.FromWorkingDate),Convert(Date,T2.LeaveFromDate)) AND ISNULL(Convert(Date,T2.ToWorkingDate),Convert(Date,T2.LeaveToDate))
						AND T1.DivisionID = T2.DivisionID
						AND T1.EmployeeID = T2.EmployeeID
INNER JOIN OOT9000 T3 ON T2.APKMaster = T3.APK AND T2.DivisionID = T3.DivisionID
				WHERE T2.Status = 1 AND T3.Status = 1
GROUP BY T1.EmployeeID, T1.AbsentDate, T2.APKMaster, T2.LeaveFromDate , T2.LeaveToDate
Order by T2.APKMaster, T1.EmployeeID,  T1.AbsentDate
--select * from #OOT2010_KN

UPDATE T1
SET	T1.BeginTime = T2.LeaveFromDate	
FROM #OOT2010 T1
INNER JOIN
(
	SELECT MIN(OrderNo) AS OrderNo, EmployeeID, APKMaster,LeaveFromDate
	FROM	#OOT2010
	GROUP BY EmployeeID, APKMaster, LeaveFromDate
) T2 ON T1.EmployeeID = T2.EmployeeID AND T1.APKMaster = T2.APKMaster AND T1.OrderNo = T2.OrderNo


UPDATE T1
SET	T1.EndTime = T2.LeaveToDate	
FROM #OOT2010 T1
INNER JOIN
(
	SELECT MAX(OrderNo) AS OrderNo, EmployeeID, APKMaster,LeaveToDate
	FROM	#OOT2010
	GROUP BY EmployeeID, APKMaster,LeaveToDate
) T2 ON T1.EmployeeID = T2.EmployeeID AND T1.APKMaster = T2.APKMaster AND T1.OrderNo = T2.OrderNo
 
 --select * from #OOT2010
UPDATE	T1
SET		T1.AbsentTime = T2.BeginTime
FROM	#HT1021_Time T1
INNER JOIN #OOT2010 T2 ON T1.EmployeeID = T2.EmployeeID AND T1.AbsentDate = T2.AbsentDate AND T1.AbsentTime = T2.EndTime
WHERE T1.IOCode = 1 

UPDATE	T1
SET		T1.AbsentTime = T2.EndTime
FROM	#HT1021_Time T1
INNER JOIN #OOT2010 T2 ON T1.EmployeeID = T2.EmployeeID AND T1.AbsentDate = T2.AbsentDate AND T1.AbsentTime = T2.BeginTime
WHERE T1.IOCode = 0 


------------############# BẮT ĐẦU INSERT DỮ LIỆU VÀO BẢNG BẤT THƯỜNG ############## -------------------
DELETE T1 
FROM OOT2060 T1
--INNER JOIN #HT1021_Time T2 ON 
--						  T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID					 								
WHERE	T1.WorkingDate between '''+Convert(NVarchar(10),@Date,101)+''' and '''+Convert(NVarchar(10),@ToDate,101)+'''
		AND T1.TranYear='+STR(@TranYear)+' AND T1.TranMonth='+STR(@TranMonth)+'
		AND Status = 0
		AND ISNULL(JugdeUnusualType,'''') = ISNULL(Fact,'''')
		--AND T1.EmployeeID = ''006729''	
'

SET @sSQL3 = N'
------------ ********** BỔ SUNG XỬ LÝ LOẠI BẤT THƯỜNG KIẾN NGHỊ : ''KN'' *************** ------------------------

-- ** Loai kien nghi 1: Có đơn xin nghỉ phép nhưng lại có dữ liệu quẹt thẻ đi làm (có quẹt vào và quẹt ra) 
IF EXISTS (
			SELECT	TOP 1 1
			FROM	
			 (	SELECT  T2.*, T1.LeaveFromDate, T1.LeaveToDate
				FROM	#OOT2010 T1
				INNER JOIN 
				(
				SELECT T1.EmployeeID, T1.AbsentDate, CASE WHEN Min(T1.IOCode) = 0 THEN MIN (T1.AbsentTime) END AS BeginTime, 
				CASE WHEN Max(T1.IOCode) = 1 THEN Max (AbsentTime) END AS EndTime
				FROM #HT2408_Time T1				
				GROUP BY T1.EmployeeID, T1.AbsentDate
				)T2 
					ON	T1.AbsentDate = T2.AbsentDate AND T1.EmployeeID = T2.EmployeeID
				WHERE 			
					T1.LeaveFromDate BETWEEN T2.BeginTime AND T2.EndTime
					AND T1.LeaveToDate BETWEEN T2.BeginTime AND T2.EndTime
					AND T1.EmployeeID = T2.EmployeeID				
			 ) T			
		)
BEGIN
	INSERT INTO OOT2060 (DivisionID, TranMonth, TranYear, EmployeeID, [Date], [Status],  BeginTime, EndTime, ActBeginTime, ActEndTime,
						Fact, JugdeUnusualType,HandleMethodID,DeleteFlag, WorkingDate, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	SELECT	'''+@DivisionID+''', '+STR(@TranMonth)+',  '+STR(@TranYear)+', EmployeeID, Convert(Date,AbsentDate) AS [Date], 0,  
			--Convert(Time,Min(LeaveFromDate)) AS BeginTime, Convert(Time,Max(LeaveToDate)) AS EndTime, 
			--CASE WHEN Min(IOCode) = 0 THEN Convert(Time,Min(AbsentTime)) END AS ActBeginTime,
			--CASE WHEN Max(IOCode) = 1 THEN Convert(Time,Max(AbsentTime)) END AS ActEndTime,	
			Convert(Time,LeaveFromDate) AS BeginTime, Convert(Time,LeaveToDate) AS EndTime,
			BeginTime AS ActBeginTime, EndTime AS ActEndTime,			
			''KN1'', ''KN'',  '''', 0,  Convert(Date,AbsentDate) AS WorkingDate, '''+@UserID+''', GETDATE(), '''+@UserID+''', GETDATE()
	FROM	
		(	SELECT  T2.*, T1.LeaveFromDate, T1.LeaveToDate
			FROM	#OOT2010 T1
			INNER JOIN 
			(
			SELECT T1.DivisionID, T1.EmployeeID, T1.AbsentDate, CASE WHEN Min(T1.IOCode) = 0 THEN MIN (T1.AbsentTime) END AS BeginTime, 
			CASE WHEN Max(T1.IOCode) = 1 THEN Max (AbsentTime) END AS EndTime
			FROM #HT2408_Time T1				
			GROUP BY T1.DivisionID, T1.EmployeeID, T1.AbsentDate
			)T2 
				ON	T1.AbsentDate = T2.AbsentDate AND T1.EmployeeID = T2.EmployeeID
			INNER JOIN 
			(
				SELECT A.DivisionID, EmployeeID, AbsentDate, ISNULL(Count(IOCode),0) AS CountHT1021
				FROM	#HT1021_Time A
				INNER JOIN HT1020 B ON A.ShiftID = B.ShiftID								
				WHERE ISNULL(B.IsShiftOff,0) = 0
				GROUP BY A.DivisionID, EmployeeID, AbsentDate 
				
			) T3 ON T2.DivisionID = T3.DivisionID AND T2.EmployeeID = T3.EmployeeID AND T2.AbsentDate = T3.AbsentDate AND CountHT1021 > 0
			WHERE  			
				T1.LeaveFromDate BETWEEN T2.BeginTime AND T2.EndTime
				AND T1.LeaveToDate BETWEEN T2.BeginTime AND T2.EndTime
				AND T1.EmployeeID = T2.EmployeeID				
		) T1
	WHERE NOT EXISTS (SELECT TOP 1 1  FROM OOT2060 WHERE OOT2060.TranYear='+STR(@TranYear)+' AND OOT2060.TranMonth='+STR(@TranMonth)+' 
								AND OOT2060.WorkingDate between '''+Convert(NVarchar(10),@Date,101)+''' and '''+Convert(NVarchar(10),@ToDate,101)+'''
								AND OOT2060.JugdeUnusualType = ''KN'' 
								AND ( OOT2060.Status = 1 OR ISNULL(JugdeUnusualType,'''') <> ISNULL(Fact,''''))
								AND OOT2060.DivisionID = T1.DivisionID AND OOT2060.EmployeeID = T1.EmployeeID AND OOT2060.Date = T1.AbsentDate)
	--GROUP BY EmployeeID, Convert(Date,AbsentDate)	
END		

'

SET @sSQL4 = N'
-- ** Loai kien nghi 2: Có sắp ca (đây là ca nghỉ) và có dữ liệu giờ vào giờ ra (giờ ra – giờ vào > 4) 
IF EXISTS (
			SELECT TOP 1 1
			FROM 
			 (
				SELECT DivisionID, EmployeeID, AbsentDate, Datediff(hh, Max(AbsentTime), Min(AbsentTime)) AS Time
				FROM	#HT2408_Time
				GROUP BY DivisionID, EmployeeID, AbsentDate 
			) T1
			LEFT JOIN 
			(
				SELECT A.DivisionID, EmployeeID, AbsentDate, ISNULL(Count(IOCode),0) AS CountHT1021
				FROM	#HT1021_Time A
				INNER JOIN HT1020 B ON A.ShiftID = B.ShiftID								
				WHERE B.IsShiftOff = 1
				GROUP BY A.DivisionID, EmployeeID, AbsentDate 
				
			) T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.AbsentDate = T2.AbsentDate
			WHERE  T1.Time >= 4  AND Isnull(T2.CountHT1021,0) <> 0
		)
BEGIN	
		INSERT INTO OOT2060 (DivisionID, TranMonth, TranYear, EmployeeID, [Date], [Status], Fact, 
									JugdeUnusualType, HandleMethodID,DeleteFlag, WorkingDate, BeginTime, EndTime, IOCode,
									ActBeginTime, ActEndTime, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT	 A.DivisionID, '+STR(@TranMonth)+',  '+STR(@TranYear)+', A.EmployeeID, Convert(Date,A.AbsentTime) AS AbsentDate, 0, 
				 ''KN2'', ''KN'', '''',
				0, A.AbsentDate, Convert(Time,A.AbsentTime) AS BeginTime,  Convert(Time,A.AbsentTime) AS EndTime, A.IOCode,
				Convert(Time,A.AbsentTime) AS ActBeginTime,  Convert(Time,A.AbsentTime) AS ActEndTime,
				'''+@UserID+''', GETDATE(), '''+@UserID+''', GETDATE()
		FROM 	#HT2408_Time A
		WHERE 
		EXISTS (	SELECT TOP 1 1
					FROM 
					(
						 SELECT T1.DivisionID, T1.EmployeeID, T1.AbsentDate
						 FROM 
						 (
							SELECT DivisionID, EmployeeID, AbsentDate, Datediff(hh, Max(AbsentTime), Min(AbsentTime)) AS Time
							FROM	#HT2408_Time
							GROUP BY DivisionID, EmployeeID, AbsentDate 
						) T1
						LEFT JOIN 
						(
							SELECT A.DivisionID, EmployeeID, AbsentDate, ISNULL(Count(IOCode),0) AS CountHT1021
							FROM	#HT1021_Time A
							INNER JOIN HT1020 B ON A.ShiftID = B.ShiftID								
							WHERE B.IsShiftOff = 1
							GROUP BY A.DivisionID, EmployeeID, AbsentDate 
				
						) T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.AbsentDate = T2.AbsentDate
						WHERE  T1.Time >= 4  AND Isnull(T2.CountHT1021,0) <> 0				
					) B 
					 WHERE A.DivisionID = B.DivisionID AND A.EmployeeID = B.EmployeeID AND A.AbsentDate = B.AbsentDate
				)
		AND  NOT EXISTS (SELECT TOP 1 1  FROM OOT2060 WHERE OOT2060.TranYear='+STR(@TranYear)+' AND OOT2060.TranMonth='+STR(@TranMonth)+' 
								AND OOT2060.WorkingDate between '''+Convert(NVarchar(10),@Date,101)+''' and '''+Convert(NVarchar(10),@ToDate,101)+'''
								AND OOT2060.JugdeUnusualType = ''KN'' 
								AND ( OOT2060.Status = 1 OR ISNULL(JugdeUnusualType,'''') <> ISNULL(Fact,''''))
								AND OOT2060.DivisionID = A.DivisionID AND OOT2060.EmployeeID = A.EmployeeID AND OOT2060.Date = A.AbsentDate)
	
END 
--- Sai ca lam viec
IF (	
	EXISTS (
		SELECT TOP 1 1
		FROM 	#HT1021_Time A
		WHERE
'

--- Bat thuong sai ca lam viec
SET @sSQL51 = N'	

		EXISTS (	SELECT TOP 1 1 
			FROM
			(SELECT T1.DivisionID, T1.EmployeeID, T1.AbsentDate
				FROM 
				(SELECT DivisionID, EmployeeID, AbsentDate, ISNULL(Count(IOCode),0) AS CountHT1021
				FROM	#HT1021_Time
				GROUP BY DivisionID, EmployeeID, AbsentDate 
				) T1
				LEFT JOIN 
				(
					SELECT DivisionID, EmployeeID, AbsentDate, ISNULL(Count(IOCode),0) AS CountHT2408
					FROM	#HT2408_Time
					GROUP BY DivisionID, EmployeeID, AbsentDate 
				) T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.AbsentDate = T2.AbsentDate 
				WHERE  T1.CountHT1021 = 2  AND T2.CountHT2408 = 2
			) B WHERE A.DivisionID = B.DivisionID AND A.EmployeeID = B.EmployeeID AND A.AbsentDate = B.AbsentDate
		)		
		AND EXISTS
				(		SELECT TOP 1 1
						FROM	 #HT2408_Time B1
						--LEFT JOIN  #HP2061_HT1021_IsNextDay B2 ON B1.DivisionID = B2.DivisionID AND B1.EmployeeID = B2.EmployeeID AND B1.AbsentDate = B2.AbsentDate
						WHERE  A.DivisionID = B1.DivisionID AND A.EmployeeID = B1.EmployeeID AND A.AbsentDate = B1.AbsentDate AND 
							(	( A.IsNextDay = 0 AND A.IOCode =1 AND  B1.IOCode = 1 AND (Convert(Date,A.AbsentTime) <> Convert(Date,B1.AbsentTime)) )	
							OR (A.IsNextDay = 1 AND ( (Convert(int,LEFT(Convert(Time,B1.AbsentTime),2)) < 18 AND B1.IOCode = 0) OR (Convert(int,LEFT(Convert(Time,B1.AbsentTime),2)) > 12 AND B1.IOCode = 1) ) ))
				)
		))
BEGIN
		INSERT INTO OOT2060 (DivisionID, TranMonth, TranYear, EmployeeID, [Date], [Status], Fact, 
								JugdeUnusualType,HandleMethodID,DeleteFlag, WorkingDate, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT DISTINCT '''+@DivisionID+''', '+STR(@TranMonth)+',  '+STR(@TranYear)+', A.EmployeeID, A.AbsentDate, 0, 					
				''BT0005'', ''BT0005'',''DXDC'', 0, A.AbsentDate AS WorkingDate, '''+@UserID+''', GETDATE(), '''+@UserID+''', GETDATE()
		FROM 	#HT1021_Time A
		WHERE 
		EXISTS (	SELECT TOP 1 1 
					FROM
					(SELECT T1.DivisionID, T1.EmployeeID, T1.AbsentDate
					 FROM 
						(SELECT DivisionID, EmployeeID, AbsentDate, ISNULL(Count(IOCode),0) AS CountHT1021
						FROM	#HT1021_Time
						GROUP BY DivisionID, EmployeeID, AbsentDate 
						) T1
						LEFT JOIN 
						(
							SELECT DivisionID, EmployeeID, AbsentDate, ISNULL(Count(IOCode),0) AS CountHT2408
							FROM	#HT2408_Time
							GROUP BY DivisionID, EmployeeID, AbsentDate 
						) T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.AbsentDate = T2.AbsentDate 
						WHERE  T1.CountHT1021 = 2  AND T2.CountHT2408 = 2
					) B WHERE A.DivisionID = B.DivisionID AND A.EmployeeID = B.EmployeeID AND A.AbsentDate = B.AbsentDate
				)		
		AND EXISTS
				(		SELECT TOP 1 1
						FROM	 #HT2408_Time B1
						--LEFT JOIN  #HP2061_HT1021_IsNextDay B2 ON B1.DivisionID = B2.DivisionID AND B1.EmployeeID = B2.EmployeeID AND B1.AbsentDate = B2.AbsentDate
						WHERE  A.DivisionID = B1.DivisionID AND A.EmployeeID = B1.EmployeeID AND A.AbsentDate = B1.AbsentDate AND 
							(	( A.IsNextDay = 0 AND A.IOCode =1 AND  B1.IOCode = 1 AND (Convert(Date,A.AbsentTime) <> Convert(Date,B1.AbsentTime)) )	
							OR (A.IsNextDay = 1 AND ( (Convert(int,LEFT(Convert(Time,B1.AbsentTime),2)) < 18 AND B1.IOCode = 0) OR (Convert(int,LEFT(Convert(Time,B1.AbsentTime),2)) > 12 AND B1.IOCode = 1) ) ))
				)
		AND  NOT EXISTS (SELECT TOP 1 1  FROM OOT2060 WHERE OOT2060.TranYear='+STR(@TranYear)+' AND OOT2060.TranMonth='+STR(@TranMonth)+' 
									AND OOT2060.WorkingDate between '''+Convert(NVarchar(10),@Date,101)+''' and '''+Convert(NVarchar(10),@ToDate,101)+'''
									AND OOT2060.JugdeUnusualType = ''BT0005'' 
									AND ( OOT2060.Status = 1 OR ISNULL(JugdeUnusualType,'''') <> ISNULL(Fact,''''))
									AND OOT2060.DivisionID = A.DivisionID AND OOT2060.EmployeeID = A.EmployeeID AND OOT2060.Date = A.AbsentDate)
		AND NOT EXISTS (SELECT TOP 1 1  FROM OOT2060 WHERE  OOT2060.JugdeUnusualType = ''KN'' AND OOT2060.DivisionID = A.DivisionID AND OOT2060.EmployeeID = A.EmployeeID AND OOT2060.Date = A.AbsentDate)	
		
'
SET @sSQL5 = N'	
		UPDATE T1
		SET		T1.ActBeginTime = Convert(Time,T2.AbsentTime)
		FROM	OOT2060 T1
		INNER JOIN  #HT2408_Time T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.WorkingDate = T2.AbsentDate
		WHERE T2.IOCode = 0 AND (T1.Status = 0 AND ISNULL(JugdeUnusualType,'''') = ISNULL(Fact,''''))

		UPDATE T1
		SET		T1.ActEndTime = Convert(Time,T2.AbsentTime)
		FROM	OOT2060 T1
		INNER JOIN  #HT2408_Time T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.WorkingDate = T2.AbsentDate
		WHERE T2.IOCode = 1 AND (T1.Status = 0 AND ISNULL(JugdeUnusualType,'''') = ISNULL(Fact,''''))

END
------ELSE
----Trường hợp bỏ làm	
IF EXISTS (
			SELECT TOP 1 1
			FROM
			 (
				SELECT DivisionID, EmployeeID, AbsentDate, ISNULL(Count(IOCode),0) AS CountHT1021
				FROM	#HT1021_Time
				GROUP BY DivisionID, EmployeeID, AbsentDate 
			) T1
			LEFT JOIN 
			(
				SELECT DivisionID, EmployeeID, AbsentDate, ISNULL(Count(IOCode),0) AS CountHT2408
				FROM	#HT2408_Time
				GROUP BY DivisionID, EmployeeID, AbsentDate 
			) T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.AbsentDate = T2.AbsentDate 
			WHERE T1.CountHT1021 = 2 AND ISNULL(T2.CountHT2408,0) = 0
		)
BEGIN	
		INSERT INTO OOT2060 (DivisionID, TranMonth, TranYear, EmployeeID, [Date], [Status], Fact, 
								JugdeUnusualType,HandleMethodID,DeleteFlag, WorkingDate, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT DISTINCT '''+@DivisionID+''', '+STR(@TranMonth)+',  '+STR(@TranYear)+', T1.EmployeeID, T1.AbsentDate, 0, 					
					''BT0003'', ''BT0003'',''DXP'', 0, T1.AbsentDate AS WorkingDate, '''+@UserID+''', GETDATE(), '''+@UserID+''', GETDATE()
		FROM
			 (
				SELECT DivisionID, EmployeeID, AbsentDate, ISNULL(Count(IOCode),0) AS CountHT1021
				FROM	#HT1021_Time
				GROUP BY DivisionID, EmployeeID, AbsentDate 
			) T1
			LEFT JOIN 
			(
				SELECT DivisionID, EmployeeID, AbsentDate, ISNULL(Count(IOCode),0) AS CountHT2408
				FROM	#HT2408_Time
				GROUP BY DivisionID, EmployeeID, AbsentDate 
			) T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.AbsentDate = T2.AbsentDate 
		WHERE T1.CountHT1021 = 2 AND ISNULL(T2.CountHT2408,0) = 0	
		AND  NOT EXISTS (SELECT TOP 1 1  FROM OOT2060 WHERE OOT2060.TranYear='+STR(@TranYear)+' AND OOT2060.TranMonth='+STR(@TranMonth)+' 
								AND OOT2060.WorkingDate between '''+Convert(NVarchar(10),@Date,101)+''' and '''+Convert(NVarchar(10),@ToDate,101)+'''
								AND OOT2060.JugdeUnusualType = ''BT0003'' 
								AND ( OOT2060.Status = 1 OR ISNULL(JugdeUnusualType,'''') <> ISNULL(Fact,''''))
								AND OOT2060.DivisionID = T1.DivisionID AND OOT2060.EmployeeID = T1.EmployeeID AND OOT2060.Date = T1.AbsentDate)		
		AND NOT EXISTS (SELECT TOP 1 1  FROM OOT2060 WHERE  OOT2060.JugdeUnusualType in (''KN'',''BT0005'') AND OOT2060.DivisionID = T1.DivisionID AND OOT2060.EmployeeID = T1.EmployeeID AND OOT2060.Date = T1.AbsentDate)	
		
'
SET @sSQL6 = N'	
UPDATE T1
		SET		T1.BeginTime = Convert(Time,T2.AbsentTime)
		FROM	OOT2060 T1
		INNER JOIN  #HT1021_Time T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.WorkingDate = T2.AbsentDate
		WHERE T2.IOCode = 0 AND (T1.Status = 0 AND ISNULL(JugdeUnusualType,'''') = ISNULL(Fact,''''))

		UPDATE T1
		SET		T1.EndTime = Convert(Time,T2.AbsentTime)
		FROM	OOT2060 T1
		INNER JOIN  #HT1021_Time T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.WorkingDate = T2.AbsentDate
		WHERE T2.IOCode = 1 AND (T1.Status = 0 AND ISNULL(JugdeUnusualType,'''') = ISNULL(Fact,''''))
END

----Trường hợp quên quẹt thẻ
IF EXISTS (
			SELECT TOP 1 1
			FROM
			 (
				SELECT DivisionID, EmployeeID, AbsentDate, ISNULL(Count(IOCode),0) AS CountHT1021
				FROM	#HT1021_Time
				GROUP BY DivisionID, EmployeeID, AbsentDate 
			) T1
			LEFT JOIN 
			(
				SELECT DivisionID, EmployeeID, AbsentDate, ISNULL(Count(IOCode),0) AS CountHT2408
				FROM	#HT2408_Time
				GROUP BY DivisionID, EmployeeID, AbsentDate 
			) T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.AbsentDate = T2.AbsentDate 
			WHERE  T1.CountHT1021 = 2  AND T2.CountHT2408 = 1
		)
BEGIN
		INSERT INTO OOT2060 (DivisionID, TranMonth, TranYear, EmployeeID, [Date], [Status], Fact, 
							JugdeUnusualType, HandleMethodID,DeleteFlag, WorkingDate, BeginTime, EndTime, IOCode, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT	 T1021.DivisionID, '+STR(@TranMonth)+',  '+STR(@TranYear)+', T1021.EmployeeID, Convert(Date,T1021.AbsentTime) AS AbsentDate, 0, 
				''BT0001'', ''BT0001'', ''DXBSQT'',
				0, T1021.AbsentDate, Convert(Time,T1021.AbsentTime) AS BeginTime,  Convert(Time,T1021.AbsentTime) AS EndTime, T1021.IOCode,
				'''+@UserID+''', GETDATE(), '''+@UserID+''', GETDATE()
				--,
				--Convert(Time,T2408.AbsentTime) AS ActBeginTime,  Convert(Time,T2408.AbsentTime) AS ActEndTime
		FROM 
		(	
			SELECT	DivisionID, EmployeeID,  AbsentDate, AbsentTime, IOCode
			FROM	#HT1021_Time A		
			WHERE 
			EXISTS (	SELECT TOP 1 1 
						FROM
						(SELECT T1.DivisionID, T1.EmployeeID, T1.AbsentDate
						 FROM 
							(SELECT DivisionID, EmployeeID, AbsentDate, ISNULL(Count(IOCode),0) AS CountHT1021
							FROM	#HT1021_Time
							GROUP BY DivisionID, EmployeeID, AbsentDate 
							) T1
							LEFT JOIN 
							(
								SELECT DivisionID, EmployeeID, AbsentDate, ISNULL(Count(IOCode),0) AS CountHT2408
								FROM	#HT2408_Time
								GROUP BY DivisionID, EmployeeID, AbsentDate 
							) T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.AbsentDate = T2.AbsentDate 
							WHERE  T1.CountHT1021 = 2  AND T2.CountHT2408 = 1
						) B WHERE A.DivisionID = B.DivisionID AND A.EmployeeID = B.EmployeeID AND A.AbsentDate = B.AbsentDate
					)
			AND NOT EXISTS (SELECT TOP 1 1 FROM #HT2408_Time C WHERE  A.DivisionID = C.DivisionID AND A.EmployeeID = C.EmployeeID AND  A.AbsentDate = C.AbsentDate AND A.IOCode = C.IOCode)
		) T1021
		--INNER JOIN #HT2408_Time T2408 ON T1021.DivisionID = T2408.DivisionID AND T1021.EmployeeID = T2408.EmployeeID AND T1021.AbsentDate = T2408.AbsentDate 
		WHERE  NOT EXISTS (SELECT TOP 1 1  FROM OOT2060 WHERE OOT2060.TranYear='+STR(@TranYear)+' AND OOT2060.TranMonth='+STR(@TranMonth)+' 
									AND OOT2060.WorkingDate between '''+Convert(NVarchar(10),@Date,101)+''' and '''+Convert(NVarchar(10),@ToDate,101)+'''
									AND OOT2060.JugdeUnusualType = ''BT0001'' 
									AND ( OOT2060.Status = 1 OR ISNULL(JugdeUnusualType,'''') <> ISNULL(Fact,''''))
									AND OOT2060.DivisionID = T1021.DivisionID AND OOT2060.EmployeeID = T1021.EmployeeID AND OOT2060.Date = Convert(Date,T1021.AbsentTime))
		AND NOT EXISTS (SELECT TOP 1 1  FROM OOT2060 WHERE  OOT2060.JugdeUnusualType in (''KN'',''BT0005'') AND OOT2060.DivisionID = T1021.DivisionID AND OOT2060.EmployeeID = T1021.EmployeeID AND OOT2060.Date = T1021.AbsentDate)	

	

'
SET @sSQL7 = '
	UPDATE T1
	SET		T1.ActBeginTime = Convert(Time,T2.AbsentTime)
	FROM	OOT2060 T1
	INNER JOIN  #HT2408_Time T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.WorkingDate = T2.AbsentDate
	WHERE T2.IOCode = 0 AND (T1.Status = 0 AND ISNULL(JugdeUnusualType,'''') = ISNULL(Fact,''''))

	UPDATE T1
	SET		T1.ActEndTime = Convert(Time,T2.AbsentTime)
	FROM	OOT2060 T1
	INNER JOIN  #HT2408_Time T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.WorkingDate = T2.AbsentDate
	WHERE T2.IOCode = 1 AND (T1.Status = 0 AND ISNULL(JugdeUnusualType,'''') = ISNULL(Fact,''''))

END

-- Đầy đủ dữ liệu quẹt thẻ vào ra:
------>> TH1: Bất thường đi trễ, về sớm
------>> TH2: Bất thường kiến nghị nếu làm ra quá số giờ cho phép
IF EXISTS (
			SELECT TOP 1 1
			FROM 
			 (
				SELECT DivisionID, EmployeeID, AbsentDate, ISNULL(Count(IOCode),0) AS CountHT1021
				FROM	#HT1021_Time
				GROUP BY DivisionID, EmployeeID, AbsentDate 
			) T1
			LEFT JOIN 
			(
				SELECT DivisionID, EmployeeID, AbsentDate, ISNULL(Count(IOCode),0) AS CountHT2408
				FROM	#HT2408_Time
				GROUP BY DivisionID, EmployeeID, AbsentDate 
			) T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.AbsentDate = T2.AbsentDate 
			WHERE  T1.CountHT1021 = 2  AND T2.CountHT2408 = 2
		)

BEGIN
		---- TH1: Đi trễ về sớm 

		INSERT INTO OOT2060 (DivisionID, TranMonth, TranYear, EmployeeID, [Date], [Status], Fact, 
									JugdeUnusualType, HandleMethodID,DeleteFlag, WorkingDate, BeginTime, EndTime, IOCode, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT	 A.DivisionID, '+STR(@TranMonth)+',  '+STR(@TranYear)+', A.EmployeeID, Convert(Date,A.AbsentTime) AS AbsentDate, 0, 
						''BT0002'', ''BT0002'', ''DXP'',
						0, A.AbsentDate,
						CASE WHEN B.AbsentTime <=  A.AbsentTime THEN Convert(Time,B.AbsentTime) ELSE Convert(Time,A.AbsentTime) END AS BeginTime,
						CASE WHEN B.AbsentTime >=  A.AbsentTime THEN Convert(Time,B.AbsentTime) ELSE Convert(Time,A.AbsentTime) END AS EndTime,
						A.IOCode, '''+@UserID+''', GETDATE(), '''+@UserID+''', GETDATE()
		FROM 	#HT1021_Time A
		INNER JOIN #HT2408_Time B 
						ON  A.DivisionID = B.DivisionID AND A.EmployeeID = B.EmployeeID AND A.AbsentDate = B.AbsentDate AND A.IOCode = B.IOCode
							AND ((A.IOCode = 0 AND B.AbsentTime > A.AbsentTime) OR (A.IOCode = 1 AND B.AbsentTime < A.AbsentTime))
		WHERE 
		EXISTS (	SELECT TOP 1 1 
					FROM
					(SELECT T1.DivisionID, T1.EmployeeID, T1.AbsentDate
					 FROM 
						(SELECT DivisionID, EmployeeID, AbsentDate, ISNULL(Count(IOCode),0) AS CountHT1021
						FROM	#HT1021_Time
						GROUP BY DivisionID, EmployeeID, AbsentDate 
						) T1
						LEFT JOIN 
						(
							SELECT DivisionID, EmployeeID, AbsentDate, ISNULL(Count(IOCode),0) AS CountHT2408
							FROM	#HT2408_Time
							GROUP BY DivisionID, EmployeeID, AbsentDate 
						) T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.AbsentDate = T2.AbsentDate 
						WHERE  T1.CountHT1021 = 2  AND T2.CountHT2408 = 2
					) B WHERE A.DivisionID = B.DivisionID AND A.EmployeeID = B.EmployeeID AND A.AbsentDate = B.AbsentDate
				)
		AND NOT EXISTS
				(
						SELECT TOP 1 1
						FROM	 #HT2408_Time B1
						--LEFT JOIN  #HP2061_HT1021_IsNextDay B2 ON B1.DivisionID = B2.DivisionID AND B1.EmployeeID = B2.EmployeeID AND B1.AbsentDate = B2.AbsentDate
						WHERE  A.DivisionID = B1.DivisionID AND A.EmployeeID = B1.EmployeeID AND A.AbsentDate = B1.AbsentDate AND A.IOCode =1 AND  B1.IOCode = 1
							AND (Convert(Date,A.AbsentTime) <> Convert(Date,B1.AbsentTime))	
				)
		
		'
SET @sSQL8 = N'
		AND  NOT EXISTS (SELECT TOP 1 1  FROM OOT2060 WHERE OOT2060.TranYear='+STR(@TranYear)+' AND OOT2060.TranMonth='+STR(@TranMonth)+' 
									AND OOT2060.WorkingDate between '''+Convert(NVarchar(10),@Date,101)+''' and '''+Convert(NVarchar(10),@ToDate,101)+'''
									AND OOT2060.JugdeUnusualType = ''BT0002'' 
									AND ( OOT2060.Status = 1 OR ISNULL(JugdeUnusualType,'''') <> ISNULL(Fact,''''))
									AND OOT2060.DivisionID = A.DivisionID AND OOT2060.EmployeeID = A.EmployeeID AND OOT2060.Date = Convert(Date,A.AbsentTime))
		AND NOT EXISTS (SELECT TOP 1 1  FROM OOT2060 WHERE  OOT2060.JugdeUnusualType in (''KN'',''BT0005'') AND OOT2060.DivisionID = A.DivisionID AND OOT2060.EmployeeID = A.EmployeeID AND OOT2060.Date = A.AbsentDate)	

		UPDATE T1
		SET		T1.ActBeginTime = Convert(Time,T2.AbsentTime)
		FROM	OOT2060 T1
		INNER JOIN  #HT2408_Time T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.WorkingDate = T2.AbsentDate
		WHERE T2.IOCode = 0 AND (T1.Status = 0 AND ISNULL(JugdeUnusualType,'''') = ISNULL(Fact,''''))
		
		UPDATE T1
		SET		T1.ActEndTime = Convert(Time,T2.AbsentTime)
		FROM	OOT2060 T1
		INNER JOIN  #HT2408_Time T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.WorkingDate = T2.AbsentDate
		WHERE T2.IOCode = 1 AND (T1.Status = 0 AND ISNULL(JugdeUnusualType,'''') = ISNULL(Fact,''''))

		
	'
SET @sSQL9 = '		
		---- TH2: Đi làm ra vượt quá giờ quy định (KN3)
		INSERT INTO OOT2060 (DivisionID, TranMonth, TranYear, EmployeeID, [Date], [Status], IOCode, Fact, 
							JugdeUnusualType, HandleMethodID,DeleteFlag, WorkingDate, BeginTime, EndTime, ActBeginTime, ActEndTime,
							CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT	 A.DivisionID, '+STR(@TranMonth)+',  '+STR(@TranYear)+', A.EmployeeID, A.AbsentDate AS AbsentDate, 0, 1,
				''KN3'', ''KN'', '''',
				0, A.AbsentDate,
				-- CASE WHEN MIN(A.IOCOde) = 0 THEN Convert(Time,MIN(A.AbsentTime)) END AS BeginTime, 
				NULL,
				CASE WHEN Max(A.IOCode) = 1 THEN Convert(Time,Max(A.AbsentTime)) END AS EndTime,
				-- CASE WHEN MIN(A.IOCOde) = 0 THEN Convert(Time,MIN(B.AbsentTime)) END AS ActBeginTime, 
				NULL,
				CASE WHEN Max(A.IOCode) = 1 THEN Convert(Time,Max(B.AbsentTime)) END AS ActEndTime,
				'''+@UserID+''', GETDATE(), '''+@UserID+''', GETDATE()
		FROM 	#HT1021_Time A
		INNER JOIN #HT2408_Time B 
						ON  A.DivisionID = B.DivisionID AND A.EmployeeID = B.EmployeeID AND A.AbsentDate = B.AbsentDate AND A.IOCode = B.IOCode
							AND A.IOCode = 1 AND Datediff(mi,A.AbsentTime,B.AbsentTime) > (Select top 1 MaxTimeOut From OOT0020 where DivisionID = '''+@DivisionID+''' and TranMonth = '+STR(@TranMonth)+' and TranYear = '+STR(@TranYear)+')
		WHERE 
		EXISTS (	SELECT TOP 1 1 
					FROM
					(SELECT T1.DivisionID, T1.EmployeeID, T1.AbsentDate
					 FROM 
						(SELECT DivisionID, EmployeeID, AbsentDate, ISNULL(Count(IOCode),0) AS CountHT1021
						FROM	#HT1021_Time
						GROUP BY DivisionID, EmployeeID, AbsentDate 
						) T1
						LEFT JOIN 
						(
							SELECT DivisionID, EmployeeID, AbsentDate, ISNULL(Count(IOCode),0) AS CountHT2408
							FROM	#HT2408_Time
							GROUP BY DivisionID, EmployeeID, AbsentDate 
						) T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.AbsentDate = T2.AbsentDate 
						WHERE  T1.CountHT1021 = 2  AND T2.CountHT2408 = 2
					) B WHERE A.DivisionID = B.DivisionID AND A.EmployeeID = B.EmployeeID AND A.AbsentDate = B.AbsentDate
				)
		AND NOT EXISTS
				(
						SELECT TOP 1 1
						FROM	 OOT2030 B1
						INNER JOIN OOT9000 B2 on B1.APKMaster = B2.APK AND B1.DivisionID = B2.DivisionID						
						WHERE  A.DivisionID = B1.DivisionID AND A.EmployeeID = B1.EmployeeID 
							AND A.AbsentDate between Isnull(B1.FromWorkingDate,Convert(Date,WorkFromDate)) AND Isnull(B1.ToWorkingDate,Convert(Date,WorkToDate))							
				)		
		AND  NOT EXISTS (SELECT TOP 1 1  FROM OOT2060 WHERE OOT2060.TranYear='+STR(@TranYear)+' AND OOT2060.TranMonth='+STR(@TranMonth)+' 
									AND OOT2060.WorkingDate between '''+Convert(NVarchar(10),@Date,101)+''' and '''+Convert(NVarchar(10),@ToDate,101)+'''
									AND OOT2060.JugdeUnusualType = ''KN'' 
									AND ( OOT2060.Status = 1 OR ISNULL(JugdeUnusualType,'''') <> ISNULL(Fact,''''))
									AND OOT2060.DivisionID = A.DivisionID AND OOT2060.EmployeeID = A.EmployeeID AND OOT2060.Date = Convert(Date,A.AbsentTime))		
		AND NOT EXISTS (SELECT TOP 1 1  FROM OOT2060 WHERE  OOT2060.JugdeUnusualType in (''KN'',''BT0005'') AND OOT2060.DivisionID = A.DivisionID AND OOT2060.EmployeeID = A.EmployeeID AND OOT2060.Date = A.AbsentDate)	
		GROUP BY  A.DivisionID, A.EmployeeID, A.AbsentDate	
END

'
SET @sSQL10 = '
---- Bất thường khác: Không phân ca nhưng vẫn đi làm
IF EXISTS (
			SELECT TOP 1 1
			FROM 
			 (
				SELECT DivisionID, EmployeeID, AbsentDate, ISNULL(Count(IOCode),0) AS CountHT2408
				FROM	#HT2408_Time
				GROUP BY DivisionID, EmployeeID, AbsentDate 
			) T1
			LEFT JOIN 
			(
				SELECT DivisionID, EmployeeID, AbsentDate, ISNULL(Count(IOCode),0) AS CountHT1021
				FROM	#HT1021_Time
				GROUP BY DivisionID, EmployeeID, AbsentDate 
				
			) T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.AbsentDate = T2.AbsentDate
			WHERE  T1.CountHT2408 <> 0  AND Isnull(T2.CountHT1021,0) = 0
		)
BEGIN	
		INSERT INTO OOT2060 (DivisionID, TranMonth, TranYear, EmployeeID, [Date], [Status], Fact, 
									JugdeUnusualType, HandleMethodID,DeleteFlag, WorkingDate, BeginTime, EndTime, IOCode,
									ActBeginTime, ActEndTime, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT	 A.DivisionID, '+STR(@TranMonth)+',  '+STR(@TranYear)+', A.EmployeeID, Convert(Date,A.AbsentTime) AS AbsentDate, 0, 
						''BT0006'', ''BT0006'', '''',
						0, A.AbsentDate, Convert(Time,A.AbsentTime) AS BeginTime,  Convert(Time,A.AbsentTime) AS EndTime, A.IOCode,
						Convert(Time,A.AbsentTime) AS ActBeginTime,  Convert(Time,A.AbsentTime) AS ActEndTime,
						'''+@UserID+''', GETDATE(), '''+@UserID+''', GETDATE()
		FROM 	#HT2408_Time A
		WHERE 
		EXISTS (	SELECT TOP 1 1
					FROM 
					(
						 SELECT T1.DivisionID, T1.EmployeeID, T1.AbsentDate
						 FROM 
							 (
								SELECT DivisionID, EmployeeID, AbsentDate, ISNULL(Count(IOCode),0) AS CountHT2408
								FROM	#HT2408_Time
								GROUP BY DivisionID, EmployeeID, AbsentDate 
							) T1
							LEFT JOIN 
							(
								SELECT DivisionID, EmployeeID, AbsentDate, ISNULL(Count(IOCode),0) AS CountHT1021
								FROM	#HT1021_Time
								GROUP BY DivisionID, EmployeeID, AbsentDate 
				
							) T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.AbsentDate = T2.AbsentDate 
						  WHERE  T1.CountHT2408 <> 0  AND Isnull(T2.CountHT1021,0) = 0				
					) B 
					 WHERE A.DivisionID = B.DivisionID AND A.EmployeeID = B.EmployeeID AND A.AbsentDate = B.AbsentDate
				)
		AND  NOT EXISTS (SELECT TOP 1 1  FROM OOT2060 WHERE OOT2060.TranYear='+STR(@TranYear)+' AND OOT2060.TranMonth='+STR(@TranMonth)+' 
								AND OOT2060.WorkingDate between '''+Convert(NVarchar(10),@Date,101)+''' and '''+Convert(NVarchar(10),@ToDate,101)+'''
								AND OOT2060.JugdeUnusualType = ''BT0006'' 
								AND ( OOT2060.Status = 1 OR ISNULL(JugdeUnusualType,'''') <> ISNULL(Fact,''''))
								AND OOT2060.DivisionID = A.DivisionID AND OOT2060.EmployeeID = A.EmployeeID AND OOT2060.Date = A.AbsentDate)
		AND NOT EXISTS (SELECT TOP 1 1  FROM OOT2060 WHERE  OOT2060.JugdeUnusualType in (''KN'',''BT0005'') AND OOT2060.DivisionID = A.DivisionID AND OOT2060.EmployeeID = A.EmployeeID AND OOT2060.Date = A.AbsentDate)	
	
END
'

SET @sSQL11 = '
DELETE T1 
FROM OOT2060 T1
INNER JOIN 
(	SELECT DivisionID, EmployeeID, MAX(LeaveDate) AS LeaveDate 
	FROM HT1380 T2 WITH (NOLOCK)
	GROUP BY DivisionID, EmployeeID 
) T2
ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID		
WHERE CONVERT(Date, T1.WorkingDate) >= CONVERT(Date,T2.LeaveDate)
'
--print @sSQL1
--print @sSQL2
--print @sSQL31
--print @sSQL3
--print @sSQL4
--print @sSQL51
--print @sSQL5
--print @sSQL6
--print @sSQL7
--print @sSQL8
--print @sSQL9
--print @sSQL10
--print @sSQL11
EXEC (@sSQL1+@sSQL1_1+@sSQL2+@sSQL31+@sSQL3+@sSQL4+@sSQL51+@sSQL5+@sSQL6+@sSQL7+@sSQL8+@sSQL9+@sSQL10+@sSQL11)













GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
