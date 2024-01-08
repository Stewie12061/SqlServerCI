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
SET @Language = 'zh-CN' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2040';

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'戰略代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'活動名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'活動分類';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.CampaignType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備註';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開始日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ExpectOpenDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結束日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ExpectCloseDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.CampaignStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'捐助者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.Sponsor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'活動預算';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.BudgetCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'期待的收入';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ExpectedRevenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預計銷量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ExpectedSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'期待的回報';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ExpectedROI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'活動費用';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ActualCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ActualRevenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'達到期待的';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ExpectedResponse', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'實際銷售數量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ActualSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'實際回報';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ActualROI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'進行日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.PlaceDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.Age', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.Position', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.BusinessLinesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.Behavior', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.LeadsTarget', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ChangeCostTarget', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.AttendLeaderTarget', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.AttendRateTarget', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.LeadsActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.ChangeCostActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.AttendLeaderActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.AttendRateActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.SponsorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.CampaignStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.LeadsPreviousActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'活動分類';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.CampaignTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2040.FromToDate', @FormID, @LanguageValue, @Language;

