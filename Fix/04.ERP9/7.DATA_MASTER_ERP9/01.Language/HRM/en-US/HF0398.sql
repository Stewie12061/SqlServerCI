-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HF0398- HRM
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
SET @FormID = 'HF0398';

SET @LanguageValue = N'Annual leave calculation Update';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Method ID';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.MethodVacationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Method name';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.MethodVacationName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Seniority leave type';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.SeniorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day in probation working';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.IsWorkDate1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day in official working';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.IsWorkDate2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Increasing leave days by';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.Title1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'With year';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.IsManagaVacation1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'With period';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.IsManagaVacation2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Manage leave';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.Title2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.IsManagaVacationName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.IsWorkDateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard leave days';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.VacationDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'(Month)';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.ToMonthPlus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.IsPrevVacationDayName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Seniority leave name';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.SeniorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Transfer backlog vacation into next year';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.Title3' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Maximum transfer';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.IsPrevVacationDay1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Don''t exceed backlog vacation transfered with seniority';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.IsPrevVacationDay2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Backlog vacation time is valid at the end of month';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.IsToMonthPlus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'(Days)';
EXEC ERP9AddLanguage @ModuleID, 'HF0398.MaxPrevVacationDay' , @FormID, @LanguageValue, @Language;
