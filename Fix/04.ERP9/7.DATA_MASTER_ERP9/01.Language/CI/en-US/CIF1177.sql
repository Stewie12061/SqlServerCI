-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1177- CI
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
SET @FormID = 'CIF1177';

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of analysis code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.AnaTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project Code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.AnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of project';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.AnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reference date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.RefDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.Amount01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.Note01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 02';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.Amount02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 02';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.Note02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 03';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.Amount03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 03';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.Note03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 04';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.Amount04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 04';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.Note04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 05';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.Amount05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 05';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.Note05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 06';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.Amount06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 06';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.Note06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 07';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.Amount07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 07';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.Note07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 08';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.Amount08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 08';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.Note08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 09';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.Amount09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 09';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.Note09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.Amount10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.Note10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dependency analysis code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.ReAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dependency analysis code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.ReAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1177.GroupID', @FormID, @LanguageValue, @Language;

