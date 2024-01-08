-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1451- CI
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
SET @FormID = 'CIF1451';

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Send feedback';
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Translations done';
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.UserNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Original name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.SystemName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Use';
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.IsUsed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.IsCommon', @FormID, @LanguageValue, @Language;

