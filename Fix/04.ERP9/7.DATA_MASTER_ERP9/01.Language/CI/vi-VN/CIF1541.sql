DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1541'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật công thức chi phí'
EXEC ERP9AddLanguage @ModuleID, 'CIF1541.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chi phí';
EXEC ERP9AddLanguage @ModuleID, 'CIF1541.TypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Định nghĩa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1541.UserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công thức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1541.Recipe',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1541.IsUsed',  @FormID, @LanguageValue, @Language;