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
SET @Language = 'en-U' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2210';

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Clue code';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.SourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of the clue';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.SourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Telephone';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Company name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Data sources';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.TypeOfSource', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'content';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.ProductInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.IsComfirmOpportunity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DeleteFlg';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'position';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.JobTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Data sources';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.TypeOfSourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.ProductInfoName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.DomainERR9', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Password';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.Password', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.IsComfirmCustomers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Clue code';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.DisplayID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recording time';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.WriteTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.CampaignMedium', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Clue';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.LeadName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.FieldAPKCRMT20301', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.IsComfirmLead', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2210.Link', @FormID, @LanguageValue, @Language;

