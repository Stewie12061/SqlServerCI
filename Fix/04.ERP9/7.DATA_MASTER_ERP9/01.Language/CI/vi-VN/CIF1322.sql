DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1322'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.VoucherTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.VoucherGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.VDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải bút toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.TDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.BankAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kho hàng/ Kho nhập';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.WareHouseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kho xuất';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.ExWareHouseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.VATTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế giá trị gia tăng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.IsVAT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.S1Type',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.S2Type',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.S3Type',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dấu cách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.separator',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dạng hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.OutputOrder',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số tăng tự động';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Separated',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.S1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.S2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.S3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thiết lập mã tăng tự động';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.ThongTinChung',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin mặc định';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.ThongTinMacDinh',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Thông tin mã tăng tự động';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.ThongTinMaTangTuDong',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản nợ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.DebitAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị mặc định';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.IsDefault',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản có';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.CreditAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.BDescription',  @FormID, @LanguageValue, @Language;



SET @LanguageValue  = N'Độ dài';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.OutputLength',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Description',  @FormID, @LanguageValue, @Language;

--------------23/11/2021 - Hoài Bảo: Mã phân hệ, Nghiệp vụ --------------
SET @LanguageValue = N'Phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.ScreenID', @FormID, @LanguageValue, @Language;