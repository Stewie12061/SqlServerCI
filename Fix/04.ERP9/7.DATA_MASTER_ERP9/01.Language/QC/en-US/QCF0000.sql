DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'QC';
SET @FormID = 'QCF0000'
---------------------------------------------------------------

SET @LanguageValue  = N'System Settings'
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Code'
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Name'
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Product quality voucher type'
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherFirstShift', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Product weight voucher type'
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Operating parameters voucher type'
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherOperateParam', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Technique parameters voucher type'
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherTechniqueParam', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tracking of materials voucher type'
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherMaterial', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Handling of defective items voucher type'
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherDefective', @FormID, @LanguageValue, @Language;