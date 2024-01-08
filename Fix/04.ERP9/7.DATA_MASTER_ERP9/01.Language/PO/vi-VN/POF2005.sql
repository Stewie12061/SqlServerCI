DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------
SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2005'
---------------------------------------------------------------
SET @LanguageValue  = N'Kế thừa yêu cầu mua hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.OrderDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày giao hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.ShipDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức độ ưu tiên'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.PriorityName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.OrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.RequestPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền nguyên tệ'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền quy đổi'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức độ ưu tiên'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.PriorityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.Description.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.AnaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.AnaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng sản phẩm'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.ProductQuantity',  @FormID, @LanguageValue, @Language;