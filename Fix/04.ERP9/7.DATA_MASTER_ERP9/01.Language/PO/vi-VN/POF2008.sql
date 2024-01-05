DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------
SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2008'
---------------------------------------------------------------
SET @LanguageValue  = N'Kế thừa dự trù chi phí'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.Title',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Số chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đối tượng'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đối tượng'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chú thích'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã TTSX'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.MOrderID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã sản phẩm'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.ProductID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên sản phẩm'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.ProductName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.ProductQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chú thích'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.PDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người yêu cầu'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.EmployeeName',  @FormID, @LanguageValue, @Language;