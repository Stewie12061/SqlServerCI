-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2122- CRM
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
SET @FormID = 'CRMF2122';

SET @LanguageValue = N'License request view';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.RequestLicenseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.RequestLicenseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name Of Legal Representative';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.NameofLegalRepresentative', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Position', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract No';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number Of Users';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.NumberOfUsers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number Of Units/Branches Used';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.NumberOfUnitsBranchesUsed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Electronic invoice';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.ElectronicBill', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Website', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Requesting person';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deadline';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.DeadlineTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'With deadline';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.IsDeadlineTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'No Deadline';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.NoDeadline', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified User';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified Date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract selection';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.ChooseContract', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Japanese language';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Jananese', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chinese language';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Chinese', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report View Only';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.ReportViewOnly', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SME 2022';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.SME', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cloud Server';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.CloudServer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Version';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.InformationVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Server';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Server', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.InformationUser', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Port';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Port', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Password';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Password', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Computer Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.ComputerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Version';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.InformationVersionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.FieldAPKCRMT2130', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Profile';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Profile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'License request information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.ThongTinChiTietPhieuDeNghiCapLicense', @FormID, @LanguageValue, @Language;

