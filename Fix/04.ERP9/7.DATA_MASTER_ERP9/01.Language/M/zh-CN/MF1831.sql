-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF1831- M
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
SET @ModuleID = 'M';
SET @FormID = 'MF1831';

SET @LanguageValue = N'替換材料之更新';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'集團程式碼';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.MaterialGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'團隊名字';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.GroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'原料類型';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'材料代號';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.MaterialID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'材料代號';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.MaterialName_Temp', @FormID, @LanguageValue, @Language;

