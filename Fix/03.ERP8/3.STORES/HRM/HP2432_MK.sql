IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2432_MK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP2432_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO











---Created by: Dang Le Bao Quynh, date: 11/10/2007
---purpose: Xac dinh ca lam viec
/********************************************
'* Edited by: [GS] [Thành Nguyên] [02/08/2010]
----- Edited by Tan Phu		Date: 26/12/2012
----- Purpose: fix trường hợp chuyển nhân viên từ phòng ban này sang phòng bang khác, tối ưu hóa sql HV2433 thêm điều kiện month year
----- Purpose: [ TT4522 ] [TIENHUNG] Hỗ trợ phần chấm công bị double dòng, vấn đề 1
'********************************************/
---Edited by: Dang Le Bao Quynh, date: 07/03/2013
---purpose: Tra ve cach xu ly ban goc, version 7.1
--- Modified on 11/08/2013 by Bảo Anh: Bổ sung lấy thông tin chấm công có giờ vào < giờ bắt đầu ca, giờ ra > giờ kết thúc ca làm việc
--- Modified on 30/10/2013 by Bảo Anh: Bổ sung trường hợp ca đêm khi lấy dữ liệu cho trường AbsentDate ở view HV2433
--- Modified on 01/12/2013 by Bảo Anh: Sửa lỗi chấm công ca đêm chưa đúng trong trường hợp 1 ngày có đủ In/Out
--- Modified on 31/12/2013 by Bảo Anh: Sửa lỗi chấm công không lên khi giờ ra = giờ kết thúc ca (Tiến Hưng: CRM TT7818)
--- Modified on 30/06/2015 by Bảo Anh: Bổ sung chấm công theo từng nhân viên và cải tiến tốc độ
--- Modified on 02/02/2016 by Bảo Anh: Bổ sung chấm công cho ca xin làm thêm giờ ngoài sắp ca (customize Meiko)
--- Modified on 24/02/2016 by Phương Thảo: Chỉnh sửa cách convert kiểu dữ liệu ngày giờ
--- Modified on 02/02/2016 by Bảo Anh: Bỏ where theo thời gian bắt đầu, kết thúc ca khi insert vào HTT2433 (do store HP2433 đã có where)
--- Modified on 21/04/2016 by Bảo Anh: trường hợp quét dư In-Out thì phần mềm tự lấy 2 dòng Min và max của AbsentTime (đưa vào chuẩn)
--- Modified on 20/06/2016 by Bảo Anh: Bổ sung chấm công cho ca nghỉ và không có quét thẻ (ví dụ dưỡng sức, nghỉ thai sản, ...)
--- Modified on 27/06/2016 by Bảo Anh: Chuyển phần set BeginTime = BeginTime -1, EndTime = EndTime + 4 sang customize Meiko
--- Modified on 20/08/2016 by Phương Thảo: Bổ sung xử lý tách bảng nghiệp vụ
--- Modified on 04/10/2016 by Phương Thảo: Bổ sung xử lý ca đêm
--- Modified on 27/04/2017 by Phương Thảo: Chỉnh sửa cách kết chuyển công Bỏ làm
--- Modified on 02/06/2017 by Phương Thảo: Bổ sung điều kiện không có đơn khi sinh tự động công BL
--- Modified on 02/06/2017 by Phương Thảo: Bổ sung sinh tự động giờ công thực tế (nếu bỏ làm)
----HP2432_MK 'IPL',12,2015,'12/05/2015','SAT','%','ADMIN','13081401'

CREATE PROCEDURE [dbo].[HP2432_MK] 
				@DivisionID nvarchar(50),				
				@TranMonth int,
				@TranYear int,
				@DateProcess datetime,
				@DateTypeID nvarchar(3),
				@DepartmentID nvarchar(50),	
				@CreateUserID nvarchar(50),
				@EmployeeID nvarchar(50) = '%'

AS
Declare @curHV2432 cursor,
		@curHV2433 cursor,
		@ShiftID nvarchar(50),
		@MainShiftID nvarchar(50),
		@BeginTime varchar(8),
		@EndTime varchar(8),
		@IsOverTime bit,
		@IsNextDay bit,
		@NextDateProcess datetime,
		@RestrictID nvarchar(50),	
		@EmployeeID1 nvarchar(50),
		@AbsentCardNo nvarchar(50),	
		@sSQL nvarchar(max),
		@sSQL1 nvarchar(max),
		@sSQL2 nvarchar(max),
		@sSQL3 nvarchar(max),
		@sSQL4 nvarchar(max),
		@ParamDefinition NVARCHAR(MAX),
		@CustomerIndex int

DECLARE	@sSQL001 Nvarchar(4000),
		@sSQL002 Nvarchar(4000),
		@TableHT2407 Varchar(50),		
		@sTranMonth Varchar(2),
		@IsAbsentShift Tinyint
		

SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WHERE IsSplitTable = 1)	
BEGIN
	SET  @TableHT2407 = 'HT2407M'+@sTranMonth+Convert(Varchar(4),@TranYear)
END
ELSE
BEGIN
	SET  @TableHT2407 = 'HT2407'
END

SELECT  @ParamDefinition= '@DivisionID2 nvarchar(50), @DateProcess2 datetime, @DepartmentID2 nvarchar(50), @EmployeeID2 nvarchar(50)'
SELECT @CustomerIndex = CustomerName From CustomerIndex
		
Set @sSQL = 	'
Delete from HTT2432
Insert into HTT2432 (DivisionID, EmployeeID, ShiftID, MainShiftID)
Select DivisionID, EmployeeID, ShiftID, MainShiftID
From (
Select HT1025.DivisionID, HT1025.EmployeeID, 
	CASE Day(@DateProcess2)     
    WHEN 1 THEN D01 WHEN 2 THEN D02 WHEN 3 THEN D03 WHEN 4 THEN D04 WHEN 5 THEN D05 WHEN 6 THEN D06 WHEN    
    7 THEN D07 WHEN 8 THEN D08 WHEN 9 THEN D09 WHEN 10 THEN D10 WHEN 11 THEN D11 WHEN 12 THEN D12 WHEN    
    13 THEN D13 WHEN 14 THEN D14 WHEN 15 THEN D15 WHEN 16 THEN D16 WHEN 17 THEN D17 WHEN 18 THEN D18 WHEN    
	19 THEN D19 WHEN 20 THEN D20 WHEN 21 THEN D21 WHEN 22 THEN D22 WHEN 23 THEN D23 WHEN 24 THEN D24 WHEN    
    25 THEN D25 WHEN 26 THEN D26 WHEN 27 THEN D27 WHEN 28 THEN D28 WHEN 29 THEN D29 WHEN 30 THEN D30 WHEN    
    31 THEN D31 ELSE NULL END As ShiftID , 
	CASE Day(@DateProcess2)     
    WHEN 1 THEN D01 WHEN 2 THEN D02 WHEN 3 THEN D03 WHEN 4 THEN D04 WHEN 5 THEN D05 WHEN 6 THEN D06 WHEN    
    7 THEN D07 WHEN 8 THEN D08 WHEN 9 THEN D09 WHEN 10 THEN D10 WHEN 11 THEN D11 WHEN 12 THEN D12 WHEN    
    13 THEN D13 WHEN 14 THEN D14 WHEN 15 THEN D15 WHEN 16 THEN D16 WHEN 17 THEN D17 WHEN 18 THEN D18 WHEN    
    19 THEN D19 WHEN 20 THEN D20 WHEN 21 THEN D21 WHEN 22 THEN D22 WHEN 23 THEN D23 WHEN 24 THEN D24 WHEN    
    25 THEN D25 WHEN 26 THEN D26 WHEN 27 THEN D27 WHEN 28 THEN D28 WHEN 29 THEN D29 WHEN 30 THEN D30 WHEN    
    31 THEN D31 ELSE NULL END as MainShiftID
From HT1025 
Inner join HT1400 On HT1025.DivisionID = HT1400.DivisionID And HT1025.EmployeeID = HT1400.EmployeeID
WHERE HT1025.DivisionID = @DivisionID2 And HT1025.TranYear = Year(@DateProcess2) And HT1025.TranMonth = Month(@DateProcess2)
And HT1400.DepartmentID like @DepartmentID2 And HT1400.EmployeeID like @EmployeeID2
'

IF (Select CustomerName from CustomerIndex) = 50	--- customize Meiko
	SET @sSQL = @sSQL + '
	UNION
	Select HT1025.DivisionID, HT1025.EmployeeID, CASE Day(@DateProcess2)     
                      WHEN 1 THEN HT1025.D01 WHEN 2 THEN HT1025.D02 WHEN 3 THEN HT1025.D03 WHEN 4 THEN HT1025.D04 WHEN 5 THEN HT1025.D05 WHEN 6 THEN HT1025.D06 WHEN    
         7 THEN HT1025.D07 WHEN 8 THEN HT1025.D08 WHEN 9 THEN HT1025.D09 WHEN 10 THEN HT1025.D10 WHEN 11 THEN HT1025.D11 WHEN 12 THEN HT1025.D12 WHEN    
                       13 THEN HT1025.D13 WHEN 14 THEN HT1025.D14 WHEN 15 THEN HT1025.D15 WHEN 16 THEN HT1025.D16 WHEN 17 THEN HT1025.D17 WHEN 18 THEN HT1025.D18 WHEN    
                       19 THEN HT1025.D19 WHEN 20 THEN HT1025.D20 WHEN 21 THEN HT1025.D21 WHEN 22 THEN HT1025.D22 WHEN 23 THEN HT1025.D23 WHEN 24 THEN HT1025.D24 WHEN    
                       25 THEN HT1025.D25 WHEN 26 THEN HT1025.D26 WHEN 27 THEN HT1025.D27 WHEN 28 THEN HT1025.D28 WHEN 29 THEN HT1025.D29 WHEN 30 THEN HT1025.D30 WHEN    
                       31 THEN HT1025.D31 ELSE NULL END As ShiftID ,
		CASE Day(@DateProcess2)     
                      WHEN 1 THEN HT25.D01 WHEN 2 THEN HT25.D02 WHEN 3 THEN HT25.D03 WHEN 4 THEN HT25.D04 WHEN 5 THEN HT25.D05 WHEN 6 THEN HT25.D06 WHEN    
         7 THEN HT25.D07 WHEN 8 THEN HT25.D08 WHEN 9 THEN HT25.D09 WHEN 10 THEN HT25.D10 WHEN 11 THEN HT25.D11 WHEN 12 THEN HT25.D12 WHEN    
                       13 THEN HT25.D13 WHEN 14 THEN HT25.D14 WHEN 15 THEN HT25.D15 WHEN 16 THEN HT25.D16 WHEN 17 THEN HT25.D17 WHEN 18 THEN HT25.D18 WHEN    
                       19 THEN HT25.D19 WHEN 20 THEN HT25.D20 WHEN 21 THEN HT25.D21 WHEN 22 THEN HT25.D22 WHEN 23 THEN HT25.D23 WHEN 24 THEN HT25.D24 WHEN    
                       25 THEN HT25.D25 WHEN 26 THEN HT25.D26 WHEN 27 THEN HT25.D27 WHEN 28 THEN HT25.D28 WHEN 29 THEN HT25.D29 WHEN 30 THEN HT25.D30 WHEN    
                       31 THEN HT25.D31 ELSE NULL END As MainShiftID
	From HT1025_MK HT1025 
	Inner join HT1025 HT25 ON HT1025.EmployeeID = HT25.EmployeeID AND HT1025.TranMonth = HT25.TranMonth
	Inner join HT1400 On HT1025.DivisionID = HT1400.DivisionID And HT1025.EmployeeID = HT1400.EmployeeID
	WHERE HT1025.DivisionID = @DivisionID2 And HT1025.TranYear = Year(@DateProcess2) And HT1025.TranMonth = Month(@DateProcess2)
	And HT1400.DepartmentID like @DepartmentID2 And HT1400.EmployeeID like @EmployeeID2
	'
SET @sSQL = @sSQL + ') A'

--Loc ra nhung ca lam viec lap trong ngay
---EXEC (@sSQL)
EXEC sp_executesql
	@sSQL,
	@ParamDefinition,
	@DivisionID2 = @DivisionID,
	@DateProcess2= @DateProcess,
	@DepartmentID2 = @DepartmentID,
	@EmployeeID2 = @EmployeeID
	
	--print @sSQL
	--print @DateProcess
	--print @EmployeeID
	--print @DepartmentID

Set @curHV2432 = cursor static for
	Select Distinct ShiftID, MainShiftID From HTT2432 Where isnull(ShiftID,'') <> '' 

Open @curHV2432

Fetch Next From @curHV2432 Into @ShiftID, @MainShiftID
While @@Fetch_Status = 0
Begin
	SET @IsAbsentShift = null
	--- Nếu là ca nghỉ được sắp sẵn nhưng không có dữ liệu quét thẻ (ví dụ nghỉ dưỡng sức,thai sản,...) thì vẫn chấm cong đủ
	IF (Select Isnull(IsAbsentShift,0) FROM HT1020 WHERE DivisionID = @DivisionID And ShiftID = @ShiftID) <> 0
	BEGIN
		Declare @AbsentHour decimal (28,8),
				@IsNextDayDetail bit,
				@AbsentTypeID nvarchar(50),
				@Orders int,
				@FromMinute datetime,  
				@ToMinute datetime,
				@curHV1020 cursor,
				@TypeID NVarchar(50)
				
		Set @curHV1020 = cursor static for  
			Select Cast(@DateProcess + ' ' + FromMinute As DateTime), Cast(@DateProcess + ' ' + ToMinute As DateTime), IsNextDay, AbsentTypeID, Orders, TypeID From HV1020  
			Where ShiftID = @ShiftID And DateTypeID = @DateTypeID
			Order By Orders  
    
		Open @curHV1020  
    
		Fetch Next From @curHV1020 Into @FromMinute, @ToMinute, @IsNextDayDetail, @AbsentTypeID, @Orders, @TypeID  
		While @@Fetch_Status = 0  
		Begin
			Set @AbsentHour = 0
			If @IsNextDayDetail = 1  
			Begin  
				If @FromMinute>@ToMinute
				Begin
					Set @ToMinute = DateAdd(d,1,@ToMinute)
				End
				Else   
				Begin
					Set @FromMinute = DateAdd(d,1,@FromMinute)  
					Set @ToMinute = DateAdd(d,1,@ToMinute)
				End
			End

			Set @AbsentHour = round((DATEDIFF (mi, @FromMinute, @ToMinute))/60,2)
			
			SET @sSQL001 = N'
			INSERT INTO '+@TableHT2407+'  (TransactionID,DivisionID,EmployeeID,AbsentCardNo,TranMonth,TranYear,AbsentDate,ShiftID,Orders,  
			FromTime, ToTime, AbsentHour, FromTimeValid, ToTimeValid, CreateUserID,CreateDate, LastModifyUserID, LastModifyDate,  
			AbsentTypeID, InEarlyMinutes, InLateMinutes, OutEarlyMinutes, OutLateMinutes, DeductMinutes, RestrictID, Coefficient, DeductTotal  
			)  
			SELECT  newid(), '''+@DivisionID+''', HTT2432.EmployeeID,
					--(Select top 1 AbsentCardNo From HT1407 Where DivisionID = '''+@DivisionID+''' And EmployeeID = HTT2432.EmployeeID
					--	and ('''+Convert(Varchar(50),@DateProcess,120)+''' between BeginDate and EndDate)),
					HT1407.AbsentCardNo,
					'+STR(@TranMonth)+', '+STR(@TranYear)+', '''+Convert(Varchar(50),@DateProcess,120)+''', '''+@ShiftID+''', '+STR(@Orders)+',  
					'''+Convert(Varchar(50),@FromMinute,120)+''', '''+Convert(Varchar(50),@ToMinute,120)+''', 
					--'+Convert(Varchar(50),@AbsentHour)+', 
					'+CASE WHEN @TypeID = 'NB' THEN Convert(Varchar(50),@AbsentHour*(-1)) ELSE  Convert(Varchar(50),@AbsentHour) END+', 
					'''+Convert(Varchar(50),@FromMinute,120)+''', '''+Convert(Varchar(50),@ToMinute,120)+''',
					'''+@CreateUserID+''', getDate(), '''+@CreateUserID+''', getDate(),  
					'''+@AbsentTypeID+''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL   
			FROM HTT2432
			INNER JOIN HT1407 ON HTT2432.EmployeeID = HT1407.EmployeeID AND HTT2432.DivisionID = HT1407.DivisionID 									
			WHERE ShiftID = '''+@ShiftID+''' and ('''+Convert(Varchar(50),@DateProcess,101)+''' between HT1407.BeginDate and HT1407.EndDate)
			
			'
			EXEC (@sSQL001)

			Fetch Next From @curHV1020 Into @FromMinute, @ToMinute, @IsNextDayDetail, @AbsentTypeID, @Orders, @TypeID
		End
		Close @curHV1020
	END

	ELSE
	BEGIN
		If @CustomerIndex = 50 --- Meiko phải lấy dư thời gian EndTime của ca làm việc do có trường hợp xin làm thêm giờ ngoài sắp ca
		Begin
			Select Top 1 @BeginTime = convert(varchar(8),dateadd(hour,-1,convert(Time,BeginTime))),
						@EndTime = CASE WHEN convert(varchar(8),dateadd(hour,4,convert(Time,EndTime))) = '00:00:00' THEN '23:59:00' ELSE convert(varchar(8),dateadd(hour,4,convert(Time,EndTime))) END
			From HV1020 Where ShiftID = @ShiftID And DateTypeID = @DateTypeID and DivisionID = @DivisionID Order by IsNextDay Desc

			SELECT @IsNextDay = IsNextDay From HV1020 Where ShiftID = @MainShiftID
			
		End
		Else
		Begin
			Select Top 1 @BeginTime = BeginTime, @EndTime = EndTime, @IsNextDay = IsNextDay
			From HV1020 Where ShiftID = @ShiftID And DateTypeID = @DateTypeID and DivisionID = @DivisionID Order by IsNextDay Desc
		End
		
		SELECT @IsAbsentShift = Isnull(IsAbsentShift,0) FROM HT1020 WHERE DivisionID = @DivisionID And ShiftID = @MainShiftID	
		
		IF @BeginTime is NULL
		  SET @BeginTime = '00:00:00'
		IF @EndTime is NULL
		  SET @EndTime = '00:00:00'
	    
		--Neu ca lam viec co tinh ngay ke, gan bien ngay ke = ngay xu ly + 1 
		If @IsNextDay = 1
			Set @NextDateProcess = DateAdd(d,1,@DateProcess)
		Else -- Nguoc lai gan bien ngay ke = ngay xu ly
			Set @NextDateProcess = @DateProcess

		SELECT  @ParamDefinition= '@DateProcess2 datetime, @BeginTime2 nvarchar(100), @NextDateProcess2 datetime, @EndTime2 nvarchar(100), @ShiftID2 nvarchar(50)'
		
		--IF @CustomerIndex = 17 or @CustomerIndex = 50 --- IPL, Meiko: trường hợp quét dư In-Out thì phần mềm tự lấy 2 dòng Min và max của AbsentTime, khách hàng không cần xóa dòng lỗi sau khi quét thẻ
		--Begin		
		 --select @ShiftID as ShiftID, @MainShiftID,@IsAbsentShift
		 		
			Set @sSQL1 = '			
			Select	DivisionID, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate, IsAO
			Into #TAM1
			From (
			Select	DivisionID,EmployeeID,TranMonth, TranYear, AbsentCardNo,AbsentDate,AbsentTime, 
					MachineCode, ShiftCode, IOCode, InputMethod,
					--Cast(Ltrim(Month(AbsentDate)) + ''/'' + LTrim(Day(AbsentDate)) + ''/'' + LTRIM(yEAR(AbsentDate)) + '' '' + AbsentTime As DateTime) As ScanDate 
					-- Convert(Datetime, Convert(Varchar(250),Convert(Varchar(50),AbsentDate,101) +'' ''+ Convert(Varchar(50),AbsentTime,108),21)) As ScanDate
					AbsentDate+ CAST(Convert(Time,AbsentTime) AS datetime) AS ScanDate,
					IsAO
			From HTT2408
			Where 	
					Convert(date,AbsentDate)  between '''+Convert(Varchar(50),@DateProcess,101)+''' and '''+Convert(Varchar(50),@NextDateProcess,101)+'''				 
				 And 
				 exists (Select top 1 1 From HTT2432 Where EmployeeID = HTT2408.EmployeeID and ShiftID = ''' + @ShiftID + ''' AND MainShiftID = ''' + @MainShiftID + ''' )
				and not exists  (select top 1 1 from '+@TableHT2407+' T07 where HTT2408.EmployeeID = T07.EmployeeID and T07.ShiftID = ''' + @ShiftID + '''
									and HTT2408.AbsentDate = T07.AbsentDate
									and T07.TranMonth+T07.Tranyear*100 = '+STR(@TranMonth+@TranYear*100)+' )
				and exists (select top 1 1 from HTT2408 T48 
							where HTT2408.DivisionID = T48.DivisionID 
							and HTT2408.EmployeeID =T48.EmployeeID 
							and HTT2408.AbsentDate = T48.AbsentDate
							and T48.IsAO = 0)
				) C'
				
			Set @sSQL2 = '
			SELECT	EmployeeID, AbsentCardNo, AbsentDate, IsAO,
					--MIN(AbsentDate+Cast(AbsentTime as Datetime)) as InTime, MAX(AbsentDate+Cast(AbsentTime as Datetime)) as OutTime
					Convert(Time, MIN(CASE WHEN IOCode = 0 THEN AbsentDate+Cast(AbsentTime as Datetime)  ELSE NULL END)) AS InTime,
					Convert(Time, MAX(CASE WHEN IOCode = 1 THEN AbsentDate+Cast(AbsentTime as Datetime)  ELSE NULL END)) AS OutTime
			INTO	#TAM12
			FROM	#TAM1
			Group by EmployeeID, AbsentCardNo, AbsentDate, IsAO

			SELECT EmployeeID, AbsentCardNo,  IsAO, Min(AbsentDate+Cast(Convert(Time(0),InTime) as Datetime)) AS InTime, 
					Max(AbsentDate+Cast(Convert(Time(0),OutTime) as Datetime)) AS OutTime,
					(SELECT DATEDIFF(mi,Min(InTime), Max (InTime) ) From #TAM12	T2 where #TAM12.EmployeeID = T2.EmployeeID ) AS Distance_I,
					(SELECT DATEDIFF(mi,Min(OutTime), Max (OutTime) ) From #TAM12 T2 where #TAM12.EmployeeID = T2.EmployeeID) AS Distance_O,
					CASE WHEN 	(SELECT DATEDIFF(mi,Min(InTime), Max (InTime) ) From #TAM12 T2	where #TAM12.EmployeeID = T2.EmployeeID) 
							- (SELECT DATEDIFF(mi,Min(OutTime), Max (OutTime) ) From #TAM12 T2 where #TAM12.EmployeeID = T2.EmployeeID) >0 
					THEN ''C'' ELSE ''D'' END AS IsDC
			INTO #TAM2
			FROM #TAM12
			Group by EmployeeID, AbsentCardNo, IsAO

				'
				
			Set @sSQL3 = '		
			SELECT T2.DivisionID, T1.EmployeeID, TranMonth, TranYear, T1.AbsentCardNo, ScanDate as AbsentDate, T2.AbsentTime, MachineCode, ShiftCode, IOCode, 
			InputMethod, ScanDate
			INTO #TAM3
			FROM #TAM2 T1
			LEFT JOIN #TAM1 T2 On T1.EmployeeID = T2.EmployeeID 			
			GROUP BY T2.DivisionID, T1.EmployeeID, TranMonth, TranYear, T1.AbsentCardNo, ScanDate, T2.AbsentTime, MachineCode, ShiftCode, IOCode, 
			InputMethod, ScanDate, T1.IsDC
			'+CASE WHEN Isnull(@IsAbsentShift,0) = 0 THEN ' 
			HAVING ( T1.IsDC = ''D'' AND ((T2.IOCode = 0 AND T2.ScanDate = Max(T1.InTime)) Or (T2.IOCode = 1 AND T2.ScanDate = Max(T1.OutTime))) )
					OR (T1.IsDC = ''C'' AND ((T2.IOCode = 0 AND T2.ScanDate = Min(T1.InTime)) Or (T2.IOCode = 1 AND T2.ScanDate = Min(T1.OutTime))) )
			' ELSE '
			HAVING (T2.IOCode = 0 AND T2.ScanDate = Max(T1.InTime)) Or (T2.IOCode = 1 AND T2.ScanDate = Min(T1.OutTime))
			' END 

			Set @sSQL4 = '
			SELECT	T1.*, 
					(select case when Min(AbsentDate) <  Max(AbsentDate) then Min(AbsentDate) else Max(AbsentDate) end from #TAM3 where #TAM3.EmployeeID = T1.EmployeeID)AS MinScanDate, 
					(select case when Min(AbsentDate) > Max(AbsentDate) then Min(AbsentDate) else Max(AbsentDate) end  from #TAM3 where #TAM3.EmployeeID = T1.EmployeeID)AS MaxScanDate 
			INTO	#TAM31
			FROM	#TAM3 T1

			Delete from HTT2433
			Insert into HTT2433 (DivisionID	, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate)
			SELECT DivisionID, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate
			FROM #TAM31
			GROUP BY DivisionID, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate, MinScanDate, MaxScanDate
			HAVING (IOCode = 0 AND ScanDate = MinScanDate )
			or (IOCode = 1 AND ScanDate = MaxScanDate)
			
			--select ''' + @ShiftID + ''', ''' + @MainShiftID + ''', ''#TAM1'', * from  #TAM1 where EmployeeID = ''000333'' order by AbsentTime, IOCode
			--select ''#TAM12'', * from  #TAM12 where EmployeeID = ''003284''
			--select '+STR(@IsAbsentShift)+',''' + @ShiftID + ''', ''' + @MainShiftID + ''', ''#TAM2'', * from  #TAM2 where EmployeeID = ''000333''
			--select '+STR(@IsAbsentShift)+',''' + @ShiftID + ''', ''' + @MainShiftID + ''', ''#TAM3'', * from  #TAM3 where EmployeeID = ''000333''
			--select ''#TAM31'', * from  #TAM3 where EmployeeID = ''003284''
			--select ''' + @ShiftID + ''', ''' + @MainShiftID + ''', ''HTT2433'', * from  HTT2433 where EmployeeID = ''000333''
			'
			--print @sSQL1
			--print @sSQL2
			--print @sSQL3
			--print @sSQL4
			EXEC(@sSQL1 + @sSQL2 + @sSQL3 + @sSQL4)



		--End
	
		--ELSE --- <> IPL
		--Begin
		--	Set @sSQL1 = '
		--	Delete from HTT2433
		--	Insert into HTT2433 (DivisionID	, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate)
		--	Select DivisionID	, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate
		--	From (
		--	Select	DivisionID,EmployeeID,TranMonth, TranYear, AbsentCardNo,AbsentDate,AbsentTime, 
		--			MachineCode, ShiftCode, IOCode, InputMethod,
		--			--Cast(Ltrim(Month(AbsentDate)) + ''/'' + LTrim(Day(AbsentDate)) + ''/'' + LTRIM(yEAR(AbsentDate)) + '' '' + AbsentTime As DateTime) As ScanDate 
		--			-- Convert(Datetime, Convert(Varchar(250),Convert(Varchar(50),AbsentDate,101) +'' ''+ Convert(Varchar(50),AbsentTime,108),21)) As ScanDate
		--			AbsentDate+ CAST(Convert(Time,AbsentTime) AS datetime) AS ScanDate
		--	From HTT2408
		--	Where 
		--		Convert(Datetime, Convert(Varchar(100),Convert(Varchar(50),AbsentDate,101) +'' ''+ Convert(Varchar(50),AbsentTime,108),21))
		--			BETWEEN		Convert(Datetime, Convert(Varchar(250),Convert(Varchar(50),@DateProcess2,101) +'' ''+ Convert(Varchar(50),@BeginTime2,108),21))
		--					AND	Convert(Datetime, Convert(Varchar(250),Convert(Varchar(50),@NextDateProcess2,101) +'' ''+ Convert(Varchar(50),@EndTime2,108),21))
		--		 --(Convert(nvarchar(20),ltrim(AbsentDate) + '' '' + AbsentTime,101) Between Convert(nvarchar(20),ltrim(@DateProcess2) + '' '' + @BeginTime2,101)  And Convert(nvarchar(20),ltrim(@NextDateProcess2) + '' '' + @EndTime2,101))
		--		And 
		--		exists (Select top 1 1 From HTT2432 Where EmployeeID = HTT2408.EmployeeID and ShiftID = @ShiftID2)) C'

		--	EXEC sp_executesql
		--		@sSQL1,
		--		@ParamDefinition,
		--		@DateProcess2 = @DateProcess,
		--		@BeginTime2= @BeginTime,
		--		@NextDateProcess2 = @NextDateProcess,
		--		@EndTime2 = @EndTime,
		--		@ShiftID2 =@ShiftID
		--End
	/*			
		-- thêm tranmonth và tranyear vào để kiểm tra trường hợp nhân viên thay đổi phòng ban
	Set @curHV2433 = cursor static for
	Select Distinct HV1.EmployeeID From HV2433 HV1
	inner join HT2400 HT1 on HV1.EmployeeID = HT1.EmployeeID and HV1.DivisionID = HT1.DivisionID
	Where HV1.DivisionID = @DivisionID
	and HT1.DepartmentID like @DepartmentID
	And HT1.TranMonth = @TranMonth And HT1.TranYear = @TranYear
	And (select count(*) From HV2433  HV2
	inner join HT2400 HT2  on HV2.EmployeeID = HT2.EmployeeID and HV2.DivisionID = HT2.DivisionID
	where HV2.DivisionID = @DivisionID
	And HT2.TranMonth = @TranMonth And HT2.TranYear = @TranYear
	and HT2.DepartmentID like @DepartmentID
	And HV2.employeeid = HV1.EmployeeID) % 2 = 0
	Open @curHV2433
	Fetch Next From @curHV2433 Into @EmployeeID1
	--End Thử					
		--Lap tung nhan vien co so lan quet the hop le (so chan) 	
	*/
	
		--Select Distinct EmployeeID, AbsentCardNo From HTT2433 HV24
		--Where HV24.DivisionID = @DivisionID and Isnull(AbsentCardNo,'') = ''


		Set @curHV2433 = cursor static for 
		Select Distinct EmployeeID From HTT2433 HV24
		Where HV24.DivisionID = @DivisionID ---And (select count(EmployeeID) From HTT2433 where DivisionID = @DivisionID And TranMonth = @TranMonth And TranYear = @TranYear And employeeid = HV24.EmployeeID) % 2 = 0
		Open @curHV2433
		Fetch Next From @curHV2433 Into @EmployeeID1
		While @@Fetch_Status=0
		Begin
			Select Top  1 @AbsentCardNo = AbsentCardNo From HTT2433 Where DivisionID = @DivisionID And EmployeeID= @EmployeeID1	
			Exec HP2433 @DivisionID, @TranMonth, @TranYear, @DateProcess, @EmployeeID1, @AbsentCardNo, @ShiftID, @DateTypeID, @IsNextDay, @CreateUserID
			Fetch Next From @curHV2433 Into @EmployeeID1
		End

		Close @curHV2433
	END
	
	Fetch Next From @curHV2432 Into @ShiftID, @MainShiftID
End
Close @curHV2432
Deallocate @curHV2432
	
---- Bổ sung xử lý: Nếu có phân ca nhưng không có dữ liệu quẹt thẻ thì tự sinh công bỏ làm (N.BL)
If @CustomerIndex = 50 --- Meiko
BEGIN			
	SET @sSQL001 = N' 	
	IF EXISTS (	SELECT TOP 1 1 FROM HTT2432 
					WHERE  
					not exists (Select top 1 1 From '+@TableHT2407+' HT2407
								Where HTT2432.EmployeeID = HT2407.EmployeeID 							
								and Convert(date,AbsentDate) = '''+CONVERT(VARCHAR(10),@DateProcess,120)+''')
			   )
					
	BEGIN									
	INSERT INTO '+@TableHT2407+'  (TransactionID,DivisionID,EmployeeID,AbsentCardNo,TranMonth,TranYear,AbsentDate,ShiftID,Orders,  
	FromTime, ToTime, 
	AbsentHour, FromTimeValid, ToTimeValid, CreateUserID,CreateDate, LastModifyUserID, LastModifyDate,  
	AbsentTypeID, InEarlyMinutes, InLateMinutes, OutEarlyMinutes, OutLateMinutes, DeductMinutes, RestrictID, Coefficient, DeductTotal  
	)  
	SELECT  newid(), '''+@DivisionID+''', HTT2432.EmployeeID,				
			HT1407.AbsentCardNo,
			'+STR(@TranMonth)+', '+STR(@TranYear)+', '''+Convert(Varchar(50),@DateProcess,120)+''', HTT2432.ShiftID, 0,  
			Cast(Convert(Datetime,'''+Convert(Varchar(50),@DateProcess,120)+''') + '' '' + BeginTime As DateTime),
			Cast(Convert(Datetime,'''+Convert(Varchar(50),@DateProcess,120)+''') + '' '' + EndTime As DateTime),
			CASE WHEN WorkingTime > 8 THEN 8 ELSE WorkingTime END AS WorkingTime, 
			Cast(Convert(Datetime,'''+Convert(Varchar(50),@DateProcess,120)+''') + '' '' + BeginTime As DateTime),
			Cast(Convert(Datetime,'''+Convert(Varchar(50),@DateProcess,120)+''') + '' '' + EndTime As DateTime),
			'''+@CreateUserID+''', getDate(), '''+@CreateUserID+''', getDate(),  
			CASE WHEN ISNULL(HT1020.IsApprenticeShift,0) = 0 THEN ''N.BL'' ELSE ''N.BL_TV'' END,
			NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL     
	FROM HTT2432
	INNER JOIN HT1407 ON HTT2432.EmployeeID = HT1407.EmployeeID AND HTT2432.DivisionID = HT1407.DivisionID 	
	INNER JOIN HT1020 ON HTT2432.ShiftID = HT1020.ShiftID AND HTT2432.DivisionID = HT1020.DivisionID								
	WHERE ('''+Convert(Varchar(50),@DateProcess,101)+''' between HT1407.BeginDate and HT1407.EndDate)
		  and not exists (Select top 1 1 From '+@TableHT2407+' HT2407
								Where HTT2432.EmployeeID = HT2407.EmployeeID 							
								and Convert(date,AbsentDate) = '''+CONVERT(VARCHAR(10),@DateProcess,120)+''')
		  and not exists (Select top 1 1 From OOT2010 T1 INNER JOIN OOT9000 T2 ON T1.DivisionID = T2.DivisionID AND T1.APKMaster = T2.APK
						Where T1.DivisionID = '''+@DivisionID+''' 
						AND '''+CONVERT(VARCHAR(10),@DateProcess,120)+''' BETWEEN CONVERT(DATE,T1.LeaveFromDate,120) and CONVERT(DATE,T1.LeaveToDate,120)
						AND HTT2432.EmployeeID = T1.EmployeeID 
						AND ISNULL(T1.Status,0) = 1 AND ISNULL(T2.Status,0) = 1
					   )
	'
	SET @sSQL002 = N' 		
	UNION ALL
	SELECT  newid(), '''+@DivisionID+''', HTT2432.EmployeeID,				
			HT1407.AbsentCardNo,
			'+STR(@TranMonth)+', '+STR(@TranYear)+', '''+Convert(Varchar(50),@DateProcess,120)+''', HTT2432.ShiftID, 0,  
			Cast(Convert(Datetime,'''+Convert(Varchar(50),@DateProcess,120)+''') + '' '' + BeginTime As DateTime),
			Cast(Convert(Datetime,'''+Convert(Varchar(50),@DateProcess,120)+''') + '' '' + EndTime As DateTime),
			CASE WHEN WorkingTime > 8 THEN 8 ELSE WorkingTime END AS WorkingTime, 
			Cast(Convert(Datetime,'''+Convert(Varchar(50),@DateProcess,120)+''') + '' '' + BeginTime As DateTime),
			Cast(Convert(Datetime,'''+Convert(Varchar(50),@DateProcess,120)+''') + '' '' + EndTime As DateTime),
			'''+@CreateUserID+''', getDate(), '''+@CreateUserID+''', getDate(),  
			CASE WHEN ISNULL(HT1020.IsApprenticeShift,0) = 0 THEN ''N.GCTT'' ELSE ''N.GCTT_TV'' END, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL     
	FROM HTT2432
	INNER JOIN HT1407 ON HTT2432.EmployeeID = HT1407.EmployeeID AND HTT2432.DivisionID = HT1407.DivisionID 	
	INNER JOIN HT1020 ON HTT2432.ShiftID = HT1020.ShiftID AND HTT2432.DivisionID = HT1020.DivisionID								
	WHERE ('''+Convert(Varchar(50),@DateProcess,101)+''' between HT1407.BeginDate and HT1407.EndDate)
		  and not exists (Select top 1 1 From '+@TableHT2407+' HT2407
								Where HTT2432.EmployeeID = HT2407.EmployeeID 							
								and Convert(date,AbsentDate) = '''+CONVERT(VARCHAR(10),@DateProcess,120)+''')
		  and not exists (Select top 1 1 From OOT2010 T1 INNER JOIN OOT9000 T2 ON T1.DivisionID = T2.DivisionID AND T1.APKMaster = T2.APK
						Where T1.DivisionID = '''+@DivisionID+''' 
						AND '''+CONVERT(VARCHAR(10),@DateProcess,120)+''' BETWEEN CONVERT(DATE,T1.LeaveFromDate,120) and CONVERT(DATE,T1.LeaveToDate,120)
						AND HTT2432.EmployeeID = T1.EmployeeID 
						AND ISNULL(T1.Status,0) = 1 AND ISNULL(T2.Status,0) = 1
					   )
	END

	'
	exec (@sSQL001+@sSQL002)
	--print @sSQL001
	--print @sSQL002
END		

SET NOCOUNT OFF











GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
