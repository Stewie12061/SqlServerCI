------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2110 - CRM 
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000)
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thuc thi truy van
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @Language = 'en-US';
SET @ModuleID = 'SO';
SET @FormID = 'SOF2110';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory Name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price Original';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.PriceOriginal' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Profit Rate(%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.ProfitRate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Profit Desired';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.ProfitDesired' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price/Set Factory';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.PriceSetFactory' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price/m2 Factory';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.PriceAcreageFactory' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price/Set Install';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.PriceSetInstall' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price/m2 Install';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.PriceAcreageInstall' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price Rival';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.PriceRival' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create Date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.CreateDate' , @FormID, @LanguageValue, @Language;

     SET @LanguageValue = N'Voucher No';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2110.VoucherNo' , @FormID, @LanguageValue, @Language;

      SET @LanguageValue = N'Status';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2110.StatusSS' , @FormID, @LanguageValue, @Language;