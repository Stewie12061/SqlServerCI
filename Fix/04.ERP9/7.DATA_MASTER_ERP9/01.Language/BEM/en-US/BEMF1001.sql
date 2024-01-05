-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF1001- BEM
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
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF1001';

SET @LanguageValue = N'Update fee type';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APK';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1001.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1001.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fee type ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1001.FeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fee name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1001.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'BEMF1001.IsCommon', @FormID, @LanguageValue, @Language;

