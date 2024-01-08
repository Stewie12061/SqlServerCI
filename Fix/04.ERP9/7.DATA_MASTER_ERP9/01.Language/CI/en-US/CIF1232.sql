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

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'WareHouse ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rated type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.NormID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MinQuantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.MinQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MaxQuantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.MaxQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ReOrder Quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.ReOrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Information on inventory norms';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.ThongTinDinhMucTonKhoHangHoa', @FormID, @LanguageValue, @Language;