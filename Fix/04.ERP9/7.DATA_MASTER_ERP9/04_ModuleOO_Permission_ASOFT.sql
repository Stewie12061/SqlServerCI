-- Thêm dữ liệu vào bảng Master

DECLARE
	@ModuleID VARCHAR(50),
	@ScreenID VARCHAR(50),
	@ScreenName NVARCHAR(MAX),
	@ScreenNameE NVARCHAR(MAX),
	@ScreenType TINYINT

SET @ModuleID = N'ASOFTOO'


SET @ScreenType = 2
--- Danh mục giờ công vi phạm
SET @ScreenID = N'OOF1080'
SET @ScreenName = N'Danh mục giờ công vi phạm'
SET @ScreenNameE = N'Danh mục giờ công vi phạm'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenType = 5
--- Xem chi tiết giờ công vi phạm
SET @ScreenID = N'OOF1082'
SET @ScreenName = N'Xem chi tiết giờ công vi phạm'
SET @ScreenNameE = N'Xem chi tiết giờ công vi phạm'
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE