-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2115- SO
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
SET @FormID = 'SOF2115';
SET @LanguageValue = N'Inherit Board Pricing';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.Title' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.FromDateToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Form code';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Finished product code';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of finished product';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of sets';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.SetNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.ColorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Color';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.ColorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price Original';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.PriceOriginal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Profit Rate(%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.ProfitRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Profit Desired';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.ProfitDesired', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price/Set Factory';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.PriceSetFactory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price/m2 Factory';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.PriceAcreageFactory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price/Set Install';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.PriceSetInstall', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price/m2 Install';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.PriceAcreageInstall', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price Rival';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.PriceRival', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.IsInheritBOM', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Browsing status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.StatusSS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.APK_InheritBOM', @FormID, @LanguageValue, @Language;

