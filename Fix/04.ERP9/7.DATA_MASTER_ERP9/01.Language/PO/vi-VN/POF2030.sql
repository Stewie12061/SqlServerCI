DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------
SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2030'
---------------------------------------------------------------
SET @LanguageValue  = N'Danh sách yêu cầu mua hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2030.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'POF2030.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2030.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2030.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'POF2030.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng duyệt'
EXEC ERP9AddLanguage @ModuleID, 'POF2030.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2030.OrderStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức độ ưu tiên'
EXEC ERP9AddLanguage @ModuleID, 'POF2030.PriorityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2030.OrderDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2030.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày giao hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2030.ShipDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ nhận hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2030.ReceivedAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2030.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả'
EXEC ERP9AddLanguage @ModuleID, 'POF2030.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tiền tệ'
EXEC ERP9AddLanguage @ModuleID, 'POF2030.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'POF2030.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2030.ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả'
EXEC ERP9AddLanguage @ModuleID, 'POF2030.Description.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá'
EXEC ERP9AddLanguage @ModuleID, 'POF2030.LinkPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'POF2030.Description',  @FormID, @LanguageValue, @Language;