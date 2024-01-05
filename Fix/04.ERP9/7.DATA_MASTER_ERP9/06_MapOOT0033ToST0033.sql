

-- FIX Map dữ liệu OOT0033 => ST0033
DECLARE @IsSuccessful INT = 0

BEGIN TRY
BEGIN TRANSACTION;
BEGIN
	SET DATEFIRST 7
	-- ST0033
	DECLARE @APK UNIQUEIDENTIFIER,
			@DivisionID VARCHAR(50),
			@RecurrenceValue INT,
			@TypeOfRecurrence TINYINT,
			@DaysOfWeek VARCHAR(250),
			@DaysOfMonth VARCHAR(250),
			@WeekOfMonth VARCHAR(250),
			@MonthOfYear VARCHAR(250),
			@FromDate DATETIME,
			@ToDate DATETIME,
			@CreateUserID VARCHAR(50),
			@CreateDate DATETIME,
			@LastModifyUserID VARCHAR(50),
			@LastModifyDate DATETIME,
			@TimeRunBefore INT,
			@TypeOfTimeRunBefore TINYINT,
			@ScheduleType TINYINT,


	-- OOT0033
			@Apk_OO UNIQUEIDENTIFIER,
			@DivisionID_OO VARCHAR(50),
			@RecurrenceTypeID_OO INT,
			@EveryDays_OO TINYINT,
			@DayOfMonthYear_OO TINYINT,
			@DayOfMonthYear1_OO TINYINT,
			@IsSunday_OO TINYINT,
			@IsMonday_OO TINYINT,
			@IsTuesday_OO TINYINT,
			@IsWednesday_OO TINYINT,
			@IsThursday_OO TINYINT,
			@IsFriday_OO TINYINT,
			@IsSaturday_OO TINYINT,
			@TheMonthYear_OO INT,
			@TheMonthYear1_OO INT,
			@TheYear1_OO INT,
			@TheYear_OO INT,
			@DayNumber_OO INT,
			@TheDays_OO VARCHAR(250),
			@TheDay_OO INT,
			@TheMonth_OO INT,
			@TheMonth1_OO INT,
			@DayOfWeek_OO INT,
			@DayOfWeek1_OO INT,
			@WeekOfMonth_OO INT,
			@WeekOfMonth1_OO INT,
			@FromDate_OO DATETIME,
			@ToDate_OO DATETIME,
			@CreateUserID_OO VARCHAR(50),
			@CreateDate_OO DATETIME,
			@LastModifyUserID_OO VARCHAR(50),
			@LastModifyDate_OO DATETIME,
			@IsNumberOfRepeat_OO INT,
			@TypeOfRepeatID_OO TINYINT,
			@Cur CURSOR
	
	
	SET @Cur = CURSOR SCROLL KEYSET FOR

	SELECT APK, DivisionID, RecurrenceTypeID, EveryDays, DayOfMonthYear, DayOfMonthYear1, IsSunday, IsMonday, 
			IsTuesday, IsWednesday, IsThursday, IsFriday, IsSaturday, TheMonthYear, TheMonthYear1, TheYear1, TheYear, 
			DayNumber, TheDays, TheDay, TheMonth, TheMonth1, DayOfWeek, DayOfWeek1, WeekOfMonth, WeekOfMonth1, FromDate, 
			ToDate, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, IsNumberOfRepeat, TypeOfRepeatID
	FROM OOT0033 WITH(NOLOCK)
	ORDER BY LastModifyDate DESC
	
	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @APK_OO, @DivisionID_OO, @RecurrenceTypeID_OO, @EveryDays_OO, @DayOfMonthYear_OO, @DayOfMonthYear1_OO, 
								@IsSunday_OO, @IsMonday_OO, @IsTuesday_OO, @IsWednesday_OO, @IsThursday_OO, @IsFriday_OO, @IsSaturday_OO, 
								@TheMonthYear_OO, @TheMonthYear1_OO, @TheYear1_OO, @TheYear_OO, @DayNumber_OO, @TheDays_OO, @TheDay_OO, 
								@TheMonth_OO, @TheMonth1_OO, @DayOfWeek_OO, @DayOfWeek1_OO, @WeekOfMonth_OO, @WeekOfMonth1_OO, @FromDate_OO, 
								@ToDate_OO, @CreateUserID_OO, @CreateDate_OO, @LastModifyUserID_OO, @LastModifyDate_OO, @IsNumberOfRepeat_OO, 
								@TypeOfRepeatID_OO
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @APK = @APK_OO
		SET @DivisionID = @DivisionID_OO
		SET @FromDate = @FromDate_OO
		SET @ToDate = @ToDate_OO
		SET @CreateUserID = @CreateUserID_OO
		SET @CreateDate = @CreateDate_OO
		SET @LastModifyUserID = @LastModifyUserID_OO
		SET @LastModifyDate = @LastModifyDate_OO
		SET @TimeRunBefore = @IsNumberOfRepeat_OO
		SET @TypeOfTimeRunBefore = @TypeOfRepeatID_OO
		
		IF (@RecurrenceTypeID_OO = 0) -- OO Ngày
		BEGIN
			SET @ScheduleType = 1
			IF(@EveryDays_OO = 0) -- OOT0033 lặp mỗi {n} ngày.
			BEGIN
				-- ST0033 Lặp mỗi {n} ngày
				SET @TypeOfRecurrence = 1
				SET @RecurrenceValue = @DayNumber_OO
			END
			
			IF(@EveryDays_OO = 1) -- OOT0033 lặp mỗi ngày.
			BEGIN
				-- ST0033 Lặp mỗi ngày
				SET @TypeOfRecurrence = 2
				SET @RecurrenceValue = 1
			END
		END

		IF(@RecurrenceTypeID_OO = 1) -- OO Ngày trong tuần
		BEGIN

			SET @ScheduleType = 2
			SET @TypeOfRecurrence = 3
			SET @DaysOfWeek = ''
			IF(@IsSunday_OO = 1)
			BEGIN
				SET @DaysOfWeek = @DaysOfWeek + '1,'
			END
			IF(@IsMonday_OO = 1)
			BEGIN
				SET @DaysOfWeek = @DaysOfWeek + '2,'
			END
			IF(@IsTuesday_OO = 1)
			BEGIN
				SET @DaysOfWeek = @DaysOfWeek + '3,'
			END
			IF(@IsWednesday_OO = 1)
			BEGIN
				SET @DaysOfWeek = @DaysOfWeek + '4,'
			END
			IF(@IsThursday_OO = 1)
			BEGIN
				SET @DaysOfWeek = @DaysOfWeek + '5,'
			END
			IF(@IsFriday_OO = 1)
			BEGIN
				SET @DaysOfWeek = @DaysOfWeek + '6,'
			END
			IF(@IsSaturday_OO = 1)
			BEGIN
				SET @DaysOfWeek = @DaysOfWeek + '7,'
			END			
		END

		IF(@RecurrenceTypeID_OO = 2) -- OO Tháng
		BEGIN 
			SET @ScheduleType = 3

			IF(@DayOfMonthYear_OO = 0) -- Ngày mỗi tháng
			BEGIN
				SET @TypeOfRecurrence = 4
				SET @DaysOfMonth = @TheDays_OO
				SET @RecurrenceValue = @TheMonthYear_OO
			END

			IF(@DayOfMonthYear_OO = 1) -- Thứ của tuần mỗi tháng
			BEGIN
				SET @TypeOfRecurrence = 5
				SET @DaysOfWeek = CAST(@DayOfWeek_OO AS VARCHAR)
				SET @WeekOfMonth = CAST(@WeekOfMonth_OO AS VARCHAR)
				SET @RecurrenceValue = @TheMonthYear1_OO
			END
		END

		IF(@RecurrenceTypeID_OO = 3) -- OO Năm
		BEGIN
			SET @ScheduleType = 4
			IF(@DayOfMonthYear1_OO = 0)
			BEGIN
				SET @TypeOfRecurrence = 6
				SET @DaysOfMonth = CAST(@TheDay_OO AS VARCHAR)
				SET @MonthOfYear = CAST(@TheMonth_OO AS VARCHAR)
				SET @RecurrenceValue = @TheYear_OO
			END

			IF(@DayOfMonthYear1_OO = 1)
			BEGIN
				SET @TypeOfRecurrence = 7
			    SET @DaysOfWeek = CAST(@DayOfWeek1_OO AS VARCHAR)
				SET @WeekOfMonth = CAST(@WeekOfMonth1_OO AS VARCHAR)
				SET @MonthOfYear = CAST(@TheMonth1_OO AS VARCHAR)
				SET @RecurrenceValue = @TheYear1_OO
			END
		END
		
		-- Map dữ liệu OOT0033 => ST0033
		INSERT INTO ST0033(APK, DivisionID, RecurrenceValue, TypeOfRecurrence, DaysOfWeek, DaysOfMonth, WeekOfMonth, MonthOfYear, FromDate, ToDate, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, TimeRunBefore, TypeOfTimeRunBefore, ScheduleType)
		VALUES(@APK, @DivisionID, @RecurrenceValue, @TypeOfRecurrence, @DaysOfWeek, @DaysOfMonth, @WeekOfMonth, @MonthOfYear, @FromDate, @ToDate, @CreateUserID, @CreateDate, @LastModifyUserID, @LastModifyDate, @TimeRunBefore, @TypeOfTimeRunBefore, @ScheduleType)

		-- Tính ngày bắt đầu Task cho dữ liệu cũ OOT2110

		DECLARE @NextPlanStart DATETIME,
				@NextPlanEnd DATETIME,
				@PlaneStartDate DATETIME,
				@PlaneEndDate DATETIME,
				@StartTime TIME,
				@EndTime TIME,
				@APK2110 UNIQUEIDENTIFIER,
				@Count INT = 0,
				@TimeTemp DATETIME,
				@CurrentMonth INT,
				@CurrentYear INT

		SELECT TOP 1 @PlaneStartDate = CONVERT(DATE,PlanStartDate), @PlaneEndDate = CONVERT(DATE, PlanEndDate), @APK2110 = APK, 
				@StartTime = CONVERT(TIME,PlanStartDate), @EndTime = CONVERT(TIME, PlanEndDate)
		FROM OOT2110 O WITH (NOLOCK) 
		WHERE O.APKSettingTime = @APK
		ORDER BY O.PlanStartDate DESC

		IF (@TypeOfRecurrence = 1 OR @TypeOfRecurrence = 2)
		BEGIN
			SET @NextPlanStart = DATEADD(DD, @RecurrenceValue, @PlaneStartDate)
			SET @NextPlanEnd = DATEADD(DD, @RecurrenceValue, @PlaneEndDate)
		END

		IF (@TypeOfRecurrence = 3)
		BEGIN
			SET @NextPlanStart = DATEADD(DD, 1, @NextPlanStart)
			SET @NextPlanEnd = DATEADD(DD,1, @NextPlanEnd)
			SET @TimeTemp = DATEADD(DD, @RecurrenceValue, @PlaneStartDate)
			WHILE (1 = 1)
			BEGIN
				SET @NextPlanStart = DATEADD(DD, 1, @NextPlanStart)
				SET @NextPlanEnd = DATEADD(DD, 1, @NextPlanEnd)
				IF CHARINDEX(CONCAT(',',DATEPART(dw, @NextPlanStart), ','), CONCAT(',', @DaysOfWeek, ',')) > 0
				BEGIN
					BREAK
				END
			END
		END
				
		-- Tháng - TH1
		ELSE IF(@TypeOfRecurrence = 4)
		BEGIN
			SET @Count = 0
			SET @NextPlanStart = @PlaneStartDate
			SET @NextPlanEnd = @PlaneEndDate
			SET @CurrentMonth = MONTH(@PlaneStartDate)
			WHILE (1 = 1)
			BEGIN
				SET @NextPlanStart = DATEADD(DD, 1, @NextPlanStart)
				SET @NextPlanEnd = DATEADD(DD,1, @NextPlanEnd)
				IF @CurrentMonth != MONTH(@NextPlanStart)
					SET @NextPlanStart = DATEADD(MM, @RecurrenceValue - 1, @NextPlanStart)

				-- @DaysOfMonth =  '2,22,24,
				IF CHARINDEX(CONCAT(',', DAY(@NextPlanStart), ','), CONCAT(',', @DaysOfMonth, ',')) > 0
				BEGIN
					BREAK
				END
			END
		END
		-- Tháng - TH2
		IF(@TypeOfRecurrence = 5)
		BEGIN
			SET @NextPlanStart = @PlaneStartDate
			SET @NextPlanEnd = @PlaneEndDate
			SET @CurrentMonth = MONTH(@PlaneStartDate)
			
			WHILE(1 = 1)
			BEGIN
				SET @NextPlanStart = DATEADD(DD, 1, @NextPlanStart)
				SET @NextPlanEnd = DATEADD(DD,1, @NextPlanEnd)
				IF @CurrentMonth != MONTH(@NextPlanStart)
					SET @NextPlanStart = DATEADD(MM, @RecurrenceValue - 1, @NextPlanStart)
				
				IF CHARINDEX(CONCAT(',',CAST((DATEPART(WEEK, @NextPlanStart) - DATEPART(WEEK, DATEFROMPARTS(YEAR(@NextPlanStart),MONTH(@NextPlanStart),1)) + 1) AS VARCHAR), ','), CONCAT(',', @WeekOfMonth, ',')) > 0
				BEGIN
					IF CHARINDEX(CONCAT(',',DATEPART(dw, @NextPlanStart), ','), CONCAT(',', @DaysOfWeek, ',')) > 0
					BEGIN
						BREAK
					END
				END

			END
		END
		
		-- Năm - TH1
		IF(@TypeOfRecurrence = 6)
		BEGIN
			SET @NextPlanStart = @PlaneStartDate
			SET @NextPlanEnd = @PlaneEndDate
			SET @CurrentYear = YEAR(@PlaneStartDate)

			WHILE(1 = 1)
			BEGIN
				SET @NextPlanStart = DATEADD(DD, 1, @NextPlanStart)
				SET @NextPlanEnd = DATEADD(DD,1, @NextPlanEnd)

				IF @CurrentYear != YEAR(@NextPlanStart)
					SET @NextPlanStart = DATEADD(YEAR, @RecurrenceValue - 1, @NextPlanStart)

				IF CHARINDEX(CONCAT(',',MONTH(@NextPlanStart), ','), CONCAT(',', @MonthOfYear, ',')) > 0
				BEGIN
					IF CHARINDEX(CONCAT(',',DAY(@NextPlanStart), ','), CONCAT(',', @DaysOfMonth, ',')) > 0
					BEGIN
						BREAK
					END
				END

			END
		END

		-- Năm - TH2
		IF(@TypeOfRecurrence = 7)
		BEGIN
			SET @NextPlanStart = @PlaneStartDate
			SET @NextPlanEnd = @PlaneEndDate
			SET @CurrentYear = YEAR(@PlaneStartDate)

			WHILE (1 = 1)
			BEGIN
				SET @NextPlanStart = DATEADD(DD, 1, @NextPlanStart)
				SET @NextPlanEnd = DATEADD(DD, 1, @NextPlanEnd)

				IF @CurrentYear != YEAR(@NextPlanStart)
					SET @NextPlanStart = DATEADD(YEAR, @RecurrenceValue - 1, @NextPlanStart)

				-- Tháng trong năm
				IF CHARINDEX(CONCAT(',', MONTH(@NextPlanStart), ','), CONCAT(',', @MonthOfYear, ',')) > 0
				BEGIN

					-- Tuần thứ mấy trong tháng
					IF CHARINDEX(CONCAT(',', CAST((DATEPART(WEEK, @NextPlanStart) - DATEPART(WEEK, DATEFROMPARTS(YEAR(@NextPlanStart), MONTH(@NextPlanStart),1)) + 1) AS VARCHAR), ','), CONCAT(',', @WeekOfMonth, ',')) > 0
					BEGIN
						IF CHARINDEX(CONCAT(',',DATEPART(dw, @NextPlanStart), ','), CONCAT(',', @DaysOfWeek, ',')) > 0
						BEGIN
							BREAK
						END
					END
				END

			END
		END

		UPDATE OOT2110 SET NextPlanDate = @NextPlanStart WHERE APKSettingTime = @APK

		FETCH NEXT FROM @Cur INTO @APK_OO, @DivisionID_OO, @RecurrenceTypeID_OO, @EveryDays_OO, @DayOfMonthYear_OO, @DayOfMonthYear1_OO, 
								@IsSunday_OO, @IsMonday_OO, @IsTuesday_OO, @IsWednesday_OO, @IsThursday_OO, @IsFriday_OO, @IsSaturday_OO, 
								@TheMonthYear_OO, @TheMonthYear1_OO, @TheYear1_OO, @TheYear_OO, @DayNumber_OO, @TheDays_OO, @TheDay_OO, 
								@TheMonth_OO, @TheMonth1_OO, @DayOfWeek_OO, @DayOfWeek1_OO, @WeekOfMonth_OO, @WeekOfMonth1_OO, @FromDate_OO, 
								@ToDate_OO, @CreateUserID_OO, @CreateDate_OO, @LastModifyUserID_OO, @LastModifyDate_OO, @IsNumberOfRepeat_OO, 
								@TypeOfRepeatID_OO
	END
CLOSE @Cur
END
UPDATE ST0033 SET BusinessScreen = 'WORK' WHERE APK IN (SELECT APKSettingTime FROM OOT2110 WHERE TaskTypeID = '2')
UPDATE ST0033 SET BusinessScreen = 'OOF2111' WHERE BusinessScreen = 'WORK'

SET @IsSuccessful = 1
COMMIT TRANSACTION;
END TRY

BEGIN CATCH
	SELECT   
		ERROR_NUMBER() AS ErrorNumber  
		,ERROR_SEVERITY() AS ErrorSeverity  
		,ERROR_STATE() AS ErrorState  
		,ERROR_LINE () AS ErrorLine  
		,ERROR_PROCEDURE() AS ErrorProcedure  
		,ERROR_MESSAGE() AS ErrorMessage;  
	ROLLBACK TRANSACTION;  
END CATCH

-- Trường hợp chuyển dữ liệu thành công
IF(@IsSuccessful = 1)
BEGIN
	-- Trường hợp không còn dữ liệu từ bảng OOT0033
	DELETE FROM OOT0033
END