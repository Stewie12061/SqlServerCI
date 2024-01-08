-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1170- CI
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
SET @FormID = 'CIF1170';

SET @LanguageValue  = N'Inventory list'
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification ID 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification ID 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Revenue account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.SalesAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account of returned sale';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.ReSalesAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Capital cost account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.PrimeCostAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase Account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.PurchaseAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.VATGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% VAT group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.VATPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Import tax group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.VATImGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% import tax group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.VATImPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification of production';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.ProductTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Import price';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.RecievedPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery price';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.DeliveryPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.PurchasePrice01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price 02';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.PurchasePrice02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price 03';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.PurchasePrice03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price 04';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.PurchasePrice04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price 05';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.PurchasePrice05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.SalePrice01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price 02';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.SalePrice02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price 03';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.SalePrice03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price 04';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.SalePrice04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price 05';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.SalePrice05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price calculation method';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.MethodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'By warehouses';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsSource', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expiration date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsLimitDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsDiscount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stock management';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsStocked', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.I01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.I02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.I03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.I04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.I05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.I06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.I07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.I08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.I09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.I10ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameters 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.Varchar01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other units';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.Varchar02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameters 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.Varchar03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameters 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.Varchar04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameters 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.Varchar05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Technical features';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.Specification', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.Notes01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.Notes02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.Notes03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reference ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.RefInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Barcode';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.Barcode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of inventory subject to environmental protection tax ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.ETaxID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion rate to environmental protection tax calculation unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.ETaxConvertedUnit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Natural resource consumption tax material';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.NRTClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of goods and services subject to excise tax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.SETID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stock level definition';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsNorm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.NormMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Avatar';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.Image01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S11', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S12', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S13', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S14', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S15', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S16', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S17', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S18', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S19', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S20', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Safety stock';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsMinQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory price type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsExpense', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gift Voucher';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsGiftVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stock level definition';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsDefineStockNorm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'All warehouses';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsWareHouse', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Norm ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.NormID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Min quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.MinQuantity10805', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Max quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.MaxQuantity10805', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reorder quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.ReOrderQuantity10805', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Every warehouse';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsEveryWarehouse', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.APK_DefineStockNorm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.VATGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.UnitID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.UnitName.CB' , @FormID, @LanguageValue, @Language;
