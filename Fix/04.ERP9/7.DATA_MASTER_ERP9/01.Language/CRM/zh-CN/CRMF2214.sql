-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2214- CRM
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
SET @FormID = 'CRMF2214';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'源代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.SourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'源名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.SourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'公司名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.TypeOfSource', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.ProductInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.IsComfirmOpportunity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職務';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.JobTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'數據來源';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.TypeOfSourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品信息';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.ProductInfoName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.DomainERR9', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.Password', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.IsComfirmCustomers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.DisplayID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.WriteTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'戰略';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.CampaignMedium', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.LeadName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.FieldAPKCRMT20301', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.IsComfirmLead', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.Link', @FormID, @LanguageValue, @Language;

