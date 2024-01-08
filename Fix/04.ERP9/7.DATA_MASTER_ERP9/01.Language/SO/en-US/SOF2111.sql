-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2111- SO
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
SET @Language = 'en-US ' 
SET @ModuleID = 'SO';
SET @FormID = 'SOF2111';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.FromDateToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Form code';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory Name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of sets';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.SetNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Color';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.ColorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.ColorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price Original';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.PriceOriginal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Profit Rate(%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.ProfitRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Profit Desired';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.ProfitDesired', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price/Set Factory';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.PriceSetFactory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price/m2 Factory';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.PriceAcreageFactory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price/Set Install';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.PriceSetInstall', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price/m2 Install';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.PriceAcreageInstall', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price Rival';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.PriceRival', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit BOM';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.IsInheritBOM', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Browsing status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.StatusSS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.APK_InheritBOM', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Specifications';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.TabSOT2111' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Consumable Supplies';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.TabSOT2112' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.TabSOT2114' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.StandardID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard Name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.StandardName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard Value';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.StandardValue' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Node ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.NodeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Node Name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.NodeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.UnitName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.Price' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.Amount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type Of Cost';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.TypeOfCost' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type Of Cost Name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.TypeOfCostName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.CostID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost Name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.CostName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percentage(%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.Percentage' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.PriceCost' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.AmountCost' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.TypeOfCost.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.TypeOfCostName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.CostID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.CostName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.StatusSS' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.AccountID' , @FormID, @LanguageValue, @Language;