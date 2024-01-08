IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE [NAME] = 'GetDayVietnamese' AND [TYPE] = 'FN')
	DROP FUNCTION GetDayVietnamese
GO
-- <Summary>
---- Lấy tiếng việt ngày trong tuần.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Nhật Thanh on 22/07/2022

-- <Example>
CREATE FUNCTION GetDayVietnamese(
	@CurrentDate VARCHAR(10) -- Ngày tiếng anh
)
returns NVARCHAR(20)
BEGIN

	RETURN CASE WHEN @CurrentDate = 'Monday' THEN N'Thứ hai'
				WHEN @CurrentDate = 'Tuesday' THEN N'Thứ ba'
				WHEN @CurrentDate = 'Wednesday' THEN N'Thứ tư'
				WHEN @CurrentDate = 'Thursday' THEN N'Thứ năm'
				WHEN @CurrentDate = 'Friday' THEN N'Thứ sáu'
				WHEN @CurrentDate = 'Saturday' THEN N'Thứ bảy'
				WHEN @CurrentDate = 'Sunday' THEN N'Chủ nhật'
			END
END




