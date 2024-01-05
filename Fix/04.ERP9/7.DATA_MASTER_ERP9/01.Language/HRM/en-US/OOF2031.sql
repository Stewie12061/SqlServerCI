-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2031- HRM
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
SET @FormID = 'OOF2031';

SET @LanguageValue = N'Update overtime application';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Application ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.WorkType' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.ApprovePersonID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Overtime (hours/month)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.OvertTime' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time exceeds OT state (hours/month)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.OvertTimeNN' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time exceeds OT company (hours/month)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.OvertTimeCompany' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.Reason' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.ShiftName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift OT';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.ShiftID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.WorkFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.WorkDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.WorkToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date OT';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.DateOT' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift now';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.ShiftNow' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total OT';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.TotalOT' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.FullName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.DepartmentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.SectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.SubsectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.ProcessID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.DepartmentName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.SectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.SubsectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.ProcessName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.EmployeeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.ApproveID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.FullName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.ShiftID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.ShiftName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.FromWorkingDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.ToWorkingDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.Department',  @FormID, @LanguageValue, @Language;