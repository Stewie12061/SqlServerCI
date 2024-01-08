DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF3007'
---------------------------------------------------------------

SET @LanguageValue  = N'Báo cáo mặt hàng mua nhiều nhất theo thời gian'
EXEC ERP9AddLanguage @ModuleID, 'POF3007.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF3007.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'POF3007.DivisionID',  @FormID, @LanguageValue, @Language;