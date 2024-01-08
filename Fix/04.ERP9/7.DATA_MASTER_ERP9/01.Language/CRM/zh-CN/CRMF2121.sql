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
SET @Language = 'zh-CN' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2121';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分配';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'提案代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.RequestLicenseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'提案表格名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.RequestLicenseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稅號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'法人代表';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.NameofLegalRepresentative', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職務';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Position', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合同編號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合同名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'用戶數';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.NumberOfUsers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'使用的單位/分支機構數量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.NumberOfUnitsBranchesUsed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子賬單';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.ElectronicBill', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'傳真';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'網站';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Website', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'要求者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'過期時間';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.DeadlineTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'過期時間';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.IsDeadlineTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'沒有最後期限';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.NoDeadline', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創立日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最後修改用戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最後修改日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'選擇合同';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.ChooseContract', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日本人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Jananese', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'中文';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Chinese', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'僅查看報告';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.ReportViewOnly', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SME 2022';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.SME', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'雲服務器';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.CloudServer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'版本';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.InformationVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'服務器';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Server', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'用戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.InformationUser', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Port';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Port', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'密碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Password', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.ComputerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.InformationVersionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.FieldAPKCRMT2130', @FormID, @LanguageValue, @Language;

