DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'FN';
SET @FormID = 'FNF3000'
---------------------------------------------------------------

SET @LanguageValue  = N'Báo cáo'
EXEC ERP9AddLanguage @ModuleID, 'FNF3000.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Báo cáo'
EXEC ERP9AddLanguage @ModuleID, 'AsoftFN.GRP_BaoCaoFN',  @FormID, @LanguageValue, @Language;
