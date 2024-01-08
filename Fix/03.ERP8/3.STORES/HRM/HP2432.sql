IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2432]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP2432]
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
--- Modify on 11/12/2019 by Văn Tài: Format lại cách trình bày, không thay đổi về code.
--- Modify on 11/12/2019 by Huỳnh Thử: fix: OT đêm liên tiếp không chấm công không được
--- Modify on 04/05/2020 by Huỳnh Thử: Optimize: OT đêm liên tiếp không chấm công không được
--- Modify on 11/05/2020 by Huỳnh Thử: Chỉ chấm công ca đêm cho những ca thuộc ca đêm (Detail IsNextDay = 1)
--- Modify on 11/05/2020 by Huỳnh Thử: Chấm công trường hợp: Ngày trước làm ca đêm, ngày hôm sau là ca thường. (VD: Ngày 9: 7h ra, 15h vào, 11 h ra.)
--- Modify on 03/07/2020 by Huỳnh Thử: FIX Thêm: Chấm công trường hợp: Ngày trước làm ca đêm, ngày hôm sau là ca thường. (VD: Ngày 9: 7h ra, 15h vào, 11 h ra.)
--- Modified on 10/09/2020 by Nhựt Trường: tách store cho customer Meiko.
--- Modified on 15/04/2020 by Hoài Phong: tách store cho customer NQH.
--- Modified on 24/06/2021 by Văn Tài	: Tách trường hợp xử lý 1 máy chấm công cho khách hàng PMT.
--- Modified on 26/04/2022 by Văn Tài	: Merge phần xử lý chấm công có kiểm tra qua đêm và không qua đêm.
--- Modified on 20/07/2022 by Văn Tài	: Xử lý bảng TAM3 không phát sinh được khi trường hợp ca qua đêm.
--- Modified on 20/09/2022 by Văn Tài	: Xử lý công qua đêm dự vào ca quy định để bắt Thời gian bắt đầu và kết thúc lấy dữ liệu quẹt thẻ.
--- Modified on 16/12/2022 by Văn Tài	: Điều chỉnh lấy giờ qua đêm chính xác hơn.
--- Modified on 17/02/2023 by Văn Tài	: Tách store HIPC.
----HP2432 'IPL',12,2015,'12/05/2015','SAT','%','ADMIN','13081401'

CREATE PROCEDURE [dbo].[HP2432] @DivisionID NVARCHAR(50),				
				@TranMonth INT,
				@TranYear INT,
				@DateProcess DATETIME,
				@DateTypeID NVARCHAR(3),
				@DepartmentID NVARCHAR(50),	
				@CreateUserID NVARCHAR(50),
				@EmployeeID NVARCHAR(50) = '%'
AS

DECLARE @CustomerName INT
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF @CustomerName = 50 ---- Customize Meiko
BEGIN
	EXEC HP2432_MK @DivisionID, @TranMonth, @TranYear, @DateProcess, @DateTypeID, @DepartmentID, @CreateUserID, @EmployeeID
END
ELSE IF  @CustomerName = 131 ---- Customize NQH
BEGIN
	EXEC HP2432_NQH @DivisionID, @TranMonth, @TranYear, @DateProcess, @DateTypeID, @DepartmentID, @CreateUserID, @EmployeeID
END
ELSE IF @CustomerName = 158 ----- HIPC
BEGIN
	EXEC HP2432_HIPC @DivisionID, @TranMonth, @TranYear, @DateProcess, @DateTypeID, @DepartmentID, @CreateUserID, @EmployeeID
END
ELSE

BEGIN
DECLARE @curHV2432 CURSOR,
		@curHV2433 CURSOR,
		@ShiftID NVARCHAR(50),
		@BeginTime VARCHAR(8),
		@EndTime VARCHAR(8),
		@IsOverTime BIT,
		@IsNextDay BIT,
		@NextDateProcess DATETIME,
		@RestrictID NVARCHAR(50),	
		@EmployeeID1 NVARCHAR(50),
		@AbsentCardNo NVARCHAR(50),	
		@sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
		@sSQL3 NVARCHAR(MAX),
		@sSQL4 NVARCHAR(MAX),
		@ParamDefinition NVARCHAR(MAX),
		@CustomerIndex INT,
		@BeginDate DATETIME,
		@EndDate DATETIME

DECLARE	@sSQL001 NVARCHAR(4000),
		@TableHT2407 VARCHAR(50),		
		@sTranMonth VARCHAR(2)

