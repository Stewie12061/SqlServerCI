DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1281'
---------------------------------------------------------------

SET @LanguageValue  = N'Update payment term'
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment term code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.PaymentTermID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment term name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.PaymentTermName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Due date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.IsDueDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Due type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.DueType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Due day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.DueDays',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Close day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.CloseDay',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'The day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.TheDay',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Of the month';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.TheMonth',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.IsDiscount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Discount type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.DiscountType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Number of discount days';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.DiscountDays',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'The discount rate is enjoyed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.DiscountPercentage',  @FormID, @LanguageValue, @Language;




