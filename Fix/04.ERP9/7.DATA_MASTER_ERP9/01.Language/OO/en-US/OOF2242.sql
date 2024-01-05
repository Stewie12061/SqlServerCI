-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2242- OO
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
/*S
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'en-US' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF2242';

SET @LanguageValue = N'Device booking info view';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Booking ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.BookingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Booking Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.BookingName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Booking User';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.BookingUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Booking User Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.BookingUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.AreaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.UseUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.UseUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repeat';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.IsRepeat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified User';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Equipment Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.EquipmentTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Equipment type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.EquipmentTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Equipment Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.EquipmentNameID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Equipment Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.EquipmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.APKSettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'All day';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.IsAllDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Booking Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.BookingStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Booking Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.BookingStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.PeriodFilterList', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.AreaName', @FormID, @LanguageValue, @Language;
