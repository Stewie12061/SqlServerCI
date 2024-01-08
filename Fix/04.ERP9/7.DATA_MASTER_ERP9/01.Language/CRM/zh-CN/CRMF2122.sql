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
SET @Language = 'zh-CN' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2122';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'提案代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.RequestLicenseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'提案表格名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.RequestLicenseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稅號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'法人代表';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.NameofLegalRepresentative', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職務';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Position', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合同編號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合同名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'用戶數';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.NumberOfUsers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'使用的單位/分支機構數量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.NumberOfUnitsBranchesUsed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子賬單';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.ElectronicBill', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'傳真';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'網站';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Website', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'要求者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'過期時間';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.DeadlineTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'有最後期限';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.IsDeadlineTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'沒有最後期限';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.NoDeadline', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'修理人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更正日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.ChooseContract', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Jananese', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Chinese', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.ReportViewOnly', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.SME', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.CloudServer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.InformationVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Server', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.InformationUser', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Port', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Password', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.ComputerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'版本';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.InformationVersionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.FieldAPKCRMT2130', @FormID, @LanguageValue, @Language;

