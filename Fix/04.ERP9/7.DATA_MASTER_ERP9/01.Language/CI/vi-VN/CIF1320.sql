DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1320'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.VoucherTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.VoucherTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.VoucherGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.VDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải bút toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.TDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.BankAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kho hàng/ Kho nhập';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.WareHouseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kho xuất';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.ExWareHouseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.VATTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thuế giá trị gia tăng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.IsVAT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.S1Type',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.S2Type',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.S3Type',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dấu cách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.separator',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dạng hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.OutputOrder',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số tăng tự động';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Separated',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.S1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.S2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.S3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thiết lập mã tăng tự động';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Auto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Description',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Tài khoản nợ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.DebitAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị mặc định';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.IsDefault',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản có';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.CreditAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.BDescription',  @FormID, @LanguageValue, @Language;

--------------23/11/2021 - Hoài Bảo: Mã phân hệ, Tên phân hệ, Phân hệ, Nghiệp vụ--------------
SET @LanguageValue = N'Mã phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.ModuleID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.ModuleName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.ScreenID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.ScreenID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.ScreenName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.MenuText1BOSS.CB', @FormID, @LanguageValue, @Language;