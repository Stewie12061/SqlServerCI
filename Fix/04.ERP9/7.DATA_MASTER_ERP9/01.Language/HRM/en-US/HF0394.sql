-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HF0394- HRM
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
SET @ModuleID = 'HRM';
SET @FormID = 'HF0394';

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HF0394.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HF0394.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HF0394.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HF0394.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Seniority leave View';
EXEC ERP9AddLanguage @ModuleID, 'HF0394.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0394.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Seniority ID';
EXEC ERP9AddLanguage @ModuleID, 'HF0394.SeniorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Descriptions';
EXEC ERP9AddLanguage @ModuleID, 'HF0394.DescriptionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'HF0394.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'>= Value (Year)';
EXEC ERP9AddLanguage @ModuleID, 'HF0393.FromValues', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'< Value (Year)';
EXEC ERP9AddLanguage @ModuleID, 'HF0393.ToValues', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The number of increase leave days';
EXEC ERP9AddLanguage @ModuleID, 'HF0393.VacSeniorDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The number of leave days is move to next year';
EXEC ERP9AddLanguage @ModuleID, 'HF0393.VacSeniorPrevDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Seniority leave Details';
EXEC ERP9AddLanguage @ModuleID, 'TabHT1028', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Seniority leave infor';
EXEC ERP9AddLanguage @ModuleID, 'HF0394.SubTitle1', @FormID, @LanguageValue, @Language;