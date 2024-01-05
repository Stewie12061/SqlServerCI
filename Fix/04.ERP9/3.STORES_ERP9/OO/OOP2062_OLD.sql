IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2062_OLD]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2062_OLD]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Đẩy dữ liệu từ đơn xin phép sau khi duyệt xuống HRM
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
----Modified by Bảo Anh on 31/08/2018: Fix lỗi chỉ innsert được công cho ngày cuối khi xin nghỉ nhiều ngày
/*-- <Example>
exec OOP2062_OLD 'MK', 'ASOFTADMIN', 2, 2016, 'F2EC6A20-0991-421F-BFC0-1D35961C6C56',1
EXEC OOP2062_OLD 'MK',N'J2278',6,2016,'EB45FC56-6655-41CA-B8FD-002E8D4BD0B9',1
----*/

CREATE PROCEDURE OOP2062_OLD
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @TranMonth INT,
  @TranYear INT,
  @APKMaster VARCHAR(50),
  @Status TINYINT =1
) 
AS 
DECLARE 
		@sSQL NVARCHAR(MAX)='',
		@sSQL1 NVARCHAR(MAX)='',
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
		@DateName VARCHAR(50)

SET @DateName = ''

SET @ID = (SELECT ID FROM OOT9000 WHERE APK = @APKMaster)

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT APK,EmployeeID,LeaveFromDate,LeaveToDate,TotalTime,
DAY(LeaveFromDate) AS FromDay,DAY(LeaveToDate) AS ToDay,
MONTH(LeaveFromDate) AS FromMonth,MONTH(LeaveToDate) AS ToMonth,
YEAR(LeaveFromDate) AS FromYear,YEAR(LeaveToDate) AS ToYear, AbsentTypeID, ShiftID, LeaveFromDate,LeaveToDate
FROM OOT2010
WHERE DivisionID= @DivisionID
AND APKMaster=@APKMaster
AND ISNULL([Status],0)=1


