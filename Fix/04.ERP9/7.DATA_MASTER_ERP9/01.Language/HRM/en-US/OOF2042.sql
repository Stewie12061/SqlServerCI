-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2042- HRM
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
SET @FormID = 'OOF2042';

SET @LanguageValue = N'View application for card scanning addition/cancellation';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Application ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 1';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson01Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 1';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson01Note' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Approve person 2';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson02Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 2';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson02Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 3';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson03Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 3';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson03Note' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Approve person 4';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson04Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 4';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson04Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 5';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson05Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 5';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson05Note' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Approve person 6';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson06Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 6';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson06Note' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Approve person 7';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson07Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 7';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson07Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 8';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson08Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 8';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson08Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 9';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson09Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 9';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson09Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 10';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson10Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type name';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.EditTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Application for card scanning addition/cancellation information';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.SubTitle1' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.Reason' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.TypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.Date' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'In/out ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.InOutID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'In/out';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.InOutName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.Department',  @FormID, @LanguageValue, @Language;