IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2061]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2061]
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
 ---- Modify by Phương Thảo on 23/02/2016 : Chỉnh sửa store, bổ sung trường hợp OT và ca đêm
 ---- Modify by Phương Thảo on 31/03/2016 : Bỏ không xét trường hợp OT
 ---- Modify by Phương Thảo on 14/06/2016 : Bỏ vòng lặp, cải tiến tốc độ. Bổ sung loại bất thường "Sai ca làm việc"
 --- Modify on 20/08/2016 by Phương Thảo: Bổ sung xử lý tách bảng nghiệp vụ
 --- Modify on 23/07/2018 by Bảo Anh: Sửa cách lấy ca làm việc cho trường hợp kỳ kế toán không bắt đầu là ngày 1
 --- Modify on 19/10/2020 by Bảo Anh: Tách store MEKIO và MTE
 /*-- <Example>
 	OOP2061 @DivisionID='CTY',@UserID='ASOFTADMIN', @TranMonth=8, @TranYear=2015, @Date=1
 ----*/
 
CREATE PROCEDURE OOP2061
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
		 @sSQL2 NVARCHAR(MAX),
		 @sSQL3 NVARCHAR(MAX),
		 @sSQL4 NVARCHAR(MAX),
		 @sSQL5 NVARCHAR(MAX),
		 @sSQL6 NVARCHAR(MAX),
		 @sSQL7 NVARCHAR(MAX),
 		 @ColDay NVARCHAR(3),
		 @sDay NVARCHAR(2),		
		 @Times Int, 
		 @i Int,
		 @FromDate Datetime
 
DECLARE	@TableHT2408 Varchar(50),		
		@sTranMonth Varchar(2),
		@CustomerName INT 

SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END
SELECT @CustomerName = CustomerName FROM dbo.CustomerIndex 
IF @CustomerName = 50 OR @CustomerName = 115 -- MEKIO và MTE
BEGIN
    EXEC dbo.OOP2061_MK @DivisionID,       -- nvarchar(50)
                     @UserID ,                  -- nvarchar(50)
                     @TranMonth ,                -- int
                     @TranYear,                  -- int
                     @Date ,  -- datetime
                     @ToDate  -- datetime
    
