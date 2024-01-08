IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2062]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2062]
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
----Modified by Bảo Anh on 03/01/2019: Bổ sung WITH (NOLOCK), lưu thêm APKDetail cho HT2401_MK
----Modified by Bảo Anh on 20/02/2019: Không lấy thời gian OT khi tính số giờ nghỉ phép
----Modified by Như Hàn on 18/07/2019: Bổ sung Customer cho NewToyo trường hợp có số giờ làm <> giờ công tiêu chuẩn của hệ thống, sửa xin phép nửa ngày mà tính là 1 ngày phép
----Modified by Như Hàn on 06/08/2019: Sửa lại nếu số giờ công là lẻ thì làm tròn thành 1 ngày hoặc nửa ngày
----Modified by Hoang Vu on 21/07/2020: Khi duyet don xin phep day ve HRM chua su dung quy dinh.
----Modified by Đình Hòa on 29/01/2021: chuyển đổi dữ liệu trung gian HT2401_MK sang bảng chấm công HT2401 không sử dụng quy định lock thời gian(CBD : CustomerIndex = 130)
----Modified by Văn Tài	 on 17/05/2021: Bổ sung kiểm tra ISNULL cho một trường hợp dữ liệu null vào cộng chuỗi SQL bị mất toàn bộ.
----Modified by Huỳnh Thử on 12/08/2021: Loại công Phép thì không cần check tới quy định
----Modified by Kiều Nga on 15/06/2022: Không sử dụng quy định lock thời gian khi insert HT2401_MK (CBD : CustomerIndex = 105)
----Modified by Văn Tài  on 30/06/2022: Tách Store Minh Trị để xử lý tính BreakTime giữa các khoảng.
----Modified by Văn Tài  on 06/04/2022: Xử lý trường hợp LQ kết chuyển từ tính phép thằng từ OOT2010 qua chứ không tính lại.
----Modified by Kiều Nga on 20/05/2023: Duyệt đơn xin phép , đơn xin đổi ca thì ca thay đổi không cập nhật vào bảng phân ca ở erp8 (MEIKO : CustomerIndex = 50)
----Modified by Nhựt Trường on 07/07/2023: [2023/07/IS/0003] - Điều chỉnh lấy dữ liệu FromWorkingDate thay LeaveFromDate ở đơn xin phép, fix lỗi cập nhật sai ca nếu là ca đêm.
----Modified by Kiều Nga on 24/07/2023: [2023/07/IS/0075] Tách store cho Meiko (fix lỗi đơn xin phép đã duyệt, cập nhật ca rồi nhưng khi chấm công lại không tính được giờ nghỉ phép)

/*-- <Example>
exec oop2062 'MK', 'ASOFTADMIN', 2, 2016, 'F2EC6A20-0991-421F-BFC0-1D35961C6C56',1
EXEC OOP2062 'MK',N'J2278',6,2016,'EB45FC56-6655-41CA-B8FD-002E8D4BD0B9',1
----*/

CREATE PROCEDURE OOP2062
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
		@sSQL12 VARCHAR(MAX)='',
		@sSQL13 VARCHAR(MAX)='',
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
		@DateName VARCHAR(50),
		@CustomerIndex INT = (SELECT TOP 1 CustomerName FROM CustomerIndex WITH (NOLOCK)),
		@Type VARCHAR(50)

IF @CustomerIndex = 92 AND @DivisionID = N'MT'
BEGIN
	EXEC OOP2062_MT 
	@DivisionID = @DivisionID,
	@UserID = @UserID,
	@TranMonth = @TranMonth,
	@TranYear = @TranYear,
	@APKMaster = @APKMaster,
	@Status = @Status,
	@APKDetail = @APKDetail

END
IF @CustomerIndex = 50 -- Customize cho Meiko
BEGIN
	EXEC OOP2062_MK @DivisionID = @DivisionID,@UserID = @UserID,@TranMonth = @TranMonth,@TranYear = @TranYear,@APKMaster = @APKMaster,@Status = @Status,@APKDetail = @APKDetail
END
ELSE
BEGIN

