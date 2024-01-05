DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------
SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2041'
---------------------------------------------------------------
SET @LanguageValue  = N'Cập nhật báo giá nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày yêu cầu'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hết hạn'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.OverDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.Attach',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người lập'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ giá'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông số kỹ thuật'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.TechnicalSpecifications',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá yêu cầu'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.RequestPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.InventoryID.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.InventoryName.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa yêu cầu mua hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.InheritPOF2005',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.Quantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.APK',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày duyệt'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.ApprovalDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú của người duyệt'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.ApprovalNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.Status.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.StatusName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chênh lệch đơn giá'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.UnitPriceDifference',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'POF2041.StandardID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'POF2041.StandardName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'POF2041.ConvertedUnitID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'POF2041.ConvertedUnitName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Toán tử';
EXEC ERP9AddLanguage @ModuleID, 'POF2041.DataTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cách tính';
EXEC ERP9AddLanguage @ModuleID, 'POF2041.FormulaDes.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số PO';
EXEC ERP9AddLanguage @ModuleID, 'POF2041.PONumber', @FormID, @LanguageValue, @Language;
