DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------
SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2042'
---------------------------------------------------------------
SET @LanguageValue  = N'Xem chi tiết báo giá nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày yêu cầu'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người lập'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ giá'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông số kỹ thuật'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.TechnicalSpecifications',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá yêu cầu'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.RequestPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin báo giá nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.Info',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chi tiết báo giá nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.Detail',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.Attacth.GR',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.Notes.GR',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.History.GR',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.Quantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2041.APK.PO',  @FormID, @LanguageValue, @Language;

--- Modified by Trọng Kiên on 06/11/2020: Bổ sung ngôn ngữ cột StatusID
SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'POF2042.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chênh lệch đơn giá'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.UnitPriceDifference',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày duyệt'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.ApprovalDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hết hạn'
EXEC ERP9AddLanguage @ModuleID, 'POF2042.OverDate',  @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Số PO';
EXEC ERP9AddLanguage @ModuleID, 'POF2042.PONumber', @FormID, @LanguageValue, @Language;
