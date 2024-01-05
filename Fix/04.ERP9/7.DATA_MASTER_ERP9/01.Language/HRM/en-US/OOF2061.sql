-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2061- HRM
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
SET @FormID = 'OOF2061';


SET @LanguageValue = N'Update abnormality response';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'In/Out';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.IOName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'OT application has been created';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.IsApproved', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Beginning time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.BeginTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End Time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.EndTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work Shift';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Abnormality type judgment';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.JugdeUnusualTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Abnormality type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.UnusualTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fact';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.Fact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Abnormality response';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.Method', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Abnormality type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.HandleMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Execute';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.Execute', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2061.FromDate', @FormID, @LanguageValue, @Language;

