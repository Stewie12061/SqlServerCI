DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1282'
---------------------------------------------------------------

SET @LanguageValue  = N'Detail payment term'
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment term code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.PaymentTermID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment term name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.PaymentTermName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Due date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.IsDueDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Due type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.DueType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Due day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.DueDays',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Close day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.CloseDay',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'The day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.TheDay',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Of the month';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.TheMonth',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.IsDiscount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Discount type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.DiscountType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Number of discount days';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.DiscountDays',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'The discount rate is enjoyed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.DiscountPercentage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.CreateUserID',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Payment Terms Information';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.ThongTinDieuKhoanThanhToan',  @FormID, @LanguageValue, @Language;


