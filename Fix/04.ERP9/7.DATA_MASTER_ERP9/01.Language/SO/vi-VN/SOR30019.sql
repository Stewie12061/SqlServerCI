declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOR30019'
SET @LanguageValue = N'Báo cáo tình hình thanh toán theo đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'SOR30019.Title' , @FormID, @LanguageValue, @Language;

-- SET @FormID = 'SOR30019'
-- SET @LanguageValue = N'Từ khách hàng';
-- EXEC ERP9AddLanguage @ModuleID, 'SOR30019.FromAccountName' , @FormID, @LanguageValue, @Language;

-- SET @FormID = 'SOR30019'
-- SET @LanguageValue = N'Đến khách hàng';
-- EXEC ERP9AddLanguage @ModuleID, 'SOR30019.ToAccountName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30019'
SET @LanguageValue = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'SOR30019.OrderStatus' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30019'
SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR30019.AccountName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR30019'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOR30019.DivisionID' , @FormID, @LanguageValue, @Language;
