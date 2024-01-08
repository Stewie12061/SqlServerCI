DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1263'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật chi tiết khuyến mãi theo hóa đơn'
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ giá trị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.FromValues',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến giá trị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.ToValues',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.DiscountPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.DiscountAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.Notes',  @FormID, @LanguageValue, @Language;


