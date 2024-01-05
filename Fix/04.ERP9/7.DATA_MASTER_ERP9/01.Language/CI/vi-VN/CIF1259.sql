DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1259'

---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật chi tiết bảng giá bán'
EXEC ERP9AddLanguage @ModuleID, 'CIF1259.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1259.ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1259.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1259.MasterDiscountPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1259.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá sau thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1259.IsTaxIncluded',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chọn nhiều mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1259.ChooseInventoryList',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1259.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1259.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1259.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1259.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá tối thiểu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1259.MinPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá tối đa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1259.MaxPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1259.DiscountPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1259.DiscountAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1259.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% VAT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1259.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền thuế VAT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1259.VATAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1259.TotalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán lẻ đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1259.RetailPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1259.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1259.ToDate',  @FormID, @LanguageValue, @Language;
