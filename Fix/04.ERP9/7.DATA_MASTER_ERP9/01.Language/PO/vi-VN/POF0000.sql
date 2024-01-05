DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF0000'
---------------------------------------------------------------

SET @LanguageValue  = N'Thiết lập hệ thống'
EXEC ERP9AddLanguage @ModuleID, 'POF0000.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF0000.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'POF0000.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại CT báo giá nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'POF0000.VoucherPriceQuote',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại CT yêu cầu mua hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF0000.VoucherRequest',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại CT Tiến độ nhận hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF0000.VoucherDeliverySchedule',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại CT Book cont đơn hàng xuất khẩu'
EXEC ERP9AddLanguage @ModuleID, 'POF0000.VoucherBookCont',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại CT đơn hàng mua'
EXEC ERP9AddLanguage @ModuleID, 'POF0000.VoucherPurchaseOrder',  @FormID, @LanguageValue, @Language;