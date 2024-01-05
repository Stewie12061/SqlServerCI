DECLARE @ModuleID AS NVARCHAR(50) = 'ASOFTPA'


DECLARE
	@ScreenID VARCHAR(50),
	@ScreenName NVARCHAR(MAX),
	@ScreenNameE NVARCHAR(MAX),
	@ScreenType TINYINT

-----------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--- Danh mục
------------------------------------------------------------------------------------------------------

------------------------------------------------ PAF1000 ---------------------------------------------
----------------------------------------------------------------------------------------------------------
SET @ScreenType = 2
SET @ScreenID = N'PAF1000'
SET @ScreenName = N'Danh mục từ điển năng lực'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'PAF1020'
SET @ScreenName = N'Danh mục thiết lập bảng đánh giá năng lực'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'PAF2000'
SET @ScreenName = N'Danh mục đánh giá năng lực'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE


------------------------------------------------ PAF1001 ---------------------------------------------
----------------------------------------------------------------------------------------------------------
SET @ScreenType = 3
SET @ScreenID = N'PAF1001'
SET @ScreenName = N'Cập nhật từ điển năng lực'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'PAF1021'
SET @ScreenName = N'Cập nhật thiết lập bảng đánh giá năng lực'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'PAF2001'
SET @ScreenName = N'Cập nhật đánh giá năng lực'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE


---------------------- Màn hình khác ------------------

SET @ScreenType = 4
SET @ScreenID = N'PAF9001'
SET @ScreenName = N'Chọn từ điển năng lực'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE


------------------------------------------------ PAF1002 ---------------------------------------------
----------------------------------------------------------------------------------------------------------
SET @ScreenType = 5
SET @ScreenID = N'PAF1002'
SET @ScreenName = N'Xem chi tiết từ điển năng lực'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE





-----------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--- Danh mục
------------------------------------------------------------------------------------------------------

------------------------------------------------ PAF1010 ---------------------------------------------
----------------------------------------------------------------------------------------------------------
SET @ScreenType = 2
SET @ScreenID = N'PAF1010'
SET @ScreenName = N'Danh mục năng lực'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE


------------------------------------------------ PAF1011 ---------------------------------------------
----------------------------------------------------------------------------------------------------------
SET @ScreenType = 3
SET @ScreenID = N'PAF1011'
SET @ScreenName = N'Cập nhật năng lực'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE


------------------------------------------------ PAF1012 ---------------------------------------------
----------------------------------------------------------------------------------------------------------
SET @ScreenType = 5
SET @ScreenID = N'PAF1012'
SET @ScreenName = N'Xem chi tiết năng lực'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE

SET @ScreenID = N'PAF1022'
SET @ScreenName = N'Xem chi tiết thiết lập bảng đánh giá năng lực'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE


---------------------------------------------- PAF2002 -------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------

SET @ScreenID = N'PAF2002'
SET @ScreenName = N'Xem chi tiết bảng đánh giá năng lực'
SET @ScreenNameE = N''
EXEC AddScreenERP9 @ModuleID, @ScreenID,@ScreenType,@ScreenName,@ScreenNameE