DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF3003'
---------------------------------------------------------------

SET @LanguageValue  = N'Báo cáo lịch sử báo giá nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'POF3003.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng'
EXEC ERP9AddLanguage @ModuleID, 'POF3003.FromObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF3003.FromInventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF3003.ToInventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF3003.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'POF3003.DivisionID',  @FormID, @LanguageValue, @Language;

