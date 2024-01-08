DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1175'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật mặt hàng - Định mức tồn kho'
EXEC ERP9AddLanguage @ModuleID, 'CIF1175.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1175.WareHouseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1175.NormID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức tối thiểu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1175.MinQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức tối đa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1175.MaxQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức đặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1175.ReOrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tất cả các kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.SelectALLMethod',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từng kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.NormMethod',  @FormID, @LanguageValue, @Language;
