DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'PO';
SET @FormID = 'POF3000'
---------------------------------------------------------------

SET @LanguageValue  = N'Report'
EXEC ERP9AddLanguage @ModuleID, 'POF3000.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chart report'
EXEC ERP9AddLanguage @ModuleID, 'POF3000.AsoftPO_Group_BaoCaoBieuDo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Other reports'
EXEC ERP9AddLanguage @ModuleID, 'POF3000.GRP_BaoCao',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Purchase'
EXEC ERP9AddLanguage @ModuleID, 'POF3000.GRP_MuaHang',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Purchase order	'
EXEC ERP9AddLanguage @ModuleID, 'POF3000.GRP_YeuCauMuaHang',  @FormID, @LanguageValue, @Language;