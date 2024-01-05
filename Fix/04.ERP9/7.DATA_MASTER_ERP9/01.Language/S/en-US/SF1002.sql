------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF1002 - S
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
SET @FormID = 'SF1002';
------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'User details';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.Title' , @FormID, @LanguageValue, @Language;
------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.DivisionID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Division name';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.DivisionName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.DepartmentID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.DepartmentName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'User ID';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.EmployeeID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'User name';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.FullName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.Address' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Phone';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.Tel' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.Email' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.Fax' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.Disabled' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.IsCommon' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'User information';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.SF1002Group01Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'System information';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.SF1002Group02Title' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Other information';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.SF1002Group03Title' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Lock';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.IsLock' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Birthday';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.Birthday' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.HireDate' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.EndDate' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Nationality';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.Nationality' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Indentification';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.IndentificationNo' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Image';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.Image01ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Duty';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.DutyID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Passport NO';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.PassportNo' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Bank account number';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.BankAccountNumber' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Gender';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.Gender' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Marital status';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.MarriedStatus' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Signature';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.Signature' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Genarel information';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.Common' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Other information';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.Order' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Token';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.UserToken', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Time Expired';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.TimeExpiredToken', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Team';
EXEC ERP9AddLanguage @ModuleID, 'SF1002.TeamID' , @FormID, @LanguageValue, @Language;
------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;