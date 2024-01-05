IF EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE [name] = 'SplitWorkingTimeRound'
          AND [type] = 'FN'
)
    DROP FUNCTION SplitWorkingTimeRound;
GO

GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO
-- <Summary>
---- Cắt vùng thời gian làm việc ra 2 đoạn: phép năm và không lương: HRMP2112_NTY.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Bảo Toàn on 07/08/2019 

-- <Example>
CREATE FUNCTION SplitWorkingTimeRound
(
    @BeginTime DATETIME,      -- Giờ bắt đầu
    @EndTime DATETIME,        -- Giờ kết thúc
    @BreakHourBegin DATETIME, --- Giờ bắt đầu nghỉ
    @BreakHourEnd DATETIME,   --- Giờ kết thúc nghỉ
    @HourSplit DECIMAL(8,2)            --- Thời gian được cắt
)
RETURNS DATETIME
BEGIN
    DECLARE @result DATETIME;

    --- Nếu [Giờ bắt đầu] nằm trong khoảng thời gian nghỉ thì set [Giờ bắt đầu] thành [Giờ kết thúc nghỉ]
    IF (
           @BeginTime >= @BreakHourBegin
           AND @BeginTime <= @BreakHourEnd
           AND @EndTime >= @BreakHourEnd
       )
        SET @BeginTime = @BreakHourEnd;

	SET @result = @BeginTime;

    --- Nếu [Thời gian nghỉ] nằm trong vùng thì sẽ cộng khoản thời gian.
    IF (@BeginTime <= @BreakHourBegin AND @EndTime >= @BreakHourBegin)
    BEGIN	
        SET @result
            = DATEADD(MINUTE, CONVERT(DECIMAL(8, 2), DATEDIFF(MINUTE, @BreakHourBegin, @BreakHourEnd)), @BeginTime);
    END;

    SET @result = DATEADD(MINUTE, @HourSplit * 60, @result);

    IF (@result > @EndTime)
        SET @result = @EndTime;

    RETURN @result;
END;

GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO