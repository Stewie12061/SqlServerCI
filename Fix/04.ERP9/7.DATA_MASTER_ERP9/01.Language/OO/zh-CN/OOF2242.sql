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
/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'zh-CN' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF2242';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'設備組代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.BookingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'標題';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.BookingName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訂購者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.BookingUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訂購者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.BookingUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'區域';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.AreaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'用戶';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.UseUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'用戶';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.UseUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'重複';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.IsRepeat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開始時間';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結束時間';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'描述';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'設備類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.EquipmentTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'設備類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.EquipmentTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'設備名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.EquipmentNameID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'設備名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.EquipmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.APKSettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'整天';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.IsAllDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.BookingStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'設置狀態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.BookingStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.PeriodFilterList', @FormID, @LanguageValue, @Language;