SET @DateName = ''
--SET @ID = (SELECT ID FROM OOT9000 WITH (NOLOCK) WHERE APK = @APKMaster)
SELECT @ID= ID, @Type=Type FROM OOT9000 WITH (NOLOCK) WHERE APK = @APKMaster


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
FROM OOT2010 WITH(NOLOCK)
WHERE DivisionID= @DivisionID
	AND APKMaster=@APKMaster
	AND APK = @APKDetail
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

			SET @s = ISNULL(@s, '')
			SET @Col = 'D'+@s
			
			-----Update ca thay đổi HT1025
			IF ISNULL(@ShiftID,'') <> '' 
				AND EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) WHERE DivisionID=@DivisionID AND EmployeeID=@EmployeeID AND TranMonth=@iMonthLast AND TranYear=@iYear) 
				AND (@Type = N'DXDC' OR @Type = N'BPC' OR @CustomerIndex =50)
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
				AND EXISTS (SELECT TOP 1 1 FROM OOT2000 WITH (NOLOCK)
							LEFT JOIN OOT9000 WITH (NOLOCK) ON OOT2000.APKMaster=OOT9000.APK
							WHERE OOT2000.DivisionID=@DivisionID AND EmployeeID=@EmployeeID AND TranMonth=@iMonthLast AND TranYear=@iYear)
			BEGIN
				SET @sSQL3=N'UPDATE  T1 
							SET D'+@s+'='''+@ShiftID+''' ,
								Note = N''Changed shift from '+@ID+'''
							FROM OOT2000 T1
							LEFT JOIN OOT9000 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T2.APK = T1.APKMaster
						    WHERE T1.DivisionID='''+@DivisionID+''' 
							AND T1.EmployeeID='''+@EmployeeID +'''
							AND T2.TranMonth='+STR(@iMonthLast)+'
							AND T2.TranYear='+STR(@iYear)+''
			END

			EXEC (@sSQL2+@sSQL3)

			----Lấy ca làm việc
			DECLARE @sqltmp NVARCHAR(MAX),
					@Shitidtmp NVARCHAR(50)

			SET @sqltmp = 'SELECT @Shitidtmp = '+@Col+' FROM HT1025 WITH (NOLOCK)
							WHERE DivisionID='''+@DivisionID +'''
							AND EmployeeID= '''+@EmployeeID +'''
							AND TranMonth='+str(@iMonthLast) +'
							AND TranYear='+str(@iYear)+''
														
			EXEC sp_executesql @sqltmp
									,N'@Shitidtmp VARCHAR(50) OUTPUT',
									@Shitidtmp=@Shitidtmp OUTPUT
			
			----Kiểm tra ca đêm

			SET @sSQL = '	
			 DECLARE @ShiftID'+ISNULL(@s, '')+' NVARCHAR(50), @Begintime'+ISNULL(@s, '')+' DATETIME,@Endtime'+ISNULL(@s, '')+' DATETIME, @Workingtime'+ISNULL(@s, '')+' DECIMAL(28,8),@TotalTime'+ISNULL(@s, '')+' DECIMAL(28,8)
			 SET @ShiftID'+ISNULL(@s, '')+' = ( SELECT '+ISNULL(@Col, '')+' 
									FROM HT1025 WITH (NOLOCK)
									WHERE DivisionID='''+ISNULL(@DivisionID, '')+'''
									AND  EmployeeID= '''+ISNULL(@EmployeeID, '')+'''
									AND TranMonth='+ISNULL(STR(@iMonthLast), '')+'
									AND TranYear='+ISNULL(STR(@iYear), '')+')	
			
			SET @begintime'+ISNULL(@s, '')+' = CAST('''+ISNULL(CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120), '')+'''+'' ''+(SELECT CONVERT(DATETIME,BeginTime) FROM ht1020 WHERE DivisionID = '''+ISNULL(@DivisionID, '')+''' AND ShiftID=@ShiftID'+ISNULL(@s, '')+') AS DATETIME)								
			
			SET @Endtime'+ISNULL(@s, '')+' = CASE WHEN exists (SELECT TOP 1 1 FROM HT1021  WITH (NOLOCK)  WHERE DivisionID = '''+ISNULL(@DivisionID, '')+''' AND ShiftID=@ShiftID'+ISNULL(@s, '')+' AND IsNextDay=1)
								
									  THEN CAST('''+ISNULL(CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120), '')+'''+'' ''+(SELECT CONVERT(DATETIME,EndTime) FROM ht1020 WHERE DivisionID = '''+ISNULL(@DivisionID, '')+''' AND ShiftID=@ShiftID'+ISNULL(@s, '')+') AS DATETIME)+1 
								
								ELSE CAST('''+ISNULL(CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120), '')+'''+'' ''+(SELECT CONVERT(DATETIME,EndTime) FROM ht1020 WHERE DivisionID = '''+@DivisionID+''' AND ShiftID=@ShiftID'+@s+') AS DATETIME) END
						
			SET @Workingtime'+ISNULL(@s, '')+' = (SELECT WorkingTime FROM HT1020  WITH (NOLOCK)  WHERE DivisionID = '''+ISNULL(@DivisionID, '')+''' AND ShiftID=@ShiftID'+ISNULL(@s, '')+')
					 
			-----TÍNH TOTALTIME
			IF '''+ISNULL(CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120), '')+''' = '''+ISNULL(Convert(VARCHAR(10),@FromWorkingDate,120), '')+'''
				BEGIN

					IF '''+ISNULL(Convert(VARCHAR(10),@ToWorkingDate,120)+''' = '''+Convert(VARCHAR(10),@FromWorkingDate,120), '')+'''
						SET @TotalTime'+ISNULL(@s, '')+' = DATEDIFF(minute,CAST('''+ISNULL(CONVERT(NVARCHAR(50),@LeaveFromDate,120), '')+''' AS DATETIME),CAST('''+ISNULL(CONVERT(NVARCHAR(50),@LeaveToDate,120), '')+''' AS DATETIME))/60.0
				
					ELSE
						SET @TotalTime'+ISNULL(@s, '')+' = DATEDIFF(minute,CAST('''+ISNULL(CONVERT(NVARCHAR(50),@LeaveFromDate,120), '')+''' AS DATETIME),convert(DATETIME,@Endtime'+ISNULL(@s, '')+',120))/60.0
				END
	
			ELSE 
			IF '''+ISNULL(CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS DATETIME),120), '')+''' ='''+ISNULL(Convert(VARCHAR(10),@ToWorkingDate,120), '')+'''
			AND '''+ISNULL(Convert(VARCHAR(10),@FromWorkingDate,120), '')+''' <> '''+ISNULL(Convert(VARCHAR(10),@ToWorkingDate,120), '')+'''
			BEGIN
					
					IF CAST('''+ISNULL(CONVERT(NVARCHAR(50),@LeaveToDate,120), '')+''' AS DATETIME) BETWEEN CAST('''+ISNULL(CONVERT(NVARCHAR(50),@BeginTimePre,120), '')+''' AS DATETIME) AND CAST('''+ISNULL(CONVERT(NVARCHAR(50),@EndTimePre,120), '')+''' AS DATETIME)
						SET @TotalTime'+ISNULL(@s, '')+' = DATEDIFF(minute,CAST('''+ISNULL(CONVERT(NVARCHAR(50),@BeginTimePre,120), '')+''' AS DATETIME),CAST('''+ISNULL(CONVERT(NVARCHAR(50),@LeaveToDate,120), '')+''' AS DATETIME))/60.0
					ELSE
						SET @TotalTime'+ISNULL(@s, '')+' = DATEDIFF(minute,convert(DATETIME,@begintime'+ISNULL(@s, '')+',120),CAST('''+ISNULL(CONVERT(NVARCHAR(50),@LeaveToDate,120), '')+''' AS DATETIME))/60.0
			END	
			ELSE	SET @TotalTime'+ISNULL(@s, '')+' = @Workingtime'+ISNULL(@s, '')+' 
			-- Nếu ngày lớn hơn BPC thì = Thời gian trong BPC
				IF @TotalTime'+ISNULL(@s, '')+' > @Workingtime'+ISNULL(@s, '')+'
					SET @TotalTime'+ISNULL(@s, '')+' = @Workingtime'+ISNULL(@s, '')+'
			 '		
			SET @sSQL1 = '
				
			----SELECT '''+ISNULL(@EmployeeID, '')+''',@ShiftID'+@s+' ShiftID'+@s+', @begintime'+@s+' begintime'+@s+', @Workingtime'+@s+' Workingtime'+@s+',@Endtime'+@s+' Endtime'+@s+',@TotalTime'+@s+' TotalTime'+@s+'
			
			---- INSERT DỮ LIỆU
			IF EXISTS (SELECT TOP 1 1 FROM OOT2010 WITH (NOLOCK) 
						   LEFT JOIN OOT1000 WITH (NOLOCK) ON OOT1000.DivisionID = OOT2010.DivisionID AND OOT1000.AbsentTypeID = '''+@AbsentTypeID+'''
						   LEFT JOIN HT1013 H13 WITH (NOLOCK) ON H13.DivisionID = OOT2010.DivisionID AND H13.AbsentTypeID = OOT1000.TypeID
						   WHERE OOT2010.DivisionID='''+ISNULL(@DivisionID, '') +'''
						   AND OOT2010.APKMaster ='''+ISNULL(@APKMaster, '')+'''
						   AND OOT2010.EmployeeID = '''+ISNULL(@EmployeeID, '')+'''
						   AND H13.TypeID NOT IN (''OT'',''C'')
						   AND ISNULL(OOT2010.Status,0)=1)
						   
			BEGIN
				---Trường hợp ca đêm xin nghỉ qua ngày hôm sau thì ko insert mà update trên dòng của ngày trước đó	
				IF '+ISNULL(STR(@i), '')+' = '+ISNULL(STR(@iDay), '')+' 
				AND '+ISNULL(STR(@i), '')+' <> '+ISNULL(STR(@FromDay), '')+' 
				AND CAST('''+ISNULL(CONVERT(NVARCHAR(50),@LeaveToDate,120), '')+''' AS DATETIME) BETWEEN CAST('''+ISNULL(CONVERT(NVARCHAR(50),@BeginTimePre,120), '')+''' AS DATETIME) AND CAST('''+ISNULL(CONVERT(NVARCHAR(50),@EndTimePre,120), '')+''' AS DATETIME)
				BEGIN
					UPDATE OOT10
					SET OOT10.AbsentAmount = CASE  WHEN  H13.TypeID=''NB'' OR  H13.TypeID=''CN'' THEN  
												(-1)* @TotalTime'+@s+'
											ELSE
												@TotalTime'+@s+'
											END											   
					FROM HT2401_MK OOT10
					INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.DivisionID = OOT10.DivisionID AND OT90.APK = OOT10.APKMaster
					LEFT JOIN OOT1000 OOT00 WITH (NOLOCK) ON OOT00.DivisionID = OOT10.DivisionID AND OOT00.AbsentTypeID = '''+ISNULL(@AbsentTypeID, '')+'''
					LEFT JOIN HT1013 H13 WITH (NOLOCK) ON H13.DivisionID = OOT00.DivisionID AND H13.AbsentTypeID = OOT00.TypeID
					WHERE OOT10.DivisionID = '''+ISNULL(@DivisionID, '')+''' AND OOT10.EmployeeID = '''+ISNULL(@EmployeeID, '')+''' AND OOT10.APKMaster = '''+ISNULL(@APKMaster, '')+''' AND OOT10.APKDetail = ''' + ISNULL(@APK, '') + '''
					AND OOT10.AbsentDate = CONVERT(DATETIME,'''+ISNULL(CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120), '')+''')-1
				END
				ELSE
				BEGIN
				'
			SET @sSQL12 = '
		
			----SELECT '''+@EmployeeID+''',@ShiftID'+@s+' ShiftID'+@s+', @begintime'+@s+' begintime'+@s+', @Workingtime'+@s+' Workingtime'+@s+',@Endtime'+@s+' Endtime'+@s+',@TotalTime'+@s+' TotalTime'+@s+'
					IF (SELECT CustomerName FROM CustomerIndex) = 81
						BEGIN 
						--select CAST('''+CONVERT(NVARCHAR(50),@BeginTimePre,120)+''' AS DATETIME)
								SELECT DISTINCT '''+@APKMaster+''' APKMaster ,'''+@DivisionID+''' DivisionID,
										CONVERT(DATE,'''+CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120)+''') AbsentDate,
										'''+@EmployeeID+''' EmployeeID,  '+STR(@iMonthLast)+' TranMonth, HT14.DepartmentID,'+STR(@iYear)+' TranYear,
										HT14.TeamID, OOT00.TypeID AbsentTypeID,
										(CASE  WHEN  H13.TypeID=''NB'' OR  H13.TypeID=''CN'' THEN								
						   							-(CASE WHEN H13.UnitID=''H'' THEN 
													@TotalTime'+@s+' ELSE 
													CASE WHEN ISNULL(TH131.C30,0) <> 0 THEN @TotalTime'+@s+'/TH131.C30 ELSE
													@TotalTime'+@s+'/8 END END)
										ELSE								
													(CASE WHEN H13.UnitID=''H'' THEN @TotalTime'+@s+' ELSE 
													CASE WHEN ISNULL(TH131.C30,0) <> 0 THEN @TotalTime'+@s+'/TH131.C30 ELSE
													@TotalTime'+@s+'/8 END END)
										END	) AbsentAmount ,
										'''+@UserID+''' CreateUserID ,OT90.CreateDate,'''+@UserID+''' LastModifyUserID,GETDATE() LastModifyDate,''' + @APK + ''' APKDetail,
										H13.TypeID
								INTO  #HT2401
								FROM OOT2010 OOT10 WITH (NOLOCK)
								INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.DivisionID = OOT10.DivisionID AND OT90.APK = OOT10.APKMaster
								LEFT JOIN OOT1000 OOT00 WITH (NOLOCK) ON OOT00.DivisionID = OOT10.DivisionID AND OOT00.AbsentTypeID = '''+@AbsentTypeID+'''
								LEFT JOIN HT1013 H13 WITH (NOLOCK) ON H13.DivisionID = OOT00.DivisionID AND H13.AbsentTypeID = OOT00.TypeID
								LEFT JOIN HT1400 HT14 WITH (NOLOCK) ON HT14.DivisionID = OOT10.DivisionID AND HT14.EmployeeID = '''+@EmployeeID+'''		
								LEFT JOIN HT1403_1 TH131 WITH (NOLOCK) ON TH131.DivisionID = OOT10.DivisionID AND TH131.EmployeeID = '''+@EmployeeID+'''		
								WHERE OOT10.DivisionID='''+@DivisionID +'''
								AND OOT10.APKMaster ='''+@APKMaster+'''
								AND OOT10.APK = ''' + @APK + '''
								AND H13.TypeID NOT IN (''OT'',''C'')
								AND ISNULL(OOT10.Status,0)=1 
								AND OOT10.EmployeeID = '''+@EmployeeID+'''

								INSERT INTO HT2401_MK (APKMaster, DivisionID, AbsentDate, EmployeeID,
											TranMonth, DepartmentID, TranYear, TeamID, AbsentTypeID,
											AbsentAmount, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, APKDetail)
								SELECT OOT10.APKMaster, OOT10.DivisionID, OOT10.AbsentDate, OOT10.EmployeeID,
											OOT10.TranMonth, ISNULL(OOT10.DepartmentID,''''), OOT10.TranYear, OOT10.TeamID, OOT10.AbsentTypeID,
											CASE ISNULL(TH131.C30,0) 
											WHEN 0 THEN CASE WHEN OOT10.AbsentAmount <= 4 THEN 4 ELSE 8 END
											ELSE CASE WHEN OOT10.AbsentAmount <= 4.5 THEN 4.5 ELSE 9 END END AbsentAmount, 
											OOT10.CreateUserID, OOT10.CreateDate, OOT10.LastModifyUserID, OOT10.LastModifyDate, OOT10.APKDetail
								FROM #HT2401 OOT10
								LEFT JOIN HT1403_1 TH131 WITH (NOLOCK) ON TH131.DivisionID = OOT10.DivisionID AND TH131.EmployeeID = OOT10.EmployeeID
								WHERE OOT10.TypeID =''P''

								INSERT INTO HT2401_MK (APKMaster, DivisionID, AbsentDate, EmployeeID,
											TranMonth, DepartmentID, TranYear, TeamID, AbsentTypeID,
											AbsentAmount, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, APKDetail)
								SELECT OOT10.APKMaster, OOT10.DivisionID, OOT10.AbsentDate, OOT10.EmployeeID,
											OOT10.TranMonth, ISNULL(OOT10.DepartmentID,''''), OOT10.TranYear, OOT10.TeamID, OOT10.AbsentTypeID,
											OOT10.AbsentAmount, 
											OOT10.CreateUserID, OOT10.CreateDate, OOT10.LastModifyUserID, OOT10.LastModifyDate, OOT10.APKDetail
								FROM #HT2401 OOT10
								LEFT JOIN HT1403_1 TH131 WITH (NOLOCK) ON TH131.DivisionID = OOT10.DivisionID AND TH131.EmployeeID = OOT10.EmployeeID
								WHERE OOT10.TypeID !=''P''

						END
					ELSE 
						'
		IF NOT EXISTS(SELECT TOP 1 1 FROM CustomerIndex WITH (NOLOCK) WHERE CustomerName = 130 OR CustomerName = 105)
		BEGIN
			declare @TypeID nvarchar(50)
			select @TypeID = H13.TypeID   FROM OOT2010 OOT10 WITH (NOLOCK)     
				LEFT JOIN OOT1000 OOT00 WITH (NOLOCK) ON OOT00.DivisionID = OOT10.DivisionID AND OOT00.AbsentTypeID = 'PN'    
				LEFT JOIN HT1013 H13 WITH (NOLOCK) ON H13.DivisionID = OOT00.DivisionID AND H13.AbsentTypeID = OOT00.TypeID 
				where OOT10.APK = @APK

			if @TypeID = 'P'
			begin
			SET @sSQL13 = '
						BEGIN
						
							INSERT INTO HT2401_MK (APKMaster, DivisionID, AbsentDate, EmployeeID,
										TranMonth, DepartmentID, TranYear, TeamID, AbsentTypeID,
										AbsentAmount, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, APKDetail)
								
							SELECT DISTINCT '''+@APKMaster+''','''+@DivisionID+''',
									CONVERT(DATE,'''+CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120)+'''),
									'''+@EmployeeID+''',  '+STR(@iMonthLast)+',ISNULL(HT14.DepartmentID,''''),'+STR(@iYear)+',HT14.TeamID, OOT00.TypeID,
									
									(CASE  WHEN  H13.TypeID=''NB'' OR  H13.TypeID=''CN'' THEN								
						   						-(CASE WHEN H13.UnitID=''H'' THEN @TotalTime'+@s+' ELSE Convert(decimal(28,8),@TotalTime'+@s+')/8 END)
									ELSE								
												(CASE WHEN H13.UnitID=''H'' THEN @TotalTime'+@s+' ELSE Convert(decimal(28,8),@TotalTime'+@s+')/8 END)
									END	),
									/*--->>>su dung quy dinh lock thoi gian
									(CASE  WHEN  H13.TypeID=''NB'' OR  H13.TypeID=''CN'' THEN								
						   						-(CASE WHEN H13.UnitID=''H'' THEN Convert(decimal(28,8),T2.SubMinute)/60 ELSE Convert(decimal(28,8),T2.SubMinute)/8/60 END)
									ELSE								
												(CASE WHEN H13.UnitID=''H'' THEN Convert(decimal(28,8),T2.SubMinute)/60 ELSE Convert(decimal(28,8),T2.SubMinute)/8/60 END)
									END	),*/
									---<<<su dung quy dinh lock thoi gian
									'''+@UserID+''',OT90.CreateDate,'''+@UserID+''',GETDATE(),''' + @APK + '''
							FROM OOT2010 OOT10 WITH (NOLOCK)
							INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.DivisionID = OOT10.DivisionID AND OT90.APK = OOT10.APKMaster
							LEFT JOIN OOT1000 OOT00 WITH (NOLOCK) ON OOT00.DivisionID = OOT10.DivisionID AND OOT00.AbsentTypeID = '''+@AbsentTypeID+'''
							LEFT JOIN HT1013 H13 WITH (NOLOCK) ON H13.DivisionID = OOT00.DivisionID AND H13.AbsentTypeID = OOT00.TypeID
							LEFT JOIN HT1400 HT14 WITH (NOLOCK) ON HT14.DivisionID = OOT10.DivisionID AND HT14.EmployeeID = '''+@EmployeeID+'''	
							--->>>su dung quy dinh lock thoi gian
							INNER JOIN 
										(SELECT HT1023.FromMinute, HT1023.ToMinute, HT1023.SubMinute
										FROM HT1022 INNER JOIN HT1023 ON HT1022.DivisionID = HT1023.DivisionID AND HT1022.RestrictID = HT1023.RestrictID
										WHERE HT1022.RestrictID = (SELECT RestrictID FROM OOT1000 WHERE AbsentTypeID = '''+@AbsentTypeID+''' AND DivisionID = '''+@DivisionID +''')
										) T2 ON 2 BETWEEN T2.FromMinute AND T2.ToMinute		
							---<<<su dung quy dinh lock thoi gian				  
							WHERE OOT10.DivisionID='''+@DivisionID +'''
							AND OOT10.APKMaster ='''+@APKMaster+'''
							AND OOT10.APK = ''' + @APK + '''
							AND H13.TypeID NOT IN (''OT'',''C'')
							AND ISNULL(OOT10.Status,0)=1 
							AND OOT10.EmployeeID = '''+@EmployeeID+'''
							
						END
					END	   
				END
				'
			end
			else
			begin
			SET @sSQL13 = '
						BEGIN
						
							INSERT INTO HT2401_MK (APKMaster, DivisionID, AbsentDate, EmployeeID,
										TranMonth, DepartmentID, TranYear, TeamID, AbsentTypeID,
										AbsentAmount, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, APKDetail)
								
							SELECT DISTINCT  '''+@APKMaster+''','''+@DivisionID+''',
									CONVERT(DATE,'''+CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120)+'''),
									'''+@EmployeeID+''',  '+STR(@iMonthLast)+',ISNULL(HT14.DepartmentID,''''),'+STR(@iYear)+',HT14.TeamID, OOT00.TypeID,
									
									/*(CASE  WHEN  H13.TypeID=''NB'' OR  H13.TypeID=''CN'' THEN								
						   						-(CASE WHEN H13.UnitID=''H'' THEN @TotalTime'+@s+' ELSE @TotalTime'+@s+'/8 END)
									ELSE								
												(CASE WHEN H13.UnitID=''H'' THEN @TotalTime'+@s+' ELSE @TotalTime'+@s+'/8 END)
									END	),*/
									--->>>su dung quy dinh lock thoi gian
									(CASE  WHEN  H13.TypeID=''NB'' OR  H13.TypeID=''CN'' THEN								
						   						-(CASE WHEN H13.UnitID=''H'' THEN Convert(decimal(28,8),T2.SubMinute)/60 ELSE Convert(decimal(28,8),T2.SubMinute)/8/60 END)
									ELSE								
												(CASE WHEN H13.UnitID=''H'' THEN Convert(decimal(28,8),T2.SubMinute)/60 ELSE Convert(decimal(28,8),T2.SubMinute)/8/60 END)
									END	),
									---<<<su dung quy dinh lock thoi gian
									'''+@UserID+''',OT90.CreateDate,'''+@UserID+''',GETDATE(),''' + @APK + '''
							FROM OOT2010 OOT10 WITH (NOLOCK)
							INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.DivisionID = OOT10.DivisionID AND OT90.APK = OOT10.APKMaster
							LEFT JOIN OOT1000 OOT00 WITH (NOLOCK) ON OOT00.DivisionID = OOT10.DivisionID AND OOT00.AbsentTypeID = '''+@AbsentTypeID+'''
							LEFT JOIN HT1013 H13 WITH (NOLOCK) ON H13.DivisionID = OOT00.DivisionID AND H13.AbsentTypeID = OOT00.TypeID
							LEFT JOIN HT1400 HT14 WITH (NOLOCK) ON HT14.DivisionID = OOT10.DivisionID AND HT14.EmployeeID = '''+@EmployeeID+'''	
							--->>>su dung quy dinh lock thoi gian
							INNER JOIN 
										(SELECT HT1023.FromMinute, HT1023.ToMinute, HT1023.SubMinute
										FROM HT1022 INNER JOIN HT1023 ON HT1022.DivisionID = HT1023.DivisionID AND HT1022.RestrictID = HT1023.RestrictID
										WHERE HT1022.RestrictID = (SELECT RestrictID FROM OOT1000 WHERE AbsentTypeID = '''+@AbsentTypeID+''' AND DivisionID = '''+@DivisionID +''')
										) T2 ON @TotalTime'+@s+'*60 BETWEEN T2.FromMinute AND T2.ToMinute		
							---<<<su dung quy dinh lock thoi gian				  
							WHERE OOT10.DivisionID='''+@DivisionID +'''
							AND OOT10.APKMaster ='''+@APKMaster+'''
							AND OOT10.APK = ''' + @APK + '''
							AND H13.TypeID NOT IN (''OT'',''C'')
							AND ISNULL(OOT10.Status,0)=1 
							AND OOT10.EmployeeID = '''+@EmployeeID+'''
							
						END
					END	   
				END
				'
				end
			END
		ELSE
		BEGIN

				IF (@CustomerIndex = 105) -- LIENQUAN
				BEGIN

					SET @sSQL13 = '
							BEGIN
							--select CAST('''+ISNULL(CONVERT(NVARCHAR(50),@BeginTimePre,120), '')+''' AS DATETIME)
								INSERT INTO HT2401_MK (APKMaster, DivisionID, AbsentDate, EmployeeID,
											TranMonth, DepartmentID, TranYear, TeamID, AbsentTypeID,
											AbsentAmount, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, APKDetail)
								
								SELECT DISTINCT '''+ISNULL(@APKMaster, '')+''','''+ISNULL(@DivisionID, '')+''',
										CONVERT(DATE,'''+ISNULL(CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120), '')+'''),
										'''+ISNULL(@EmployeeID, '')+''',  '+ISNULL(STR(@iMonthLast), '')+',ISNULL(HT14.DepartmentID,''''),'+ISNULL(STR(@iYear), '')+',HT14.TeamID, OOT00.TypeID,
									
										(CASE  WHEN  H13.TypeID=''NB'' OR  H13.TypeID=''CN'' THEN								
						   							-(CASE WHEN H13.UnitID=''H'' THEN OOT10.TotalTime ELSE OOT10.TotalTime/8 END)
										ELSE								
													(CASE WHEN H13.UnitID=''H'' THEN OOT10.TotalTime ELSE OOT10.TotalTime/8 END)
										END	),
										'''+ISNULL(@UserID, '')+''',OT90.CreateDate,'''+ISNULL(@UserID, '')+''',GETDATE(),''' + ISNULL(@APK, '') + '''
								FROM OOT2010 OOT10 WITH (NOLOCK)
								INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.DivisionID = OOT10.DivisionID AND OT90.APK = OOT10.APKMaster
								LEFT JOIN OOT1000 OOT00 WITH (NOLOCK) ON OOT00.DivisionID = OOT10.DivisionID AND OOT00.AbsentTypeID = '''+ISNULL(@AbsentTypeID, '')+'''
								LEFT JOIN HT1013 H13 WITH (NOLOCK) ON H13.DivisionID = OOT00.DivisionID AND H13.AbsentTypeID = OOT00.TypeID
								LEFT JOIN HT1400 HT14 WITH (NOLOCK) ON HT14.DivisionID = OOT10.DivisionID AND HT14.EmployeeID = '''+ISNULL(@EmployeeID, '')+'''		  
								WHERE OOT10.DivisionID='''+ISNULL(@DivisionID, '') +'''
								AND OOT10.APKMaster ='''+ISNULL(@APKMaster, '')+'''
								AND OOT10.APK = ''' + ISNULL(@APK, '') + '''
								AND H13.TypeID NOT IN (''OT'',''C'')
								AND ISNULL(OOT10.Status,0)=1 
								AND OOT10.EmployeeID = '''+ISNULL(@EmployeeID, '')+'''							
							END
						END	   
					END
					'

				END
				ELSE
				BEGIN
				
					SET @sSQL13 = '
							BEGIN
							--select CAST('''+ISNULL(CONVERT(NVARCHAR(50),@BeginTimePre,120), '')+''' AS DATETIME)
								INSERT INTO HT2401_MK (APKMaster, DivisionID, AbsentDate, EmployeeID,
											TranMonth, DepartmentID, TranYear, TeamID, AbsentTypeID,
											AbsentAmount, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, APKDetail)
								
								SELECT DISTINCT '''+ISNULL(@APKMaster, '')+''','''+ISNULL(@DivisionID, '')+''',
										CONVERT(DATE,'''+ISNULL(CONVERT(NVARCHAR(10),CAST(LTRIM(@iYear)+'/'+LTRIM(@iMonthLast)+'/'+LTRIM(@i) AS  DATETIME),120), '')+'''),
										'''+ISNULL(@EmployeeID, '')+''',  '+ISNULL(STR(@iMonthLast), '')+',ISNULL(HT14.DepartmentID,''''),'+ISNULL(STR(@iYear), '')+',HT14.TeamID, OOT00.TypeID,
									
										(CASE  WHEN  H13.TypeID=''NB'' OR  H13.TypeID=''CN'' THEN								
						   							-(CASE WHEN H13.UnitID=''H'' THEN @TotalTime'+@s+' ELSE @TotalTime'+@s+'/8 END)
										ELSE								
													(CASE WHEN H13.UnitID=''H'' THEN @TotalTime'+@s+' ELSE @TotalTime'+@s+'/8 END)
										END	),
										'''+ISNULL(@UserID, '')+''',OT90.CreateDate,'''+ISNULL(@UserID, '')+''',GETDATE(),''' + ISNULL(@APK, '') + '''
								FROM OOT2010 OOT10 WITH (NOLOCK)
								INNER JOIN OOT9000 OT90 WITH (NOLOCK) ON OT90.DivisionID = OOT10.DivisionID AND OT90.APK = OOT10.APKMaster
								LEFT JOIN OOT1000 OOT00 WITH (NOLOCK) ON OOT00.DivisionID = OOT10.DivisionID AND OOT00.AbsentTypeID = '''+ISNULL(@AbsentTypeID, '')+'''
								LEFT JOIN HT1013 H13 WITH (NOLOCK) ON H13.DivisionID = OOT00.DivisionID AND H13.AbsentTypeID = OOT00.TypeID
								LEFT JOIN HT1400 HT14 WITH (NOLOCK) ON HT14.DivisionID = OOT10.DivisionID AND HT14.EmployeeID = '''+ISNULL(@EmployeeID, '')+'''		  
								WHERE OOT10.DivisionID='''+ISNULL(@DivisionID, '') +'''
								AND OOT10.APKMaster ='''+ISNULL(@APKMaster, '')+'''
								AND OOT10.APK = ''' + ISNULL(@APK, '') + '''
								AND H13.TypeID NOT IN (''OT'',''C'')
								AND ISNULL(OOT10.Status,0)=1 
								AND OOT10.EmployeeID = '''+ISNULL(@EmployeeID, '')+'''							
							END
						END	   
					END'
			
				END
			END

			
			PRINT (@sSQL)
			PRINT (@sSQL1)
			PRINT (@sSQL12)
			PRINT (@sSQL13)

			EXEC(@sSQL+@sSQL1+@sSQL12+@sSQL13)

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

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
