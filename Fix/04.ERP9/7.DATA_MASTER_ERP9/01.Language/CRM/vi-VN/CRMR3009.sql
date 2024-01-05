declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'vi-VN'

SET @FormID = 'CRMR3009'
SET @LanguageValue = N'Tổng hợp số lượng khách hàng nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3009.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3009'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3009.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3009'
SET @LanguageValue = N'Từ khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3009.FromAccountName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3009'
SET @LanguageValue = N'Đến khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3009.ToAccountName', @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3009'
SET @LanguageValue = N'Từ nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3009.FromSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3009'
SET @LanguageValue = N'Đến nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3009.ToSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3009'
SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3009.AccountID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3009'
SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3009.AccountName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3009'
SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3009.SalesManID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3009'
SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3009.SalesManName' , @FormID, @LanguageValue, @Language;



