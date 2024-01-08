IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2112]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2112]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Kiểm tra phép âm khi lưu đơn xin phép (ERP 9.0)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
--- Created on 25/12/2018 by Bảo Anh
--- Modified on 28/06/2019 by Như Hàn: Sửa lại cách viết store khi truyền các biến vào trong chuỗi gọi từ OOP2052
--- Modified on 16/03/2022 by Văn Tài: Xử lý truyền XML theo bản ERP 9.0
--- Modified on 17/05/2023 by Kiều Nga: Fix lỗi số ngày nghỉ vượt quá số phép tồn (trường hợp ca đêm).
-- <Example>
---- EXEC HRMP2112 'NTY','NTVN0021','P1','12/04/2018 07:30:00','12/04/2018 12:00:00',2,1
/*-- <Example>

----*/

CREATE PROCEDURE HRMP2112
( 
	@DivisionID VARCHAR(50),
	@XML XML
)
AS 
DECLARE @Cur AS CURSOR,
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
		@IsNextDay TINYINT,
		@WorkingTime DECIMAL(8,2),
		@AbsentDays DECIMAL(8,2),
		@IsAnnualLeave BIT,	--- là loại phép năm
		@IsOTLeave BIT	--- là loại phép nghỉ bù

CREATE TABLE #TAM (EmployeeID VARCHAR(50), AbsentDate DATE, ShiftID VARCHAR(50), BeginTime DATETIME, EndTime DATETIME, AbsentAmount DECIMAL(8,2), BreakHours DECIMAL(8,2), WorkingTime DECIMAL(8,2))

