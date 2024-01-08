-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1161- CI
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
SET @Language = 'en-US'; 
SET @ModuleID = 'CI';
SET @FormID = 'CIF1161';

SET @LanguageValue  = N'Update account'
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.Title',  @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account name (En)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.AccountNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.Notes1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.Notes2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'No provision';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.IsNotShow', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Management by object';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.IsObject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.CreateUserID', @FormID, @LanguageValue, @Language;

