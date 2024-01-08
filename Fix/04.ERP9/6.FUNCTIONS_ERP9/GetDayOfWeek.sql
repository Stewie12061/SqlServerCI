IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE [NAME] = 'GetDayOfWeek' AND [TYPE] = 'FN')
	DROP FUNCTION GetDayOfWeek
GO
-- <Summary>
---- Lấy mã ngày trong tuần.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Văn Tài on 08/06/2020 

-- <Example>
CREATE FUNCTION GetDayOfWeek(
	@CurrentDate DATETIME -- Cot phieu
)
returns VARCHAR(10)
BEGIN
	DECLARE @DayName VARCHAR(10);

	SET @DayName = DATENAME(dw, @CurrentDate);

	RETURN CASE WHEN @DayName = 'Monday' THEN 'MON'
				WHEN @DayName = 'Tuesday' THEN 'TUE'
				WHEN @DayName = 'Wednesday' THEN 'WED'
				WHEN @DayName = 'Thursday' THEN 'THU'
				WHEN @DayName = 'Friday' THEN 'FRI'
				WHEN @DayName = 'Saturday' THEN 'SAT'
				WHEN @DayName = 'Sunday' THEN 'SUN'
			END
END




