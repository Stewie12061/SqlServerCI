-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2032- HRM
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
SET @FormID = 'OOF2032';

SET @LanguageValue = N'Overtime application view';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Application ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 1';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ApprovePerson01Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 1';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ApprovePerson01Note' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Approve person 2';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ApprovePerson02Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 2';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ApprovePerson02Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 3';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ApprovePerson03Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 3';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ApprovePerson03Note' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Approve person 4';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ApprovePerson04Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 4';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ApprovePerson04Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 5';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ApprovePerson05Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 5';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ApprovePerson05Note' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Approve person 6';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ApprovePerson06Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 6';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ApprovePerson06Note' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Approve person 7';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ApprovePerson07Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 7';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ApprovePerson07Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 8';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ApprovePerson08Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 8';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ApprovePerson08Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 9';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ApprovePerson09Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 9';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ApprovePerson09Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 10';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ApprovePerson10Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work type';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2032.WorkTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ShiftID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'OverTime application information';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2032.SubTitle1' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Overtime (hours/month)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.OvertTime' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time exceeds OT state (hours/month)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.OvertTimeNN' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time exceeds OT company  (hours/month)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.OvertTimeCompany' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.Reason' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift OT';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ShiftName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.WorkFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.WorkToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.WorkDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date OT';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.DateOT' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift now';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ShiftNow' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total OT';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.TotalOT' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.FullName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.FromWorkingDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.ToWorkingDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2032.Department',  @FormID, @LanguageValue, @Language;