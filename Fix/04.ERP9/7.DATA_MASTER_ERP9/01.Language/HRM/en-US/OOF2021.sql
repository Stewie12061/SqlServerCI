-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2021- HRM
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
SET @FormID = 'OOF2021';

SET @LanguageValue = N'Update exit application';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exit application ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ask for vehicle';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.AskForVehicle' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Use vehicle';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.UseVehicle' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Have lunch';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.HaveLunch' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.ApprovePersonID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.Reason' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Place';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.Place' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Estimated go time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.GoFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Go straight';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.GoStraight' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Estimated return time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.GoToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Come straight';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.ComeStraight' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.DepartmentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.SectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.SubsectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.ProcessID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.DepartmentName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.SectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.SubsectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.ProcessName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.EmployeeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.FullName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.FromWorkingDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2021.ToWorkingDate' , @FormID, @LanguageValue, @Language;