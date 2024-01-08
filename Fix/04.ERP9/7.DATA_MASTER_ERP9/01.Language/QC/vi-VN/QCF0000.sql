DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'QC';
SET @FormID = 'QCF0000'
---------------------------------------------------------------

SET @LanguageValue  = N'Thiết lập hệ thống'
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại CT Phiếu chất lượng đầu ca'
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherFirstShift',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại CT Phiếu ghi nhận số lượng'
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại CT Thông số vận hành'
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherOperateParam',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại CT Thông số kỹ thuật'
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherTechniqueParam',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại CT Theo dõi nguyên vật liệu'
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherMaterial',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại CT Xử lý hàng lỗi'
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherDefective',  @FormID, @LanguageValue, @Language;