SELECT @sTranMonth = CASE WHEN @TranMonth > 9 
						  THEN CONVERT(VARCHAR(2), @TranMonth) 
						  ELSE '0' + CONVERT(VARCHAR(1), @TranMonth) END

SELECT @BeginDate = BeginDate From HT9999 WHERE TranMonth = @TranMonth AND TranYear = @TranYear
SELECT @EndDate = EndDate From HT9999 WHERE TranMonth = @TranMonth AND TranYear = @TranYear

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WHERE IsSplitTable = 1)	
BEGIN
	SET  @TableHT2407 = 'HT2407M' + @sTranMonth + CONVERT(VARCHAR(4), @TranYear)
END
ELSE
BEGIN
	SET  @TableHT2407 = 'HT2407'
END
		

SELECT  @ParamDefinition= '@DivisionID2 NVARCHAR(50), @DateProcess2 DATETIME, @DepartmentID2 NVARCHAR(50), @EmployeeID2 NVARCHAR(50)'
		
-- Ca làm việc của ngày
Set @sSQL = 	'
DELETE FROM HTT2432
INSERT INTO HTT2432 (DivisionID, EmployeeID, ShiftID)
SELECT DivisionID, EmployeeID, ShiftID
FROM (
		SELECT HT1025.DivisionID
		, HT1025.EmployeeID
		, CASE DATEDIFF(DAY, '''+ CONVERT(NVARCHAR(50),@BeginDate) +''',@DateProcess2) + 1 WHEN 1 THEN D01 
								  WHEN 2 THEN D02 
								  WHEN 3 THEN D03 
								  WHEN 4 THEN D04 
								  WHEN 5 THEN D05 
								  WHEN 6 THEN D06 
								  WHEN 7 THEN D07 
								  WHEN 8 THEN D08 
								  WHEN 9 THEN D09 
								  WHEN 10 THEN D10 
								  WHEN 11 THEN D11 
								  WHEN 12 THEN D12 
								  WHEN 13 THEN D13 
								  WHEN 14 THEN D14 
								  WHEN 15 THEN D15 
								  WHEN 16 THEN D16 
								  WHEN 17 THEN D17 
								  WHEN 18 THEN D18 
								  WHEN 19 THEN D19 
								  WHEN 20 THEN D20 
								  WHEN 21 THEN D21 
								  WHEN 22 THEN D22 
								  WHEN 23 THEN D23 
								  WHEN 24 THEN D24 
								  WHEN 25 THEN D25 
								  WHEN 26 THEN D26 
								  WHEN 27 THEN D27 
								  WHEN 28 THEN D28 
								  WHEN 29 THEN D29 
								  WHEN 30 THEN D30 
								  WHEN 31 THEN D31 
								ELSE NULL END As ShiftID 
		FROM HT1025 
		INNER JOIN HT1400 ON HT1025.DivisionID = HT1400.DivisionID 
						 AND HT1025.EmployeeID = HT1400.EmployeeID
		WHERE HT1025.DivisionID = @DivisionID2 
			AND HT1025.TranYear = ' +CONVERT(NVARCHAR(50), @TranYear)+'
			AND HT1025.TranMonth = ' +CONVERT(NVARCHAR(50), @TranMonth)+'
			AND HT1400.DepartmentID LIKE @DepartmentID2 
			AND HT1400.EmployeeID LIKE @EmployeeID2 '

--IF (Select CustomerName from CustomerIndex) = 50	--- customize Meiko
	SET @sSQL = @sSQL + '
	UNION
	SELECT HT1025.DivisionID
		 , HT1025.EmployeeID
		 , CASE Day(@DateProcess2)     
                      WHEN 1 THEN D01 
					  WHEN 2 THEN D02 
					  WHEN 3 THEN D03 
					  WHEN 4 THEN D04 
					  WHEN 5 THEN D05 
					  WHEN 6 THEN D06 
					  WHEN 7 THEN D07 
					  WHEN 8 THEN D08 
					  WHEN 9 THEN D09 
					  WHEN 10 THEN D10 
					  WHEN 11 THEN D11 
					  WHEN 12 THEN D12 
					  WHEN 13 THEN D13 
					  WHEN 14 THEN D14 
					  WHEN 15 THEN D15 
					  WHEN 16 THEN D16 
					  WHEN 17 THEN D17 
					  WHEN 18 THEN D18
					  WHEN 19 THEN D19 
					  WHEN 20 THEN D20 
					  WHEN 21 THEN D21 
					  WHEN 22 THEN D22 
					  WHEN 23 THEN D23 
					  WHEN 24 THEN D24
					  WHEN 25 THEN D25 
					  WHEN 26 THEN D26 
					  WHEN 27 THEN D27 
					  WHEN 28 THEN D28 
					  WHEN 29 THEN D29
					  WHEN 30 THEN D30
					  WHEN 31 THEN D31 
					ELSE NULL END As ShiftID 
	FROM HT1025_MK HT1025 
	INNER JOIN HT1400 ON HT1025.DivisionID = HT1400.DivisionID 
						AND HT1025.EmployeeID = HT1400.EmployeeID
	WHERE HT1025.DivisionID = @DivisionID2 
		AND HT1025.TranYear = ' +CONVERT(NVARCHAR(50), @TranYear)+'
		AND HT1025.TranMonth = ' +CONVERT(NVARCHAR(50), @TranMonth)+'
		AND HT1400.DepartmentID LIKE @DepartmentID2 
		AND HT1400.EmployeeID LIKE @EmployeeID2
	'
SET @sSQL = @sSQL + ') A'

--Loc ra nhung ca lam viec lap trong ngay
--EXEC (@sSQL)
EXEC sp_executesql
	@sSQL,
	@ParamDefinition,
	@DivisionID2 = @DivisionID,
	@DateProcess2 = @DateProcess,
	@DepartmentID2 = @DepartmentID,
	@EmployeeID2 = @EmployeeID

-- Duyệt danh sách ca trong ngày của nhân viên đó
SET @curHV2432 = CURSOR STATIC FOR
	SELECT DISTINCT ShiftID 
	FROM HTT2432 
	WHERE ISNULL(ShiftID,'') <> '' 

-- DEBUG
--SELECT @DateProcess AS [Date], ShiftID FROM HTT2432

OPEN @curHV2432
FETCH NEXT FROM @curHV2432 INTO @ShiftID
WHILE @@Fetch_Status = 0
BEGIN
	--- Nếu là ca nghỉ được sắp sẵn nhưng không có dữ liệu quét thẻ (ví dụ nghỉ dưỡng sức, thai sản,...) thì vẫn chấm công đủ
	IF (SELECT ISNULL(IsAbsentShift,0) FROM HT1020 WHERE DivisionID = @DivisionID AND ShiftID = @ShiftID) <> 0
	BEGIN
		DECLARE @AbsentHour DECIMAL (28,8),
				@IsNextDayDetail BIT,
				@AbsentTypeID NVARCHAR(50),
				@Orders INT,
				@FromMinute DATETIME,  
				@ToMinute DATETIME,
				@curHV1020 CURSOR
				
		SET @curHV1020 = CURSOR STATIC FOR 
			SELECT CAST(@DateProcess + ' ' + FromMinute AS DATETIME)
				 , CAST(@DateProcess + ' ' + ToMinute AS DATETIME)
				 , IsNextDay
				 , AbsentTypeID
				 , Orders FROM HV1020
			WHERE ShiftID = @ShiftID 
				AND DateTypeID = @DateTypeID
			ORDER BY Orders

		OPEN @curHV1020
		FETCH NEXT FROM @curHV1020
				   INTO @FromMinute
					  , @ToMinute
					  , @IsNextDayDetail
					  , @AbsentTypeID
					  , @Orders
		WHILE @@FETCH_STATUS = 0  
		BEGIN
			SET @AbsentHour = 0
			IF @IsNextDayDetail = 1  
			BEGIN  
				IF @FromMinute>@ToMinute
				BEGIN
					SET @ToMinute = DATEADD(d, 1, @ToMinute)
				END
				ELSE   
				BEGIN
					SET @FromMinute = DATEADD(d, 1, @FromMinute)  
					SET @ToMinute = DATEADD(d, 1, @ToMinute)
				END
			END

			SET @AbsentHour = ROUND((DATEDIFF (mi, @FromMinute, @ToMinute))/60, 2)
			SELECT CONVERT(VARCHAR(50), GETDATE(), 101)
			SET @sSQL001 = N'
			INSERT INTO '+@TableHT2407+'  (
				TransactionID, DivisionID, EmployeeID, AbsentCardNo, TranMonth, TranYear, AbsentDate, ShiftID, Orders,  
				FromTime, ToTime, AbsentHour, FromTimeValid, ToTimeValid, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate,  
				AbsentTypeID, InEarlyMinutes, InLateMinutes, OutEarlyMinutes, OutLateMinutes, DeductMinutes, RestrictID, Coefficient, DeductTotal  
			)  
			SELECT  NEWID()
					, ''' + @DivisionID + '''
					, HTT2432.EmployeeID
					, --(SELECT TOP 1 AbsentCardNo FROM HT1407 WHERE DivisionID = ''' + @DivisionID + ''' AND EmployeeID = HTT2432.EmployeeID
					  --	AND (''' + CONVERT(VARCHAR(50), @DateProcess, 120)+''' BETWEEN BeginDate AND EndDate)),
					HT1407.AbsentCardNo
					, ' + STR(@TranMonth) + ', ' + STR(@TranYear) + '
					, ''' + CONVERT(VARCHAR(50), @DateProcess, 120) + '''
					, ''' + @ShiftID + '''
					, ' + STR(@Orders) + '
					, ''' + CONVERT(VARCHAR(50), @FromMinute, 120) + '''
					, ''' + CONVERT(VARCHAR(50), @ToMinute, 120) + '''
					, ' + CONVERT(VARCHAR(50), @AbsentHour) +'
					, ''' + CONVERT(VARCHAR(50), @FromMinute, 120) + '''
					, ''' + CONVERT(VARCHAR(50), @ToMinute, 120) + '''
					, ''' + @CreateUserID + '''
					, GETDATE()
					, ''' + @CreateUserID + '''
					, GETDATE()
					, ''' + @AbsentTypeID + '''
					, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL   
			FROM HTT2432
				INNER JOIN HT1407 ON HTT2432.EmployeeID = HT1407.EmployeeID 
									AND HTT2432.DivisionID = HT1407.DivisionID 									
			WHERE ShiftID = ''' + @ShiftID + ''' AND (''' + CONVERT(VARCHAR(50), @DateProcess, 101) + ''' BETWEEN HT1407.BeginDate AND HT1407.EndDate)			
			'

			EXEC (@sSQL001)
			--print ('@sSQL001: '+@sSQL001)			

			FETCH NEXT FROM @curHV1020 INTO @FromMinute, @ToMinute, @IsNextDayDetail, @AbsentTypeID, @Orders
		END
		CLOSE @curHV1020
	END

	ELSE
	BEGIN
		IF @CustomerIndex = 50 --- Meiko phải lấy dư thời gian EndTime của ca làm việc do có trường hợp xin làm thêm giờ ngoài sắp ca
			BEGIN
				SELECT TOP 1 @BeginTime = CONVERT(VARCHAR(8), DATEADD(HOUR, -1, CONVERT(TIME, BeginTime))),
							 @EndTime = CONVERT(VARCHAR(8), DATEADD(HOUR, 4, CONVERT(TIME, EndTime))),
							 @IsNextDay = IsNextDay
				FROM HV1020 Where ShiftID = @ShiftID 
								AND DateTypeID = @DateTypeID 
								AND DivisionID = @DivisionID 
				ORDER BY IsNextDay DESC
			END
		ELSE
			BEGIN
				SELECT TOP 1 @BeginTime = BeginTime
							, @EndTime = EndTime
							, @IsNextDay = IsNextDay
				FROM HV1020 
				WHERE DivisionID = @DivisionID 
					AND ShiftID = @ShiftID 
					AND DateTypeID = @DateTypeID 
				ORDER BY IsNextDay DESC
			END
		
		IF @BeginTime IS NULL
		  SET @BeginTime = '00:00:00'
		IF @EndTime IS NULL
		  SET @EndTime = '00:00:00'
	    
		--Neu ca lam viec co tinh ngay ke, gan bien ngay ke = ngay xu ly + 1 
		IF @IsNextDay = 1
			SET @NextDateProcess = DATEADD(d, 1, @DateProcess)
		ELSE -- Nguoc lai gan bien ngay ke = ngay xu ly
			SET @NextDateProcess = @DateProcess

		SELECT  @ParamDefinition= '@DateProcess2 DATETIME
								 , @BeginTime2 NVARCHAR(100)
								 , @NextDateProcess2 DATETIME
								 , @EndTime2 NVARCHAR(100)
								 , @ShiftID2 NVARCHAR(50)'
		
		--TH Khách hàng TUV : phần mềm tự lấy 2 dòng Min và max của AbsentTime, không quan tâm đến dữ liệu IOCode
		IF @CustomerIndex = 72 -- KH TUV
		BEGIN
			SET @sSQL1 = '
			SELECT APK
			    , DivisionID
				, EmployeeID
				, TranMonth
				, TranYear
				, AbsentCardNo
				, AbsentDate
				, AbsentTime
				, MachineCode
				, ShiftCode
				, IOCode
				, InputMethod
				, ScanDate
			INTO #TAM1
			FROM (
					SELECT    APK
							, DivisionID
							, EmployeeID
							, TranMonth
							, TranYear
							, AbsentCardNo
							, AbsentDate
							, AbsentTime
							, MachineCode
							, ShiftCode
							, IOCode
							, InputMethod,
							-- CAST(LTRIM(MONTH(AbsentDate)) + ''/'' + LTRIM(DAY(AbsentDate)) + ''/'' + LTRIM(YEAR(AbsentDate)) + '' '' + AbsentTime AS DateTime) AS ScanDate 
							-- CONVERT(DATETIME, CONVERT(VARCHAR(250), CONVERT(VARCHAR(50), AbsentDate, 101) + '' '' + CONVERT(VARCHAR(50), AbsentTime, 108), 21)) AS ScanDate
							AbsentDate + CAST(CONVERT(TIME, AbsentTime) AS datetime) AS ScanDate
					FROM HTT2408
					WHERE CONVERT(DATE, AbsentDate) BETWEEN ''' + CONVERT(VARCHAR(50), @DateProcess, 101) + ''' AND ''' + CONVERT(VARCHAR(50), @NextDateProcess, 101) + '''
						AND EXISTS (
									SELECT TOP 1 1 FROM HTT2432 WHERE EmployeeID = HTT2408.EmployeeID 
																	AND ShiftID = ''' + @ShiftID + '''
									)
				) C
				ORDER BY AbsentDate '
				
			Set @sSQL2 = '
			SELECT	EmployeeID
					, AbsentCardNo
					, AbsentDate
					, MIN(AbsentTime) AS InTime
					, MAX(AbsentTime) AS OutTime
			INTO #TAM2
			FROM #TAM1
			GROUP BY EmployeeID, AbsentCardNo, AbsentDate'

			Set @sSQL3 = '
			SELECT T1.DivisionID
					, T1.EmployeeID
					, TranMonth
					, TranYear
					, T1.AbsentCardNo
					, T1.AbsentDate
					, T1.AbsentTime
					, MachineCode
					, ShiftCode
					, IOCode
					, InputMethod
					, ScanDate
					, ROW_NUMBER() OVER (PARTITION BY T1.EmployeeID ORDER BY (SELECT 1)) AS Orders
			INTO #TAM3
			FROM #TAM1 T1
				INNER JOIN #TAM2 T2 On T1.EmployeeID = T2.EmployeeID 
									AND T1.AbsentDate = T2.AbsentDate 
									AND (T1.AbsentTime = T2.InTime OR T1.AbsentTime = T2.OutTime)
			'

			SET @sSQL4 = '
			DELETE FROM HTT2433
			INSERT INTO 
			HTT2433 (DivisionID, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate)
			SELECT   DivisionID, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate
			FROM #TAM3		
			
			-- select ''HTT2433'', * from  HTT2433 where EmployeeID = ''5350013''
			-- order by AbsentDate	
			'
			--print @sSQL1
			--print @sSQL2
			--print @sSQL3
			--print @sSQL4
			EXEC(@sSQL1 + @sSQL2 + @sSQL3 + @sSQL4)

		END
		ELSE
		IF @CustomerIndex = 62 -- PMT
		BEGIN
			SET @sSQL1 = '
			SELECT APK
			    , DivisionID
				, EmployeeID
				, TranMonth
				, TranYear
				, AbsentCardNo
				, AbsentDate
				, AbsentTime
				, MachineCode
				, ShiftCode
				, IOCode
				, InputMethod
				, ScanDate
			INTO #TAM1
			FROM (
					SELECT    APK
							, DivisionID
							, EmployeeID
							, TranMonth
							, TranYear
							, AbsentCardNo
							, AbsentDate
							, AbsentTime
							, MachineCode
							, ShiftCode
							, IOCode
							, InputMethod,
							-- CAST(LTRIM(MONTH(AbsentDate)) + ''/'' + LTRIM(DAY(AbsentDate)) + ''/'' + LTRIM(YEAR(AbsentDate)) + '' '' + AbsentTime AS DateTime) AS ScanDate 
							-- CONVERT(DATETIME, CONVERT(VARCHAR(250), CONVERT(VARCHAR(50), AbsentDate, 101) + '' '' + CONVERT(VARCHAR(50), AbsentTime, 108), 21)) AS ScanDate
							AbsentDate + CAST(CONVERT(TIME, AbsentTime) AS datetime) AS ScanDate
					FROM HTT2408
					WHERE CONVERT(DATE, AbsentDate) BETWEEN ''' + CONVERT(VARCHAR(50), @DateProcess, 101) + ''' AND ''' + CONVERT(VARCHAR(50), @NextDateProcess, 101) + '''
						AND EXISTS (
									SELECT TOP 1 1 FROM HTT2432 WHERE EmployeeID = HTT2408.EmployeeID 
																	AND ShiftID = ''' + @ShiftID + '''
									)
				) C
				ORDER BY AbsentDate '
				
			Set @sSQL2 = '
			SELECT	EmployeeID
					, AbsentCardNo
					, AbsentDate
					, MIN(AbsentTime) AS InTime
					, MAX(AbsentTime) AS OutTime
			INTO #TAM2
			FROM #TAM1
			GROUP BY EmployeeID, AbsentCardNo, AbsentDate'

			Set @sSQL3 = '
			SELECT T1.DivisionID
					, T1.EmployeeID
					, TranMonth
					, TranYear
					, T1.AbsentCardNo
					, T1.AbsentDate
					, T1.AbsentTime
					, MachineCode
					, ShiftCode
					, IOCode
					, InputMethod
					, ScanDate
					, ROW_NUMBER() OVER (PARTITION BY T1.EmployeeID ORDER BY (SELECT 1)) AS Orders
			INTO #TAM3
			FROM #TAM1 T1
				INNER JOIN #TAM2 T2 On T1.EmployeeID = T2.EmployeeID 
									AND T1.AbsentDate = T2.AbsentDate 
									AND (T1.AbsentTime = T2.InTime OR T1.AbsentTime = T2.OutTime)
			'

			SET @sSQL4 = '
			DELETE FROM HTT2433
			INSERT INTO 
			HTT2433 (DivisionID, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate)
			SELECT   DivisionID, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate
			FROM #TAM3		
			
			-- select ''HTT2433'', * from  HTT2433 where EmployeeID = ''5350013''
			-- order by AbsentDate	
			'
			--print @sSQL1
			--print @sSQL2
			--print @sSQL3
			--print @sSQL4
			EXEC(@sSQL1 + @sSQL2 + @sSQL3 + @sSQL4)

		END
		ELSE 
		BEGIN

			Set @sSQL1 = '	
			Select	DivisionID, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate, ShiftID
			Into #TAM1
			From (
			Select	DivisionID,EmployeeID,TranMonth, TranYear, AbsentCardNo,AbsentDate,AbsentTime, 
					MachineCode, ShiftCode, IOCode, InputMethod,
					--Cast(Ltrim(Month(AbsentDate)) + ''/'' + LTrim(Day(AbsentDate)) + ''/'' + LTRIM(yEAR(AbsentDate)) + '' '' + AbsentTime As DateTime) As ScanDate 
					-- Convert(Datetime, Convert(Varchar(250),Convert(Varchar(50),AbsentDate,101) +'' ''+ Convert(Varchar(50),AbsentTime,108),21)) As ScanDate
					AbsentDate + CAST(Convert(Time,AbsentTime) AS datetime) AS ScanDate,
					''' + @ShiftID + ''' AS ShiftID
			From HTT2408
			Where 	
					Convert(date,AbsentDate)  between '''+Convert(Varchar(50),@DateProcess,101)+''' and '''+Convert(Varchar(50),@NextDateProcess,101)+'''				 
				 And 
				 exists (Select top 1 1 From HTT2432 Where EmployeeID = HTT2408.EmployeeID and HTT2432.ShiftID = ''' + @ShiftID + ''')
				and not exists  (select top 1 1 from '+@TableHT2407+' T07 where HTT2408.EmployeeID = T07.EmployeeID and T07.ShiftID = ''' + @ShiftID + '''
									and HTT2408.AbsentDate = T07.AbsentDate
									and T07.TranMonth+T07.Tranyear*100 = '''+STR(@TranMonth+@TranYear*100)+''' )
				) C
			SELECT ''#TAM1'' AS Title, * FROM #TAM1	
			Order by IOCode	
			'

			If @IsNextDay = 0
			BEGIN
				SET @sSQL2 = 'SELECT	A.EmployeeID, A.AbsentCardNo, 
									MAX(A.InTime) as InTime, MAX(A.OutTime) as OutTime,MAX(A.InTimeOT) as InTimeOT, MAX(A.OutTimeOT) as OutTimeOT
						INTO #TAM2 
						FROM (
						SELECT	EmployeeID, AbsentCardNo, 
											min(ScanDate) as InTime, max(ScanDate) as OutTime,NULL as InTimeOT,NULL as OutTimeOT
									FROM #TAM1
									Group by EmployeeID, AbsentCardNo
						--- Tính Thời gian InTimeOT(Giờ checkin thực tế nếu sớm hơn là lấy giờ vào đăng ký đơn) => giá trị lớn nhất trong giờ gian CheckIn và thời gian đăng ký giờ vào đơn xin OT
						UNION ALL
						SELECT	EmployeeID, AbsentCardNo, NULL as InTime, NULL as OutTime,
											MAX(ScanDate) as InTimeOT,NULL as OutTimeOT
									FROM #TAM1
									WHERE IOCode = 0
									Group by EmployeeID, AbsentCardNo
						--- Tính Thời gian OutTimeOT(Giờ checkout thực tế nếu muộn hơn là lấy giờ ra đăng ký đơn)=> giá trị nhỏ nhất trong giờ gian CheckOut và thời gian đăng ký giờ ra đơn xin OT
						UNION ALL
						SELECT	EmployeeID, AbsentCardNo, NULL as InTime, NULL as OutTime,
											NULL as InTimeOT, MIN(ScanDate) as OutTimeOT
									FROM #TAM1
									WHERE IOCode = 1
									Group by EmployeeID, AbsentCardNo) A
						Group by A.EmployeeID, A.AbsentCardNo

						'
			END
			ELSE
			--- Có qua đêm thì lấy thông tin chấm công nhỏ hơn 7h30. Vì lớn 
			BEGIN
				SET @sSQL2 = 'SELECT	A.EmployeeID, A.AbsentCardNo, 
											(
												SELECT TOP 1 ScanDate
												FROM #TAM1 AA WITH (NOLOCK)
												INNER JOIN HT1020 HT02 WITH (NOLOCK) ON HT02.DivisionID = AA.DivisionID AND HT02.ShiftID = AA.ShiftID
												WHERE
													AA.EmployeeID = A.EmployeeID
													AND
													(
														(
															(CONVERT(DATE, AA.ScanDate) = CONVERT(DATE, ''' + Convert(Varchar(50), @DateProcess,101) + ''') AND DATEPART(HH, AA.ScanDate) >= (DATEPART(HH, HT02.BeginTime) - 2))
															AND
															(CONVERT(DATE, AA.ScanDate) < CONVERT(DATE, ''' + Convert(Varchar(50), @NextDateProcess,101) + '''))
														)
														OR
														(CONVERT(DATE, AA.ScanDate) = CONVERT(DATE, ''' + Convert(Varchar(50), @NextDateProcess,101) + ''') AND DATEPART(HH, AA.ScanDate) <= (DATEPART(HH, HT02.EndTime) + 2))
													)
												ORDER BY ScanDate
											) InTime
										,
											(
												SELECT TOP 1 ScanDate
												FROM #TAM1 A1 WITH (NOLOCK)
												WHERE 
													A1.EmployeeID = A.EmployeeID
													AND
													(
														(DAY(ScanDate) < DAY(''' + Convert(Varchar(50),@NextDateProcess,101) + ''') AND DATEPART(HH, ScanDate) >= 8)
														OR
														(DAY(ScanDate) = DAY(''' + Convert(Varchar(50),@NextDateProcess,101) + ''') AND DATEPART(HH, ScanDate) <= 7)
													)
												ORDER BY ScanDate DESC
											) OutTime
										, MAX(A.InTimeOT) as InTimeOT, MAX(A.OutTimeOT) as OutTimeOT
							INTO #TAM2 
							FROM (
									SELECT	EmployeeID, AbsentCardNo, 
														min(ScanDate) as InTime, max(ScanDate) as OutTime,NULL as InTimeOT,NULL as OutTimeOT
												FROM #TAM1
												Group by EmployeeID, AbsentCardNo
									--- Tính Thời gian InTimeOT(Giờ checkin thực tế nếu sớm hơn là lấy giờ vào đăng ký đơn) => giá trị lớn nhất trong giờ gian CheckIn và thời gian đăng ký giờ vào đơn xin OT
									UNION ALL
									SELECT EmployeeID, AbsentCardNo, NULL as InTime, NULL as OutTime,
														MIN(ScanDate) as InTimeOT,NULL as OutTimeOT
												FROM #TAM1
												--WHERE IOCode = 0
												Group by EmployeeID, AbsentCardNo
									--- Tính Thời gian OutTimeOT(Giờ checkout thực tế nếu muộn hơn là lấy giờ ra đăng ký đơn) => giá trị nhỏ nhất trong giờ gian CheckOut và thời gian đăng ký giờ ra đơn xin OT
									UNION ALL
									SELECT EmployeeID, AbsentCardNo, NULL as InTime, NULL as OutTime,
														NULL as InTimeOT, MAX(ScanDate) as OutTimeOT
												FROM #TAM1
												WHERE 
													--IOCode = 1
													--AND
													(
														(DAY(ScanDate) < DAY(''' + Convert(Varchar(50),@NextDateProcess,101) + ''') AND DATEPART(HH, ScanDate) >= 8)
														OR
														(DAY(ScanDate) = DAY(''' + Convert(Varchar(50),@NextDateProcess,101) + ''') AND DATEPART(HH, ScanDate) <= 7)
													)
												Group by EmployeeID, AbsentCardNo
							) A
							Group by A.EmployeeID, A.AbsentCardNo 
							ORDER BY A.EmployeeID, A.AbsentCardNo, MAX(A.InTime), MAX(A.OutTime), MAX(A.InTimeOT), MAX(A.OutTimeOT) '
			END

			Set @sSQL3 = '		
			SELECT T1.DivisionID, T1.EmployeeID, TranMonth, TranYear, T1.AbsentCardNo, T1.AbsentDate, T1.AbsentTime,
							--- Bổ sung trường Thời gian Quét là thời gian OT thực tế
							CASE WHEN T1.ScanDate = T2.InTime THEN  T2.InTimeOT ELSE  T2.OutTimeOT END as ScanDateOT, MachineCode, ShiftCode,
								IOCode, InputMethod, ScanDate, 
								Row_Number() Over (partition by T1.EmployeeID Order by (Select 1)) as Orders
			INTO #TAM3
			FROM #TAM1 T1
			INNER JOIN #TAM2 T2			
				On T1.EmployeeID = T2.EmployeeID And (T1.ScanDate = T2.InTime Or T1.ScanDate = T2.OutTime)
			'

			Set @sSQL4 = '			
			Delete from HTT2433
			Insert into HTT2433 (DivisionID	, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod,ScanDate, ScanDateOT)
			SELECT DivisionID, EmployeeID, TranMonth, TranYear, AbsentCardNo, AbsentDate, AbsentTime, MachineCode, ShiftCode, IOCode, InputMethod, ScanDate, ScanDateOT
			FROM #TAM3		
			
						
			--SELECT ''#TAM2'' Title, * FROM #TAM2	
			--SELECT ''#TAM3'' Title, * FROM #TAM3
			
			'

			--print @sSQL1
			--print @sSQL2
			--print @sSQL3
			--print @sSQL4
			SET @sSQL = @sSQL1 + @sSQL2 + @sSQL3 + @sSQL4
			EXEC(@sSQL)

			print ('B')

			SELECT @DateProcess AS [Date], * FROM HTT2433
		END
		
		SET @curHV2433 = CURSOR STATIC FOR 
									   SELECT DISTINCT EmployeeID 
									   FROM HTT2433 HV24
									   WHERE HV24.DivisionID = @DivisionID 
											 ---And (select count(EmployeeID) From HTT2433 where DivisionID = @DivisionID And TranMonth = @TranMonth And TranYear = @TranYear And employeeid = HV24.EmployeeID) % 2 = 0
		OPEN @curHV2433
		FETCH NEXT FROM @curHV2433 INTO @EmployeeID1
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT TOP 1 @AbsentCardNo = AbsentCardNo 
			FROM HTT2433 
			WHERE DivisionID = @DivisionID 
			  AND EmployeeID = @EmployeeID1	
			  --PRINT '----------------------------------------HP2433-----------------------------------'
			  --PRINT ('EXEC HP2433 ' + @DivisionID +',' + CONVERT(NVARCHAR(50),@TranMonth)+',' + CONVERT(NVARCHAR(50),@TranYear)+','+CONVERT(NVARCHAR(50),@DateProcess,111)+','+@EmployeeID1+','+@AbsentCardNo+','+@ShiftID+','+@DateTypeID+','+CONVERT(NVARCHAR(10),@IsNextDay)+','+@CreateUserID)
			EXEC HP2433 @DivisionID
					  , @TranMonth
					  , @TranYear
					  , @DateProcess
					  , @EmployeeID1
					  , @AbsentCardNo
					  , @ShiftID
					  , @DateTypeID
					  , @IsNextDay
					  , @CreateUserID

			FETCH NEXT FROM @curHV2433 INTO @EmployeeID1
		END

		CLOSE @curHV2433
	END
	
	FETCH NEXT FROM @curHV2432 Into @ShiftID
END
CLOSE @curHV2432

DEALLOCATE @curHV2432
SET NOCOUNT OFF

END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO