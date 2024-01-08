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
SET @Language = 'zh-CN' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2041';

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'戰略代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'活動名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'活動分類';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.CampaignType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'興趣';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開始日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ExpectOpenDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結束日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ExpectCloseDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.CampaignStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'捐助者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Sponsor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'活動預算';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.BudgetCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'期待的收入';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ExpectedRevenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預計銷量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ExpectedSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'期待的回報';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ExpectedROI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'活動費用';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ActualCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'實際收入';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ActualRevenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'達到期待的';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ExpectedResponse', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'實際銷售數量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ActualSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'實際回報';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ActualROI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'進行日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.PlaceDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'年齡';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Age', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地理位置';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職務';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Position', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分支';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.BusinessLinesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'行為';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.Behavior', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.LeadsTarget', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'成本/Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ChangeCostTarget', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'參加Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AttendLeaderTarget', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'參加率(%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AttendRateTarget', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.LeadsActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'成本/Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.ChangeCostActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'參加Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AttendLeaderActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'參加率(%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.AttendRateActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'捐助者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.SponsorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.CampaignStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'先前活動參加的Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.LeadsPreviousActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'活動分類';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.CampaignTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2041.FromToDate', @FormID, @LanguageValue, @Language;

