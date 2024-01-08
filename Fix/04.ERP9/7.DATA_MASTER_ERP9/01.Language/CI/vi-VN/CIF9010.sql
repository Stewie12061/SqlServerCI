DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF9010'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn quy cách'
EXEC ERP9AddLanguage @ModuleID, 'CIF9010.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã quy cách'
EXEC ERP9AddLanguage @ModuleID, 'CIF9010.StandardID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên quy cách'
EXEC ERP9AddLanguage @ModuleID, 'CIF9010.StandardName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'CIF9010.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại quy cách'
EXEC ERP9AddLanguage @ModuleID, 'CIF9010.StandardTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị'
EXEC ERP9AddLanguage @ModuleID, 'CIF9010.Disabled',  @FormID, @LanguageValue, @Language;