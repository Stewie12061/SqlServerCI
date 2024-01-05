DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1340'
---------------------------------------------------------------

SET @LanguageValue  = N'Mã tự động mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tạo mã tự động';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.IsAutomatic',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.IsS1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.IsS2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.IsS3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân loại 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.S1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân loại 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.S2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân loại 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.S3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dạng hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.OutputOrder',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dấu phân cách ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.Separator',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đăt lại chỉ số tăng tự động';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.IsSeparator',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đăt lại chỉ số tăng tự động';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.IsLastKey',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Độ dài';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.Length',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.LastKey',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ví dụ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1340.Example',  @FormID, @LanguageValue, @Language;


