-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2022- HRM
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
SET @FormID = 'OOF2022';

SET @LanguageValue = N'Exit application view';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exit application ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 1';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2022.ApprovePerson01Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 1';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2022.ApprovePerson01Note' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Approve person 2';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2022.ApprovePerson02Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 2';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2022.ApprovePerson02Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 3';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2022.ApprovePerson03Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 3';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2022.ApprovePerson03Note' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Approve person 4';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2022.ApprovePerson04Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 4';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2022.ApprovePerson04Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 5';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2022.ApprovePerson05Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 5';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2022.ApprovePerson05Note' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Approve person 6';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2022.ApprovePerson06Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 6';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2022.ApprovePerson06Note' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Approve person 7';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2022.ApprovePerson07Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 7';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2022.ApprovePerson07Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 8';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2022.ApprovePerson08Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 8';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2022.ApprovePerson08Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 9';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2022.ApprovePerson09Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Noted by approve person 9';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2022.ApprovePerson09Note' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Approve person 10';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2022.ApprovePerson10Name' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Ask for vehicle';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2022.AskForVehicle' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Have lunch';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2022.HaveLunch' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Use vehicle';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2022.UseVehicleName' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Exit application information';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2022.SubTitle1' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.Reason' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Place';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.Place' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Estimated go time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.GoFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Go straight';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.GoStraight' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Estimated return time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.GoToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Come straight';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.ComeStraight' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.FullName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.FromWorkingDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.ToWorkingDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2022.StatusName' , @FormID, @LanguageValue, @Language;