OPEN @Cur
FETCH NEXT FROM @Cur INTO @APK,@EmployeeID,@LeaveFromDate,@LeaveToDate,@TotalTime, @FromDay,@ToDay,@FromMonth,@ToMonth,@FromYear,
@ToYear,@AbsentTypeID, @ShiftID, @FromWorkingDate,@ToWorkingDate
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
			IF @i = @FromDay 
			BEGIN
				SET @BeginTimePre =  CONVERT(DATETIME,LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) +' '+'00:00:00',120)
				SET @EndTimePre = CONVERT(DATETIME,LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) +' '+'00:00:00',120)
			END
			
			IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
			ELSE SET @s = CONVERT(VARCHAR, @i)
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
			 DECLARE @ShiftID'+@s+' NVARCHAR(50), @Begintime'+@s+' DATETIME,@Endtime'+@s+' DATETIME, @Workingtime'+@s+' DECIMAL(28,8),@TotalTime'+@s+' DECIMAL(28,8), @DateTypeID'+@s+' NVARCHAR(50)
			 SET @ShiftID'+@s+' = ( SELECT '+@Col+' 
									FROM HT1025
									WHERE DivisionID='''+@DivisionID+'''
									AND  EmployeeID= '''+@EmployeeID+'''
									AND TranMonth='+STR(@iMonthLast)+'
									AND TranYear='+STR(@iYear)+')

			SET @DateTypeID'+@s+' = LEFT(DATENAME(dw,'''+CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120)+'''),3)
			
			SET @begintime'+@s+' = CAST('''+CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120)+'''+'' ''+(SELECT CONVERT(DATETIME,BeginTime) FROM ht1020 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND ShiftID=@ShiftID'+@s+') AS DATETIME)								
			
			SET @Endtime'+@s+' = CASE WHEN exists (SELECT TOP 1 1 FROM HT1021 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND ShiftID=@ShiftID'+@s+' AND IsNextDay=1 AND IsOvertime = 0)
								
									  THEN CAST('''+CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120)+'''+'' ''+(SELECT TOP 1 CONVERT(DATETIME,ToMinute) FROM HT1021 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND ShiftID=@ShiftID'+@s+' AND DateTypeID = @DateTypeID'+@s+' AND IsOvertime = 0 ORDER BY ToMinute DESC) AS DATETIME)+1 
								
								ELSE CAST('''+CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120)+'''+'' ''+(SELECT TOP 1 CONVERT(DATETIME,ToMinute) FROM HT1021 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND ShiftID=@ShiftID'+@s+' AND DateTypeID = @DateTypeID'+@s+' AND IsOvertime = 0 ORDER BY ToMinute DESC) AS DATETIME) END
						
			SET @Workingtime'+@s+' = DATEDIFF(hh,@begintime'+@s+',@Endtime'+@s+')
								 
			-----TÍNH TOTALTIME
			IF '''+CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120)+''' = '''+Convert(VARCHAR(10),@FromWorkingDate,120)+'''
				BEGIN
					IF '''+Convert(VARCHAR(10),@ToWorkingDate,120)+''' = '''+Convert(VARCHAR(10),@FromWorkingDate,120)+'''
						IF (SELECT CustomerName FROM CustomerIndex) = 81
							BEGIN 
								IF '''+Convert(VARCHAR(50),@ToWorkingDate,120)+''' < @Endtime'+@s+'
									SET @TotalTime'+@s+' = CONVERT(DECIMAL(28,8),DATEDIFF(mi,convert(DATETIME,@begintime'+@s+',120),CAST('''+CONVERT(NVARCHAR(50),@ToWorkingDate,120)+''' AS DATETIME)))/ 60
								ELSE
									SET @TotalTime'+@s+' = @Workingtime'+@s+'
							END
						ELSE
							SET @TotalTime'+@s+' = @Workingtime'+@s+'
					ELSE
						SET @TotalTime'+@s+' = DATEDIFF(hh,CAST('''+CONVERT(NVARCHAR(50),@LeaveFromDate,120)+''' AS DATETIME),convert(DATETIME,@Endtime'+@s+',120))
				END
	
			ELSE IF '''+CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS DATETIME),120)+''' ='''+Convert(VARCHAR(10),@ToWorkingDate,120)+'''
			AND '''+Convert(VARCHAR(10),@FromWorkingDate,120)+''' <> '''+Convert(VARCHAR(10),@ToWorkingDate,120)+'''
			BEGIN
			
					IF CAST('''+CONVERT(NVARCHAR(50),@LeaveToDate,120)+''' AS DATETIME) BETWEEN CAST('''+CONVERT(NVARCHAR(50),@BeginTimePre,120)+''' AS DATETIME) AND CAST('''+CONVERT(NVARCHAR(50),@EndTimePre,120)+''' AS DATETIME)
						SET @TotalTime'+@s+' = DATEDIFF(hh,CAST('''+CONVERT(NVARCHAR(50),@BeginTimePre,120)+''' AS DATETIME),CAST('''+CONVERT(NVARCHAR(50),@LeaveToDate,120)+''' AS DATETIME))
					ELSE
						SET @TotalTime'+@s+' = DATEDIFF(hh,convert(DATETIME,@begintime'+@s+',120),CAST('''+CONVERT(NVARCHAR(50),@LeaveToDate,120)+''' AS DATETIME))
			END	
			ELSE	SET @TotalTime'+@s+' = @Workingtime'+@s+' '
		
			SET @sSQL1 = '
				
			--SELECT '''+@EmployeeID+''',@ShiftID'+@s+' ShiftID'+@s+', @begintime'+@s+' begintime'+@s+', @Workingtime'+@s+' Workingtime'+@s+',@Endtime'+@s+' Endtime'+@s+',@TotalTime'+@s+' TotalTime'+@s+'
			
			---- INSERT DỮ LIỆU
			IF EXISTS (SELECT TOP 1 1 FROM OOT2010 
						   LEFT JOIN OOT1000 ON OOT1000.DivisionID = OOT2010.DivisionID AND OOT1000.AbsentTypeID = '''+@AbsentTypeID+'''
						   LEFT JOIN HT1013 H13 ON H13.DivisionID = OOT2010.DivisionID AND H13.AbsentTypeID = OOT1000.TypeID
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
													(-1)* @TotalTime'+@s+'
												ELSE
													@TotalTime'+@s+'
											END											   
					FROM HT2401_MK OOT10
					INNER JOIN OOT9000 OT90 ON OT90.DivisionID = OOT10.DivisionID AND OT90.APK = OOT10.APKMaster
					LEFT JOIN OOT1000 OOT00 ON OOT00.DivisionID = OOT10.DivisionID AND OOT00.AbsentTypeID = '''+@AbsentTypeID+'''
					LEFT JOIN HT1013 H13 ON H13.DivisionID = OOT00.DivisionID AND H13.AbsentTypeID = OOT00.TypeID
					WHERE OOT10.DivisionID = '''+@DivisionID+''' AND OOT10.EmployeeID = '''+@EmployeeID+''' AND OOT10.APKMaster = '''+@APKMaster+''' 
					AND OOT10.AbsentDate = CONVERT(DATETIME,'''+CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120)+''')-1
				END
				ELSE
				BEGIN
					INSERT INTO HT2401_MK (APKMaster, DivisionID, AbsentDate, EmployeeID,
								TranMonth, DepartmentID, TranYear, TeamID, AbsentTypeID,
								AbsentAmount, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
								
					SELECT DISTINCT '''+@APKMaster+''','''+@DivisionID+''',
							CONVERT(DATE,'''+CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120)+'''),
							'''+@EmployeeID+''',  '+STR(@iMonthLast)+',HT14.DepartmentID,'+STR(@iYear)+',HT14.TeamID, OOT00.TypeID,
							(CASE  WHEN  H13.TypeID=''NB'' OR  H13.TypeID=''CN'' THEN								
						   				-(CASE WHEN H13.UnitID=''H'' THEN @TotalTime'+@s+' ELSE @TotalTime'+@s+'/8 END)
							ELSE								
										(CASE WHEN H13.UnitID=''H'' THEN @TotalTime'+@s+' ELSE @TotalTime'+@s+'/8 END)
							END	),
							'''+@UserID+''',OT90.CreateDate,'''+@UserID+''',GETDATE()
					FROM OOT2010 OOT10
					INNER JOIN OOT9000 OT90 ON OT90.DivisionID = OOT10.DivisionID AND OT90.APK = OOT10.APKMaster
					LEFT JOIN OOT1000 OOT00 ON OOT00.DivisionID = OOT10.DivisionID AND OOT00.AbsentTypeID = '''+@AbsentTypeID+'''
					LEFT JOIN HT1013 H13 ON H13.DivisionID = OOT00.DivisionID AND H13.AbsentTypeID = OOT00.TypeID
					LEFT JOIN HT1400 HT14 ON HT14.DivisionID = OOT10.DivisionID AND HT14.EmployeeID = '''+@EmployeeID+'''						  
					WHERE OOT10.DivisionID='''+@DivisionID +'''
					AND OOT10.APKMaster ='''+@APKMaster+'''
					AND H13.TypeID NOT IN (''OT'',''C'')
					AND ISNULL(OOT10.Status,0)=1 
					AND OOT10.EmployeeID = '''+@EmployeeID+'''
					
				END	   
			END
				'

			EXEC(@sSQL+@sSQL1)
			--PRINT (@sSQL)
			--PRINT (@sSQL1)
			
			SET @DateName = LEFT(DATENAME(dw,CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME)),3)

			SET @BeginTimePre = (SELECT CONVERT(DATETIME,LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i)+' '+BeginTime,120) FROM HT1020 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND ShiftID=@Shitidtmp)
			
			SET @EndTimePre = CASE WHEN EXISTS (SELECT TOP 1 1 FROM HT1021 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND ShiftID=@Shitidtmp AND IsnextDay=1 AND IsOverTime = 0) 
								   THEN (SELECT TOP 1 CONVERT(DATETIME,LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i)+' '+ToMinute,120)+1 FROM HT1021 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND ShiftID=@Shitidtmp AND DateTypeID = @DateName AND IsOverTime = 0 ORDER BY ToMinute DESC)
							  ELSE (SELECT TOP 1 CONVERT(DATETIME,LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i)+' '+ToMinute,120) FROM HT1021 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND ShiftID=@Shitidtmp AND DateTypeID = @DateName AND IsOverTime = 0 ORDER BY ToMinute DESC) END
								
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
