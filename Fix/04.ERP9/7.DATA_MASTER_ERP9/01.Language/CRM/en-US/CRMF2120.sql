-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2120- CRM
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
SET @FormID = 'CRMF2120';

SET @LanguageValue = N'List of license request';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.RequestLicenseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.RequestLicenseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name Of Legal Representative';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.NameofLegalRepresentative', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.Position', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract No';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number Of Users';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.NumberOfUsers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number Of Units/Branches Used';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.NumberOfUnitsBranchesUsed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Electronic invoice';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.ElectronicBill', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.Website', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Requesting person';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deadline';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.DeadlineTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'With deadline';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.IsDeadlineTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'No Deadline';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.NoDeadline', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified User';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified Date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract selection';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.ChooseContract', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Japanese language';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.Jananese', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chinese language';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.Chinese', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report View Only';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.ReportViewOnly', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SME 2022';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.SME', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cloud Server';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.CloudServer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Version';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.InformationVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Server';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.Server', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.InformationUser', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Port';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.Port', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Password';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.Password', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Computer Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.ComputerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Version';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.InformationVersionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.FieldAPKCRMT2130', @FormID, @LanguageValue, @Language;

