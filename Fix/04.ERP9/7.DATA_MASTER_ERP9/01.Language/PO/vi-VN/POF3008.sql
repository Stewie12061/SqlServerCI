DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF3008'
---------------------------------------------------------------

SET @LanguageValue  = N'Báo cáo tổng hợp tình hình đơn đặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF3008.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cả những phiếu chưa đặt hết trước thời gian trên'
EXEC ERP9AddLanguage @ModuleID, 'POF3008.IsFilter1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF3008.IsGroup1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng'
EXEC ERP9AddLanguage @ModuleID, 'POF3008.IsGroup2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhà cung cấp'
EXEC ERP9AddLanguage @ModuleID, 'POF3008.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF3008.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm'
EXEC ERP9AddLanguage @ModuleID, 'POF3008.GroupPOR3008',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm'
EXEC ERP9AddLanguage @ModuleID, 'POF3008.IsFilter2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'POF3008.DivisionID',  @FormID, @LanguageValue, @Language;
