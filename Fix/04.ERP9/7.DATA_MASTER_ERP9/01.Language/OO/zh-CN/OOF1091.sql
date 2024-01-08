-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1091- OO
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
SET @FormID = 'OOF1091';

SET @LanguageValue = N'設備代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.DeviceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'設備名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.DeviceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'設備名稱（英文）';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.DeviceNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APK';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'設備類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'區域';
EXEC ERP9AddLanguage @ModuleID, 'OOF1091.AreaID', @FormID, @LanguageValue, @Language;

