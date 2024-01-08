declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOR3006'
SET @LanguageValue = N'Doanh số trung bình của đơn hàng theo nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOR3006.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3006'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOR3006.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3006'
SET @LanguageValue = N'Từ khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3006.FromAccountName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3006'
SET @LanguageValue = N'Đến khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3006.ToAccountName', @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3006'
SET @LanguageValue = N'Từ nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOR3006.FromSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3006'
SET @LanguageValue = N'Đến nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOR3006.ToSalesManName' , @FormID, @LanguageValue, @Language;


