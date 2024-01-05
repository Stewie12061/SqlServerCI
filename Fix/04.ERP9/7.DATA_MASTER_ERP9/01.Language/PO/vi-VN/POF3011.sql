DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF3011'
---------------------------------------------------------------

SET @LanguageValue  = N'Báo cáo tổng hợp giá mua mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF3011.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng'
EXEC ERP9AddLanguage @ModuleID, 'POF3011.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF3011.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'POF3011.DivisionID',  @FormID, @LanguageValue, @Language;


