DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------
SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF9005'
---------------------------------------------------------------
SET @LanguageValue = N'Chọn thông tin vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng container'
EXEC ERP9AddLanguage @ModuleID, 'POF9005.QuantityContainer',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số hóa đơn'
EXEC ERP9AddLanguage @ModuleID, 'POF9005.InvoiceNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vận đơn'
EXEC ERP9AddLanguage @ModuleID, 'POF9005.BillOfLadingNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hết hạn thông quan'
EXEC ERP9AddLanguage @ModuleID, 'POF9005.ClearanceExpirationDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tàu chạy'
EXEC ERP9AddLanguage @ModuleID, 'POF9005.DepartureDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tàu đến'
EXEC ERP9AddLanguage @ModuleID, 'POF9005.ArrivalDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian được miễn phí lưu cont'
EXEC ERP9AddLanguage @ModuleID, 'POF9005.DateFreeCont',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian được miễn phí lưu bãi'
EXEC ERP9AddLanguage @ModuleID, 'POF9005.DateFreePlace',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày thanh toán tiền hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF9005.PaymentDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hồ sơ đăng ký chuyên ngành'
EXEC ERP9AddLanguage @ModuleID, 'POF9005.CRMajorsID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số giấy đăng chuyên ngành'
EXEC ERP9AddLanguage @ModuleID, 'POF9005.CRMajorsNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày lấy mẫu kiểm tra chuyên ngành'
EXEC ERP9AddLanguage @ModuleID, 'POF9005.DateInspection',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số hợp quy'
EXEC ERP9AddLanguage @ModuleID, 'POF9005.LegalNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng nhận hợp quy'
EXEC ERP9AddLanguage @ModuleID, 'POF9005.CertificateLegalNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng thư'
EXEC ERP9AddLanguage @ModuleID, 'POF9005.CertificateNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày kéo cont'
EXEC ERP9AddLanguage @ModuleID, 'POF9005.TowingDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lấy mẫu kiểm tra chuyên ngành';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.InspectionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi phí';

EXEC ERP9AddLanguage @ModuleID, 'POF9005.ThongTinChiPhi', @FormID, @LanguageValue, @Language;
