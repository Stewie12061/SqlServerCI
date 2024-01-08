-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2011- HRM
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
SET @FormID = 'OOF2011';

SET @LanguageValue = N'Update leave application';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Application ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.EmployeeName_Master' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.Reason' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Absent type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.AbsentTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Absent type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.AbsentTypeID_Master' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.LeaveFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.LeaveToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.LeaveFromDate_Master' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.LeaveToDate_Master ' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.TotalTime' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time allowance (Hours)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.TimeAllowance' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Offset time (Hours) ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.OffsetTime' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.SectionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.SectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.SubsectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.ProcessID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.SectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.SubsectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.ProcessName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Absent type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.AbsentTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Absent name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.Description.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Old shift';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.OldShiftID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange shift';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.ShiftID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.ShiftID_Master' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.ShiftID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.ShiftName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.FromWorkingDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.ToWorkingDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Absent type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.AbsentTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is next day';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.IsNextDay' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is valid';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.IsValid' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is Series';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.IsSeri' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 1';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.ApprovePerson01ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 2';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.ApprovePerson02ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 3';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.ApprovePerson03ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Days leave remained (days)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.DaysRemained' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'OTDays leave remained(days)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.OTDaysRemained' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total (hours)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.TotalTime_Master' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.Reason_Master' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.Note_Master' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Days leave remained (days)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.DaysRemained_Master' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'OTDays leave remained(days)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.OTDaysRemained_Master' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.Department' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.DepartmentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.DepartmentName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total day';
EXEC ERP9AddLanguage @ModuleID, 'OOF2011.TotalDay' , @FormID, @LanguageValue, @Language;