-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF1048- KPI
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
SET @FormID = 'KPIF1048';

SET @LanguageValue = N'Formula Update';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1048.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1048.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Formula ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1048.FormulaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Formula name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1048.FormulaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Formula';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1048.FormulaDes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1048.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1048.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1048.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1048.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1048.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1048.LastModifyDate', @FormID, @LanguageValue, @Language;

