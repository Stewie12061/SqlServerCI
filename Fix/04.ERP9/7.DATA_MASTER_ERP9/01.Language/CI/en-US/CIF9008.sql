-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF9008- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF9008';

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item code';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name items';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification code 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification code 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification code 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MH type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account code';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Revenue account';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.SalesAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account for returned goods';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.ReSalesAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost account';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.PrimeCostAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase account';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.PurchaseAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax group';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.VATGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% VAT';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.VATPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Import tax group';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.VATImGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% Import tax group';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.VATImPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production classificatio';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.ProductTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery price';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.RecievedPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery price';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.DeliveryPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.PurchasePrice01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price 02';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.PurchasePrice02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price 03';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.PurchasePrice03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price 04';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.PurchasePrice04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price 05';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.PurchasePrice05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.SalePrice01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price 02';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.SalePrice02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price 03';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.SalePrice03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price 04';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.SalePrice04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price 05';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.SalePrice05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Method code';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.MethodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'IsSource';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.IsSource', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'IsLimitDate';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.IsLimitDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.IsDiscount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stocked';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.IsStocked', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.I01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 02';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.I02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 03';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.I03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 04';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.I04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 05';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.I05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 06';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.I06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 07';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.I07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 08';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.I08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 09';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.I09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.I10ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameter 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.Varchar01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameter 02';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.Varchar02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameter 03';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.Varchar03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameter 04';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.Varchar04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameter 05';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.Varchar05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Specifications';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.Specification', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.Notes01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 02';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.Notes02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 03';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.Notes03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reference code';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.RefInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Barcode';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.Barcode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of goods subject to environmental protection tax';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.ETaxID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion rate to environmental protection tax calculation unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.ETaxConvertedUnit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of resource subject to resource tax';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.NRTClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of goods and services subject to VAT';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.SETID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Determine inventory levels';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.IsNorm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Norm method';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.NormMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Image';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.Image01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.S01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.S02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.S03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.S04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.S05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.S06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.S07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.S08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.S09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.S10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.S11', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.S12', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.S13', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.S14', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.S15', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.S16', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.S17', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.S18', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.S19', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.S20', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Safe inventory';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.IsMinQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost item type';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.IsExpense', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gift Certificate';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.IsGiftVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Determine inventory levels';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.IsDefineStockNorm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'All warehouses';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.IsWareHouse', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Norm code';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.NormID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Minimum';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.MinQuantity10805', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Max quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.MaxQuantity10805', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reorder quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.ReOrderQuantity10805', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Every warehouse';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax group';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.APK_DefineStockNorm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax group';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.VATGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit price';
EXEC ERP9AddLanguage @ModuleID, 'CIF9008.SalePrice', @FormID, @LanguageValue, @Language;

