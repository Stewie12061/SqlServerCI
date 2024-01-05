-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2080- HRM
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
SET @FormID = 'OOF2080';

SET @LanguageValue = N'List of applications';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Application ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'EmployeeID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.Date' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.Status' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.StatusName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Form code';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Form type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.Type' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Form type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.TypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.DepartmentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.SectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.SubsectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.ProcessID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.DepartmentName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.SectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.SubsectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.ProcessName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.CreateUserName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.ID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.Description.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.EmployeeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.FullName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Begin Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.BeginDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2080.EndDate' , @FormID, @LanguageValue, @Language;