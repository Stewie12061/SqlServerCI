-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HF0401- HRM
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
SET @FormID = 'HF0401';

SET @LanguageValue = N'Update leave record';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Team';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.TeamName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Full name';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.FullName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leave calculation method';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.MethodVacationName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Remained annual leave of the previous period';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.DaysPrevMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Annual leave';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.DaysInYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Seniority leave';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.VacSeniorDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Increased leave during period';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.AddDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leave to the month {0}/{1}';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.DaysSpentToMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leave during the month {0}/{1}';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.DaysSpent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Backlog vacation total at the end of period';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.DaysRemained', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.EmployeeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Full name';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.FullName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.DepartmentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.DepartmentName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Team';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.TeamID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Team';
EXEC ERP9AddLanguage @ModuleID, 'HF0401.TeamName.CB' , @FormID, @LanguageValue, @Language;