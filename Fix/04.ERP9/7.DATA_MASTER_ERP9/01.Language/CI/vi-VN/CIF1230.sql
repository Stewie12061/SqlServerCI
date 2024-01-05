-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1230- CI
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
SET @FormID = 'CIF1230';

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1230.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1230.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1230.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1230.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1230.NormID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1230.NormName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1230.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mức tối thiểu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1230.MinQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mức tối đa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1230.MaxQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mức đặt lại hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1230.ReOrderQuantity', @FormID, @LanguageValue, @Language;