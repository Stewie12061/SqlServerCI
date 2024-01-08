-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HF0400- HRM
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
SET @FormID = 'HF0400';

SET @LanguageValue = N'Leave record view';
EXEC ERP9AddLanguage @ModuleID, 'HF0400.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0400.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0400.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0400.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HF0400.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Team';
EXEC ERP9AddLanguage @ModuleID, 'HF0400.TeamName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'HF0400.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Full name';
EXEC ERP9AddLanguage @ModuleID, 'HF0400.FullName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leave calculation method';
EXEC ERP9AddLanguage @ModuleID, 'HF0400.MethodVacationName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Remained annual leave of the previous period';
EXEC ERP9AddLanguage @ModuleID, 'HF0400.DaysPrevMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Annual leave';
EXEC ERP9AddLanguage @ModuleID, 'HF0400.DaysInYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Seniority leave';
EXEC ERP9AddLanguage @ModuleID, 'HF0400.VacSeniorDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Increased leave during period';
EXEC ERP9AddLanguage @ModuleID, 'HF0400.AddDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leave to the month {0}/{1}';
EXEC ERP9AddLanguage @ModuleID, 'HF0400.DaysSpentToMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leave during the month {0}/{1}';
EXEC ERP9AddLanguage @ModuleID, 'HF0400.DaysSpent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total annual leave by the end of period';
EXEC ERP9AddLanguage @ModuleID, 'HF0400.DaysRemained', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HF0400.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HF0400.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HF0400.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HF0400.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leave record information';
EXEC ERP9AddLanguage @ModuleID, 'HF0400.SubTitle1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HF0400.StatusID', @FormID, @LanguageValue, @Language;
