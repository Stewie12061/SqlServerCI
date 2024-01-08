IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2062_MK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2062_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Đẩy dữ liệu từ đơn xin phép sau khi duyệt xuống HRM (tách store cho Meiko)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 03/03/2016
----Modified by Bảo Thy, Date: 09/09/2016: Sửa lỗi lấy loại công
----Modified by Bảo Thy, Date: 09/11/2016: Bổ sung comment, sửa update HT2401_MK, sửa cách lấy kỳ khi qua năm tiếp theo
----Modified by Bảo Thy on 26/05/2017: Fix trường hợp xin phép 2 lần trong cùng một ngày
----Modified by Bảo Thy on 22/06/2017: Fix trường hợp xin nghỉ ngày hôm sau của ca đêm
----Modified by Bảo Thy on 27/06/2017: Insert HT2401_MK theo DepartmentID của Hồ sơ lương
---- Modified by Phương Thảo on 28/06/2017: Bổ sung xử lý kết chuyển công không hưởng lương theo quy định thiết lập (ASOFT)
/*-- <Example>
exec OOP2062_MK 'MK', 'ASOFTADMIN', 2, 2016, 'F2EC6A20-0991-421F-BFC0-1D35961C6C56',1
EXEC OOP2062_MK 'MK',N'J2278',6,2016,'EB45FC56-6655-41CA-B8FD-002E8D4BD0B9',1
----*/

CREATE PROCEDURE OOP2062_MK
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @TranMonth INT,
  @TranYear INT,
  @APKMaster VARCHAR(50),
  @Status TINYINT =1,
  @APKDetail VARCHAR(50)
) 
AS 
DECLARE 
		@sSQL NVARCHAR(MAX)='',
		@sSQL1 NVARCHAR(MAX)='',
		@sSQL12 NVARCHAR(MAX)='',
		@sSQL2 NVARCHAR(MAX)='',
		@sSQL3 NVARCHAR(MAX)=''
			
DECLARE
		@Cur CURSOR,
		@APK VARCHAR(50),
		@LeaveFromDate DATETIME,
		@LeaveToDate DATETIME,
		@TotalTime DECIMAL,
		@EmployeeID VARCHAR(50),
		@Col VARCHAR(3),
		@FromDay INT,
		@ToDay INT,
		@FromMonth INT,
		@ToMonth INT,
		@FromYear INT,
		@ToYear INT,
		@iMonthTotal INT,
		@iYear INT,
		@iDay INT ,
		@AbsentTypeID VARCHAR(50),
		@BeginTimePre DATETIME,
		@EndTimePre DATETIME,
		@FromWorkingDate DATETIME,
		@ToWorkingDate DATETIME,
		@iMonthLast INT,
		@ShiftID VARCHAR(50),
		@ID VARCHAR(50),
		@TableHT2400 Varchar(50),		
		@sTranMonth Varchar(2),
		@AbsentDecimals Int,
		@IsDTVS Int


SELECT @AbsentDecimals = AbsentDecimals
FROM HT0000 WITH (NOLOCK)
WHERE DivisionID = @DivisionID

SET @ID = (SELECT ID FROM OOT9000 WITH (NOLOCK) WHERE APK = @APKMaster)

--SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END
-- lấy bảng hồ sơ lương tương ứng với tháng xin phép của phiếu
SELECT @sTranMonth = CASE WHEN TranMonth >9 THEN Convert(Varchar(2),TranMonth) ELSE '0'+Convert(Varchar(1),TranMonth) END FROM OOT9000 WHERE APK = @APKMaster
IF EXISTS (SELECT TOP 1 1 FROM AT0001 WITH (NOLOCK) WHERE IsSplitTable = 1)	
BEGIN
	SET  @TableHT2400 = 'HT2400M'+@sTranMonth+Convert(Varchar(4),@TranYear)
END
ELSE
BEGIN
	SET  @TableHT2400 = 'HT2400'
END

