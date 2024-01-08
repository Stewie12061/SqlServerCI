DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------
SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'CMNF9001'
---------------------------------------------------------------
SET @LanguageValue  = N'Chọn mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.InventoryName',  @FormID, @LanguageValue, @Language;
