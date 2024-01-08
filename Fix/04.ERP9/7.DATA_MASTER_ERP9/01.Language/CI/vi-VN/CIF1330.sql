DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1330'
---------------------------------------------------------------

SET @LanguageValue  = N'Mã tự động đối tượng'
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tạo mã tự động';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.IsAutomatic',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.IsS1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.IsS2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.IsS3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân loại 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.S1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân loại 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.S2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân loại 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.S3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dạng hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.OutputOrder',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dấu phân cách ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.Separator',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đăt lại chỉ số tăng tự động';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.IsSeparator',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đăt lại chỉ số tăng tự động';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.IsLastKey',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Độ dài';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.Length',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.LastKey',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ví dụ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.Example',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.TypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.TypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1330.TypeName.CB',  @FormID, @LanguageValue, @Language;

