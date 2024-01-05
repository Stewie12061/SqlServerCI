DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------
SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2034'
---------------------------------------------------------------
SET @LanguageValue  = N'Chọn mẫu in'
EXEC ERP9AddLanguage @ModuleID, 'POF2034.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn đặt hàng dữ trữ'
EXEC ERP9AddLanguage @ModuleID, 'POF2034.Report1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn đặt hàng dữ trữ - bổ sung '
EXEC ERP9AddLanguage @ModuleID, 'POF2034.Report2',  @FormID, @LanguageValue, @Language;

