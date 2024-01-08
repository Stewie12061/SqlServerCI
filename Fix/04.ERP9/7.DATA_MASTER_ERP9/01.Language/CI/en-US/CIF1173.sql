-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1173- CI
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
SET @FormID = 'CIF1173';

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item code';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit code';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of the unit of measure';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name items';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory type';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account code';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Revenue account';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.SalesAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account for returned goods';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.ReSalesAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost account';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.PrimeCostAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase account';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.PurchaseAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax group';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.VATGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% tax';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.VATPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Import tax group';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.VATImGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% Import tax group';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.VATImPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production classification';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.ProductTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recieved price';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.RecievedPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery price';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.DeliveryPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price 01';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.PurchasePrice01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price 02';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.PurchasePrice02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price 03';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.PurchasePrice03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price 04';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.PurchasePrice04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price 05';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.PurchasePrice05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sale price';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.SalePrice01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Selling price 02';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.SalePrice02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Selling price 03';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.SalePrice03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Selling price 04';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.SalePrice04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Selling price 05';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.SalePrice05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Method I';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.MethodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'According to warehouse';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.IsSource', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expiration date';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.IsLimitDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.IsDiscount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is stocked';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.IsStocked', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = 'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 1';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.I01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 2';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.I02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 3';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.I03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 4';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.I04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 5';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.I05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 6';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.I06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 7';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.I07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 8';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.I08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 9';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.I09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 10';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.I10ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameter 1';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.Varchar01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameter 2';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.Varchar02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameter 3';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.Varchar03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameter 4';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.Varchar04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameter 5';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.Varchar05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Specification';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.Specification', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 1';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.Notes01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 2';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.Notes02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 3';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.Notes03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reference code';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.RefInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Barcode';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.Barcode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of goods subject to environmental protection tax';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.ETaxID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion rate to environmental protection tax calculation unit';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.ETaxConvertedUnit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of resource subject to resource tax';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.NRTClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of goods and services subject to VAT';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.SETID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Determine inventory levels';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.IsNorm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Norm method';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.NormMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Image';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.Image01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.S01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.S02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.S03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.S04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.S05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.S06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.S07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.S08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.S09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.S10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.S11', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.S12', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.S13', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.S14', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.S15', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.S16', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.S17', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.S18', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.S19', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.S20', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Safe inventory';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.IsMinQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost item type';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.IsExpense', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gift Certificate';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.IsGiftVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stock level definition';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.IsDefineStockNorm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'All warehouses';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.IsWareHouse', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Norm code';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.NormID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Minimum';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.MinQuantity10805', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Maximum levels';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.MaxQuantity10805', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reorder quantity';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.ReOrderQuantity10805', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Every warehouse';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.IsEveryWarehouse', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.APK_DefineStockNorm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax group type name';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.VATGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Selling price list';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.SalePrice', @FormID, @LanguageValue, @Language;

