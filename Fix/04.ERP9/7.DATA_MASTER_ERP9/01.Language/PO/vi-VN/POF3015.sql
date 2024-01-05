DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF3015'
---------------------------------------------------------------

SET @LanguageValue  = N'Báo cáo dự trù chi phí theo dự án'
EXEC ERP9AddLanguage @ModuleID, 'POF3015.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dự án'
EXEC ERP9AddLanguage @ModuleID, 'POF3015.Ana01Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF3015.InventoryID',  @FormID, @LanguageValue, @Language;