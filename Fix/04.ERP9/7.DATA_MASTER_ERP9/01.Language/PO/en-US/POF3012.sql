DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'PO';
SET @FormID = 'POF3012'
---------------------------------------------------------------

SET @LanguageValue  = N'Order purchase status report'
EXEC ERP9AddLanguage @ModuleID, 'POF3012.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object'
EXEC ERP9AddLanguage @ModuleID, 'POF3012.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee'
EXEC ERP9AddLanguage @ModuleID, 'POF3012.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division'
EXEC ERP9AddLanguage @ModuleID, 'POF3012.DivisionID',  @FormID, @LanguageValue, @Language;


