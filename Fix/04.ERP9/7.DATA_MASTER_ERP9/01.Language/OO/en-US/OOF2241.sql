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
SET @Language = 'en-US' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF2241';

SET @LanguageValue = N'Update device booking';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Booking ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.BookingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Booking Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.BookingName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Booking User';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.BookingUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Booking User Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.BookingUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.AreaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.UseUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.UseUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repeat';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.IsRepeat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Equipment Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.EquipmentTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.EquipmentTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Equipment Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.EquipmentNameID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.EquipmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.APKSettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'All day';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.IsAllDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.BookingStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.BookingStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.PeriodFilterList', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Equipment Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.EquipmentTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Device ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.DeviceID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Device Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.DeviceName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area';
EXEC ERP9AddLanguage @ModuleID, 'OOF2241.AreaID.CB', @FormID, @LanguageValue, @Language;

