IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2112_NTY]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2112_NTY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Kiểm tra phép âm khi lưu đơn xin phép và duyệt (ERP 9) : NEWTOYO
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
--- Created on 03/06/2020 by Văn Tài
--- Modified on 05/06/2020 by Văn Tài: Bổ sung kiểm round từng dòng phép.
--- Modified on 08/06/2020 by Văn Tài: Bổ sung gộp ngày tồn phép để kiểm tra.
--- Modified on 10/06/2020 by Văn Tài: Bổ sung biến đếm tồn phép OT.
--- Modified on 13/06/2020 by Văn Tài: Bổ sung cách tính theo khoản thời gian công nhật.
--- Modified on 28/07/2020 by Văn Tài: Bổ sung tên bảng cho cột IsDTVs.
--- Modified on 09/08/2022 by Thanh Lượng: Bổ sung CONVERT chỉ lấy ngày không lấy giờ
-- <Example>
---- 
/*-- <Example>

----*/

CREATE PROCEDURE HRMP2112_NTY
( 
	@DivisionID VARCHAR(50),
	@XML XML
)
AS 
DECLARE @Cur AS CURSOR,
		@Orders INT,
		@EmployeeID VARCHAR(50),
		@AbsentTypeID VARCHAR(50),
		@LeaveFromDate DATETIME,
		@LeaveToDate DATETIME,
		@DaysRemained DECIMAL(8,2),
		@OTLeaveDaysRemained DECIMAL(8,2),
		@FromDate DATE,
		@ToDate DATE,
		@Date DATE,
		@ShiftID VARCHAR(50),
		@TranMonth INT,
		@TranYear INT,
		@BeginTime DATETIME,
		@EndTime DATETIME,
		@FromBreakTime NVARCHAR(100),
		@ToBreakTime NVARCHAR(100),
		@BreakHours DECIMAL(8,2),
		@IsNextDay TINYINT,
		@WorkingTime DECIMAL(8,2),
		@AbsentDays DECIMAL(8,2),
		@AbsentAmountResult DECIMAL(8,2),		--- Kế quả thời gian nghỉ phép sau khi được làm tròn theo C30
		@RoundOfRecord INT,						--- thứ tự khoảng thời gian cho 1 dòng xin phép
		@DaysRemainedCountDown DECIMAL(8,2),	--- Ngày phép sử dụng của nhân viên đếm ngược.
		@DaysOTCountDown DECIMAL(8,2),			--- Ngày phép OT sử dụng của nhân viên đếm ngược.
		@C30 DECIMAL(8,2),
		@SplitTime DATETIME,					--- Thời gian tách.
		@FromBreakDate DATETIME,				--- Thời gian bắt đầu nghỉ có ngày.
		@ToBreakDate DATETIME,					--- Thời gian kết thúc nghỉ có ngày.
		@RoundBeginTime DATETIME,				--- Thời gian bắt đầu của round.
		@RoundEndTime DATETIME,					--- Thời gian kết thúc của round.
		@AbsentDaysRound DECIMAL(8,2),			--- Ngày phép sử dụng trong round.
		@ShiftFromTime DATETIME,				--- Thời gian bắt đầu ca công nhật.
		@ShiftToTime DATETIME,					--- Thời gian kết thúc ca công nhật.
		@IsAnnualLeave BIT,						--- là loại phép năm
		@IsOTLeave BIT							--- là loại phép nghỉ bù

CREATE TABLE #TAM
(
    Orders INT,
    EmployeeID VARCHAR(50),
    AbsentDate DATE,
    ShiftID VARCHAR(50),
    BeginTime DATETIME,
    EndTime DATETIME,
    AbsentAmount DECIMAL(8, 2),
    BreakHours DECIMAL(8, 2),
    WorkingTime DECIMAL(8, 2),
	RoundOfRecord INT,			--- Round thời gian của 1 dòng dữ liệu phép. *Có thể dùng như 1 round là 1 ngày trôi qua.
	StatusRound INT,			--- 0: hợp lệ, 1: lỗi, 2: Cần tách thời gian tại đây.
	SplitTime DATETIME,			--- Thời gian cắt.
)

