-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2040- CRM
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
SET @FormID = 'CRMF2040';

SET @LanguageValue = N'List of marketing campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign classification';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.CampaignType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ExpectOpenDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ExpectCloseDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.CampaignStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Donors';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.Sponsor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign budget';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.BudgetCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected Revenue';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ExpectedRevenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected sales quantity';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ExpectedSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected ROI';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ExpectedROI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign cost';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ActualCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual revenue';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ActualRevenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected response';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ExpectedResponse', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual sale quantity';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ActualSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual ROI';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ActualROI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Event date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.PlaceDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Age';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.Age', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Geographic location';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.Position', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business Lines';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.BusinessLinesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Behavior';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.Behavior', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.LeadsTarget', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost/Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ChangeCostTarget', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attending leader';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.AttendLeaderTarget', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attending rate (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.AttendRateTarget', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.LeadsActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost/Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ChangeCostActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attending leader';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.AttendLeaderActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual attending rate (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.AttendRateActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Donors';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.SponsorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.CampaignStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attending leads from previous campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.LeadsPreviousActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign classification';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.CampaignTypeName', @FormID, @LanguageValue, @Language;

