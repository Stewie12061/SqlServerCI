DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF0001'
---------------------------------------------------------------

SET @LanguageValue  = N'Thiết lập đơn hàng mua'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.Title',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.ClassifyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người theo dõi'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương thức thanh toán'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.PaymentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kho giữ chỗ'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.WareHouseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ nhận hàng'	
EXEC ERP9AddLanguage @ModuleID, 'POF0001.DeReAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'	
EXEC ERP9AddLanguage @ModuleID, 'POF0001.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.OrderStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.CurrencyName.CB',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Mã phân loại'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.ClassifyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân loại'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.ClassifyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phương thức thanh toán'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.PaymentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phương thức thanh toán'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.PaymentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.InventoryTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.InventoryTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã kho'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.WareHouseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên kho'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.WareHouseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;
