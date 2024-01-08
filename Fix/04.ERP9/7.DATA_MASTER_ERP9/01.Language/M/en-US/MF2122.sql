-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2122- M
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
SET @ModuleID = 'M';
SET @FormID = 'MF2122';

SET @LanguageValue = N'Inventory norm view';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product code';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.NodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product is name';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.NodeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.BomVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start time';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End time';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory type';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name items';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Structure type';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.NodeTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance type';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.InheritID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.CreateBOMVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.Version', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production process';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.RoutingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Version quantity';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.QuantityVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory type';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.NodeTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Display name';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.DisplayMember', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dictates name';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.DictatesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machining';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.OutsourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production order';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantitative type';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.QuantitativeTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantitative';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.QuantitativeValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loss';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.LossValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material group ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.MaterialGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material group';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.MaterialGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Alternative material';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Coefficient';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.MaterialConstant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory norm information';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.DinhMucSanPham', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory norm details';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.ChiTietDinhMucSanPham', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'List of BOM version';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.DanhSachVersionBOM', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.S01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.S02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.S03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.S04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.S05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.S06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.S07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.S08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.S09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.S10ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.S11ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.S12ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.S13ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.S14ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.S15ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.S16ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.S17ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.S18ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.S19ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.S20ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Specifications';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.Specification', @FormID, @LanguageValue, @Language;

