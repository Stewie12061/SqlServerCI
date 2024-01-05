IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP2017]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP2017]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Insert dữ liệu tạo công việc từ Pipeline (Thiết lập cho CBD)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Đình hòa, Date: 02/02/2021

CREATE PROCEDURE SP2017 ( 
        @DivisionID NVARCHAR(50),		
		@TaskID NVARCHAR(250),	
		@PlanStartDate DATETIME,
		@PlanEndDate DATETIME,
		@TaskTypeID NVARCHAR(250),
		@StatusID NVARCHAR(250),
		@AssignedToUserID NVARCHAR(250),
		@UserID NVARCHAR(250),
		@TaskName NVARCHAR(250),
		@PreviousTaskID NVARCHAR(50),
		@PlanTime DECIMAL(28,2)
) 
AS 
BEGIN	

	IF NOT EXISTS(SELECT TOP 1 1 FROM OOT2110 WITH (NOLOCK) WHERE PreviousTaskID = @PreviousTaskID AND DeleteFlg = 0)
	BEGIN
		DECLARE @BeginTime INT, @EndTime INT,@SpecialDay DATETIME, @NumberDaysOff INT = 0
				, @PlanStart DATETIME, @PlanEnd DATETIME, @IndexBegin INT, @DayOfWeek VARCHAR(20)
				, @Index INT = 1, @Count INT = 1, @MaxIndex INT , @WorkTime INT = 86400
				, @BeginTimeTmp INT,@BeginTimeSetting INT, @EndTimeSetting INT, @DateName VARCHAR(50)
				, @TimeActual INT

		--- Lấy thời gian làm việc đã thiết lập
		SELECT M.APK, M.DivisionID, M.FromDate, M.ToDate, K.IsWorkMon, K.IsWorkThurs, K.IsWorkWed, K.IsWorkTues, K.IsWorkFri, K.IsWorkSat
		, K.IsWorkSun, K.BeginTime, K.EndTime, K.HoursWork, K.BeginBreak, K.EndBreak
		INTO #ListTime
		FROM OOT0030 M WITH (NOLOCK)
			LEFT JOIN OOT0032 K WITH (NOLOCK) ON K.APKMaster = M.APK 
		WHERE M.FromDate < GETDATE() AND GETDATE() < M.ToDate 
		ORDER BY M.ToDate DESC

		--- Lấy thời gian ngày đặc biệt đã thiết lập
		SELECT N.*
		INTO #ListSpecialDay
		FROM OOT0030 M WITH (NOLOCK)
			LEFT JOIN OOT0031 N WITH (NOLOCK) ON N.APKMaster = M.APK
		WHERE M.FromDate < GETDATE() AND GETDATE() < M.ToDate 
		ORDER BY M.ToDate DESC

		CREATE TABLE #MyData(
			ShiftID VARCHAR(20),
			DayOfTheWeek VARCHAR(20),
			BeginTime INT,
			EndTime INT,
			DuringTime INT,
			Orders INT
		)

		INSERT INTO #MyData VALUES ('CA1','Monday',0,0,0,1); INSERT INTO #MyData VALUES ('CA2','Monday',0,0,0,2)
		INSERT INTO #MyData VALUES ('CA1','Tuesday',0,0,0,3); INSERT INTO #MyData VALUES ('CA2','Tuesday',0,0,0,4)
		INSERT INTO #MyData VALUES ('CA1','Wednesday',0,0,0,5); INSERT INTO #MyData VALUES ('CA2','Wednesday',0,0,0,6)
		INSERT INTO #MyData VALUES ('CA1','Thursday',0,0,0,7); INSERT INTO #MyData VALUES ('CA2','Thursday',0,0,0,8)
		INSERT INTO #MyData VALUES ('CA1','Friday',0,0,0,9); INSERT INTO #MyData VALUES ('CA2','Friday',0,0,0,10)
		INSERT INTO #MyData VALUES ('CA1','Saturday',0,0,0,11); INSERT INTO #MyData VALUES ('CA2','Saturday',0,0,0,12)
		INSERT INTO #MyData VALUES ('CA1','Sunday',0,0,0,13); INSERT INTO #MyData VALUES ('CA2','Sunday',0,0,0,14)

		IF EXISTS (SELECT TOP 1 1 FROM #ListTime WHERE IsWorkMon = 1)
		BEGIN
			SELECT TOP 1 @BeginTime = BeginTime FROM #ListTime WHERE IsWorkMon = 1 
			SELECT TOP 1 @EndTime = ISNULL(BeginBreak,EndTime) FROM #ListTime WHERE IsWorkMon = 1 
			UPDATE #MyData SET BeginTime = @BeginTime, EndTime = @EndTime, DuringTime = @EndTime - @BeginTime WHERE DayOfTheWeek = 'Monday' AND ShiftID = 'CA1'
			SELECT TOP 1 @BeginTime = ISNULL(EndBreak,EndTime) FROM #ListTime WHERE IsWorkMon = 1 
			SELECT TOP 1 @EndTime = EndTime FROM #ListTime WHERE IsWorkMon = 1 
			UPDATE #MyData SET BeginTime = @BeginTime, EndTime = @EndTime, DuringTime = @EndTime - @BeginTime WHERE DayOfTheWeek = 'Monday' AND ShiftID = 'CA2'
		END

		IF EXISTS (SELECT TOP 1 1 FROM #ListTime WHERE IsWorkTues = 1)
		BEGIN
			SELECT TOP 1 @BeginTime = BeginTime FROM #ListTime WHERE IsWorkTues = 1 
			SELECT TOP 1 @EndTime = ISNULL(BeginBreak,EndTime) FROM #ListTime WHERE IsWorkTues = 1 
			UPDATE #MyData SET BeginTime = @BeginTime, EndTime = @EndTime, DuringTime = @EndTime - @BeginTime WHERE DayOfTheWeek = 'Tuesday' AND ShiftID = 'CA1'
			SELECT TOP 1 @BeginTime = ISNULL(EndBreak,EndTime) FROM #ListTime WHERE IsWorkTues = 1 
			SELECT TOP 1 @EndTime = EndTime FROM #ListTime WHERE IsWorkTues = 1 
			UPDATE #MyData SET BeginTime = @BeginTime, EndTime = @EndTime, DuringTime = @EndTime - @BeginTime WHERE DayOfTheWeek = 'Tuesday' AND ShiftID = 'CA2'
		END

		IF EXISTS (SELECT TOP 1 1 FROM #ListTime WHERE IsWorkWed = 1)
		BEGIN
			SELECT TOP 1 @BeginTime = BeginTime FROM #ListTime WHERE IsWorkWed = 1 
			SELECT TOP 1 @EndTime = ISNULL(BeginBreak,EndTime) FROM #ListTime WHERE IsWorkWed = 1 
			UPDATE #MyData SET BeginTime = @BeginTime, EndTime = @EndTime, DuringTime = @EndTime - @BeginTime WHERE DayOfTheWeek = 'Wednesday' AND ShiftID = 'CA1'
			SELECT TOP 1 @BeginTime = ISNULL(EndBreak,EndTime) FROM #ListTime WHERE IsWorkWed = 1 
			SELECT TOP 1 @EndTime = EndTime FROM #ListTime WHERE IsWorkWed = 1 
			UPDATE #MyData SET BeginTime = @BeginTime, EndTime = @EndTime, DuringTime = @EndTime - @BeginTime WHERE DayOfTheWeek = 'Wednesday' AND ShiftID = 'CA2'
		END

		IF EXISTS (SELECT TOP 1 1 FROM #ListTime WHERE IsWorkThurs = 1)
		BEGIN
			SELECT TOP 1 @BeginTime = BeginTime FROM #ListTime WHERE IsWorkThurs = 1 
			SELECT TOP 1 @EndTime = ISNULL(BeginBreak,EndTime) FROM #ListTime WHERE IsWorkThurs = 1 
			UPDATE #MyData SET BeginTime = @BeginTime, EndTime = @EndTime, DuringTime = @EndTime - @BeginTime WHERE DayOfTheWeek = 'Thursday' AND ShiftID = 'CA1'
			SELECT TOP 1 @BeginTime = ISNULL(EndBreak,EndTime) FROM #ListTime WHERE IsWorkThurs = 1 
			SELECT TOP 1 @EndTime = EndTime FROM #ListTime WHERE IsWorkThurs = 1 
			UPDATE #MyData SET BeginTime = @BeginTime, EndTime = @EndTime, DuringTime = @EndTime - @BeginTime WHERE DayOfTheWeek = 'Thursday' AND ShiftID = 'CA2'
		END

		IF EXISTS (SELECT TOP 1 1 FROM #ListTime WHERE IsWorkFri = 1)
		BEGIN
			SELECT TOP 1 @BeginTime = BeginTime FROM #ListTime WHERE IsWorkFri = 1 
			SELECT TOP 1 @EndTime = ISNULL(BeginBreak,EndTime) FROM #ListTime WHERE IsWorkFri = 1 
			UPDATE #MyData SET BeginTime = @BeginTime, EndTime = @EndTime, DuringTime = @EndTime - @BeginTime WHERE DayOfTheWeek = 'Friday' AND ShiftID = 'CA1'
			SELECT TOP 1 @BeginTime = ISNULL(EndBreak,EndTime) FROM #ListTime WHERE IsWorkFri = 1 
			SELECT TOP 1 @EndTime = EndTime FROM #ListTime WHERE IsWorkFri = 1 
			UPDATE #MyData SET BeginTime = @BeginTime, EndTime = @EndTime, DuringTime = @EndTime - @BeginTime WHERE DayOfTheWeek = 'Friday' AND ShiftID = 'CA2'
		END

		IF EXISTS (SELECT TOP 1 1 FROM #ListTime WHERE IsWorkSat = 1)
		BEGIN
			SELECT TOP 1 @BeginTime = BeginTime FROM #ListTime WHERE IsWorkSat = 1 
			SELECT TOP 1 @EndTime = ISNULL(BeginBreak,EndTime) FROM #ListTime WHERE IsWorkSat = 1 
			UPDATE #MyData SET BeginTime = @BeginTime, EndTime = @EndTime, DuringTime = @EndTime - @BeginTime WHERE DayOfTheWeek = 'Saturday' AND ShiftID = 'CA1'
			SELECT TOP 1 @BeginTime = ISNULL(EndBreak,EndTime) FROM #ListTime WHERE IsWorkSat = 1 
			SELECT TOP 1 @EndTime = EndTime FROM #ListTime WHERE IsWorkSat = 1 
			UPDATE #MyData SET BeginTime = @BeginTime, EndTime = @EndTime, DuringTime = @EndTime - @BeginTime WHERE DayOfTheWeek = 'Saturday' AND ShiftID = 'CA2'
		END

		IF EXISTS (SELECT TOP 1 1 FROM #ListTime WHERE IsWorkSun = 1)
		BEGIN
			SELECT TOP 1 @BeginTime = BeginTime FROM #ListTime WHERE IsWorkSun = 1 
			SELECT TOP 1 @EndTime = ISNULL(BeginBreak,EndTime) FROM #ListTime WHERE IsWorkSun = 1 
			UPDATE #MyData SET BeginTime = @BeginTime, EndTime = @EndTime, DuringTime = @EndTime - @BeginTime WHERE DayOfTheWeek = 'Sunday' AND ShiftID = 'CA1'
			SELECT TOP 1 @BeginTime = ISNULL(EndBreak,EndTime) FROM #ListTime WHERE IsWorkSun = 1 
			SELECT TOP 1 @EndTime = EndTime FROM #ListTime WHERE IsWorkSun = 1 
			UPDATE #MyData SET BeginTime = @BeginTime, EndTime = @EndTime, DuringTime = @EndTime - @BeginTime WHERE DayOfTheWeek = 'Sunday' AND ShiftID = 'CA2'
		END

		-- Set lại thời gian bắt đầu nếu đã quá giờ làm việc
		SET @DateName = (SELECT DATENAME(WEEKDAY,@PlanStartDate))
		SET @BeginTimeSetting =  (SELECT TOP 1 BeginTime FROM #MyData Where DayOfTheWeek = @DateName ORDER BY Orders ASC)
		SET @EndTimeSetting =  (SELECT TOP 1 EndTime FROM #MyData Where DayOfTheWeek = @DateName ORDER BY Orders DESC)
		SET @TimeActual = ((SELECT DATEPART(HOUR, @PlanStartDate)) * 60 + (SELECT DATEPART(Minute, @PlanStartDate))) * 60
		SET @PlanStart = @PlanStartDate

		IF @BeginTimeSetting = 0
		BEGIN
			WHILE @BeginTimeSetting = 0
			BEGIN
				SET @PlanStart = (SELECT DATEADD(DAY,1, @PlanStart))
				SET @DateName = (SELECT DATENAME(WEEKDAY,@PlanStart))
				SET @BeginTimeSetting =  (SELECT TOP 1 BeginTime FROM #MyData Where DayOfTheWeek = @DateName ORDER BY Orders ASC)

				SET @PlanStart = (SELECT DATETIMEFROMPARTS(YEAR(@PlanStart), MONTH(@PlanStart), DAY(@PlanStart), (@BeginTimeSetting / 3600),0,0,0))
			END
		END
		ELSE
		IF @TimeActual > @EndTimeSetting
		BEGIN
			WHILE  @TimeActual > @EndTimeSetting OR (@BeginTimeSetting = 0 AND @EndTimeSetting = 0)
			BEGIN
				SET @PlanStart = (SELECT DATEADD(DAY,1, @PlanStart))
				SET @DateName = (SELECT DATENAME(WEEKDAY,@PlanStart))
				SET @BeginTimeSetting =  (SELECT TOP 1 BeginTime FROM #MyData Where DayOfTheWeek = @DateName ORDER BY Orders ASC)
				SET @EndTimeSetting =  (SELECT TOP 1 EndTime FROM #MyData Where DayOfTheWeek = @DateName ORDER BY Orders DESC)
				SET @PlanStart = (SELECT DATETIMEFROMPARTS(YEAR(@PlanStart), MONTH(@PlanStart), DAY(@PlanStart), (@BeginTimeSetting / 3600),0,0,0))

				SET @TimeActual = ((SELECT DATEPART(HOUR, @PlanStart)) * 60 + (SELECT DATEPART(Minute, @PlanStart))) * 60
			END
		END

		--- Ngày nghĩ trong tuần lấy từ thiết lập hệ thống
		SELECT @BeginTimeTmp = (DatePart(HOUR, @PlanStart) * 3600) + (DatePart(MINUTE, @PlanStart) * 60) + DatePart(SECOND, @PlanStart)
		SELECT TOP 1 @MaxIndex = Orders FROM #MyData ORDER BY Orders DESC
		SELECT @IndexBegin = Orders, @DayOfWeek = DayOfTheWeek FROM #MyData
		WHERE DayOfTheWeek = DATENAME(dw,@PlanStart) AND 
		(DatePart(HOUR, @PlanStart) * 3600) + (DatePart(MINUTE, @PlanStart) * 60) + DatePart(SECOND, @PlanStart) BETWEEN BeginTime AND EndTime
		SET @Index = @IndexBegin

		DECLARE @ResultTime INT = 0

		WHILE @WorkTime > 0 
		BEGIN
			DECLARE @pBeginTime INT, @pEndTime INT, @pDuringTime INT, @pDay VARCHAR(20)
			SELECT @pDay = DayOfTheWeek, @pBeginTime = BeginTime, @pEndTime = EndTime, @pDuringTime = DuringTime FROM #MyData WHERE Orders = @Index
			IF (@Count = 1)
			BEGIN
				SET @WorkTime = @WorkTime - (@pEndTime - @BeginTimeTmp)
			END
			ELSE
			BEGIN
				IF (@WorkTime > @pDuringTime)
				BEGIN
					SET @WorkTime = @WorkTime - @pDuringTime
				END
				ELSE 
				BEGIN
					SET @ResultTime = @pBeginTime + @WorkTime
					SET @WorkTime = 0
				END
			END
			IF (@DayOfWeek != @pDay)
			BEGIN
				SET @DayOfWeek = @pDay
				SET @PlanStart = DATEADD(day, 1, @PlanStart)
			END

			SET @Count = @Count + 1
			SET @Index = CASE WHEN (@Index + 1) % @MaxIndex = 0 THEN @MaxIndex ELSE (@Index + 1) % @MaxIndex END
		END

		SELECT DayOfTheWeek, CONVERT(datetime, CONVERT(varchar, @PlanStart, 101)) AS Ngay, @ResultTime AS Gio 
		INTO #WorkDate
		FROM #MyData WHERE Orders = @Index - 1

		SET @PlanEnd =  (SELECT DATEADD(SECOND,(SELECT Gio FROM #WorkDate) ,(SELECT Ngay FROM #WorkDate)))

		SET @SpecialDay = (SELECT DATETIMEFROMPARTS(YEAR(@PlanStartDate), MONTH(@PlanStartDate), DAY(@PlanStartDate), 0,0,0,0))

		--- Ngày lễ của công ty lấy từ thiết lập hệ thống
		WHILE @SpecialDay <= @PlanEnd
		BEGIN
			--SET @CurrentSpecialDay = (SELECT DATEPART(WEEKDAY, @SpecialDay))
			SELECT * INTO #ListSpecialDayTmp FROM #ListSpecialDay

			WHILE EXISTS (SELECT TOP 1 1 FROM #ListSpecialDayTmp)
			BEGIN
				SELECT TOP 1 APK, StartDayOff, EndDayOff INTO #Tmp FROM #ListSpecialDayTmp

				IF EXISTS(SELECT TOP 1 1 FROM #Tmp WHERE @SpecialDay BETWEEN StartDayOff AND EndDayOff)
					SET @NumberDaysOff = @NumberDaysOff + 1

				DELETE #ListSpecialDayTmp WHERE APK = (SELECT APK FROM #Tmp)
				DROP TABLE #Tmp
			END
	
			DROP TABLE #ListSpecialDayTmp

			SET @SpecialDay = DATEADD(HOUR,24,@SpecialDay)
		END

		-- Set lại thời gian kết thúc công việc khi rơi vào ngày nghỉ và ngày lễ của công ty
		IF(@NumberDaysOff > 0)
			SET @PlanEnd = DATEADD(DAY,@NumberDaysOff,@PlanEnd)

		--- Thêm công việc theo Pipeline
		INSERT INTO OOT2110 (DivisionID, TaskID, TaskName, TaskTypeID, PlanStartDate, PlanEndDate, PlanTime,StatusID, AssignedToUserID, PreviousTaskID,CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		VALUES(@DivisionID, @TaskID, @TaskName, @TaskTypeID, @PlanStartDate, @PlanEnd, 24, @StatusID, @AssignedToUserID, @PreviousTaskID, @UserID, GETDATE(), @UserID, GETDATE())	
			
	END

END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