END
ELSE 
BEGIN 

	IF EXISTS (SELECT TOP 1 1 FROM AT0001 WHERE IsSplitTable = 1)	
	BEGIN
		SET  @TableHT2408 = 'HT2408M'+@sTranMonth+Convert(Varchar(4),@TranYear)
	END
	ELSE
	BEGIN
		SET  @TableHT2408 = 'HT2408'
	END		

	Select @Times = DATEDIFF(d,@Date,@ToDate) + 1,
			@FromDate = @Date
	SET @i = 1

	CREATE TABLE #HP2061_HT1025 (OrderNo INT IDENTITY(1,1),   DivisionID Nvarchar(50), ShiftID Nvarchar (50), EmployeeID NVarchar(50), 
								AbsentDate Datetime, DateTypeID Varchar(3) ) 
							
	CREATE TABLE #HP2061_HT1021 (OrderNo INT IDENTITY(1,1),   DivisionID Nvarchar(50), ShiftID Nvarchar (50), EmployeeID NVarchar(50),
								AbsentTime time, IOCode Tinyint, OrderNo2 Int, TypeID nvarchar (50), IsNextDay Tinyint, 
								AbsentDate datetime, WorkingDate datetime ) 

	CREATE TABLE #HP2061_HT2408 (OrderNo INT IDENTITY(1,1), DivisionID Nvarchar(50), EmployeeID nvarchar (50), TranMonth int, TranYear int, AbsentCardNo nvarchar (50),
								AbsentDate datetime, AbsentTime time, MachineCode nvarchar (50), ShiftCode nvarchar (50), IOCode tinyint, InputMethod tinyint, OrderNo2 Int, WorkingDate datetime) 
	--select @Times
	WHILE (@i <= @Times)
	BEGIN
		--IF Day(@FromDate) < 10 SET @sDay = '0' + CONVERT(NVARCHAR, Day(@FromDate))
		-- ELSE SET @sDay = CONVERT(NVARCHAR, Day(@Date))

		IF (SELECT DateOrder FROM dbo.[GetDayOfMonth] (@DivisionID, @TranMonth, @TranYear) WHERE [Date] = @FromDate) < 10
			SET @sDay = '0' + CONVERT(NVARCHAR, (SELECT DateOrder FROM dbo.[GetDayOfMonth] (@DivisionID, @TranMonth, @TranYear) WHERE [Date] = @FromDate))
		ELSE
			SET @sDay = CONVERT(NVARCHAR, (SELECT DateOrder FROM dbo.[GetDayOfMonth] (@DivisionID, @TranMonth, @TranYear) WHERE [Date] = @FromDate))

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
			AND 
			(
			NOT EXISTS (SELECT TOP 1 1 FROM HT2401_MK T2 WHERE T1.DivisionID = T2.DivisionID  
			 											AND T1.EmployeeID = T2.EmployeeID AND T2.AbsentDate = '''+Convert(NVarchar(10),@FromDate,101)+''')
			)			
		'
		--Print @sSQL
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
	ORDER BY AbsentDate, Convert(Time,AbsentTime) 


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
			CASE WHEN IOCode = 0 THEN MIN(AbsentDate+Cast(AbsentTime as Datetime)) ELSE MAX(AbsentDate+Cast(AbsentTime as Datetime))  END AS AbsentTime	
	INTO #HT1021_Time
	FROM #HP2061_HT1021
	GROUP BY DivisionID, EmployeeID, WorkingDate, IOCode


	SELECT T1.DivisionID, T1.EmployeeID, WorkingDate AS AbsentDate, IOCode, 
			CASE WHEN IOCode = 0 THEN MIN(T1.AbsentDate+Cast(T1.AbsentTime as Datetime)) 
			ELSE MAX(T1.AbsentDate+Cast(T1.AbsentTime as Datetime))  END AS AbsentTime		
	INTO  #HT2408_Time
	FROM #HP2061_HT2408 T1
	WHERE  
	(
	NOT EXISTS (SELECT TOP 1 1 FROM HT2401_MK T2 WHERE T1.DivisionID = T2.DivisionID  
			 									AND T1.EmployeeID = T2.EmployeeID AND T1.WorkingDate = T2.AbsentDate)
	)
	GROUP BY DivisionID, EmployeeID, WorkingDate, IOCode
	
	--select ''#HP2061_HT1021'', * from #HP2061_HT1021 order by EmployeeID, AbsentDate, AbsentTime 
	--select ''#HP2061_HT2408'', * from #HP2061_HT2408 order by EmployeeID, AbsentDate, AbsentTime 
	--select ''#HT1021_Time'', * from #HT1021_Time 
	--select  ''#HT2408_Time'', *  from #HT2408_Time 
	'
	--print @sSQL1
	--print @sSQL2

	--EXEC (@sSQL1+@sSQL2)

	-- return
	SET @sSQL3 = N'

	------------############# BẮT ĐẦU INSERT DỮ LIỆU VÀO BẢNG BẤT THƯỜNG ############## -------------------
	DELETE T1 
	FROM OOT2060 T1
	INNER JOIN #HT1021_Time T2 ON 
							  T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID								 								
	WHERE	T1.WorkingDate between '''+Convert(NVarchar(10),@Date,101)+''' and '''+Convert(NVarchar(10),@ToDate,101)+'''
			AND T1.TranYear='+STR(@TranYear)+' AND T1.TranMonth='+STR(@TranMonth)+'
			AND Status = 0
			AND ISNULL(JugdeUnusualType,'''') = ISNULL(Fact,'''')
			--AND T1.EmployeeID = ''000254''	
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
									JugdeUnusualType,HandleMethodID,DeleteFlag, WorkingDate)
			SELECT DISTINCT '''+@DivisionID+''', '+STR(@TranMonth)+',  '+STR(@TranYear)+', T1.EmployeeID, T1.AbsentDate, 0, 					
						''BT0003'', ''BT0003'',''DXP'', 0, T1.AbsentDate AS WorkingDate
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
									AND OOT2060.Status = 1
									AND OOT2060.DivisionID = T1.DivisionID AND OOT2060.EmployeeID = T1.EmployeeID AND OOT2060.Date = T1.AbsentDate)		
		
			UPDATE T1
			SET		T1.BeginTime = Convert(Time,T2.AbsentTime)
			FROM	OOT2060 T1
			INNER JOIN  #HT1021_Time T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.WorkingDate = T2.AbsentDate
			WHERE T2.IOCode = 0 AND T1.Status = 0

			UPDATE T1
			SET		T1.EndTime = Convert(Time,T2.AbsentTime)
			FROM	OOT2060 T1
			INNER JOIN  #HT1021_Time T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.WorkingDate = T2.AbsentDate
			WHERE T2.IOCode = 1 AND T1.Status = 0		
	END

	'
	SET @sSQL4 = '
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
								JugdeUnusualType, HandleMethodID,DeleteFlag, WorkingDate, BeginTime, EndTime, IOCode)
			SELECT	 T1021.DivisionID, '+STR(@TranMonth)+',  '+STR(@TranYear)+', T1021.EmployeeID, Convert(Date,T1021.AbsentTime) AS AbsentDate, 0, 
					''BT0001'', ''BT0001'', ''DXBSQT'',
					0, T1021.AbsentDate, Convert(Time,T1021.AbsentTime) AS BeginTime,  Convert(Time,T1021.AbsentTime) AS EndTime, T1021.IOCode--,
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
										AND OOT2060.Status = 1
										AND OOT2060.DivisionID = T1021.DivisionID AND OOT2060.EmployeeID = T1021.EmployeeID AND OOT2060.Date = Convert(Date,T1021.AbsentTime))

			UPDATE T1
			SET		T1.ActBeginTime = Convert(Time,T2.AbsentTime)
			FROM	OOT2060 T1
			INNER JOIN  #HT2408_Time T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.WorkingDate = T2.AbsentDate
			WHERE T2.IOCode = 0 AND T1.Status = 0

			UPDATE T1
			SET		T1.ActEndTime = Convert(Time,T2.AbsentTime)
			FROM	OOT2060 T1
			INNER JOIN  #HT2408_Time T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.WorkingDate = T2.AbsentDate
			WHERE T2.IOCode = 1 AND T1.Status = 0

	END

	'
	SET @sSQL5 = '
	----Đi trễ về sớm 
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

			INSERT INTO OOT2060 (DivisionID, TranMonth, TranYear, EmployeeID, [Date], [Status], Fact, 
										JugdeUnusualType, HandleMethodID,DeleteFlag, WorkingDate, BeginTime, EndTime, IOCode)
			SELECT	 A.DivisionID, '+STR(@TranMonth)+',  '+STR(@TranYear)+', A.EmployeeID, Convert(Date,A.AbsentTime) AS AbsentDate, 0, 
							''BT0002'', ''BT0002'', ''DXP'',
							0, A.AbsentDate,
							CASE WHEN B.AbsentTime <=  A.AbsentTime THEN Convert(Time,B.AbsentTime) ELSE Convert(Time,A.AbsentTime) END AS BeginTime,
							CASE WHEN B.AbsentTime >=  A.AbsentTime THEN Convert(Time,B.AbsentTime) ELSE Convert(Time,A.AbsentTime) END AS EndTime,
							A.IOCode
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
			AND  NOT EXISTS (SELECT TOP 1 1  FROM OOT2060 WHERE OOT2060.TranYear='+STR(@TranYear)+' AND OOT2060.TranMonth='+STR(@TranMonth)+' 
										AND OOT2060.WorkingDate between '''+Convert(NVarchar(10),@Date,101)+''' and '''+Convert(NVarchar(10),@ToDate,101)+'''
										AND OOT2060.JugdeUnusualType = ''BT0002'' 
										AND OOT2060.Status = 1
										AND OOT2060.DivisionID = A.DivisionID AND OOT2060.EmployeeID = A.EmployeeID AND OOT2060.Date = Convert(Date,A.AbsentTime))
		
			UPDATE T1
			SET		T1.ActBeginTime = Convert(Time,T2.AbsentTime)
			FROM	OOT2060 T1
			INNER JOIN  #HT2408_Time T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.WorkingDate = T2.AbsentDate
			WHERE T2.IOCode = 0 AND T1.Status = 0

			UPDATE T1
			SET		T1.ActEndTime = Convert(Time,T2.AbsentTime)
			FROM	OOT2060 T1
			INNER JOIN  #HT2408_Time T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.WorkingDate = T2.AbsentDate
			WHERE T2.IOCode = 1 AND T1.Status = 0
	
		'
	SET @sSQL6 = '

			INSERT INTO OOT2060 (DivisionID, TranMonth, TranYear, EmployeeID, [Date], [Status], Fact, 
									JugdeUnusualType,HandleMethodID,DeleteFlag, WorkingDate)
			SELECT DISTINCT '''+@DivisionID+''', '+STR(@TranMonth)+',  '+STR(@TranYear)+', A.EmployeeID, A.AbsentDate, 0, 					
					''BT0005'', ''BT0005'',''DXDC'', 0, A.AbsentDate AS WorkingDate
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
					(
							SELECT TOP 1 1
							FROM	 #HT2408_Time B1
							--LEFT JOIN  #HP2061_HT1021_IsNextDay B2 ON B1.DivisionID = B2.DivisionID AND B1.EmployeeID = B2.EmployeeID AND B1.AbsentDate = B2.AbsentDate
							WHERE  A.DivisionID = B1.DivisionID AND A.EmployeeID = B1.EmployeeID AND A.AbsentDate = B1.AbsentDate AND A.IOCode =1 AND  B1.IOCode = 1
								AND (Convert(Date,A.AbsentTime) <> Convert(Date,B1.AbsentTime))	
					)
			AND  NOT EXISTS (SELECT TOP 1 1  FROM OOT2060 WHERE OOT2060.TranYear='+STR(@TranYear)+' AND OOT2060.TranMonth='+STR(@TranMonth)+' 
										AND OOT2060.WorkingDate between '''+Convert(NVarchar(10),@Date,101)+''' and '''+Convert(NVarchar(10),@ToDate,101)+'''
										AND OOT2060.JugdeUnusualType = ''BT0005'' 
										AND OOT2060.Status = 1
										AND OOT2060.DivisionID = A.DivisionID AND OOT2060.EmployeeID = A.EmployeeID AND OOT2060.Date = A.AbsentDate)
		
			UPDATE T1
			SET		T1.ActBeginTime = Convert(Time,T2.AbsentTime)
			FROM	OOT2060 T1
			INNER JOIN  #HT2408_Time T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.WorkingDate = T2.AbsentDate
			WHERE T2.IOCode = 0 AND T1.Status = 0

			UPDATE T1
			SET		T1.ActEndTime = Convert(Time,T2.AbsentTime)
			FROM	OOT2060 T1
			INNER JOIN  #HT2408_Time T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.WorkingDate = T2.AbsentDate
			WHERE T2.IOCode = 1 AND T1.Status = 0
	
	END

	'
	SET @sSQL7 = '
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
										ActBeginTime, ActEndTime)
			SELECT	 A.DivisionID, '+STR(@TranMonth)+',  '+STR(@TranYear)+', A.EmployeeID, Convert(Date,A.AbsentTime) AS AbsentDate, 0, 
							''BT0006'', ''BT0006'', '''',
							0, A.AbsentDate, Convert(Time,A.AbsentTime) AS BeginTime,  Convert(Time,A.AbsentTime) AS EndTime, A.IOCode,
							Convert(Time,A.AbsentTime) AS ActBeginTime,  Convert(Time,A.AbsentTime) AS ActEndTime
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
									AND OOT2060.Status = 1
									AND OOT2060.DivisionID = A.DivisionID AND OOT2060.EmployeeID = A.EmployeeID AND OOT2060.Date = A.AbsentDate)
	
	END
	'

	--print @sSQL1
	--print @sSQL2
	--print @sSQL3
	--print @sSQL4
	--print @sSQL5
	--print @sSQL6
	--print @sSQL7
	EXEC (@sSQL1+@sSQL2+@sSQL3+@sSQL4+@sSQL5+@sSQL6+@sSQL7)


END










GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
