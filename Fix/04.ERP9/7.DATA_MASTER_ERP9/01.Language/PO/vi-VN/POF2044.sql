DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------
SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2044'
---------------------------------------------------------------
SET @LanguageValue  = N'Kế thừa báo giá nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'POF2044.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2044.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày yêu cầu'
EXEC ERP9AddLanguage @ModuleID, 'POF2044.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hết hạn'
EXEC ERP9AddLanguage @ModuleID, 'POF2044.OverDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'POF2044.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người lập'
EXEC ERP9AddLanguage @ModuleID, 'POF2044.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'POF2044.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2044.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2044.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông số kỹ thuật'
EXEC ERP9AddLanguage @ModuleID, 'POF2044.TechnicalSpecifications',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng'
EXEC ERP9AddLanguage @ModuleID, 'POF2044.Quantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá Yêu cầu'
EXEC ERP9AddLanguage @ModuleID, 'POF2044.RequestPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá'
EXEC ERP9AddLanguage @ModuleID, 'POF2044.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'POF2044.Notes',  @FormID, @LanguageValue, @Language;