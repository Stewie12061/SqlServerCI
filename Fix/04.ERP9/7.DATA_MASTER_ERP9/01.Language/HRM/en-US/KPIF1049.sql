-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF1049- KPI
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
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF1049';

SET @LanguageValue = N'Formula View';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Formula ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.FormulaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Formula name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.FormulaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Formula';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.FormulaDes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user id';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Formula Information';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.TabFormulaInformation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.TabCRMT00002', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.TabCRMT00003', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1049.StatusID', @FormID, @LanguageValue, @Language;