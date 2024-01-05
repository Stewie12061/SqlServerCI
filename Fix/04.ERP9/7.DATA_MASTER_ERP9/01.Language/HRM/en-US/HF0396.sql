-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HF0396- HRM
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
SET @FormID = 'HF0396';

SET @LanguageValue = N'List of annual leave calculation';
EXEC ERP9AddLanguage @ModuleID, 'HF0396.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0396.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Method ID';
EXEC ERP9AddLanguage @ModuleID, 'HF0396.MethodVacationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Method name';
EXEC ERP9AddLanguage @ModuleID, 'HF0396.MethodVacationName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Seniority ID';
EXEC ERP9AddLanguage @ModuleID, 'HF0396.SeniorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Manage leave';
EXEC ERP9AddLanguage @ModuleID, 'HF0396.IsManagaVacationName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Increase leave days';
EXEC ERP9AddLanguage @ModuleID, 'HF0396.IsWorkDateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard leave days';
EXEC ERP9AddLanguage @ModuleID, 'HF0396.VacationDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0396.ToMonthPlus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0396.IsPrevVacationDayName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'HF0396.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0396.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0396.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0396.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0396.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Seniority name';
EXEC ERP9AddLanguage @ModuleID, 'HF0396.SeniorityName', @FormID, @LanguageValue, @Language;

