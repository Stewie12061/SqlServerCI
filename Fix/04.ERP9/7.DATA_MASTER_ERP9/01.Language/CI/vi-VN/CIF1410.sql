DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1410'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục thiết lập quy cách hàng hóa'
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.IsUsed',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên gốc';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.SystemName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại quy cách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.UserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại quy cách (tiếng Anh)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.UserNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phụ phí';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.IsExtraFee',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại quy cách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1410.TypeID',  @FormID, @LanguageValue, @Language;