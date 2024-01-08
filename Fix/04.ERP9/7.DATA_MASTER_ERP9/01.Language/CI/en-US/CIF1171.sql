-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1171- CI
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
SET @FormID = 'CIF1171';

SET @LanguageValue  = N'Update inventory'
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification ID 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification ID 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Revenue account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.SalesAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account of returned sale';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.ReSalesAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Capital cost account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.PrimeCostAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase Account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.PurchaseAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tax group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.VATGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% VAT group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.VATPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Import tax group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.VATImGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% import tax group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.VATImPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification of production';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.ProductTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Import price';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.RecievedPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery price';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.DeliveryPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.PurchasePrice01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price 02';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.PurchasePrice02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price 03';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.PurchasePrice03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price 04';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.PurchasePrice04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price 05';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.PurchasePrice05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.SalePrice01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price 02';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.SalePrice02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price 03';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.SalePrice03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price 04';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.SalePrice04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price 05';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.SalePrice05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price calculation method';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.MethodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'By warehouses';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsSource', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expiration date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsLimitDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsDiscount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stock management';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsStocked', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.I01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.I02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.I03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.I04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.I05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.I06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.I07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.I08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.I09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis ID 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.I10ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameters 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Varchar01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other units';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Varchar02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameters 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Varchar03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameters 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Varchar04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameters 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Varchar05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Technical features';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Specification', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Notes01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Notes02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Notes03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reference ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.RefInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Barcode';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Barcode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of inventory subject to environmental protection tax ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.ETaxID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion rate to environmental protection tax calculation unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.ETaxConvertedUnit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Natural resource consumption tax material';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.NRTClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of goods and services subject to excise tax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.SETID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stock level definition';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsNorm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.NormMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Avatar';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Image01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S11', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S12', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S13', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S14', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S15', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S16', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S17', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S18', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S19', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S20', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Safety stock';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsMinQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory price type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsExpense', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gift Voucher';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsGiftVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stock level definition';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsDefineStockNorm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'All warehouses';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsWareHouse', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Norm ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.NormID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Min quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.MinQuantity10805', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Max quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.MaxQuantity10805', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reorder quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.ReOrderQuantity10805', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Every warehouse';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsEveryWarehouse', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.APK_DefineStockNorm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.VATGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'First in first out (FIFO)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.MethodID1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Equality in family';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.MethodID2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Named reality';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.MethodID3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Weighted average income';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.MethodID4',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'General information';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.ThongTinChung',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Other information';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.ThongTinKhac',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'SET codes';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.SETID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'SET name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.SETName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Resource code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.NRTClassifyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Resource name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.NRTClassifyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ETax code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.ETaxID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ETax name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.ETaxName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ana code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.AnaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ana name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.AnaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Stock account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.TaiKhoanTonKho',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sales account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.TaiKhoanDoanhThu',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Stock norm';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.DinhMucTonKho',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Specification of goods';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.QuyCachHang',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Serial number management';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.QuanLiSoSeri',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.AccountName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Auto Serial';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.AutoSerial',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classify 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Enabled1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classify 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Enabled2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classify 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Enabled3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classify Name 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S1Type',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classify Name 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S2Type',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classify Name 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S3Type',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Example';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Example',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Output Order';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.OutputOrder',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Separator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Separator',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Length';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.OutputLength',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Is Last Key';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsLastKey',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last Key';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.LastKey',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classify Code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.ClassifyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classify Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.ClassifyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classify Code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classify Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.SName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Warehouse';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.WareHouseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Norm ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.NormID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Min quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.MinQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Max quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.MaxQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Reorder quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.ReOrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.AccountIDDT',  @FormID, @LanguageValue, @Language;

