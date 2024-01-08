IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[OOP2017]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[OOP2017]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Tính totaltime khi tạo đơn
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 10/03/2017
----Modified by Phương Thảo on 28/06/2017: Xử lý làm tròn theo quy định DTVS
----Modified by Bảo Anh on 26/12/2018: Trả thêm cột TotalDay
----Modified by Như Hàn on 26/06/2019: Sửa lỗi trả ra thời gian sai khi thời gian từ > thời gian đến
----Modified by Lương Mỹ on 03/12/2019: Bổ sung trường hợp Tính thiếu ngày cuối cùng của Vòng lặp
----Modified by Văn Tài on 28/02/2020: Phục hồi kiểm tra IF cho NEWTOYO, không rõ lý do MTE không dùng IF vẫn chạy đúng.
----Modified by Văn Tài on 24/08/2021: Bổ sung trường hợp cho MINHTRI như NEWTOYO.
----Modified by Nhựt Trường 02/11/2022: [2022/10/IS/0123] - Bổ sung điều kiện AbsentTypeID khi tính toán giá trị @EndTimePre,

/*-- <Example>
	EXEC oop2017 'VCH', 'ASOFTADMIN', '011532584', '2017-01-04', '2017-01-06'
----*/

CREATE PROCEDURE OOP2017
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @EmployeeID VARCHAR(50),
  @FromDate DATETIME,
  @ToDate DATETIME,
  @AbsentTypeID VARCHAR(50) = ''
) 
AS 
DECLARE 
		@sSQL NVARCHAR(MAX)='',
		@Cur CURSOR,
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
		@BeginTimePre DATETIME = NULL,
		@EndTimePre DATETIME = NULL,
		@FromWorkingDate DATETIME,
		@ToWorkingDate DATETIME,
		@iMonthLast INT,
		@CustomerIndex INT = 0

SET @CustomerIndex = (SELECT TOP 1  CustomerName FROM dbo.CustomerIndex)

CREATE TABLE #TotalTime (TotalTime DECIMAL(28,8), TotalDay DECIMAL(28,2))

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT @EmployeeID,@FromDate,@ToDate,
DAY(@FromDate) AS FromDay,DAY(@ToDate) AS ToDay,
MONTH(@FromDate) AS FromMonth,MONTH(@ToDate) AS ToMonth,
YEAR(@FromDate) AS FromYear,YEAR(@ToDate) AS ToYear


