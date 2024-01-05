declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOR3008'
SET @LanguageValue = N'Doanh số bán hàng theo khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3008.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3008'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOR3008.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3008'
SET @LanguageValue = N'Từ khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3008.FromAccountName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3008'
SET @LanguageValue = N'Đến khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3008.ToAccountName', @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3008'
SET @LanguageValue = N'Từ nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOR3008.FromSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3008'
SET @LanguageValue = N'Đến nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOR3008.ToSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3008'
SET @LanguageValue = N'Từ mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3008.FromInventoryName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3008'
SET @LanguageValue = N'Đến mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3008.ToInventoryName' , @FormID, @LanguageValue, @Language;


