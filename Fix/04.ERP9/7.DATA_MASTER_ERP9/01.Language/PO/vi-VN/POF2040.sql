DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------
SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2040'
---------------------------------------------------------------
SET @LanguageValue  = N'Báo giá nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'POF2040.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'POF2040.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2040.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2040.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'POF2040.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người lập'
EXEC ERP9AddLanguage @ModuleID, 'POF2040.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày yêu cầu'
EXEC ERP9AddLanguage @ModuleID, 'POF2040.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hết hạn'
EXEC ERP9AddLanguage @ModuleID, 'POF2040.OverDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'POF2040.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người lập'
EXEC ERP9AddLanguage @ModuleID, 'POF2040.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'POF2040.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF2040.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'POF2040.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá'
EXEC ERP9AddLanguage @ModuleID, 'POF2040.LinkPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xem giá'
EXEC ERP9AddLanguage @ModuleID, 'POF2040.Price',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng duyệt'
EXEC ERP9AddLanguage @ModuleID, 'POF2040.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sản phẩm'
EXEC ERP9AddLanguage @ModuleID, 'POF2040.InventoryName',  @FormID, @LanguageValue, @Language;
