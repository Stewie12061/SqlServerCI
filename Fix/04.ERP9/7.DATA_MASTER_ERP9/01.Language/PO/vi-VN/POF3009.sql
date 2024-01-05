DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF3009'
---------------------------------------------------------------

SET @LanguageValue  = N'Báo cáo chi tiết đơn hàng mua'
EXEC ERP9AddLanguage @ModuleID, 'POF3009.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'POF3009.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'POF3009.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm'
EXEC ERP9AddLanguage @ModuleID, 'POF3009.IsFilter2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'POF3009.DivisionID',  @FormID, @LanguageValue, @Language;
