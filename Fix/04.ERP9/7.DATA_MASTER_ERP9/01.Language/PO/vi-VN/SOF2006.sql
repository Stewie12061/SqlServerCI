DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'SOF2006'
---------------------------------------------------------------

SET @LanguageValue  = N'Kế thừa đơn hàng bán'
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa đơn hàng bán'
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.SubTitle',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chừng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.OrderDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.OrderStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.Quantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng còn lại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.RemainQuantity',  @FormID, @LanguageValue, @Language;