IF EXISTS (SELECT TOP 1 1 FROM OOT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
BEGIN
	DECLARE @AccumulateAbsentAmount Decimal(28,8) = 0,
	@HMaxPerMonth decimal(28, 8), @HMaxPerTime decimal(28, 8), @TMaxPerMonth int, @NoSalaryAbsentID nvarchar (50), @MinusSalaryAbsentID nvarchar (50)

	SELECT	@HMaxPerMonth = HMaxPerMonth, @HMaxPerTime = HMaxPerTime, @TMaxPerMonth = TMaxPerMonth, 
			@NoSalaryAbsentID = NoSalaryAbsentID, @MinusSalaryAbsentID = MinusSalaryAbsentID
	FROM OOT0000 WITH (NOLOCK)
	WHERE DivisionID = @DivisionID
		
	SELECT	ROW_NUMBER() OVER(PARTITION BY T1.EmployeeID ORDER BY T1.EmployeeID, OT90.LastModifyDate) AS OrderNum,
			T1.APK, T1.EmployeeID, T1.TotalTime, Convert(Decimal(28,8),0) AS AccumulateAmount
	INTO #OOP2062_MK_OOT2010_DTVS
	FROM OOT2010 T1 WITH (NOLOCK)
	INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON T1.APKMaster = OT90.APK AND T1.DivisionID = OT90.DivisionID
	WHERE EXISTS (SELECT TOP 1 1 FROM OOT2010 T2 WITH (NOLOCK)
				INNER JOIN OOT9000 T3  WITH (NOLOCK) ON T2.APKMaster = T3.APK AND T2.DivisionID = T3.DivisionID
				WHERE T2.DivisionID= @DivisionID
				AND T2.APKMaster=@APKMaster
				AND T2.APK=@APKDetail
				AND ISNULL(T2.[Status],0)=1 AND T1.EmployeeID = T2.EmployeeID AND OT90.TranMonth = T3.TranMonth AND OT90.TranYear = T3.TranYear
				AND T2.AbsentTypeID in (SELECT AbsentTypeID FROM OOT1000 WITH (NOLOCK) WHERE IsDTVS = 1)
				)	
		  AND T1.DivisionID = @DivisionID
		  AND T1.AbsentTypeID in (SELECT AbsentTypeID FROM OOT1000 WITH (NOLOCK) WHERE IsDTVS = 1)
		  AND T1.Status = 1 AND OT90.Status = 1
		  AND (T1.APKMaster <> @APKMaster AND T1.IsValid = 1 OR T1.APKMaster = @APKMaster )
		  AND T1.APK = @APKDetail
	ORDER BY OT90.LastModifyDate	

	UPDATE T1
	SET @AccumulateAbsentAmount= @AccumulateAbsentAmount+ T1.TotalTime,
		T1.AccumulateAmount = @AccumulateAbsentAmount
	FROM #OOP2062_MK_OOT2010_DTVS T1	


	--select *
	--FROM OOT2010 T1
	--LEFT JOIN #OOP2062_MK_OOT2010_DTVS T2 ON T1.APK = T2.APK
	--WHERE ISNULL(T2.AccumulateAmount,0) <= @HMaxPerMonth AND ISNULL(T1.TotalTime,0) <= @HMaxPerTime
	--and Isnull(OrderNum,0) <= @TMaxPerMonth
	--AND T1.DivisionID= @DivisionID
	--AND T1.APKMaster=@APKMaster
	--AND ISNULL(T1.[Status],0)=1 
	--AND T1.AbsentTypeID in (SELECT AbsentTypeID FROM OOT1000 WHERE IsDTVS = 1)

	UPDATE T1
	SET T1.IsValid = 1
	FROM OOT2010 T1 WITH (NOLOCK)
	LEFT JOIN #OOP2062_MK_OOT2010_DTVS T2 WITH (NOLOCK) ON T1.APK = T2.APK
	WHERE ISNULL(T2.AccumulateAmount,0) <= @HMaxPerMonth AND ISNULL(T1.TotalTime,0) <= @HMaxPerTime
	and Isnull(OrderNum,0) <= @TMaxPerMonth
	AND T1.DivisionID= @DivisionID
	AND T1.APKMaster=@APKMaster
	AND T1.APK = @APKDetail
	AND ISNULL(T1.[Status],0)=1 
	AND T1.AbsentTypeID in (SELECT AbsentTypeID FROM OOT1000 WHERE IsDTVS = 1)

END

----Xóa chấm công trong HT2401_MK
DELETE HT24
FROM HT2401_MK HT24 WITH (NOLOCK)
INNER JOIN OOT2010 OOT20 WITH (NOLOCK) ON OOT20.DivisionID = HT24.DivisionID AND OOT20.APKMaster = HT24.APKMaster
AND OOT20.APKMaster = @APKMaster
AND HT24.APKDetail = @APKDetail
AND ISNULL([Status],0)=1

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT APK,EmployeeID,LeaveFromDate,LeaveToDate,TotalTime,
	DAY(ISNULL(FromWorkingDate, LeaveFromDate)) AS FromDay,
	DAY(ISNULL(ToWorkingDate, LeaveToDate)) AS ToDay,
	MONTH(ISNULL(FromWorkingDate, LeaveFromDate)) AS FromMonth,
	MONTH(ISNULL(ToWorkingDate, LeaveToDate)) AS ToMonth,
	YEAR(ISNULL(FromWorkingDate, LeaveFromDate)) AS FromYear,
	YEAR(ISNULL(ToWorkingDate, LeaveToDate)) AS ToYear,
	AbsentTypeID, ShiftID, 
	ISNULL(FromWorkingDate, LeaveFromDate),
	ISNULL(ToWorkingDate, LeaveToDate)
FROM OOT2010 WITH (NOLOCK)
WHERE DivisionID= @DivisionID
AND APKMaster=@APKMaster
AND APK = @APKDetail
AND ISNULL([Status],0)=1



OPEN @Cur
FETCH NEXT FROM @Cur INTO @APK,@EmployeeID,@LeaveFromDate,@LeaveToDate,@TotalTime, @FromDay,@ToDay,@FromMonth,@ToMonth,@FromYear,
@ToYear,@AbsentTypeID, @ShiftID, @FromWorkingDate,@ToWorkingDate
WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @IsDTVS = Isnull(IsDTVS,0)
	FROM OOT1000 WITH (NOLOCK)
	WHERE AbsentTypeID = @AbsentTypeID

	SET @iMonthTotal=@FromMonth
	SET @iYear=@FromYear
	 
	SET @iMonthTotal = @ToMonth + 12 * (@ToYear - @FromYear)
	
	DECLARE @j INT =@FromMonth,@iMonth INT =@FromMonth,@i INT =@FromDay,@s VARCHAR(2)
	--SELECT @iMonthTotal iMonthTotal, @iMonth iMonth, @ToYear, @FromYear
	
	WHILE @iMonth<=@iMonthTotal
	BEGIN
		IF @iMonth <= 12
		SET @iMonthLast =  @iMonth 
		ELSE
		BEGIN
			IF (@iMonth%12 = 1) --IN (13,25,37,49,61,73,85))
				BEGIN 
					SET @iMonthLast=1
					SET @iYear=@iYear+1
				END
			ELSE
			IF @iMonth > 13 AND @iMonth%12 <> 1 -- NOT IN (13,25,37,49,61,73,85)
				BEGIN
					SET @iMonthLast=@iMonthLast+1
				END
		END
		--select @imonth imonth, @iMonthLast iMonthLast
		IF @iMonthLast = @FromMonth AND @iYear=@FromYear  SET @i=@FromDay
		ELSE SET  @i=1

		IF @iMonthLast = @ToMonth AND @iYear=@ToYear  SET @iDay=@ToDay
		ELSE SET  @iDay=DAY(EOMONTH(CONVERT(date,'01/'+STR(@iMonthLast)+'/'+STR(@iYear),103)))
		
		WHILE @i <= @iDay
		BEGIN
			IF @i = @FromDay 
			BEGIN
				SET @BeginTimePre =  CONVERT(DATETIME,LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) +' '+'00:00:00',120)
				SET @EndTimePre = CONVERT(DATETIME,LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) +' '+'00:00:00',120)
			END
			
			IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
			ELSE SET @s = CONVERT(VARCHAR, @i)

			SET @s = ISNULL(@s, '')
			SET @Col = 'D'+@s
			
			-----Update ca thay đổi HT1025
			IF ISNULL(@ShiftID,'') <> '' 
				AND EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE DivisionID=@DivisionID AND EmployeeID=@EmployeeID AND TranMonth=@iMonthLast AND TranYear=@iYear)
			BEGIN

				SET @sSQL2=N'UPDATE  HT1025 
							SET D'+@s+'='''+@ShiftID+''',
								LastModifyUserID = '''+@UserID+''',
								LastModifyDate = GETDATE(),
								Notes = N''Changed shift from '+@ID+'''
							WHERE DivisionID='''+@DivisionID+''' 
							AND EmployeeID='''+@EmployeeID +'''
							AND TranMonth='+STR(@iMonthLast)+'
							AND TranYear='+STR(@iYear)+''
			END

			IF ISNULL(@ShiftID,'') <> '' 
				AND EXISTS (SELECT TOP 1 1 FROM OOT2000 
							LEFT JOIN OOT9000 ON OOT2000.APKMaster=OOT9000.APK
							WHERE OOT2000.DivisionID=@DivisionID AND EmployeeID=@EmployeeID AND TranMonth=@iMonthLast AND TranYear=@iYear)
			BEGIN
				SET @sSQL3=N'UPDATE  T1 
							SET D'+@s+'='''+@ShiftID+''' ,
								Note = N''Changed shift from '+@ID+'''
							FROM OOT2000 T1
							LEFT JOIN OOT9000 T2 ON T1.DivisionID = T2.DivisionID AND T2.APK = T1.APKMaster
						    WHERE T1.DivisionID='''+@DivisionID+''' 
							AND T1.EmployeeID='''+@EmployeeID +'''
							AND T2.TranMonth='+STR(@iMonthLast)+'
							AND T2.TranYear='+STR(@iYear)+''
			END

			EXEC (@sSQL2+@sSQL3)

			----Lấy ca làm việc
			DECLARE @sqltmp NVARCHAR(MAX),
					@Shitidtmp NVARCHAR(50)

			SET @sqltmp = 'SELECT @Shitidtmp = '+@Col+' FROM HT1025
							WHERE DivisionID='''+@DivisionID +'''
							AND EmployeeID= '''+@EmployeeID +'''
							AND TranMonth='+str(@iMonthLast) +'
							AND TranYear='+str(@iYear)+''
														
			EXEC sp_executesql @sqltmp
									,N'@Shitidtmp VARCHAR(50) OUTPUT',
									@Shitidtmp=@Shitidtmp OUTPUT
			
			----Kiểm tra ca đêm

			SET @sSQL = '	
			 DECLARE @ShiftID'+@s+' NVARCHAR(50), @Begintime'+@s+' DATETIME,@Endtime'+@s+' DATETIME, @Workingtime'+@s+' DECIMAL(28,8),@TotalTime'+@s+' DECIMAL(28,8)
			 SET @ShiftID'+@s+' = ( SELECT '+@Col+' 
									FROM HT1025
									WHERE DivisionID='''+@DivisionID+'''
									AND  EmployeeID= '''+@EmployeeID+'''
									AND TranMonth='+STR(@iMonthLast)+'
									AND TranYear='+STR(@iYear)+')	
			
			SET @begintime'+@s+' = CAST('''+CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120)+'''+'' ''+(SELECT CONVERT(DATETIME,BeginTime) FROM ht1020 WHERE DivisionID = '''+@DivisionID+''' AND ShiftID=@ShiftID'+@s+') AS DATETIME)								
			
			SET @Endtime'+@s+' = CASE WHEN exists (SELECT TOP 1 1 FROM HT1021 WHERE DivisionID = '''+@DivisionID+''' AND ShiftID=@ShiftID'+@s+' AND IsNextDay=1)
								
									  THEN CAST('''+CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120)+'''+'' ''+(SELECT CONVERT(DATETIME,EndTime) FROM ht1020 WHERE DivisionID = '''+@DivisionID+''' AND ShiftID=@ShiftID'+@s+') AS DATETIME)+1 
								
								ELSE CAST('''+CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120)+'''+'' ''+(SELECT CONVERT(DATETIME,EndTime) FROM ht1020 WHERE DivisionID = '''+@DivisionID+''' AND ShiftID=@ShiftID'+@s+') AS DATETIME) END
						
			SET @Workingtime'+@s+' = (SELECT WorkingTime FROM HT1020 WHERE DivisionID = '''+@DivisionID+''' AND ShiftID=@ShiftID'+@s+')
								 
			-----TÍNH TOTALTIME
			IF '''+CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120)+''' = '''+Convert(VARCHAR(10),@FromWorkingDate,120)+'''
				BEGIN
					IF '''+Convert(VARCHAR(10),@ToWorkingDate,120)+''' = '''+Convert(VARCHAR(10),@FromWorkingDate,120)+'''
						SET @TotalTime'+@s+' = Convert(Decimal(28,8),DATEDIFF(mi,CAST('''+CONVERT(NVARCHAR(50),@LeaveFromDate,120)+''' AS DATETIME),CAST('''+CONVERT(NVARCHAR(50),@LeaveToDate,120)+''' AS DATETIME)))/60
				
					ELSE
						SET @TotalTime'+@s+' = Convert(Decimal(28,8),DATEDIFF(mi,CAST('''+CONVERT(NVARCHAR(50),@LeaveFromDate,120)+''' AS DATETIME),convert(DATETIME,@Endtime'+@s+',120)))/60
				END
	
			ELSE 
			IF '''+CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS DATETIME),120)+''' ='''+Convert(VARCHAR(10),@ToWorkingDate,120)+'''
			AND '''+Convert(VARCHAR(10),@FromWorkingDate,120)+''' <> '''+Convert(VARCHAR(10),@ToWorkingDate,120)+'''
			BEGIN
			
					IF CAST('''+CONVERT(NVARCHAR(50),@LeaveToDate,120)+''' AS DATETIME) BETWEEN CAST('''+CONVERT(NVARCHAR(50),@BeginTimePre,120)+''' AS DATETIME) AND CAST('''+CONVERT(NVARCHAR(50),@EndTimePre,120)+''' AS DATETIME)
						SET @TotalTime'+@s+' = Convert(Decimal(28,8),DATEDIFF(mi,CAST('''+CONVERT(NVARCHAR(50),@BeginTimePre,120)+''' AS DATETIME),CAST('''+CONVERT(NVARCHAR(50),@LeaveToDate,120)+''' AS DATETIME)))/60
					ELSE
						SET @TotalTime'+@s+' = Convert(Decimal(28,8),DATEDIFF(mi,convert(DATETIME,@begintime'+@s+',120),CAST('''+CONVERT(NVARCHAR(50),@LeaveToDate,120)+''' AS DATETIME)))/60
			END	
			ELSE	SET @TotalTime'+@s+' = @Workingtime'+@s+' 
			
			SELECT	@TotalTime'+@s+'= CASE WHEN @TotalTime'+@s+'*60 BETWEEN T2.FromMinute AND T2.ToMinute 
										THEN ROUND(Convert(decimal(28,8),T2.SubMinute)/60,'+STR(@AbsentDecimals)+') ELSE ROUND(@TotalTime'+@s+','+STR(@AbsentDecimals)+') END
			FROM 
			(SELECT HT1023.FromMinute, HT1023.ToMinute, HT1023.SubMinute
			FROM HT1022 INNER JOIN HT1023 ON HT1022.DivisionID = HT1023.DivisionID AND HT1022.RestrictID = HT1023.RestrictID
			WHERE HT1022.RestrictID = (SELECT RestrictID FROM OOT1000 WHERE AbsentTypeID = '''+@AbsentTypeID+''' AND DivisionID = '''+@DivisionID+''')
			) T2	

			IF @TotalTime'+@s+' > @Workingtime'+@s+'
				SET @TotalTime'+@s+' = @Workingtime'+@s+'
			'

			SET @sSQL1 = '
				
			--SELECT '''+@EmployeeID+''',@ShiftID'+@s+' ShiftID'+@s+', @begintime'+@s+' begintime'+@s+', @Workingtime'+@s+' Workingtime'+@s+',@Endtime'+@s+' Endtime'+@s+',@TotalTime'+@s+' TotalTime'+@s+'
			
			---- INSERT DỮ LIỆU
			IF EXISTS (SELECT TOP 1 1 FROM OOT2010  WITH (NOLOCK)
						   LEFT JOIN OOT1000 WITH (NOLOCK) ON OOT1000.DivisionID = OOT2010.DivisionID AND OOT1000.AbsentTypeID = '''+@AbsentTypeID+'''
						   LEFT JOIN HT1013 H13 WITH (NOLOCK) ON H13.DivisionID = OOT2010.DivisionID AND H13.AbsentTypeID = OOT1000.TypeID
						   WHERE OOT2010.DivisionID='''+@DivisionID +'''
						   AND OOT2010.APKMaster ='''+@APKMaster+'''
						   AND OOT2010.EmployeeID = '''+@EmployeeID+'''
						   AND H13.TypeID NOT IN (''OT'',''C'')
						   AND ISNULL(OOT2010.Status,0)=1)
						   
			BEGIN
				---Trường hợp ca đêm xin nghỉ qua ngày hôm sau thì ko insert mà update trên dòng của ngày trước đó	
				IF '+STR(@i)+' = '+STR(@iDay)+' 
				AND '+STR(@i)+' <> '+STR(@FromDay)+' 
				AND CAST('''+CONVERT(NVARCHAR(50),@LeaveToDate,120)+''' AS DATETIME) BETWEEN CAST('''+CONVERT(NVARCHAR(50),@BeginTimePre,120)+''' AS DATETIME) AND CAST('''+CONVERT(NVARCHAR(50),@EndTimePre,120)+''' AS DATETIME)
				BEGIN
					UPDATE OOT10
					SET OOT10.AbsentAmount = CASE  WHEN  H13.TypeID=''NB'' OR  H13.TypeID=''CN'' THEN  
												CASE WHEN @TotalTime'+@s+' >= 8 THEN -8 ELSE (-1)* ROUND(@TotalTime'+@s+','+STR(@AbsentDecimals)+') END
												ELSE
												CASE WHEN @TotalTime'+@s+' >= 8 THEN 8 ELSE ROUND(@TotalTime'+@s+','+STR(@AbsentDecimals)+') END
											END											   
					FROM HT2401_MK OOT10 WITH (NOLOCK)
					INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.DivisionID = OOT10.DivisionID AND OT90.APK = OOT10.APKMaster
					LEFT JOIN OOT1000 OOT00 WITH (NOLOCK) ON OOT00.DivisionID = OOT10.DivisionID AND OOT00.AbsentTypeID = '''+@AbsentTypeID+'''
					LEFT JOIN HT1013 H13 WITH (NOLOCK) ON H13.DivisionID = OOT00.DivisionID AND H13.AbsentTypeID = OOT00.TypeID
					WHERE OOT10.DivisionID = '''+@DivisionID+''' AND OOT10.EmployeeID = '''+@EmployeeID+''' AND OOT10.APKMaster = '''+@APKMaster+''' 
					AND OOT10.AbsentDate = CONVERT(DATETIME,'''+CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120)+''')
				END
				ELSE
				'
		SET @sSQL12 ='
				BEGIN
					INSERT INTO HT2401_MK (APKMaster, DivisionID, AbsentDate, EmployeeID,
								TranMonth, DepartmentID, TranYear, TeamID, AbsentTypeID,
								AbsentAmount, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, APKDetail)
								
					SELECT DISTINCT '''+@APKMaster+''','''+@DivisionID+''',
							CONVERT(DATE,'''+CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120)+'''),
							'''+@EmployeeID+''',  '+STR(@iMonthLast)+',ISNULL(HT14.DepartmentID,''''),'+STR(@iYear)+',HT14.TeamID, OOT00.TypeID,
							(CASE  WHEN  H13.TypeID=''NB'' OR  H13.TypeID=''CN'' THEN   
								CASE WHEN (CASE WHEN H13.UnitID=''H'' THEN ROUND(@TotalTime'+@s+','+STR(@AbsentDecimals)+') ELSE ROUND(@TotalTime'+@s+'/8,'+STR(@AbsentDecimals)+') END) >= 8 THEN -8 
									ELSE
						   				-(CASE WHEN H13.UnitID=''H'' THEN ROUND(@TotalTime'+@s+','+STR(@AbsentDecimals)+') ELSE ROUND(@TotalTime'+@s+'/8,'+STR(@AbsentDecimals)+') END) END
							ELSE 
								CASE WHEN (CASE WHEN H13.UnitID=''H'' THEN ROUND(@TotalTime'+@s+','+STR(@AbsentDecimals)+') ELSE ROUND(@TotalTime'+@s+'/8,'+STR(@AbsentDecimals)+') END) >= 8 THEN 8 
									ELSE 
										(CASE WHEN H13.UnitID=''H'' THEN ROUND(@TotalTime'+@s+','+STR(@AbsentDecimals)+') ELSE ROUND(@TotalTime'+@s+'/8,'+STR(@AbsentDecimals)+') END) END
							END	),
							'''+@UserID+''',OT90.CreateDate,'''+@UserID+''',GETDATE(),''' + ISNULL(@APK, '') + '''
					FROM OOT2010 OOT10 WITH (NOLOCK)
					INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.DivisionID = OOT10.DivisionID AND OT90.APK = OOT10.APKMaster
					LEFT JOIN OOT1000 OOT00 WITH (NOLOCK) ON OOT00.DivisionID = OOT10.DivisionID AND OOT00.AbsentTypeID = '''+@AbsentTypeID+'''
					LEFT JOIN HT1013 H13 WITH (NOLOCK) ON H13.DivisionID = OOT00.DivisionID AND H13.AbsentTypeID = OOT00.TypeID
					LEFT JOIN '+@TableHT2400+' HT14 WITH (NOLOCK) ON HT14.DivisionID = OOT10.DivisionID AND HT14.EmployeeID = '''+@EmployeeID+'''	AND HT14.TranMonth = OT90.TranMonth AND HT14.TranYear = OT90.TranYear 
					WHERE OOT10.DivisionID='''+@DivisionID +''' 
					AND OOT10.APKMaster ='''+@APKMaster+'''
					AND OOT10.APK = ''' + @APK + '''
					AND H13.TypeID NOT IN (''OT'',''C'')
					--AND OOT00.AbsentTypeID <>''NOOT'' 
					AND ISNULL(OOT10.Status,0)=1 
					AND OOT10.EmployeeID = '''+@EmployeeID+'''	
					AND ( (EXISTS (SELECT TOP 1 1 FROM OOT0000 WHERE DivisionID= '''+@DivisionID+''') AND ISNULL(OOT10.IsValid,0) = 1 AND '+STR(@IsDTVS)+' = 1 )
							OR (NOT EXISTS (SELECT TOP 1 1 FROM OOT0000 WHERE DivisionID= '''+@DivisionID+''')) OR '+STR(@IsDTVS)+' = 0)				
					'

				SET @sSQL2 = '
					INSERT INTO HT2401_MK (APKMaster, DivisionID, AbsentDate, EmployeeID,
								TranMonth, DepartmentID, TranYear, TeamID, AbsentTypeID,
								AbsentAmount, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, APKDetail)
								
					SELECT DISTINCT '''+@APKMaster+''','''+@DivisionID+''',
							CONVERT(DATE,'''+CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120)+'''),
							'''+@EmployeeID+''',  '+STR(@iMonthLast)+',ISNULL(HT14.DepartmentID,''''),'+STR(@iYear)+',HT14.TeamID, '''+Isnull(@NoSalaryAbsentID,'')+''',
							(CASE  WHEN  H13.TypeID=''NB'' OR  H13.TypeID=''CN'' THEN   
								CASE WHEN (CASE WHEN H13.UnitID=''H'' THEN ROUND(@TotalTime'+@s+','+STR(@AbsentDecimals)+') ELSE ROUND(@TotalTime'+@s+'/8,'+STR(@AbsentDecimals)+') END) >= 8 THEN -8 
									ELSE
						   				-(CASE WHEN H13.UnitID=''H'' THEN ROUND(@TotalTime'+@s+','+STR(@AbsentDecimals)+') ELSE ROUND(@TotalTime'+@s+'/8,'+STR(@AbsentDecimals)+') END) END
							ELSE 
								CASE WHEN (CASE WHEN H13.UnitID=''H'' THEN ROUND(@TotalTime'+@s+','+STR(@AbsentDecimals)+') ELSE ROUND(@TotalTime'+@s+'/8,'+STR(@AbsentDecimals)+') END) >= 8 THEN 8 
									ELSE 
										(CASE WHEN H13.UnitID=''H'' THEN ROUND(@TotalTime'+@s+','+STR(@AbsentDecimals)+') ELSE ROUND(@TotalTime'+@s+'/8,'+STR(@AbsentDecimals)+') END) END
							END	),
							'''+@UserID+''',OT90.CreateDate,'''+@UserID+''',GETDATE(),''' + ISNULL(@APK, '') + '''
					FROM OOT2010 OOT10 WITH (NOLOCK)
					INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.DivisionID = OOT10.DivisionID AND OT90.APK = OOT10.APKMaster
					LEFT JOIN OOT1000 OOT00 WITH (NOLOCK) ON OOT00.DivisionID = OOT10.DivisionID AND OOT00.AbsentTypeID = '''+@AbsentTypeID+'''
					LEFT JOIN HT1013 H13 WITH (NOLOCK) ON H13.DivisionID = OOT00.DivisionID AND H13.AbsentTypeID = OOT00.TypeID
					LEFT JOIN '+@TableHT2400+' HT14 WITH (NOLOCK) ON HT14.DivisionID = OOT10.DivisionID AND HT14.EmployeeID = '''+@EmployeeID+'''	AND HT14.TranMonth = OT90.TranMonth
					AND HT14.TranYear = OT90.TranYear		  
					WHERE OOT10.DivisionID='''+@DivisionID +'''
					AND OOT10.APKMaster ='''+@APKMaster+'''
					AND OOT10.APK = ''' + @APK + '''
					AND H13.TypeID NOT IN (''OT'',''C'')
					--AND OOT00.AbsentTypeID <>''NOOT''
					AND ISNULL(OOT10.Status,0)=1 
					AND OOT10.EmployeeID = '''+@EmployeeID+'''	
					AND EXISTS (SELECT TOP 1 1 FROM OOT0000 WHERE DivisionID= '''+@DivisionID+''') AND ISNULL(OOT10.IsValid,0) = 0
					AND '+STR(@IsDTVS)+' = 1 
									
				END	   
			END
				'

			EXEC(@sSQL+@sSQL1+@sSQL12+@sSQL2)
			--PRINT (@sSQL)
			--PRINT (@sSQL1)
			--PRINT (@sSQL12)
			--PRINT (@sSQL2)
		
			SET @BeginTimePre = (SELECT CONVERT(DATETIME,LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i)+' '+BeginTime,120) FROM HT1020 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND ShiftID=@Shitidtmp)
			
			SET @EndTimePre = CASE WHEN EXISTS (SELECT TOP 1 1 FROM HT1021 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND ShiftID=@Shitidtmp AND IsnextDay=1) 
								   THEN (SELECT CONVERT(DATETIME,LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i)+' '+EndTime,120)+1 FROM HT1020 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND ShiftID=@Shitidtmp)
							  ELSE (SELECT CONVERT(DATETIME,LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i)+' '+EndTime,120) FROM HT1020 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND ShiftID=@Shitidtmp) END
								
			SET @i =  @i + 1
			
			END
			
			SET @iMonth=@iMonth+1
	END
FETCH NEXT FROM @Cur INTO @APK,@EmployeeID,@LeaveFromDate,@LeaveToDate,@TotalTime, @FromDay,@ToDay,@FromMonth,@ToMonth,@FromYear,@ToYear,
@AbsentTypeID, @ShiftID, @FromWorkingDate,@ToWorkingDate
END 
Close @Cur 






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
