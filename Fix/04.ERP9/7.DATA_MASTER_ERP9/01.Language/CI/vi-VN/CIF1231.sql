-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1231- CI
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
SET @Language = 'vi-VN' 
SET @ModuleID = 'CI';
SET @FormID = 'CIF1231';

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.FromInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.ToInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kho ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.NormID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mức tối thiểu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.MinQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mức tối đa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.MaxQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mức đặt lại hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.ReOrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.WareHouseID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.WareHouseName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.NormID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.Description.CB', @FormID, @LanguageValue, @Language;