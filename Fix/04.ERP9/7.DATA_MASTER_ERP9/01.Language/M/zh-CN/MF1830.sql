-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF1830- M
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
SET @FormID = 'MF1830';

SET @LanguageValue = N'替代材料清單';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'集團程式碼';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.MaterialGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'團隊名字';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.GroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'原物料類型';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'材料代碼';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.MaterialID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'原物料名稱';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.MaterialName_Temp', @FormID, @LanguageValue, @Language;

