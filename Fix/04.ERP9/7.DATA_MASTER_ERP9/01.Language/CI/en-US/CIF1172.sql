-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1172- CI
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
SET @FormID = 'CIF1172';

SET @LanguageValue  = N'Inventory view'
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification ID 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification ID 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Revenue account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.SalesAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account of returned sale';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.ReSalesAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Capital cost account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.PrimeCostAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase Account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.PurchaseAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.VATGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% VAT group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.VATPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Import tax group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.VATImGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% import tax group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.VATImPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification of production';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.ProductTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Import price';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.RecievedPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery price';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.DeliveryPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.PurchasePrice01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price 02';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.PurchasePrice02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price 03';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.PurchasePrice03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price 04';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.PurchasePrice04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price 05';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.PurchasePrice05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.SalePrice01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price 02';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.SalePrice02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price 03';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.SalePrice03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price 04';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.SalePrice04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price 05';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.SalePrice05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price calculation method';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.MethodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'By warehouses';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsSource', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expiration date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsLimitDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsDiscount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stock management';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsStocked', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.I01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.I02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.I03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.I04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.I05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.I06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.I07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.I08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.I09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.I10ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameters 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Varchar01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other units';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Varchar02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameters 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Varchar03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameters 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Varchar04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameters 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Varchar05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Technical features';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Specification', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Notes01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Notes02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Notes03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reference ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.RefInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Barcode';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Barcode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of inventory subject to environmental protection tax ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.ETaxID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion rate to environmental protection tax calculation unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.ETaxConvertedUnit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Natural resource consumption tax material';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.NRTClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of goods and services subject to excise tax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.SETID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stock level definition';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsNorm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.NormMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Avatar';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Image01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S11', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S12', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S13', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S14', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S15', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S16', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S17', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S18', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S19', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S20', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Safety stock';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsMinQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory price type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsExpense', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gift Voucher';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsGiftVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stock level definition';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsDefineStockNorm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'All warehouses';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsWareHouse', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Norm ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.NormID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Min quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.MinQuantity10805', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Max quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.MaxQuantity10805', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reorder quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.ReOrderQuantity10805', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Every warehouse';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsEveryWarehouse', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.APK_DefineStockNorm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.VATGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.AccountName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Avatar';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172ImageID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Select warehouse';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsWareHouseName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ware house code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.WareHouseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Minimum level';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.MinQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Maximum level';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.MaxQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Order level';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.ReOrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory information';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.ThongTinMatHang',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Other Information';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.ThongTinKhac',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory and revenue accounts information';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.ThongTinTaiKhoanTonKhoDoanhThu',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Stock level information';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.ThongTinDinhMucTonKho',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Description',  @FormID, @LanguageValue, @Language;

