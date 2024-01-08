declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'vi-VN'

SET @FormID = 'CRMR3013'

SET @LanguageValue = N'Daily Warranty Report';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3013.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3013.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3013.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3013.FromMemberName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3013.ToMemberName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3013.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3013.SaleVoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu xuất kho';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3013.ExportVoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số thẻ bảo hành';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3013.WarrantyCard' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số seri';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3013.SerialNo' , @FormID, @LanguageValue, @Language;