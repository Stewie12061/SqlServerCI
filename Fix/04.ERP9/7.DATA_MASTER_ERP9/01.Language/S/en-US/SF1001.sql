------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF1001 - S
--Người tạo: Hồ Hoàng Tú-13/10/2014
-----------------------------------------------------------------------------------------------------
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
 - Tieng Viet: en-US 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'en-US' 
SET @ModuleID = 'S';
SET @FormID = 'SF1001';
------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'User update';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.Title' , @FormID, @LanguageValue, @Language;
------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.DivisionID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.DepartmentID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.DepartmentName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Temp';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.TempID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Team';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.TeamID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.EmployeeID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Full name';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.FullName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.Address' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.Tel' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.Email' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.Fax' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.Disabled' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Password';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.PassWord' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Confirm password';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.RePassWord' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'User group';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.GroupID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Birthday';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.Birthday' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.HireDate' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.EndDate' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Nationality';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.Nationality' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Identifycation NO';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.IndentificationNo' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Image';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.Image01ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Duty';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.DutyID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Passport NO';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.PassportNo' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Bank account number';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.BankAccountNumber' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Gender';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.Gender' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Marital status';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.MarriedStatus' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Signature';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.Signature' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Genaral information';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.Common' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Order information';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.Order' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Token';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.UserToken', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Time Expired';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.TimeExpiredToken', @FormID, @LanguageValue, @Language;

-- [Đình Hòa] [26/02/2021] - Bổ sung ngôn ngữ
SET @LanguageValue = N'SETTING MAIL RECEIVE BY USER';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.SETTINGMAILRECEIVEBYUSER', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Team';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.LanguageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Page Size';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.PageSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Signature Send Mail';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.SignatureSendMail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Signature Feedback Mail';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.SignatureFeedbackMail', @FormID, @LanguageValue, @Language;

-- 07/10/2021 - [Hoài Bảo] - Bổ sung ngôn ngữ cho cập nhật người dùng SF1001 - thông tin chung
SET @LanguageValue = N'Sip Address';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.SipID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sip Password';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.SipPassword', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'EContract account';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.EContractAccount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'EContract password';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.EContractPassword', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'E-Signature';
EXEC ERP9AddLanguage @ModuleID, 'SF1001.ImageIDEsign', @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;