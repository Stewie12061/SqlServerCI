-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1312- CI
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
SET @FormID = 'CIF1312';

SET @LanguageValue  = N'View detail analyst'
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.GroupIDName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of analysis code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.AnaTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product group code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.AnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product group name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.AnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recipe';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Analyst name (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.AnaNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reference date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.RefDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dependency analysis code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.ReAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dependency analysis code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.ReAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.GroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Analyst infomation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.ThongTinMaPhanTich',  @FormID, @LanguageValue, @Language;
SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Description',  @FormID, @LanguageValue, @Language;