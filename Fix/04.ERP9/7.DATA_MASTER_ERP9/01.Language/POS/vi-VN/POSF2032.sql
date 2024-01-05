DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'POS';
SET @FormID = 'POSF2032'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết phiếu đề nghị xuất hóa đơn'
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.ShopID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.VATObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xuất hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.SuggestUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.VATObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.VATObjectAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hóa đơn bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.InvoiceVoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.SumAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phiếu bán hàng POS';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.InVoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.SuggestUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa phiếu bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.BtnInheritDeposit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.InVoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.InVoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.InVoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã gói';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.PackageID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.Quantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.UnitPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin phiếu đề nghị xuất hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.ThongTinPhieuDeNghiXuatHoaDon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi tiết phiếu xuất hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.ChiTietPhieuDeNghiXuatHoaDon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.VATObjectIDOKIA',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.VATObjectNameOKIA',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.DiscountRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.DiscountAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% thuế';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền thuế';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.TaxAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF2032.MemberName',  @FormID, @LanguageValue, @Language;



