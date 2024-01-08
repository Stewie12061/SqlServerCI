-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1253- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1253';

SET @LanguageValue = N'Update details price list table sell';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.Title', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.InventoryID.Auto', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.InventoryName.Auto', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Price list code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recommended retail price';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.RetailPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit price';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Wholesale price';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.WholesalePrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Minimum price';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.MinPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Maximum price';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.MaxPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.DiscountPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.DiscountAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% Discount 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffPercent01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffAmount01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% Discount 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffPercent02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffAmount02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% Discount 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffPercent03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffAmount03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% Discount 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffPercent04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffAmount04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% 5% discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffPercent05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'5% discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.SaleOffAmount05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.Notes01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.Notes02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Detailed code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.DetailID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% VAT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.VATPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT tax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.VATAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total amount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.TotalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name items';
EXEC ERP9AddLanguage @ModuleID, 'CIF1253.InventoryName', @FormID, @LanguageValue, @Language;

