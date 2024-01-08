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
SET @Language = 'en-U' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2211';

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Clue code';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.SourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of the clue';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.SourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Telephone';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Company name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Data sources';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.TypeOfSource', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'content';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.ProductInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.IsComfirmOpportunity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DeleteFlg';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue =N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'position';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.JobTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Data sources';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.TypeOfSourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.ProductInfoName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DomainERR9';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.DomainERR9', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'UserName';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Password';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.Password', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.IsComfirmCustomers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Clue code';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.DisplayID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.WriteTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.CampaignMedium', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.LeadName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.FieldAPKCRMT20301', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.IsComfirmLead', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.Link', @FormID, @LanguageValue, @Language;

