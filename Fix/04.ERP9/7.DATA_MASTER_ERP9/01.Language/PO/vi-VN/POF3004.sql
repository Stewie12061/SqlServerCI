DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF3004'
---------------------------------------------------------------

SET @LanguageValue  = N'Báo cáo thống kê yêu cầu mua hàng theo từng dự án'
EXEC ERP9AddLanguage @ModuleID, 'POF3004.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF3004.FromInventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF3004.ToInventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dự án'
EXEC ERP9AddLanguage @ModuleID, 'POF3004.Ana01Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF3004.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'POF3004.DivisionID',  @FormID, @LanguageValue, @Language;