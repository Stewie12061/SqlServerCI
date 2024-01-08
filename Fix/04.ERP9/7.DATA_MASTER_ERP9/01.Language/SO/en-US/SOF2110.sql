-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2110- SO
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
SET @ModuleID = 'SO';
SET @FormID = 'SOF2110';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.FromDateToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Form code';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Finished product code';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of finished product';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of sets';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.SetNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.ColorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Color';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.ColorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price Original';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.PriceOriginal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Profit Rate(%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.ProfitRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Profit Desired';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.ProfitDesired', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price/Set Factory';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.PriceSetFactory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price/m2 Factory';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.PriceAcreageFactory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price/Set Install';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.PriceSetInstall', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price/m2 Install';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.PriceAcreageInstall', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price Rival';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.PriceRival', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.IsInheritBOM', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Browsing status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.StatusSS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.APK_InheritBOM', @FormID, @LanguageValue, @Language;

