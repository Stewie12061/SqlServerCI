DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'SO';
SET @FormID = 'SOF2024'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn báo giá'
EXEC ERP9AddLanguage @ModuleID, 'SOF2024.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2024.QuotationNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2024.QuotationDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2024.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2024.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2024.IsConfirm',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2024.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng giá trị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2024.SumAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2024.QuotationStatus',  @FormID, @LanguageValue, @Language;

---[Đình Hoà] [26/06/2020] Bổ sung ngôn ngữ cho màn hình
SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2024.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2024.OrderStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'IsSO';
EXEC ERP9AddLanguage @ModuleID, 'SOF2024.IsSO',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2024.VoucherTypeID',  @FormID, @LanguageValue, @Language;