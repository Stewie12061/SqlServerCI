-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2060- HRM
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
SET @FormID = 'OOF2060';


SET @LanguageValue = N'Abnormality response';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'In/Out';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.IOName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'OT application has been created';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.IsApproved', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Beginning time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.BeginTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End Time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.EndTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work Shift';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Abnormality type judgment';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.JugdeUnusualTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Abnormality type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.UnusualTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fact';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.Fact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Abnormality response';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.Method', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Abnormality type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.HandleMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Execute';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.Execute', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.Status' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.DepartmentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.SectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.SubsectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.ProcessID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.DepartmentName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.SectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.SubsectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.ProcessName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Abnormality type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.UnusualTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.Description.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.EmployeeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.FullName.CB' , @FormID, @LanguageValue, @Language;

