DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1191'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật loại ngoại tệ'
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ngoại tệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.CurrencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ngoại tệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.CurrencyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.ExchangeRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Toán tử';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.Operator',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phần thập phân';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.ExchangeRateDecimal',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phần thập phân';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.DecimalName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phần đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương pháp tính giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.Method',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1191.CreateUserID',  @FormID, @LanguageValue, @Language;


