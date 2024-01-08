DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1280'
---------------------------------------------------------------

SET @LanguageValue  = N'Category payment term'
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment term code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.PaymentTermID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment term name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.PaymentTermName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Due date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.IsDueDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Due type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.DueType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Due day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.DueDays',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Close day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.CloseDay',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'The day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.TheDay',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Of the month';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.TheMonth',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.IsDiscount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Discount type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.DiscountType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Number of discount days';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.DiscountDays',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'The discount rate is enjoyed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1280.DiscountPercentage',  @FormID, @LanguageValue, @Language;

