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
SET @Language = 'zh-CN' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2042';

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'戰略代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'活動名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'活動分類';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.CampaignType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'興趣';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開始日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ExpectOpenDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結束日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ExpectCloseDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.CampaignStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'捐助者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.Sponsor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'活動預算';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.BudgetCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶收入';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ExpectedRevenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'計劃銷售數量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ExpectedSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'計劃回報';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ExpectedROI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'活動費用';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ActualCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'實際收入';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ActualRevenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'達到期待的';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ExpectedResponse', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'實際銷售數量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ActualSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'實際回報';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ActualROI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'進行日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.PlaceDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'年齡';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.Age', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地理位置';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職務';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.Position', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分支';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.BusinessLinesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'行為';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.Behavior', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'計劃Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.LeadsTarget', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'成本/客戶Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ChangeCostTarget', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'計劃參加Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.AttendLeaderTarget', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'參加率 (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.AttendRateTarget', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'實際Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.LeadsActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'成本/Leads TT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.ChangeCostActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'實際出席Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.AttendLeaderActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'參加率TT(%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.AttendRateActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.SponsorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.CampaignStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'先前活動參加的Leads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.LeadsPreviousActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.CampaignTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2042.FromToDate', @FormID, @LanguageValue, @Language;

