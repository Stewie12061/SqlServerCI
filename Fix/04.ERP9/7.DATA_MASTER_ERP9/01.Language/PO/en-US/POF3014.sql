DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'PO';
SET @FormID = 'POF3014'
---------------------------------------------------------------

SET @LanguageValue  = N'Report on container booking for export order'
EXEC ERP9AddLanguage @ModuleID, 'POF3014.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Customer'
EXEC ERP9AddLanguage @ModuleID, 'POF3014.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher No'
EXEC ERP9AddLanguage @ModuleID, 'POF3014.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division'
EXEC ERP9AddLanguage @ModuleID, 'POF3014.DivisionID',  @FormID, @LanguageValue, @Language;