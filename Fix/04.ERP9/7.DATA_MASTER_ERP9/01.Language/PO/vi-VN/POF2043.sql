DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------
SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2043'
---------------------------------------------------------------
SET @LanguageValue  = N'So sánh báo giá nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'POF2043.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2043.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2043.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn giá yêu cầu'
EXEC ERP9AddLanguage @ModuleID, 'POF2043.RequestPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'POF2043.Notes',  @FormID, @LanguageValue, @Language;



