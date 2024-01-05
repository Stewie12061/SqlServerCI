DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF3000'
---------------------------------------------------------------

SET @LanguageValue  = N'Báo cáo đơn hàng mua'
EXEC ERP9AddLanguage @ModuleID, 'POF3000.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Báo cáo biểu đồ'
EXEC ERP9AddLanguage @ModuleID, 'AsoftPO_Group_BaoCaoBieuDo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Báo cáo khác'
EXEC ERP9AddLanguage @ModuleID, 'AsoftPO.GRP_BaoCao',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu mua hàng'
EXEC ERP9AddLanguage @ModuleID, 'AsoftPO.GRP_YeuCauMuaHang',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mua hàng'
EXEC ERP9AddLanguage @ModuleID, 'AsoftPO.GRP_MuaHang',  @FormID, @LanguageValue, @Language;