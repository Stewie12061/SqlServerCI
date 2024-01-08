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
SET @Language = 'zh-CN' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF2240';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訂購代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.BookingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'標題';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.BookingName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訂購者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.BookingUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訂購者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.BookingUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.AreaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'用戶';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.UseUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'用戶';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.UseUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.IsRepeat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開始時間';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結束時間';
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

SET @LanguageValue = N'設備類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.EquipmentTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'設備類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.EquipmentTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'設備名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.EquipmentNameID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'設備名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.EquipmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.APKSettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'整天';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.IsAllDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.BookingStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'設置狀態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.BookingStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.PeriodFilterList', @FormID, @LanguageValue, @Language;

