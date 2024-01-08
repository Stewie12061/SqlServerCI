-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2042- CRM
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
SET @FormID = 'CRMF2042';

SET @LanguageValue = N'Campaign view';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign classification';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.CampaignType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ExpectOpenDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ExpectCloseDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.CampaignStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Donors';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.Sponsor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign budget';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.BudgetCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected Revenue';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ExpectedRevenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected sales quantity';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ExpectedSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected ROI';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ExpectedROI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign cost';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ActualCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual revenue';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ActualRevenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected response';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ExpectedResponse', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual sale quantity';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ActualSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual ROI';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ActualROI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Event date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.PlaceDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Age';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.Age', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Geographic location';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.Position', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business Lines';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.BusinessLinesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Behavior';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.Behavior', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.LeadsTarget', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost/Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ChangeCostTarget', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attending leader';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.AttendLeaderTarget', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attending rate (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.AttendRateTarget', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.LeadsActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost/Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ChangeCostActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attending leader';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.AttendLeaderActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual attending rate (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.AttendRateActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Donors';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.SponsorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.CampaignStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attending leads from previous campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.LeadsPreviousActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign classification';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.CampaignTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion Actual Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ConversionActualName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion Rate Actual';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ConversionRateActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attend Actual';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.AttendActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead Portrait';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.LeadPortrait', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead Portrait Rate';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.LeadPortraitRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Campaign Information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ThongTinChiTietChienDich',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Plan/Target';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.KyVongThucTe',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.TabCMNT90051',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hitsory';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lead';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.TabCRMT20301',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Opportunity';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.TabCRMT20501',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tasks';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.TabCRMT90041',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Event';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.TabCRMT90051',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Conversion Plan/Target details';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.TabCRMT20402',  @FormID, @LanguageValue, @Language;	

SET @LanguageValue  = N'Actual conversion details';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.TabCRMT20403',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.TabCRMT2140',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.StatusID',  @FormID, @LanguageValue, @Language;