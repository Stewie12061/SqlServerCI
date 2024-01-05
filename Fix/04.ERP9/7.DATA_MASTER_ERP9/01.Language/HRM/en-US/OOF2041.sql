-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2041- HRM
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
SET @FormID = 'OOF2041';

SET @LanguageValue = N'Update application for card scanning addition/cancellation';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Application ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.Reason' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.Date' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'In/out ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.InOutID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'In/out';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.InOutName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.DepartmentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section  ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.SectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.SubsectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.ProcessID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.DepartmentName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.SectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.SubsectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.ProcessName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2041.Department',  @FormID, @LanguageValue, @Language;

