-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2012- HRM
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
SET @FormID = 'OOF2012';

SET @LanguageValue = N'Leave application view';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Application ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 1';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ApprovePerson01Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 1';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ApprovePerson01Notes' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Approve person 2';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ApprovePerson02Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 2';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ApprovePerson02Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 3';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ApprovePerson03Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 3';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ApprovePerson03Notes' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Approve person 4';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ApprovePerson04Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 4';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ApprovePerson04Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 5';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ApprovePerson05Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 5';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ApprovePerson05Notes' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Approve person 6';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ApprovePerson06Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 6';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ApprovePerson06Notes' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Approve person 7';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ApprovePerson07Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 7';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ApprovePerson07Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 8';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ApprovePerson08Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 8';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ApprovePerson08Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 9';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ApprovePerson09Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 9';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ApprovePerson09Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 10';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ApprovePerson10Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 10';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ApprovePerson10Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leave application details';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2012.SubTitle1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.Reason' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Absent type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.AbsentTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.LeaveFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.LeaveToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.TotalTime' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time allowance (hours)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.TimeAllowance' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Offset time (Giờ)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.OffsetTime' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Old shift';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.OldShiftID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange shift';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ShiftID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.FromWorkingDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.ToWorkingDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Absent type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.AbsentTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is next day';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.IsNextDay' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is valid';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.IsValid' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.StatusName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.StatusID' , @FormID, @LanguageValue, @Language;
 