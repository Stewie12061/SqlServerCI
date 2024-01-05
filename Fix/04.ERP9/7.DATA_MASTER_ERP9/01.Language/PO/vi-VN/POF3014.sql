DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF3014'
---------------------------------------------------------------

SET @LanguageValue  = N'Báo cáo Book-cont đơn hàng xuất khẩu'
EXEC ERP9AddLanguage @ModuleID, 'POF3014.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF3014.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF3014.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'POF3014.DivisionID',  @FormID, @LanguageValue, @Language;