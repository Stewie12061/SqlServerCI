-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2240- OO
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
SET @FormID = 'OOF2240';

SET @LanguageValue = N'Device booking list';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Booking ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.BookingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Booking Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.BookingName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Booking User';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.BookingUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Booking User Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.BookingUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.AreaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.UseUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.UseUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repeat';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.IsRepeat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Equipment Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.EquipmentTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Equipment type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.EquipmentTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Equipment Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.EquipmentNameID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Equipment Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.EquipmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.APKSettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'All day';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.IsAllDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Booking Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.BookingStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Booking Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.BookingStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.PeriodFilterList', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Equipment Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.EquipmentTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Equipment Type Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.EquipmentTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Device';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.DeviceID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Device Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.DeviceName.CB', @FormID, @LanguageValue, @Language;
