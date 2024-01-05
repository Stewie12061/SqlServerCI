DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF3012'
---------------------------------------------------------------

SET @LanguageValue  = N'Báo cáo tình hình lập đơn hàng mua'
EXEC ERP9AddLanguage @ModuleID, 'POF3012.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng'
EXEC ERP9AddLanguage @ModuleID, 'POF3012.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'POF3012.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'POF3012.DivisionID',  @FormID, @LanguageValue, @Language;