CREATE TABLE #RemainedDays
(
    Orders INT,
    EmployeeID VARCHAR(50),
    DaysRemained DECIMAL(8, 2)
)

--Tạo bảng tạm chứa dữ liệu message cảnh báo
SELECT CONVERT(VARCHAR(50),'''') MessageID, 
	   CONVERT(TINYINT,0) [Orders], 
	   CONVERT(TINYINT,0) [Status],
	   CONVERT(VARCHAR(50),'''') Params, 
	   CONVERT(DECIMAL(8, 2), 0) AbsentDays
INTO #Message
--xóa dòng rỗng
DELETE #Message

SELECT	X.Data.query('Orders').value('.', 'INT') AS Orders,
		X.Data.query('EmployeeID').value('.', 'VARCHAR(50)') AS EmployeeID,
		X.Data.query('AbsentTypeID').value('.', 'VARCHAR(50)') AS AbsentTypeID,
		X.Data.query('LeaveFromDate').value('.', 'VARCHAR(50)') AS LeaveFromDate,
		X.Data.query('LeaveToDate').value('.', 'VARCHAR(50)') AS LeaveToDate,
		(CASE WHEN X.Data.query('DaysRemained').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('DaysRemained').value('.', 'VARCHAR(50)') END) AS DaysRemained,
		(CASE WHEN X.Data.query('OTLeaveDaysRemained').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('OTLeaveDaysRemained').value('.', 'VARCHAR(50)') END) AS OTLeaveDaysRemained
INTO	#HRMP2112
FROM	@XML.nodes('//Data') AS X (Data)


SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT *
FROM #HRMP2112

OPEN @Cur
FETCH NEXT FROM @Cur INTO @Orders, @EmployeeID, @AbsentTypeID, @LeaveFromDate, @LeaveToDate, @DaysRemained, @OTLeaveDaysRemained

WHILE @@Fetch_Status = 0 
BEGIN

	-- Lấy thông tin hồ sơ lương
	SELECT TOP 1
			@C30 = C30
	FROM HT1403_1 WITH (NOLOCK)
	WHERE DivisionID = @DivisionID
			AND EmployeeID = @EmployeeID

	IF(NOT EXISTS(SELECT TOP 1 * FROM #RemainedDays WHERE EmployeeID = @EmployeeID))
	BEGIN
		INSERT #RemainedDays
		(
			Orders,
			EmployeeID,
			DaysRemained
		)
		VALUES
		(   @Orders,
			@EmployeeID, 
			@DaysRemained);
	END;
	ELSE
	BEGIN
		SELECT TOP 1 @DaysRemained = DaysRemained FROM #RemainedDays WHERE EmployeeID = @EmployeeID
	END

	SET @DaysRemainedCountDown = @DaysRemained;
	SET @DaysOTCountDown = @DaysRemained;

	--------------------------------------------------------------------------------------------------------
	SELECT TOP 1
		   @IsAnnualLeave = ISNULL(H14.IsAnnualLeave, 0)
	FROM OOT1000 T00 WITH (NOLOCK)
		INNER JOIN HT1013 H13 WITH (NOLOCK)
			ON T00.DivisionID = H13.DivisionID
			   AND T00.TypeID = H13.AbsentTypeID
			   AND H13.IsMonth = 0
		LEFT JOIN HT1013 H14 WITH (NOLOCK)
			ON H13.DivisionID = H14.DivisionID
			   AND H13.ParentID = H14.AbsentTypeID
			   AND H14.IsMonth = 1
	WHERE T00.DivisionID = @DivisionID
		  AND T00.AbsentTypeID = @AbsentTypeID
		  AND ISNULL(H13.IsDTVS, 0) = 0;

	SELECT TOP 1
		   @IsOTLeave = ISNULL(H14.IsOTLeave, 0)
	FROM OOT1000 T00 WITH (NOLOCK)
		INNER JOIN HT1013 H13 WITH (NOLOCK)
			ON T00.DivisionID = H13.DivisionID
			   AND T00.TypeID = H13.AbsentTypeID
			   AND H13.IsMonth = 0
		LEFT JOIN HT1013 H14 WITH (NOLOCK)
			ON H13.DivisionID = H14.DivisionID
			   AND H13.ParentID = H14.AbsentTypeID
			   AND H14.IsMonth = 1
	WHERE T00.DivisionID = @DivisionID
		  AND T00.AbsentTypeID = @AbsentTypeID
		  AND ISNULL(H13.IsDTVS, 0) = 0;

	
	--- Nếu là loại phép năm hoặc nghỉ bù thì mới thực hiện kiểm tra phép âm
	IF ISNULL(@IsAnnualLeave,0) = 0 AND ISNULL(@IsOTLeave,0) = 0
	BEGIN
		FETCH NEXT FROM @Cur
		INTO @Orders,
			 @EmployeeID,
			 @AbsentTypeID,
			 @LeaveFromDate,
			 @LeaveToDate,
			 @DaysRemained,
			 @OTLeaveDaysRemained;
		CONTINUE
	END
	--- Bổ sung CONVERT chỉ lấy ngày không lấy giờ
	SELECT @TranMonth = TranMonth, @TranYear = TranYear FROM HT9999 WITH (NOLOCK)
	WHERE DivisionID = @DivisionID AND CONVERT(DATE, @LeaveFromDate, 101) <= CONVERT(DATE, EndDate, 101) AND CONVERT(DATE, @LeaveToDate, 101) >= CONVERT(DATE, BeginDate, 101)
	
	SET @RoundOfRecord = 0;
	SET @FromDate = CONVERT(DATE, @LeaveFromDate, 101);
	SET @ToDate = CONVERT(DATE, @LeaveToDate, 101);
	SET @Date = @FromDate;

	WHILE @Date <= @ToDate
	BEGIN
		SELECT @ShiftID = CASE G.DateOrder
						WHEN 1 THEN H25.D01 WHEN 2 THEN H25.D02 WHEN 3 THEN H25.D03 WHEN 4 THEN H25.D04 WHEN 5 THEN H25.D05 WHEN 6 THEN H25.D06 WHEN    
						7 THEN H25.D07 WHEN 8 THEN H25.D08 WHEN 9 THEN H25.D09 WHEN 10 THEN H25.D10 WHEN 11 THEN H25.D11 WHEN 12 THEN H25.D12 WHEN    
						13 THEN H25.D13 WHEN 14 THEN H25.D14 WHEN 15 THEN H25.D15 WHEN 16 THEN H25.D16 WHEN 17 THEN H25.D17 WHEN 18 THEN H25.D18 WHEN    
						19 THEN H25.D19 WHEN 20 THEN H25.D20 WHEN 21 THEN H25.D21 WHEN 22 THEN H25.D22 WHEN 23 THEN H25.D23 WHEN 24 THEN H25.D24 WHEN    
						25 THEN H25.D25 WHEN 26 THEN H25.D26 WHEN 27 THEN H25.D27 WHEN 28 THEN H25.D28 WHEN 29 THEN H25.D29 WHEN 30 THEN H25.D30 WHEN    
						31 THEN H25.D31 WHEN 32 THEN H25.D32 WHEN 33 THEN H25.D33 ELSE NULL END
		FROM HT1025 H25 WITH (NOLOCK)
		LEFT JOIN dbo.[GetDayOfMonth] (@DivisionID, @TranMonth, @TranYear) G ON G.Date = CONVERT(DATE,@Date,101)
		WHERE DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear AND EmployeeID = @EmployeeID

		SET @IsNextDay = 0
		SET @ShiftFromTime = NULL
		SET @ShiftToTime = NULL

		SELECT TOP 1 @IsNextDay = ISNULL(IsNextDay,0)
		FROM HT1021 WITH (NOLOCK)
		WHERE DivisionID = @DivisionID AND ShiftID = @ShiftID AND DateTypeID = LEFT(DATENAME(dw,@Date),3)
		ORDER BY ISNULL(IsNextDay,0) DESC
	
		SELECT @BeginTime = CONVERT(DATETIME, LTRIM(CONVERT(DATE, @Date, 101)) + ' ' + BeginTime, 101),
		   @EndTime = CASE
						  WHEN @IsNextDay = 0 THEN
							  CONVERT(DATETIME, LTRIM(CONVERT(DATE, @Date, 101)) + ' ' + EndTime, 101)
						  ELSE
							  CONVERT(DATETIME, CONVERT(VARCHAR(10), DATEADD(d, 1, @Date), 101) + ' ' + EndTime, 101)
					  END,
		   @WorkingTime = ISNULL(WorkingTime, 8),
		   @FromBreakTime = FromBreakTime,
		   @ToBreakTime =  ToBreakTime
		FROM HT1020 WITH (NOLOCK)
		WHERE DivisionID = @DivisionID
			  AND ShiftID = @ShiftID;

		SELECT TOP 1 
		@ShiftFromTime = CONVERT(DATETIME, LTRIM(CONVERT(DATE, @BeginTime, 101)) + ' ' + HT1021.FromMinute, 101),
		@ShiftToTime = 
		(
			CASE WHEN @IsNextDay = 0 
			THEN
			CONVERT(DATETIME, LTRIM(CONVERT(DATE, @BeginTime, 101)) + ' ' + HT1021.ToMinute, 101)
			ELSE
			CONVERT(DATETIME, CONVERT(VARCHAR(10), DATEADD(d, 1, @BeginTime), 101) + ' ' + HT1021.ToMinute, 101)
			END
		)
        FROM HT1021 WITH (NOLOCK)
        WHERE DivisionID = @DivisionID
            AND ShiftID = @ShiftID
            AND AbsentTypeID = 'CN'
            AND DateTypeID = dbo.GetDayOfWeek(@BeginTime)          
        ORDER BY Orders

		IF (@ShiftFromTime IS NOT NULL)
		BEGIN
			SET @WorkingTime = DATEDIFF(hour, @ShiftFromTime, @ShiftToTime)
		END
	
		INSERT INTO #TAM (Orders, EmployeeID, AbsentDate, ShiftID, BeginTime, EndTime, WorkingTime, BreakHours, RoundOfRecord, StatusRound)
		SELECT	@Orders, @EmployeeID, @Date, @ShiftID, @BeginTime, @EndTime, @WorkingTime,
				CASE WHEN @FromBreakTime IS NULL OR @ToBreakTime IS NULL THEN 1 ELSE CONVERT(DECIMAL(8,2),DATEDIFF(minute,@FromBreakTime,@ToBreakTime))/60 END,
				@RoundOfRecord,
				0

		---- BEGIN CHECK dữ liệu theo dòng

		UPDATE #TAM
		SET BeginTime = @LeaveFromDate
		WHERE EmployeeID = @EmployeeID 
		AND AbsentDate = (SELECT TOP 1 AbsentDate FROM #TAM ORDER BY BeginTime)
		AND BeginTime < @LeaveFromDate 
		AND Orders = @Orders 
		AND RoundOfRecord = @RoundOfRecord

		UPDATE #TAM
		SET EndTime = @LeaveToDate
		WHERE EmployeeID = @EmployeeID 
		AND AbsentDate = (SELECT TOP 1 AbsentDate FROM #TAM ORDER BY EndTime DESC)
		AND EndTime > @LeaveToDate 
		AND Orders = @Orders
		AND RoundOfRecord = @RoundOfRecord

		--- Lấy giá  trị AbsentAmount chưa được tính toán
		SELECT TOP 1 @AbsentAmountResult = (DATEDIFF(hh, BeginTime, EndTime) - ISNULL(BreakHours, 1)),
		@RoundBeginTime = BeginTime,
		@RoundEndTime = EndTime
		FROM #TAM
		WHERE EmployeeID = @EmployeeID 
		AND Orders = @Orders	
		AND RoundOfRecord = @RoundOfRecord
					
		IF (@AbsentAmountResult <> 0)
		BEGIN
			IF (ISNULL(@C30, 0) = 0)
			BEGIN
				IF (@AbsentAmountResult <= 4)
					SET @AbsentAmountResult = 4
				ELSE
					SET @AbsentAmountResult = 8

				SET @BreakHours = 4
			END
			ELSE
			BEGIN
				IF (@AbsentAmountResult <= 4.5)
					SET @AbsentAmountResult = 4.5
				ELSE
					SET @AbsentAmountResult = 9

				SET @BreakHours = 4.5
			END
		END

		UPDATE #TAM
		SET AbsentAmount = @AbsentAmountResult
		WHERE EmployeeID = @EmployeeID 
		AND Orders = @Orders	
		AND RoundOfRecord = @RoundOfRecord

		SELECT @AbsentDaysRound = AbsentAmount/WorkingTime
		FROM #TAM
		WHERE EmployeeID = @EmployeeID
		AND RoundOfRecord = @RoundOfRecord

		SELECT @AbsentDays = SUM(AbsentAmount/WorkingTime)
		FROM #TAM
		WHERE EmployeeID = @EmployeeID

		--SELECT 'A', * FROM #TAM

		IF (
			   ISNULL(@IsAnnualLeave, 0) = 1
			   AND @DaysRemained < ROUND(@AbsentDays, 2)
		   )
		   OR
		   -- Tăng ca
		   (
			   ISNULL(@IsOTLeave, 0) = 1
			   AND @OTLeaveDaysRemained < ROUND(@AbsentDays, 2)
		   )
		   --- START: Còn 0.5 ngày phép
		   OR
		   (
			   ISNULL(@IsAnnualLeave, 0) = 1
			   AND @DaysRemainedCountDown = 0.5
			   AND @Date < @ToDate
		   )
		   OR
		   (
			   ISNULL(@IsOTLeave, 0) = 1
			   AND @DaysRemainedCountDown = 0.5
			   AND @Date < @ToDate
		   )
		   --- END: Còn 0.5 ngày phép
		   --- START: Còn 1 ngày phép
		   OR
		   (
				ISNULL(@IsAnnualLeave, 0) = 1
			    AND @DaysRemainedCountDown = 1
				AND @AbsentDaysRound = 1
				AND @Date < @ToDate
		   )
		   OR
		   (
				ISNULL(@IsOTLeave, 0) = 1
			    AND @DaysRemainedCountDown = 1
				AND @AbsentDaysRound = 1
				AND @Date < @ToDate
		   )
		   --- END: Còn 1 ngày phép
		BEGIN
			SET @SplitTime = NULL
		
			--- Tồn tại vượt phép trước đó.
			DECLARE @exist INT = 0
			SELECT TOP 1
				   @exist = 1
			FROM #TAM
			WHERE EmployeeID = @EmployeeID
				  AND StatusRound > 0;

			--- Cập nhật trạng thái của round.
			UPDATE #TAM
			SET StatusRound = 1
			WHERE EmployeeID = @EmployeeID
				  AND Orders = @Orders
				  AND RoundOfRecord = @RoundOfRecord;

			--- SET giá trị thời gian nghỉ
			SET @FromBreakDate
			= DATEADD(
						 MINUTE,
						 DATEPART(HOUR, CAST(@FromBreakTime AS TIME)) * 60 + DATEPART(MINUTE, CAST(@FromBreakTime AS TIME)),
						 CAST(CONVERT(DATE, @BeginTime, 101) AS DATETIME)
					 );
			SET @ToBreakDate
			= DATEADD(
						 MINUTE,
						 DATEPART(HOUR, CAST(@ToBreakTime AS TIME)) * 60 + DATEPART(MINUTE, CAST(@ToBreakTime AS TIME)),
						 CAST(CONVERT(DATE, @BeginTime, 101) AS DATETIME)
					 );

			--- Nếu giá thời gian nghỉ nhỏ hơn => ca qua đêm và giờ nghỉ nằm ở ngày tiếp theo.
			IF(@FromBreakDate < @BeginTime)
				SET @FromBreakDate = DATEADD(DAY, 1, @FromBreakDate);
			IF(@ToBreakDate < @FromBreakDate)
				SET @ToBreakDate = DATEADD(DAY, 1, @ToBreakDate);

			--- Nếu thời gian xin nghỉ trước giờ bắt đầu ca thì set lại giá trị [bắt đầu của ca]
			--- Để có thể cộng giờ tiếp theo.
			--IF(@RoundBeginTime < @BeginTime)
			--BEGIN
			--SET @RoundBeginTime = @BeginTime
			--END

			--- Loại xin phép [nghỉ phép]: Ngày phép thường giảm còn 0.5 ngày => cắt ngày phép và không lương tại round này.
			IF(@exist = 0 
				AND ISNULL(@IsAnnualLeave, 0) = 1 
				AND @DaysRemainedCountDown > 0
				AND @DaysRemainedCountDown < 1)
			BEGIN
				SET @SplitTime = dbo.SplitWorkingTimeRound(@RoundBeginTime,
										@RoundEndTime,
										--- NEWTOYO: giờ công tính luôn cả giờ nghỉ trưa
										@FromBreakDate, 
										@FromBreakDate, 
										@BreakHours);
				UPDATE #TAM
				SET StatusRound = 2
					, SplitTime = @SplitTime
				WHERE EmployeeID = @EmployeeID
					  AND Orders = @Orders
					  AND RoundOfRecord = @RoundOfRecord;
			END

			--- Loại xin phép [nghỉ OT]: Ngày OT giảm còn 0.5 ngày => Cắt ngày phép và không lương lại đây [ngày tiếp theo].
			IF(@exist = 0 
				AND ISNULL(@IsOTLeave, 0) = 1 
				AND @DaysOTCountDown > 0
				AND @DaysOTCountDown < 1)
			BEGIN
				SET @SplitTime = dbo.SplitWorkingTimeRound(@RoundBeginTime,
										@RoundEndTime,
										--- NEWTOYO: giờ công tính luôn cả giờ nghỉ trưa
										@FromBreakDate, 
										@FromBreakDate, 
										@BreakHours);
				UPDATE #TAM
				SET StatusRound = 2
					, SplitTime = @SplitTime
				WHERE EmployeeID = @EmployeeID
					  AND Orders = @Orders
					  AND RoundOfRecord = @RoundOfRecord;
			END

			--- Loại xin phép [nghỉ phép]: Ngày phép thường giảm còn 1 và 
			IF(@exist = 0 
				AND ISNULL(@IsAnnualLeave, 0) = 1 
				AND @DaysRemainedCountDown = 1
				AND @Date < @ToDate
				)
			BEGIN
			
				--- Cập nhật thời gian cuối ngày.
				UPDATE #TAM
				SET StatusRound = 2
					, SplitTime = @RoundEndTime
				WHERE EmployeeID = @EmployeeID
					  AND Orders = @Orders
					  AND RoundOfRecord = @RoundOfRecord;
			END

			--- Loại xin phép [nghỉ OT]: Ngày phép thường giảm còn 1 và 
			IF(@exist = 0 
				AND ISNULL(@IsOTLeave, 0) = 1 
				AND @DaysOTCountDown = 1
				AND @Date < @ToDate
				)
			BEGIN
			
				--- Cập nhật thời gian cuối ngày.
				UPDATE #TAM
				SET StatusRound = 2
					, SplitTime = @RoundEndTime
				WHERE EmployeeID = @EmployeeID
					  AND Orders = @Orders
					  AND RoundOfRecord = @RoundOfRecord;
			END

		END;
				
		---- END CHECK dữ liệu theo dòng
				
		--- Tăng	
		SET @Date = DATEADD (d,1,@Date)
		SET @RoundOfRecord = @RoundOfRecord + 1

		--- Giảm		
		SET @DaysRemainedCountDown = @DaysRemainedCountDown - @AbsentDaysRound;
		SET @DaysOTCountDown = @DaysOTCountDown - @AbsentDaysRound

		IF(ISNULL(@IsAnnualLeave, 0) = 1)
		BEGIN
			UPDATE #RemainedDays
			SET DaysRemained = @DaysRemainedCountDown
			WHERE EmployeeID = @EmployeeID
		END

		IF(ISNULL(@IsOTLeave, 0) = 1)
		BEGIN
			UPDATE #RemainedDays
			SET DaysRemained = @DaysOTCountDown
			WHERE EmployeeID = @EmployeeID
		END

	END	
	
	--UPDATE #TAM
	--SET BeginTime = @LeaveFromDate
	--WHERE EmployeeID = @EmployeeID AND AbsentDate = (SELECT TOP 1 AbsentDate FROM #TAM ORDER BY BeginTime)
	--AND BeginTime < @LeaveFromDate AND Orders = @Orders

	--UPDATE #TAM
	--SET EndTime = @LeaveToDate
	--WHERE EmployeeID = @EmployeeID AND AbsentDate = (SELECT TOP 1 AbsentDate FROM #TAM ORDER BY EndTime DESC)
	--AND EndTime > @LeaveToDate AND Orders = @Orders
	
	----- Lấy giá  trị AbsentAmount chưa được tính toán
	--SELECT TOP 1 @AbsentAmountResult = (DATEDIFF(hh, BeginTime, EndTime) - ISNULL(BreakHours, 1))
	--FROM #TAM
	--WHERE EmployeeID = @EmployeeID AND Orders = @Orders	

	--IF (@AbsentAmountResult <> 0)
	--BEGIN
	--	-- Lấy thông tin hồ sơ lương
	--	SELECT TOP 1
	--		   @C30 = C30
	--	FROM HT1403_1
	--	WHERE DivisionID = @DivisionID
	--		  AND EmployeeID = @EmployeeID

	--	IF (ISNULL(@C30, 0) = 0)
	--	BEGIN
	--		IF (@AbsentAmountResult <= 4)
	--			SET @AbsentAmountResult = 4
	--		ELSE
	--			SET @AbsentAmountResult = 8
	--	END
	--	ELSE
	--	BEGIN
	--		IF (@AbsentAmountResult <= 4.5)
	--			SET @AbsentAmountResult = 4.5
	--		ELSE
	--			SET @AbsentAmountResult = 9
	--	END
	--END

	--UPDATE #TAM
	--SET AbsentAmount = @AbsentAmountResult
	--WHERE EmployeeID = @EmployeeID AND Orders = @Orders	
	
	SELECT @AbsentDays = SUM(AbsentAmount/WorkingTime)
	FROM #TAM
	WHERE EmployeeID = @EmployeeID
	
	IF ISNULL(@IsAnnualLeave, 0) = 1
	   AND @DaysRemained < ROUND(@AbsentDays, 2)
	BEGIN
		INSERT INTO #Message
		(
			MessageID,
			Orders,
			Status,
			Params,
			AbsentDays
		)
		SELECT 'HRMFML000039',
			   @Orders,
			   1,
			   @EmployeeID,
			   @AbsentDays;
	END;

	ELSE IF ISNULL(@IsOTLeave, 0) = 1
			AND @OTLeaveDaysRemained < ROUND(@AbsentDays, 2)
	BEGIN
		INSERT INTO #Message
		(
			MessageID,
			Orders,
			Status,
			Params,
			AbsentDays
		)
		SELECT 'HRMFML000039',
			   @Orders,
			   1,
			   @EmployeeID,
			   @AbsentDays;
	END;

	FETCH NEXT FROM @Cur
	INTO @Orders,
		 @EmployeeID,
		 @AbsentTypeID,
		 @LeaveFromDate,
		 @LeaveToDate,
		 @DaysRemained,
		 @OTLeaveDaysRemained;
END

SELECT  Orders, Status,Params, MessageID, AbsentDays FROM #Message WHERE ISNULL(Status,0) <> 0
-- TEST
 SELECT * FROM #TAM


