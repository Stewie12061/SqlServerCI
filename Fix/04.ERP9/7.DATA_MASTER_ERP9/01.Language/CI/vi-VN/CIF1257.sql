DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1257'

---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật chi tiết bảng giá bán'
EXEC ERP9AddLanguage @ModuleID, 'CIF1257.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1257.ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1257.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1257.MasterDiscountPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1257.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng giá sau thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1257.IsTaxIncluded',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chọn nhiều mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1257.ChooseInventoryList',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1257.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1257.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1257.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1257.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá tối thiểu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1257.MinPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá tối đa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1257.MaxPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1257.DiscountPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1257.DiscountAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1257.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% VAT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1257.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền thuế VAT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1257.VATAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1257.TotalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán lẻ đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1257.RetailPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa bảng tính giá dự kiến';
EXEC ERP9AddLanguage @ModuleID, 'CIF1257.IsInheritCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1257.EditSpecifications',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1257.UnitID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1257.UnitName.CB',  @FormID, @LanguageValue, @Language;
