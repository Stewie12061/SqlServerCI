DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1192'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết loại ngoại tệ'
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ngoại tệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ngoại tệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.CurrencyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Toán tử';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.Operator',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phần thập phân';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.ExchangeRateDecimal',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phần thập phân';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.DecimalName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phần đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương pháp tính giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.Method',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin ngoại tệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1192.ThongTinNgoaiTe',  @FormID, @LanguageValue, @Language;

