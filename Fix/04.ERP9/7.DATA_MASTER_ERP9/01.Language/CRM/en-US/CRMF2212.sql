-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2212- CRM
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
SET @Language = 'en-U' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2212';

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Clue code';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.SourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of the clue';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.SourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Telephone';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Company name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Data sources';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.TypeOfSource', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'content';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.ProductInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.IsComfirmOpportunity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DeleteFlg';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Correction date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'position';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.JobTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Data sources';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.TypeOfSourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.ProductInfoName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.DomainERR9', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Password';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.Password', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.IsComfirmCustomers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Clue code';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.DisplayID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recording time';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.WriteTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.CampaignMedium', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Clue';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.LeadName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.FieldAPKCRMT20301', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.IsComfirmLead', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2212.Link', @FormID, @LanguageValue, @Language;

