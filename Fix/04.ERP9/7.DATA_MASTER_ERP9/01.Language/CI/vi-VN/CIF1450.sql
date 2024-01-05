DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1450'
---------------------------------------------------------------

SET @LanguageValue  = N'Thiết lập mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'CIF1450.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1450.TypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Định nghĩa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1450.UserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Định nghĩa (tiếng Anh)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1450.UserNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên gốc';
EXEC ERP9AddLanguage @ModuleID, 'CIF1450.SystemName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1450.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1450.IsUsed',  @FormID, @LanguageValue, @Language;