-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2112- SO
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
SET @Language = 'en-US';
SET @ModuleID = 'SO';
SET @FormID = 'SOF2112';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.FromDateToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Form code';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Finished product code';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of finished product';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of sets';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.SetNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.ColorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Color';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.ColorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price Original';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.PriceOriginal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Profit Rate(%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.ProfitRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Profit Desired';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.ProfitDesired', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price/Set Factory';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.PriceSetFactory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price/m2 Factory';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.PriceAcreageFactory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price/Set Install';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.PriceSetInstall', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price/m2 Install';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.PriceAcreageInstall', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price Rival';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.PriceRival', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit BOM';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.IsInheritBOM', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Editor';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Browsing status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.StatusSS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.APK_InheritBOM', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Standard ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.StandardID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard Name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.StandardName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard Value';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.StandardValue' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Node ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.NodeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Node Name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.NodeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.Price' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.Amount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type Of Cost Name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.TypeOfCostName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost Name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.CostName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percentage(%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.Percentage' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.PriceCost' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.AmountCost' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Modify User';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Modify Date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create User';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create Date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.StatusID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Details of the price list';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.ThongTinBangTinhGia' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Specifications';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.TabSOT2111' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Consumable supplies';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.TabSOT2112' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost';
EXEC ERP9AddLanguage @ModuleID, 'SOF2112.TabSOT2114' , @FormID, @LanguageValue, @Language;