--Tạo bảng tạm chứa dữ liệu message cảnh báo
SELECT CONVERT(VARCHAR(50),'''') MessageID,CONVERT(TINYINT,0) [Status],CONVERT(VARCHAR(50),'''') Params
INTO #Message
--xóa dòng rỗng
DELETE #Message

SELECT	X.Data.query('EmployeeID').value('.', 'VARCHAR(50)') AS EmployeeID,
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
FETCH NEXT FROM @Cur INTO @EmployeeID, @AbsentTypeID, @LeaveFromDate, @LeaveToDate, @DaysRemained, @OTLeaveDaysRemained

WHILE @@Fetch_Status = 0 
BEGIN


	SELECT TOP 1 @IsAnnualLeave = ISNULL(H14.IsAnnualLeave,0)
	FROM OOT1000 T00 WITH (NOLOCK)
	INNER JOIN HT1013 H13 WITH (NOLOCK) ON T00.DivisionID = H13.DivisionID AND T00.TypeID = H13.AbsentTypeID AND H13.IsMonth = 0
	LEFT JOIN HT1013 H14 WITH (NOLOCK) ON H13.DivisionID = H14.DivisionID AND H13.ParentID = H14.AbsentTypeID AND H14.IsMonth = 1
	WHERE T00.DivisionID = @DivisionID AND T00.AbsentTypeID = @AbsentTypeID AND ISNULL(H13.IsDTVS,0) = 0

	SELECT TOP 1 @IsOTLeave = ISNULL(H14.IsOTLeave,0)
	FROM OOT1000 T00 WITH (NOLOCK)
	INNER JOIN HT1013 H13 WITH (NOLOCK) ON T00.DivisionID = H13.DivisionID AND T00.TypeID = H13.AbsentTypeID AND H13.IsMonth = 0
	LEFT JOIN HT1013 H14 WITH (NOLOCK) ON H13.DivisionID = H14.DivisionID AND H13.ParentID = H14.AbsentTypeID AND H14.IsMonth = 1
	WHERE T00.DivisionID = @DivisionID AND T00.AbsentTypeID = @AbsentTypeID AND ISNULL(H13.IsDTVS,0) = 0

	
	--- Nếu là loại phép năm hoặc nghỉ bù thì mới thực hiện kiểm tra phép âm
	IF ISNULL(@IsAnnualLeave,0) = 0 AND ISNULL(@IsOTLeave,0) = 0
	BEGIN
		FETCH NEXT FROM @Cur INTO @EmployeeID, @AbsentTypeID, @LeaveFromDate, @LeaveToDate, @DaysRemained, @OTLeaveDaysRemained
		CONTINUE
	END

	SELECT @TranMonth = TranMonth, @TranYear = TranYear FROM HT9999 WITH (NOLOCK)
	WHERE DivisionID = @DivisionID AND @LeaveFromDate <= EndDate AND @LeaveToDate >= BeginDate

	
	
	SET @FromDate = CONVERT(DATE,@LeaveFromDate,101)
	SET @ToDate = CONVERT(DATE,@LeaveToDate,101)


	SET @Date = @FromDate
	SET @EndTime = @LeaveFromDate

	WHILE @Date <= @ToDate AND @EndTime < @LeaveToDate
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

		SELECT TOP 1 @IsNextDay = ISNULL(IsNextDay,0)
		FROM HT1021 WITH (NOLOCK)
		WHERE DivisionID = @DivisionID AND ShiftID = @ShiftID AND DateTypeID = LEFT(DATENAME(dw,@Date),3)
		ORDER BY ISNULL(IsNextDay,0) DESC
	
		SELECT	@BeginTime = CONVERT(DATETIME, LTRIM(CONVERT(DATE,@Date,101)) + ' ' + BeginTime, 101),
				@EndTime =	CASE WHEN @IsNextDay = 0 THEN CONVERT(DATETIME, LTRIM(CONVERT(DATE,@Date,101)) + ' ' + EndTime, 101)
							ELSE  CASE WHEN CONVERT(DATETIME,CONVERT(VARCHAR(10),DATEADD(d,1,@Date),101) + ' ' + EndTime, 101) < @LeaveToDate
								  THEN CONVERT(DATETIME,CONVERT(VARCHAR(10),DATEADD(d,1,@Date),101) + ' ' + EndTime, 101) ELSE @LeaveToDate END 
							END,
				@WorkingTime = ISNULL(WorkingTime,8), @FromBreakTime = FromBreakTime, @ToBreakTime = ToBreakTime
		FROM HT1020 WITH (NOLOCK)
		WHERE DivisionID = @DivisionID AND ShiftID = @ShiftID
	
		IF ISNULL(@ShiftID,'') <> ''
		BEGIN
			INSERT INTO #TAM (EmployeeID, AbsentDate, ShiftID, BeginTime, EndTime, WorkingTime, BreakHours)
			SELECT	@EmployeeID, @Date, @ShiftID, @BeginTime, @EndTime, @WorkingTime,
					CASE WHEN @FromBreakTime IS NULL OR @ToBreakTime IS NULL THEN 1 ELSE 
					CONVERT(DECIMAL(8,2),DATEDIFF(minute,CONVERT(DATETIME, LTRIM(CONVERT(DATE,@Date,101)) + ' ' + @FromBreakTime, 101)
														,CASE WHEN @IsNextDay = 0 THEN CONVERT(DATETIME, LTRIM(CONVERT(DATE,@Date,101)) + ' ' + @ToBreakTime, 101) 
																				  ELSE CONVERT(DATETIME,CONVERT(VARCHAR(10),DATEADD(d,1,@Date),101) + ' ' + @ToBreakTime,101) END))/60 END
		END

		SET @Date = DATEADD (d,1,@Date)
	END

	UPDATE #TAM
	SET BeginTime = @LeaveFromDate
	WHERE EmployeeID = @EmployeeID AND AbsentDate = (SELECT TOP 1 AbsentDate FROM #TAM ORDER BY BeginTime)
	AND BeginTime < @LeaveFromDate

	UPDATE #TAM
	SET EndTime = @LeaveToDate
	WHERE EmployeeID = @EmployeeID AND AbsentDate = (SELECT TOP 1 AbsentDate FROM #TAM ORDER BY EndTime DESC)
	AND EndTime > @LeaveToDate

	UPDATE #TAM
	SET AbsentAmount = CASE WHEN BreakHours >0 THEN DATEDIFF(hh, BeginTime, EndTime) - ISNULL(BreakHours,1) ELSE DATEDIFF(hh, BeginTime, EndTime) END
	WHERE EmployeeID = @EmployeeID
	
	SELECT @AbsentDays = SUM(AbsentAmount/WorkingTime)
	FROM #TAM
	WHERE EmployeeID = @EmployeeID

	--select * from #TAM

	IF ISNULL(@IsAnnualLeave,0) = 1 and @DaysRemained < ROUND(@AbsentDays,2)
	BEGIN
		INSERT INTO #Message(MessageID,Status,Params)
		SELECT 'HRMFML000032', 1, @EmployeeID
	END
	ELSE IF ISNULL(@IsOTLeave,0) = 1 and @OTLeaveDaysRemained < ROUND(@AbsentDays,2)
	BEGIN
		INSERT INTO #Message(MessageID,Status,Params)
		SELECT 'HRMFML000034', 1, @EmployeeID
	END

	FETCH NEXT FROM @Cur INTO @EmployeeID, @AbsentTypeID, @LeaveFromDate, @LeaveToDate, @DaysRemained, @OTLeaveDaysRemained
END

SELECT Status,Params, MessageID FROM #Message WHERE ISNULL(Status,0) <> 0


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
