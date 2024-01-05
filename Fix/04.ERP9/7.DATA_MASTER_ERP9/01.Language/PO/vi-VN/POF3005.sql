DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF3005'
---------------------------------------------------------------

SET @LanguageValue  = N'Báo cáo xem chi tiết đơn hàng mua theo dự án'
EXEC ERP9AddLanguage @ModuleID, 'POF3005.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dự án'
EXEC ERP9AddLanguage @ModuleID, 'POF3005.Ana01Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF3005.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'POF3005.DivisionID',  @FormID, @LanguageValue, @Language;