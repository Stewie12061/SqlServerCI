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
SET @Language = 'vi-VN' 
SET @ModuleID = 'CI';
SET @FormID = 'CIF1232';

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kho ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.NormID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mức tối thiểu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.MinQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mức tối đa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.MaxQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mức đặt lại hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.ReOrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin định mức tồn kho hàng hóa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.ThongTinDinhMucTonKhoHangHoa', @FormID, @LanguageValue, @Language;