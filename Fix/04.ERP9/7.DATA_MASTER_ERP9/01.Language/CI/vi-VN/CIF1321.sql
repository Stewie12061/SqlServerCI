DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1321'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VoucherTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VoucherGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải bút toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.TDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.BankAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kho hàng/ Kho nhập';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.WareHouseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kho xuất';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ExWareHouseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VATTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế giá trị gia tăng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.IsVAT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.S1Type',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.S2Type',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.S3Type',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dấu cách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.separator',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dạng hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.OutputOrder',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số tăng tự động';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.SetLastKey',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.S1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.S2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.S3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thiết lập mã tăng tự động';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhóm chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VoucherGroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhóm chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VoucherGroupName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.WareHouseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.WareHouseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.AccountID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.AccountName.CB',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VATTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VATTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.BankAccountID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.BankAccountName.CB',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ThongTinChung',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin mặc định';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ThongTinMacDinh',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Thông tin mã tăng tự động';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ThongTinMaTangTuDong',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản nợ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.DebitAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị mặc định';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.IsDefault',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản có';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.CreditAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.BDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sử dụng diễn giải chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.IsBDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sử dụng diễn giải chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.IsTDescription',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Đặt lại chỉ số tăng tự động';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.IsSetLastKey',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Độ dài';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.OutputLength',  @FormID, @LanguageValue, @Language;

--------------23/11/2021 - Hoài Bảo: Mã phân hệ, Nghiệp vụ --------------
SET @LanguageValue = N'Phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ScreenID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ModuleID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ModuleName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ScreenID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ScreenName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.Description.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.MenuText1BOSS.CB', @FormID, @LanguageValue, @Language;