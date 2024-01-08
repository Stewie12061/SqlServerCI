declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOR3003'
SET @LanguageValue = N'Tổng hợp đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'SOR3003.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3003'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOR3003.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3003'
SET @LanguageValue = N'Từ khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3003.FromAccountName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3003'
SET @LanguageValue = N'Đến khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3003.ToAccountName', @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3003'
SET @LanguageValue = N'Từ nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOR3003.FromSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3003'
SET @LanguageValue = N'Đến nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOR3003.ToSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3003'
SET @LanguageValue = N'Trang thái';
EXEC ERP9AddLanguage @ModuleID, 'SOR3003.OrderStatus' , @FormID, @LanguageValue, @Language;