OPEN @Cur
FETCH NEXT FROM @Cur INTO @EmployeeID,@FromDate,@ToDate, @FromDay,@ToDay,@FromMonth,@ToMonth,@FromYear, @ToYear
WHILE @@FETCH_STATUS = 0
BEGIN
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

			-- Nếu là ngày đầu tiên trong vòng lặp
			IF @i = @FromDay 
			BEGIN
				SET @BeginTimePre =  CONVERT(DATETIME,LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) +' '+'00:00:00',120)
				SET @EndTimePre = CONVERT(DATETIME,LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) +' '+'00:00:00',120)	

			END

			IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
			ELSE SET @s = CONVERT(VARCHAR, @i)
			SET @Col = 'D'+@s
																		

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

			-- [03/12/2019] - [Lương Mỹ] - Begin Update
			-- Nếu là ngày đầu tiên trong vòng lặp
			IF @BeginTimePre IS NULL 
			BEGIN
            	SET @BeginTimePre = (SELECT CONVERT(DATETIME,LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i)+' '+BeginTime,120) FROM HT1020 WHERE DivisionID = @DivisionID AND ShiftID=@Shitidtmp)
				
			END
			IF @EndTimePre IS NULL 
			BEGIN
				SET @EndTimePre = CASE WHEN EXISTS (SELECT TOP 1 1 FROM HT1021 WHERE DivisionID = @DivisionID AND ShiftID=@Shitidtmp AND IsnextDay=1) 
										THEN (SELECT CONVERT(DATETIME,LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i)+' '+EndTime,120)+1 FROM HT1020 WHERE DivisionID = @DivisionID AND ShiftID=@Shitidtmp)
										ELSE (SELECT CONVERT(DATETIME,LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i)+' '+EndTime,120) FROM HT1020 WHERE DivisionID = @DivisionID AND ShiftID=@Shitidtmp) 
									END										
			END

			--SELECT @EndTimePre,@BeginTimePre

			-- [03/12/2019] - [Lương Mỹ] - End Update


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
			IF '''+CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120)+''' = '''+Convert(VARCHAR(10),@FromDate,120)+'''
			BEGIN

				IF '''+Convert(VARCHAR(10),@ToDate,120)+''' = '''+Convert(VARCHAR(10),@FromDate,120)+''' OR  '''+Convert(VARCHAR(50),@ToDate,120)+''' <=  @Endtime'+@s+'
					SET @TotalTime'+@s+' = CONVERT(DECIMAL(28,8),DATEDIFF(mi,CAST('''+CONVERT(NVARCHAR(50),@FromDate,120)+''' AS DATETIME),CAST('''+CONVERT(NVARCHAR(50),@ToDate,120)+''' AS DATETIME))) / 60
				ELSE IF '''+Convert(VARCHAR(50),@FromDate,120)+''' <=  @Endtime'+@s+'
				BEGIN
					SET @TotalTime'+@s+' = CONVERT(DECIMAL(28,8),DATEDIFF(mi,CAST('''+CONVERT(NVARCHAR(50),@FromDate,120)+''' AS DATETIME),convert(DATETIME,@Endtime'+@s+',120)))/60
				END
			END
	
			ELSE 
			IF '''+CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120)+''' ='''+Convert(VARCHAR(10),@ToDate,120)+'''
			AND '''+Convert(VARCHAR(10),@ToDate,120)+''' <> '''+Convert(VARCHAR(10),@FromDate,120)+'''
			BEGIN

					IF CAST('''+CONVERT(NVARCHAR(50),@ToDate,120)+''' AS DATETIME) BETWEEN CAST('''+CONVERT(NVARCHAR(50),@BeginTimePre,120)+''' AS DATETIME) AND CAST('''+CONVERT(NVARCHAR(50),@EndTimePre,120)+''' AS DATETIME)
					BEGIN
						IF (
							('''+CONVERT(NVARCHAR(50),@EndTimePre,120)+''' < '''+Convert(VARCHAR(50),@ToDate,120)+ N''') 
							--- Kiểm tra không phải NEWTOYO thì cho phép thực hiện.
								OR (' + Convert(VARCHAR(10), @CustomerIndex) + ' <> 81
									 AND ' + Convert(VARCHAR(10), @CustomerIndex) + ' <> 92
								   )
						)
						SET @TotalTime'+@s+' = CONVERT(DECIMAL(28,8),DATEDIFF(mi,CAST('''+CONVERT(NVARCHAR(50),@BeginTimePre,120)+''' AS DATETIME),CAST('''+CONVERT(NVARCHAR(50),@ToDate,120)+''' AS DATETIME)))/60
					END
					ELSE IF CONVERT(DATETIME,@begintime'+@s+',120) < '''+Convert(VARCHAR(50),@ToDate,120)+'''
						SET @TotalTime'+@s+' = CONVERT(DECIMAL(28,8),DATEDIFF(mi,convert(DATETIME,@begintime'+@s+',120),CAST('''+CONVERT(NVARCHAR(50),@ToDate,120)+''' AS DATETIME)))/60
			END	
			ELSE	
			IF '''+CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120)+''' <>'''+Convert(VARCHAR(10),@ToDate,120)+'''
			AND '''+CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120)+''' <> '''+Convert(VARCHAR(10),@FromDate,120)+'''
			AND '''+CONVERT(NVARCHAR(50),@EndTimePre,120)+''' < '''+Convert(VARCHAR(50),@ToDate,120)+'''
					SET @TotalTime'+@s+' = CONVERT(DECIMAL(28,8),DATEDIFF(mi,convert(DATETIME,@begintime'+@s+',120),CAST('''+CONVERT(NVARCHAR(50),@ToDate,120)+''' AS DATETIME)))/60
			ELSE
			SET @TotalTime'+@s+' = @Workingtime'+@s+' 


			IF  @TotalTime'+@s+' > @Workingtime'+@s+' SET @TotalTime'+@s+' = @Workingtime'+@s+' 

			INSERT INTO #TotalTime (TotalTime)
			VALUES (ISNULL(@TotalTime'+@s+',0))			
			
			UPDATE T1
			SET		T1.TotalTime = Convert(decimal(28,8),T2.SubMinute)/60
			FROM  #TotalTime T1
			INNER JOIN 
			(SELECT HT1023.FromMinute, HT1023.ToMinute, HT1023.SubMinute
			FROM HT1022 INNER JOIN HT1023 ON HT1022.DivisionID = HT1023.DivisionID AND HT1022.RestrictID = HT1023.RestrictID
			WHERE HT1022.RestrictID = (SELECT RestrictID FROM OOT1000 WHERE AbsentTypeID = '''+@AbsentTypeID+''' AND DivisionID = '''+@DivisionID+''')
			) T2 ON T1.TotalTime*60 BETWEEN T2.FromMinute AND T2.ToMinute
			
			IF ISNULL(@Workingtime'+@s+',0) <> 0
			UPDATE #TotalTime
			SET TotalDay = ROUND(TotalTime/@Workingtime'+@s+',2)'


			PRINT @sSQL
			EXEC(@sSQL)
	
			-- Tăng bước nhảy trong vòng lặp While
			SET @BeginTimePre = (SELECT CONVERT(DATETIME,LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i)+' '+BeginTime,120) FROM HT1020 WHERE DivisionID = @DivisionID AND ShiftID=@Shitidtmp)
			
			SET @EndTimePre = CASE WHEN EXISTS (SELECT TOP 1 1 FROM HT1021 WHERE DivisionID = @DivisionID AND ShiftID=@Shitidtmp AND IsnextDay=1 AND AbsentTypeID = @AbsentTypeID) 
								   THEN (SELECT CONVERT(DATETIME,LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i)+' '+EndTime,120)+1 FROM HT1020 WHERE DivisionID = @DivisionID AND ShiftID=@Shitidtmp)
							  ELSE (SELECT CONVERT(DATETIME,LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i)+' '+EndTime,120) FROM HT1020 WHERE DivisionID = @DivisionID AND ShiftID=@Shitidtmp) END
				
			--SELECT @EndTimePre,@BeginTimePre
						
			SET @i =  @i + 1
			
			END
			
			SET @iMonth=@iMonth+1
	END
FETCH NEXT FROM @Cur INTO @EmployeeID,@FromDate,@ToDate, @FromDay,@ToDay,@FromMonth,@ToMonth,@FromYear, @ToYear
END 
Close @Cur 

SELECT SUM(TotalTime) AS TotalTime, SUM(TotalDay) AS TotalDay FROM #TotalTime

DROP TABLE #TotalTime





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
