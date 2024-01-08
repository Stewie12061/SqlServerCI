-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2241- OO
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT


------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
------------------------------------------------------------------------------------------------------
/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'vi-VN' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF2241';


SET @LanguageValue = N'Cập nhật đặt thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đặt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.BookingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.BookingName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khu vực';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.UseUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.UseUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.EquipmentTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.EquipmentNameID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lặp lại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.IsRepeat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cả ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.IsAllDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.EquipmentTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.EquipmentTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.DeviceID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.DeviceName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã Khu vực';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.AreaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khu vực';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.AreaName.CB', @FormID, @LanguageValue, @Language;

