DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POR3002'
---------------------------------------------------------------

SET @LanguageValue  = N'Báo cáo chi tiết đơn hàng mua'
EXEC ERP9AddLanguage @ModuleID, 'POR3002.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'POR3002.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền tệ'
EXEC ERP9AddLanguage @ModuleID, 'POR3002.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm phân tích'
EXEC ERP9AddLanguage @ModuleID, 'POR3002.GroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'POR3002.FromObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'POR3002.ToObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'POR3002.OrderStatus',  @FormID, @LanguageValue, @Language;