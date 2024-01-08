DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'PO';
SET @FormID = 'POF3010'
---------------------------------------------------------------

SET @LanguageValue  = N'Purchase order summary report'
EXEC ERP9AddLanguage @ModuleID, 'POF3010.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Supplier'
EXEC ERP9AddLanguage @ModuleID, 'POF3010.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status'
EXEC ERP9AddLanguage @ModuleID, 'POF3010.OrderStatusPO',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division'
EXEC ERP9AddLanguage @ModuleID, 'POF3010.DivisionID',  @FormID, @LanguageValue, @Language;


