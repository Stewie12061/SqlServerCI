DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------
SET @Language = 'en-US';
SET @ModuleID = 'PO';
SET @FormID = 'POF2008'
---------------------------------------------------------------
SET @LanguageValue  = N'Inherit Tentative'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher No'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher Date'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object Name'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'MOrder ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.MOrderID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Product ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.ProductID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Product Name'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.ProductName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit Name'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quantity'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.ProductQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.PDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee Name'
EXEC ERP9AddLanguage @ModuleID, 'POF2008.EmployeeName',  @FormID, @LanguageValue, @Language;