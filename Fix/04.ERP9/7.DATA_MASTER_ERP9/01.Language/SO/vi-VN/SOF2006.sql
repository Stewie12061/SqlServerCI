DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------
SET @Language = 'vi-VN';
SET @ModuleID = 'SO';
SET @FormID = 'SOF2006'

---------------------------------------------------------------
SET @LanguageValue  = N'Kế thừa đơn hàng gia công'
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.Title',  @FormID, @LanguageValue, @Language;
--Master
SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.OrderDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã khách hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.Notes',  @FormID, @LanguageValue, @Language;

--Detail
SET @LanguageValue  = N'Mã hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính'
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính'
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.OrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá'
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.SalePrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành tiền'
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành tiền quy đổi'
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tàu chạy'
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.ShipStartDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng kế thừa'
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.InheritedQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng sẵn sàng'
EXEC ERP9AddLanguage @ModuleID, 'SOF2006.AvailableQuantity',  @FormID, @LanguageValue, @Language;