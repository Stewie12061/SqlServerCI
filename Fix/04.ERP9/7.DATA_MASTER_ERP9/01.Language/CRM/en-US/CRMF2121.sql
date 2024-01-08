-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2121- CRM
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
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2121';

SET @LanguageValue = N'Update License request';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request  ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.RequestLicenseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.RequestLicenseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name Of Legal Representative';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.NameofLegalRepresentative', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Position', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract No';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number Of Users';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.NumberOfUsers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number Of Units/Branches Used';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.NumberOfUnitsBranchesUsed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Electronic invoice';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.ElectronicBill', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Website', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Requesting person';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deadline';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.DeadlineTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'With deadline';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.IsDeadlineTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'No Deadline';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.NoDeadline', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified User';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified Date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract selection';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.ChooseContract', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Japanese language';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Jananese', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chinese language';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Chinese', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report View Only';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.ReportViewOnly', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SME 2022';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.SME', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cloud Server';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.CloudServer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Version';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.InformationVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Server';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Server', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.InformationUser', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Port';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Port', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Password';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Password', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Computer Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.ComputerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Version';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.InformationVersionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.FieldAPKCRMT2130', @FormID, @LanguageValue, @Language;

