DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF3016'
---------------------------------------------------------------

SET @LanguageValue  = N'Báo cáo chi tiết tình hình nhận hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF3016.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'POF3016.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chọn đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF3016.Ana01Name',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF3016.OrderDate',  @FormID, @LanguageValue, @Language;