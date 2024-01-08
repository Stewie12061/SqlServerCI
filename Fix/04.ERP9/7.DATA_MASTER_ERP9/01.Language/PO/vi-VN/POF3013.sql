DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF3013'
---------------------------------------------------------------

SET @LanguageValue  = N'Báo cáo tổng hợp tình hình nhận hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF3013.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'POF3013.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF3013.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cả những phiếu chưa đặt hết trước thời gian trên'
EXEC ERP9AddLanguage @ModuleID, 'POF3013.IsFilter1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm'
EXEC ERP9AddLanguage @ModuleID, 'POF3013.IsFilter2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'POF3013.DivisionID',  @FormID, @LanguageValue, @Language;