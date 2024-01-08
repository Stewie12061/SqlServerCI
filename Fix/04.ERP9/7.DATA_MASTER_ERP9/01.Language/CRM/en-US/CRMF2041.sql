-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2041- CRM
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
SET @FormID = 'CRMF2041';

SET @LanguageValue = N'Update marketing campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign classification';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.CampaignType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ExpectOpenDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ExpectCloseDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.CampaignStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Donors';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Sponsor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign budget';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.BudgetCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected Revenue';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ExpectedRevenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected sales quantity';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ExpectedSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected ROI';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ExpectedROI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign cost';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ActualCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual revenue';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ActualRevenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected response';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ExpectedResponse', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual sale quantity';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ActualSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual ROI';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ActualROI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Event date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.PlaceDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Age';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Age', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Geographic location';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Position', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business Lines';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.BusinessLinesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Behavior';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Behavior', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.LeadsTarget', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost/Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ChangeCostTarget', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attending leader';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AttendLeaderTarget', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attending rate (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AttendRateTarget', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.LeadsActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost/Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ChangeCostActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attending leader';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AttendLeaderActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual attending rate (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AttendRateActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Donors';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.SponsorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.CampaignStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attending leads from previous campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.LeadsPreviousActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign classification';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.CampaignTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business Lines Code';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.BusinessLinesID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business Lines Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.BusinessLinesName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area Code';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AreaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AreaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion Target Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ConversionTargetName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion Rate';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ConversionRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attend Target';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AttendTarget', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign infomation';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Tabs-1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Plan/Target';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Tabs-2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reality';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Tabs-3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion details';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Tabs-4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion target';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Tabs-5', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion Actual Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ConversionActualName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion Rate Actual';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ConversionRateActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attend Actual';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AttendActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead Portrait';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.LeadPortrait', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead Portrait Rate';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.LeadPortraitRate', @FormID, @LanguageValue, @Language;

