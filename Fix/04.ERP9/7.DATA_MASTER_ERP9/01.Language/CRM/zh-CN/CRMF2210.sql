-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2210- CRM
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
SET @FormID = 'CRMF2210';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'線索代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.SourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'線索名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.SourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'公司名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'數據來源';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.TypeOfSource', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'內容';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品信息';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.ProductInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.IsComfirmOpportunity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職務';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.JobTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'數據來源';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.TypeOfSourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品信息';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.ProductInfoName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.DomainERR9', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.Password', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.IsComfirmCustomers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'線索代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.DisplayID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'確認時間';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.WriteTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'戰略';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'戰略';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.CampaignMedium', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'線索';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.LeadName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.FieldAPKCRMT20301', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'變成了商業聯絡點';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.IsComfirmLead', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.Link', @FormID, @LanguageValue, @Language;

