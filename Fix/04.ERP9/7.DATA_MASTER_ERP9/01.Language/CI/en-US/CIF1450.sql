-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1450- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1450';

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1450.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1450.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1450.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Send feedback';
EXEC ERP9AddLanguage @ModuleID, 'CIF1450.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Translations done';
EXEC ERP9AddLanguage @ModuleID, 'CIF1450.UserNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Original name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1450.SystemName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Use';
EXEC ERP9AddLanguage @ModuleID, 'CIF1450.IsUsed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1450.IsCommon', @FormID, @LanguageValue, @Language;

