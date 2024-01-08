-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1310- CI
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
SET @FormID = 'CIF1310';

SET @LanguageValue  = N'List of analyst'
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.GroupIDName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of analysis code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.AnaTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product group code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.AnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product group name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.AnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Analyst name (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.AnaNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recipe';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reference date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.RefDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'You create';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dependency analysis code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.ReAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dependency analysis code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.ReAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Type ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.AnaTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.AnaTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classify';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.GroupID', @FormID, @LanguageValue, @Language;

