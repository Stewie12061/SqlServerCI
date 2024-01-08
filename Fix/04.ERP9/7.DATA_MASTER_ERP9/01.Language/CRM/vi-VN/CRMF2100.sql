DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2100'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục phiếu yêu cầu khách hàng'
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số phiếu yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.VoucherDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.PaperTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.ActualQuantity',  @FormID, @LanguageValue, @Language;
