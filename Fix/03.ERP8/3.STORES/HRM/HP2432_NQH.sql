IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2432_NQH]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP2432_NQH]
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
--- Modify on 11/08/2013 by Bảo Anh: Bổ sung lấy thông tin chấm công có giờ vào < giờ bắt đầu ca, giờ ra > giờ kết thúc ca làm việc
--- Modify on 30/10/2013 by Bảo Anh: Bổ sung trường hợp ca đêm khi lấy dữ liệu cho trường AbsentDate ở view HV2433
--- Modify on 01/12/2013 by Bảo Anh: Sửa lỗi chấm công ca đêm chưa đúng trong trường hợp 1 ngày có đủ In/Out
--- Modify on 31/12/2013 by Bảo Anh: Sửa lỗi chấm công không lên khi giờ ra = giờ kết thúc ca (Tiến Hưng: CRM TT7818)
--- Modify on 30/06/2015 by Bảo Anh: Bổ sung chấm công theo từng nhân viên và cải tiến tốc độ
--- Modify on 02/02/2016 by Bảo Anh: Bổ sung chấm công cho ca xin làm thêm giờ ngoài sắp ca (customize Meiko)
--- Modify on 24/02/2016 by Phương Thảo: Chỉnh sửa cách convert kiểu dữ liệu ngày giờ
--- Modify on 02/02/2016 by Bảo Anh: Bỏ where theo thời gian bắt đầu, kết thúc ca khi insert vào HTT2433 (do store HP2433 đã có where)
--- Modify on 21/04/2016 by Bảo Anh: trường hợp quét dư In-Out thì phần mềm tự lấy 2 dòng Min và max của AbsentTime (đưa vào chuẩn)
--- Modify on 20/06/2016 by Bảo Anh: Bổ sung chấm công cho ca nghỉ và không có quét thẻ (ví dụ dưỡng sức, nghỉ thai sản, ...)
--- Modify on 27/06/2016 by Bảo Anh: Chuyển phần set BeginTime = BeginTime -1, EndTime = EndTime + 4 sang customize Meiko
--- Modify on 20/08/2016 by Phương Thảo: Bổ sung xử lý tách bảng nghiệp vụ
--- Modify on 12/09/2016 by Bảo Thy: Bỏ Comment đoạn xử lý riêng cho IPL, Meiko: trường hợp quét dư In-Out thì phần mềm tự lấy 2 dòng Min và max của AbsentTime, khách hàng không cần xóa dòng lỗi sau khi quét thẻ
--- Modify on 09/08/2018 by Bảo Anh: Sửa lỗi chấm công không đúng khi ca ngày nối ca đêm
--- Modify on 17/10/2018 by Bảo Anh: Sửa lỗi chấm công không lên khi giờ Out của ngày làm ca đêm >= giờ In của ca ngày hôm sau
--- Modify on 14/02/2019 by Bảo Anh: Sửa lỗi chấm công double khi làm đơn xin OT có thời gian OT kéo dài qua ngày hôm sau (http://192.168.0.204:8069/web#id=6455&view_type=form&model=project.issue&menu_id=304&action=390)
--- Modify on 26/07/2019 by Như Hàn: Sửa lỗi phát sinh 2 dòng dữ liệu khi lấy ca làm việc (#TEMP)
--- Modify on 26/07/201 by Như Hàn: Sửa lỗi phát sinh 2 dòng dữ liệu khi lấy ca làm việc (#TEMP)
----HP2432_NQH_NTY 'IPL',12,2015,'12/05/2015','SAT','%','ADMIN','13081401'

CREATE PROCEDURE [dbo].[HP2432_NQH] @DivisionID nvarchar(50),				
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
		@sSQL21 nvarchar(max),
		@sSQL3 nvarchar(max),
		@sSQL4 nvarchar(max),
		@ParamDefinition NVARCHAR(MAX),
		@CustomerIndex int

DECLARE	@sSQL001 Nvarchar(4000),
		@TableHT2407 Varchar(50),		
		@sTranMonth Varchar(2)

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

SELECT EmployeeID, StrDate, 
 Convert(Date,STR(@TranMonth)+'/'+ RIGHT(StrDate,LEN(StrDate) -1)+'/'+STR(@TranYear)) AS Date,
  ShiftID
INTO #HP2432_NTY_HT1025
FROM 
(SELECT T1.EmployeeID, [D01], [D02], [D03], [D04], [D05], [D06], [D07], [D08], [D09], [D10], [D11], [D12], [D13], [D14], [D15],
					[D16], [D17], [D18], [D19], [D20], [D21], [D22], [D23], [D24], [D25], [D26], [D27], [D28], [D29], [D30], [D31]
FROM HT1025 T1
INNER JOIN HT2400 T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear
WHERE T1.DivisionID = @DivisionID AND T1.TranMonth = @TranMonth AND T1.TranYear = @TranYear 
AND T2.DepartmentID LIKE @DepartmentID AND T1.EmployeeID LIKE @EmployeeID) p
UNPIVOT
(ShiftID FOR StrDate IN 
([D01], [D02], [D03], [D04], [D05], [D06], [D07], [D08], [D09], [D10], [D11], [D12], [D13], [D14], [D15],
 [D16], [D17], [D18], [D19], [D20], [D21], [D22], [D23], [D24], [D25], [D26], [D27], [D28], [D29], [D30], [D31])
)AS unpvt
WHERE  Convert(Int,RIGHT(StrDate,LEN(StrDate) -1)) <= DAY(DATEADD(mm,DATEDIFF(mm,0, Convert(Date,STR(@TranMonth)+'/'+ '1' +'/'+STR(@TranYear)))+1,-1))


SELECT DISTINCT EmployeeID
INTO #HP2432_NTY_lstEmp_NightShift
FROM #HP2432_NTY_HT1025 T1
WHERE EXISTS (SELECT TOP 1 1 FROM HV1020 T2 WHERE T1.ShiftID = T2.ShiftID AND LEFT(DATENAME(dw,T1.Date),3) = T2.DateTypeID AND T2.IsNextDay = 1)
	

Set @sSQL = 	'
Delete from HTT2432
Insert into HTT2432 (DivisionID, EmployeeID, ShiftID, IsFromDXLTG)
Select DivisionID, EmployeeID, ShiftID, IsFromDXLTG
From (
Select HT1025.DivisionID, HT1025.EmployeeID, CASE Day(@DateProcess2)     
                      WHEN 1 THEN D01 WHEN 2 THEN D02 WHEN 3 THEN D03 WHEN 4 THEN D04 WHEN 5 THEN D05 WHEN 6 THEN D06 WHEN    
                       7 THEN D07 WHEN 8 THEN D08 WHEN 9 THEN D09 WHEN 10 THEN D10 WHEN 11 THEN D11 WHEN 12 THEN D12 WHEN    
                       13 THEN D13 WHEN 14 THEN D14 WHEN 15 THEN D15 WHEN 16 THEN D16 WHEN 17 THEN D17 WHEN 18 THEN D18 WHEN    
                       19 THEN D19 WHEN 20 THEN D20 WHEN 21 THEN D21 WHEN 22 THEN D22 WHEN 23 THEN D23 WHEN 24 THEN D24 WHEN    
                       25 THEN D25 WHEN 26 THEN D26 WHEN 27 THEN D27 WHEN 28 THEN D28 WHEN 29 THEN D29 WHEN 30 THEN D30 WHEN    
                       31 THEN D31 ELSE NULL END As ShiftID,
					   0 AS IsFromDXLTG
				From HT1025 WITH (NOLOCK)
				 Inner join HT1400 WITH (NOLOCK) On HT1025.DivisionID = HT1400.DivisionID And HT1025.EmployeeID = HT1400.EmployeeID
				 WHERE HT1025.DivisionID = @DivisionID2 And HT1025.TranYear = Year(@DateProcess2) And HT1025.TranMonth = Month(@DateProcess2)
				 And HT1400.DepartmentID like @DepartmentID2 And HT1400.EmployeeID like @EmployeeID2'



--IF (Select CustomerName from CustomerIndex) = 50	--- customize Meiko
	SET @sSQL = @sSQL + '
	UNION
	Select HT1025.DivisionID, HT1025.EmployeeID, CASE Day(@DateProcess2)     
                      WHEN 1 THEN D01 WHEN 2 THEN D02 WHEN 3 THEN D03 WHEN 4 THEN D04 WHEN 5 THEN D05 WHEN 6 THEN D06 WHEN    
         7 THEN D07 WHEN 8 THEN D08 WHEN 9 THEN D09 WHEN 10 THEN D10 WHEN 11 THEN D11 WHEN 12 THEN D12 WHEN    
                       13 THEN D13 WHEN 14 THEN D14 WHEN 15 THEN D15 WHEN 16 THEN D16 WHEN 17 THEN D17 WHEN 18 THEN D18 WHEN    
                       19 THEN D19 WHEN 20 THEN D20 WHEN 21 THEN D21 WHEN 22 THEN D22 WHEN 23 THEN D23 WHEN 24 THEN D24 WHEN    
                       25 THEN D25 WHEN 26 THEN D26 WHEN 27 THEN D27 WHEN 28 THEN D28 WHEN 29 THEN D29 WHEN 30 THEN D30 WHEN    
                       31 THEN D31 ELSE NULL END As ShiftID,
		1 AS IsFromDXLTG 
	From HT1025_MK HT1025 WITH (NOLOCK) 
	Inner join HT1400 WITH (NOLOCK) On HT1025.DivisionID = HT1400.DivisionID And HT1025.EmployeeID = HT1400.EmployeeID
	WHERE HT1025.DivisionID = @DivisionID2 And HT1025.TranYear = Year(@DateProcess2) And HT1025.TranMonth = Month(@DateProcess2)
	And HT1400.DepartmentID like @DepartmentID2 And HT1400.EmployeeID like @EmployeeID2
	'
SET @sSQL = @sSQL + ') A'

--Loc ra nhung ca lam viec lap trong ngay
--EXEC (@sSQL)
EXEC sp_executesql
	@sSQL,
	@ParamDefinition,
	@DivisionID2 = @DivisionID,
	@DateProcess2= @DateProcess,
	@DepartmentID2 = @DepartmentID,
	@EmployeeID2 = @EmployeeID
select @sSQL
--- Loại trừ các ca xin OT trùng thời gian chấm công của ca chính (xl cho trường hợp nhân viên làm đơn xin OT nhưng thời gian OT kéo dài qua ngày hôm sau: http://192.168.0.204:8069/web#id=6455&view_type=form&model=project.issue&menu_id=304&action=390)
SELECT ShiftID, IsFromDXLTG, MIN(FromMinute) AS FromMinute, MAX(ToMinute) AS ToMinute
INTO #TEMP
FROM
(SELECT HT1021.ShiftID, HTT2432.IsFromDXLTG, HT1021.FromMinute, CASE WHEN IsNextDay = 1 THEN DATEADD(hh,24,ToMinute) ELSE ToMinute END AS ToMinute
FROM HT1021 WITH (NOLOCK)
INNER JOIN HTT2432 WITH (NOLOCK) ON HT1021.DivisionID = HTT2432.DivisionID AND HT1021.ShiftID = HTT2432.ShiftID
WHERE HT1021.DivisionID = @DivisionID AND HT1021.DateTypeID = LEFT(DATENAME(DW,@DateProcess),3)
) A
GROUP BY ShiftID, IsFromDXLTG


--DELETE HTT2432
--WHERE ShiftID IN
--(
--SELECT ShiftID FROM #TEMP
--WHERE ISNULL(IsFromDXLTG,0) = 1
--AND FromMinute >= (SELECT TOP 1 FromMinute From #TEMP WHERE ISNULL(IsFromDXLTG,0) = 0)
--AND ToMinute <= (SELECT TOP 1 ToMinute From #TEMP WHERE ISNULL(IsFromDXLTG,0) = 0)
--)



Set @curHV2432 = cursor static for
	Select Distinct ShiftID From HTT2432 Where isnull(ShiftID,'') <> '' 

Open @curHV2432

Fetch Next From @curHV2432 Into @ShiftID
While @@Fetch_Status = 0
Begin
	--- Nếu là ca nghỉ được sắp sẵn nhưng không có dữ liệu quét thẻ (ví dụ nghỉ dưỡng sức,thai sản,...) thì vẫn chấm cong đủ
	IF (Select Isnull(IsAbsentShift,0) FROM HT1020 WHERE DivisionID = @DivisionID And ShiftID = @ShiftID) <> 0
	BEGIN
		Declare @AbsentHour decimal (28,8),
				@IsNextDayDetail bit,
				@AbsentTypeID nvarchar(50),
				@Orders int,
				@FromMinute datetime,  
				@ToMinute datetime,
				@curHV1020 cursor
				
		Set @curHV1020 = cursor static for  
			Select Cast(@DateProcess + ' ' + FromMinute As DateTime), Cast(@DateProcess + ' ' + ToMinute As DateTime), IsNextDay, AbsentTypeID, Orders From HV1020  
			Where ShiftID = @ShiftID And DateTypeID = @DateTypeID
			Order By Orders  
    
		Open @curHV1020  
    
		Fetch Next From @curHV1020 Into @FromMinute, @ToMinute, @IsNextDayDetail, @AbsentTypeID, @Orders  
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
					'+Convert(Varchar(50),@AbsentHour)+', '''+Convert(Varchar(50),@FromMinute,120)+''', '''+Convert(Varchar(50),@ToMinute,120)+''',
					'''+@CreateUserID+''', getDate(), '''+@CreateUserID+''', getDate(),  
					'''+@AbsentTypeID+''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL   
			FROM HTT2432
			INNER JOIN HT1407 ON HTT2432.EmployeeID = HT1407.EmployeeID AND HTT2432.DivisionID = HT1407.DivisionID 									
			WHERE ShiftID = '''+@ShiftID+''' and ('''+Convert(Varchar(50),@DateProcess,101)+''' between HT1407.BeginDate and HT1407.EndDate)
			
			'
			EXEC (@sSQL001)
			--print ('@sSQL001'+@sSQL001)

			Fetch Next From @curHV1020 Into @FromMinute, @ToMinute, @IsNextDayDetail, @AbsentTypeID, @Orders
		End
		Close @curHV1020
	END

	ELSE
	BEGIN
		If @CustomerIndex = 50 OR @CustomerIndex = 81 --- Meiko, Newtoyo phải lấy dư thời gian EndTime của ca làm việc do có trường hợp xin làm thêm giờ ngoài sắp ca
		Begin
			Select Top 1 @BeginTime = convert(varchar(8),dateadd(hour,-1,convert(Time,BeginTime))),
						@EndTime = convert(varchar(8),dateadd(hour,4,convert(Time,EndTime))),
						@IsNextDay = IsNextDay
			From HV1020 Where ShiftID = @ShiftID And DateTypeID = @DateTypeID and DivisionID = @DivisionID Order by IsNextDay Desc
		End
		Else
		Begin
			Select Top 1 @BeginTime = BeginTime, @EndTime = EndTime, @IsNextDay = IsNextDay
			From HV1020 Where ShiftID = @ShiftID And DateTypeID = @DateTypeID and DivisionID = @DivisionID Order by IsNextDay Desc
		End
		
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
		
		--TH Khách hàng TUV : phần mềm tự lấy 2 dòng Min và max của AbsentTime, không quan tâm đến dữ liệu IOCode
		IF @CustomerIndex = 72 -- KH TUV
		Begin
			Set @sSQL1 = '
			Select DivisionID, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate
			Into #TAM1
			From (
			Select	DivisionID,EmployeeID,TranMonth, TranYear, AbsentCardNo,AbsentDate,AbsentTime, 
					MachineCode, ShiftCode, IOCode, InputMethod,
					--Cast(Ltrim(Month(AbsentDate)) + ''/'' + LTrim(Day(AbsentDate)) + ''/'' + LTRIM(yEAR(AbsentDate)) + '' '' + AbsentTime As DateTime) As ScanDate 
					-- Convert(Datetime, Convert(Varchar(250),Convert(Varchar(50),AbsentDate,101) +'' ''+ Convert(Varchar(50),AbsentTime,108),21)) As ScanDate
					AbsentDate+ CAST(Convert(Time,AbsentTime) AS datetime) AS ScanDate
			From HTT2408
			Where 	Convert(date,AbsentDate)  between '''+Convert(Varchar(50),@DateProcess,101)+''' and '''+Convert(Varchar(50),@NextDateProcess,101)+'''
				And 
				exists (Select top 1 1 From HTT2432 Where EmployeeID = HTT2408.EmployeeID and ShiftID = ''' + @ShiftID + ''')) C'
				
			Set @sSQL2 = '
			SELECT	EmployeeID, AbsentCardNo, AbsentDate,
					min(AbsentTime) as InTime, max(AbsentTime) as OutTime
			INTO #TAM2
			FROM #TAM1
			Group by EmployeeID, AbsentCardNo, AbsentDate'

			Set @sSQL3 = '
			SELECT T1.DivisionID, T1.EmployeeID, TranMonth, TranYear, T1.AbsentCardNo, T1.AbsentDate, T1.AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate,
					Row_Number() Over (partition by T1.EmployeeID Order by (Select 1)) as Orders
			INTO #TAM3
			FROM #TAM1 T1
			INNER JOIN #TAM2 T2 On T1.EmployeeID = T2.EmployeeID And T1.AbsentDate = T2.AbsentDate And (T1.AbsentTime = T2.InTime Or T1.AbsentTime = T2.OutTime)
			'

			Set @sSQL4 = '
			Delete from HTT2433
			Insert into HTT2433 (DivisionID	, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate)
			SELECT DivisionID, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate
			FROM #TAM3		
			
			--select ''HTT2433'', * from  HTT2433 where EmployeeID = ''5350013''
			--order by AbsentDate	
			'
			--print @sSQL1
			--print @sSQL2
			--print @sSQL3
			--print @sSQL4
			EXEC(@sSQL1 + @sSQL2 + @sSQL3 + @sSQL4)
		End
		Else -- KH <> TUV
		Begin
			Set @sSQL1 = '	
				Select	DivisionID, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate
				Into #TAM1
				From (
				Select	DivisionID,EmployeeID,TranMonth, TranYear, AbsentCardNo,AbsentDate,AbsentTime, 
						MachineCode, ShiftCode, IOCode, InputMethod,
						--Cast(Ltrim(Month(AbsentDate)) + ''/'' + LTrim(Day(AbsentDate)) + ''/'' + LTRIM(yEAR(AbsentDate)) + '' '' + AbsentTime As DateTime) As ScanDate 
						-- Convert(Datetime, Convert(Varchar(250),Convert(Varchar(50),AbsentDate,101) +'' ''+ Convert(Varchar(50),AbsentTime,108),21)) As ScanDate
						AbsentDate+ CAST(Convert(Time,AbsentTime) AS datetime) AS ScanDate
				From HTT2408
				Where 	
						Convert(date,AbsentDate)  between '''+Convert(Varchar(50),@DateProcess,101)+''' and '''+Convert(Varchar(50),@NextDateProcess,101)+'''				 
					 And 
					 exists (Select top 1 1 From HTT2432 Where EmployeeID = HTT2408.EmployeeID and ShiftID = ''' + @ShiftID + ''')
					and not exists  (select top 1 1 from '+@TableHT2407+' T07 where HTT2408.EmployeeID = T07.EmployeeID and T07.ShiftID = ''' + @ShiftID + '''
										and HTT2408.AbsentDate = T07.AbsentDate
										and T07.TranMonth+T07.Tranyear*100 = '+STR(@TranMonth+@TranYear*100)+' )
					) C
				
				'
			Set @sSQL2 = '
				---- Nhung nhan vien chi lam ca ngay trong thang
				SELECT	EmployeeID, AbsentCardNo, AbsentDate,
						min(AbsentTime) as InTime, max(AbsentTime) as OutTime
				INTO #TAM2A
				FROM #TAM1
				WHERE	EmployeeID not in (SElECT EmployeeID FROM #HP2432_NTY_lstEmp_NightShift)
				Group by EmployeeID, AbsentCardNo, AbsentDate

				Delete from HTT2433 WHERE EmployeeID not in (SElECT EmployeeID FROM #HP2432_NTY_lstEmp_NightShift)
				Insert into HTT2433 (DivisionID	, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate)
				SELECT T1.DivisionID, T1.EmployeeID, TranMonth, TranYear, T1.AbsentCardNo, T1.AbsentDate, T1.AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate
				FROM #TAM1 T1
				INNER JOIN #TAM2A T2 On T1.EmployeeID = T2.EmployeeID And T1.AbsentDate = T2.AbsentDate And (T1.AbsentTime = T2.InTime Or T1.AbsentTime = T2.OutTime)
			
			select ''#TAM1'',* From #TAM1
			
			'

			Set @sSQL21 = '
			--- Lấy ca làm việc theo từng ngày
			SELECT #TAM1.*,
				CASE Day(#TAM1.AbsentDate)     
				WHEN 1 THEN HT1025.D01 WHEN 2 THEN HT1025.D02 WHEN 3 THEN HT1025.D03 WHEN 4 THEN HT1025.D04 WHEN 5 THEN HT1025.D05 WHEN 6 THEN HT1025.D06 WHEN    
						7 THEN HT1025.D07 WHEN 8 THEN HT1025.D08 WHEN 9 THEN HT1025.D09 WHEN 10 THEN HT1025.D10 WHEN 11 THEN HT1025.D11 WHEN 12 THEN HT1025.D12 WHEN    
									13 THEN HT1025.D13 WHEN 14 THEN HT1025.D14 WHEN 15 THEN HT1025.D15 WHEN 16 THEN HT1025.D16 WHEN 17 THEN HT1025.D17 WHEN 18 THEN HT1025.D18 WHEN    
									19 THEN HT1025.D19 WHEN 20 THEN HT1025.D20 WHEN 21 THEN HT1025.D21 WHEN 22 THEN HT1025.D22 WHEN 23 THEN HT1025.D23 WHEN 24 THEN HT1025.D24 WHEN    
									25 THEN HT1025.D25 WHEN 26 THEN HT1025.D26 WHEN 27 THEN HT1025.D27 WHEN 28 THEN HT1025.D28 WHEN 29 THEN HT1025.D29 WHEN 30 THEN HT1025.D30 WHEN    
									31 THEN HT1025.D31 ELSE NULL END AS ShiftID
			INTO #TAM11
			FROM #TAM1
			Inner join HT1025 ON #TAM1.EmployeeID = HT1025.EmployeeID AND Month(#TAM1.AbsentDate) = HT1025.TranMonth AND Year(#TAM1.AbsentDate) = HT1025.TranYear
			
			--- Loại trừ thời gian check in/out của ca thuộc ngày kế tiếp
			SELECT *
			INTO #TAM12
			FROM
			(
				SELECT	#TAM11.*,
						ISNULL((SELECT TOP 1 1 FROM HT1021 WHERE ShiftID = #TAM11.ShiftID AND DateTypeID = LEFT(DATENAME(dw,#TAM11.AbsentDate),3) AND ISNULL(IsNextDay,0) <> 0),0) AS IsNightShiftID,
						CONVERT(TIME(0),DATEADD(hh,1,(SELECT TOP 1 FromMinute FROM HT1021 WITH (NOLOCK) WHERE DivisionID = ''' + @DivisionID + ''' AND ShiftID = #TAM11.ShiftID
														AND DateTypeID = LEFT(DATENAME(dw,#TAM11.AbsentDate),3) AND ISNULL(IsOvertime,0) = 0 ORDER BY Orders)
									)) AS BeginTime
				FROM #TAM11
			) A
			WHERE Convert(date,AbsentDate)  = '''+Convert(Varchar(50),@DateProcess,101)+''' OR (Convert(date,AbsentDate) = '''+Convert(Varchar(50),@NextDateProcess,101)+''' AND AbsentTime <= ISNULL(BeginTime,AbsentTime))
			'

			Set @sSQL3 = '	
				SELECT	EmployeeID, AbsentCardNo, 
						min(CASE WHEN IOCode = 0 THEN ScanDate ELSE NULL END) as InTime, max(CASE WHEN IOCode = 1 THEN ScanDate ELSE NULL END) as OutTime
				INTO #TAM2B
				FROM #TAM12			
				WHERE	EmployeeID in (SElECT EmployeeID FROM #HP2432_NTY_lstEmp_NightShift)
				Group by EmployeeID, AbsentCardNo
				HAVING min(CASE WHEN IOCode = 0 THEN ScanDate ELSE NULL END)  < max(CASE WHEN IOCode = 1 THEN ScanDate ELSE NULL END)

				SELECT T1.DivisionID, T1.EmployeeID, TranMonth, TranYear, T1.AbsentCardNo, T1.AbsentDate, T1.AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate,
						Row_Number() Over (partition by T1.EmployeeID Order by (Select 1)) as Orders
				INTO #TAM3
				FROM #TAM12 T1
				INNER JOIN #TAM2B T2 On T1.EmployeeID = T2.EmployeeID And (T1.ScanDate = T2.InTime Or T1.ScanDate = T2.OutTime)

				Delete from HTT2433 WHERE EmployeeID in (SElECT EmployeeID FROM #HP2432_NTY_lstEmp_NightShift)
				Insert into HTT2433 (DivisionID	, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate)
				SELECT DivisionID, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate
				FROM #TAM3		
				select ''HTT2408'', * from HTT2408
				select ''#TAM1'', * from #TAM1		
				select ''#TAM2A'', * from #TAM2A
				select ''#TAM2B'', * from #TAM2B
				select ''#TAM3'', * from #TAM3
				select ''HTT2433'', * from HTT2433
			'    
			print @sSQL1
			print @sSQL2
			print @sSQL21
			print @sSQL3
			EXEC(@sSQL1 + @sSQL2 + @sSQL21 + @sSQL3)
			                                                
			--IF (@IsNextDay = 0)
			--BEGIN
			--	Set @sSQL2 = '
			--	SELECT	EmployeeID, AbsentCardNo, AbsentDate,
			--			min(AbsentTime) as InTime, max(AbsentTime) as OutTime
			--	INTO #TAM2
			--	FROM #TAM1
			--	Group by EmployeeID, AbsentCardNo, AbsentDate'

			--	Set @sSQL3 = '
			--	Delete from HTT2433
			--	Insert into HTT2433 (DivisionID	, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate)
			--	SELECT T1.DivisionID, T1.EmployeeID, TranMonth, TranYear, T1.AbsentCardNo, T1.AbsentDate, T1.AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate
			--	FROM #TAM1 T1
			--	INNER JOIN #TAM2 T2 On T1.EmployeeID = T2.EmployeeID And T1.AbsentDate = T2.AbsentDate And (T1.AbsentTime = T2.InTime Or T1.AbsentTime = T2.OutTime) 
			--	--select ''HTT2408'', * from HTT2408
			--	--select ''HTT2433'', '''+Convert(Varchar(50),@DateProcess,101)+''', * from HTT2433
			--	'
			--	EXEC(@sSQL1 + @sSQL2 + @sSQL3)
			--END
			--ELSE
			--BEGIN				
				
			--	Set @sSQL2 = '
			--	SELECT	EmployeeID, AbsentCardNo, 
			--			min(CASE WHEN IOCode = 0 THEN ScanDate ELSE NULL END) as InTime, max(CASE WHEN IOCode = 1 THEN ScanDate ELSE NULL END) as OutTime
			--	INTO #TAM2
			--	FROM #TAM1			
			--	Group by EmployeeID, AbsentCardNo
			--	HAVING min(CASE WHEN IOCode = 0 THEN ScanDate ELSE NULL END)  < max(CASE WHEN IOCode = 1 THEN ScanDate ELSE NULL END)
			--		'
				
			--	Set @sSQL3 = '		
			--	SELECT T1.DivisionID, T1.EmployeeID, TranMonth, TranYear, T1.AbsentCardNo, T1.AbsentDate, T1.AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate,
			--			Row_Number() Over (partition by T1.EmployeeID Order by (Select 1)) as Orders
			--	INTO #TAM3
			--	FROM #TAM1 T1
			--	INNER JOIN #TAM2 T2 On T1.EmployeeID = T2.EmployeeID And (T1.ScanDate = T2.InTime Or T1.ScanDate = T2.OutTime)
			--	'

			--	Set @sSQL4 = '			

			--	Delete from HTT2433
			--	Insert into HTT2433 (DivisionID	, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate)
			--	SELECT DivisionID, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate
			--	FROM #TAM3		
			--	--select ''HTT2408'', * from HTT2408
			--	--select ''#TAM1'', * from #TAM1		
			--	--select ''#TAM2'', * from #TAM2
			--	--select ''#TAM3'', * from #TAM3
			--	--select ''HTT2433'', * from HTT2433
			--	'
			--	--print @sSQL1
			--	--print @sSQL2
			--	--print @sSQL3
			--	--print @sSQL4
			--	EXEC(@sSQL1 + @sSQL2 + @sSQL3 + @sSQL4)
			--END
		End
		
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
	--if @employeeid = '450008'
	--      Select 'hp2432', * From HTT2433 Where DivisionID = @DivisionID And TranMonth = @TranMonth  
 -- And TranYear = @TranYear And EmployeeID = '450008' Order by EmployeeID,ScanDate  

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
	
	Fetch Next From @curHV2432 Into @ShiftID
End
Close @curHV2432

Deallocate @curHV2432
SET NOCOUNT OFF







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
