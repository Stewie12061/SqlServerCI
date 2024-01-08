-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1232- CI
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
SET @FormID = 'CIF1232';

SET @LanguageValue = N'Store code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Norm type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.NormID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Minimum';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.MinQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Maximum levels';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.MaxQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reorder level';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.ReOrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory levels of goods';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.InventoryNormID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.FromInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Go to the item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.ToInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ReOrder Quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.ReOrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Information on inventory norms';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.ThongTinDinhMucTonKhoHangHoa', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.InventoryName', @FormID, @LanguageValue, @Language;