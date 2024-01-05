-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HF0397- HRM
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
SET @FormID = 'HF0397';

SET @LanguageValue = N'Annual leave calculation View';
EXEC ERP9AddLanguage @ModuleID, 'HF0397.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0397.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Method ID';
EXEC ERP9AddLanguage @ModuleID, 'HF0397.MethodVacationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Increasing leave days by';
EXEC ERP9AddLanguage @ModuleID, 'HF0397.MethodVacationName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0397.SeniorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Manage leave';
EXEC ERP9AddLanguage @ModuleID, 'HF0397.IsManagaVacationName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Increase leave days';
EXEC ERP9AddLanguage @ModuleID, 'HF0397.IsWorkDateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard leave days';
EXEC ERP9AddLanguage @ModuleID, 'HF0397.VacationDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Backlog leave time is valid at the end of month';
EXEC ERP9AddLanguage @ModuleID, 'HF0397.ToMonthPlus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Transfer backlog leave into next year';
EXEC ERP9AddLanguage @ModuleID, 'HF0397.IsPrevVacationDayName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0397.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HF0397.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HF0397.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HF0397.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HF0397.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Seniority name';
EXEC ERP9AddLanguage @ModuleID, 'HF0397.SeniorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Annual leave calculation infor';
EXEC ERP9AddLanguage @ModuleID, 'HF0397.SubTitle1' , @FormID, @LanguageValue, @Language;
