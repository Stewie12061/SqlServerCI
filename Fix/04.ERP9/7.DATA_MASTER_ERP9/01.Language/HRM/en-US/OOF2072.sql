-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2072- HRM
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
SET @FormID = 'OOF2072';

SET @LanguageValue = N'Application for shift exchange view';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift exchange application ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ShiftID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ChangeFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ChangeToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Application for shift exchange information';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.SubTitle1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.StatusID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2072.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2072.StatusName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 1';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ApprovePerson01Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 1';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ApprovePerson01Note' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Approve person 2';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ApprovePerson02Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 2';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ApprovePerson02Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 3';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ApprovePerson03Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 3';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ApprovePerson03Note' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Approve person 4';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ApprovePerson04Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 4';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ApprovePerson04Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 5';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ApprovePerson05Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 5';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ApprovePerson05Note' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Approve person 6';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ApprovePerson06Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 6';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ApprovePerson06Note' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Approve person 7';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ApprovePerson07Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 7';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ApprovePerson07Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 8';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ApprovePerson08Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 8';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ApprovePerson08Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 9';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ApprovePerson09Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 9';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ApprovePerson09Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 10';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ApprovePerson10Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 10';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2072.ApprovePerson10Note' , @FormID, @LanguageValue, @Language;
