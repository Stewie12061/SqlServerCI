-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2211- CRM
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
SET @FormID = 'CRMF2211';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'線索代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.SourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'線索名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.SourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'公司名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'數據來源';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.TypeOfSource', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'內容';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品信息';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.ProductInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.IsComfirmOpportunity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職務';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.JobTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'數據來源';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.TypeOfSourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品信息';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.ProductInfoName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DomainERR9';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.DomainERR9', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'用戶名';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'密碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.Password', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.IsComfirmCustomers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'線索代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.DisplayID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.WriteTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'戰略';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.CampaignMedium', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.LeadName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.FieldAPKCRMT20301', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'IsComfirmLead';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.IsComfirmLead', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.Link', @FormID, @LanguageValue, @Language;

