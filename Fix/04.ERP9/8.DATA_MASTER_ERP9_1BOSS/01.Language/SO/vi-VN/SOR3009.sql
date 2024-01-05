declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOR3009'
SET @LanguageValue = N'Tổng hợp doanh số bán hàng theo nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOR3009.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3009'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOR3009.DivisionID' , @FormID, @LanguageValue, @Language;

-- SET @FormID = 'SOR3009'
-- SET @LanguageValue = N'Từ khách hàng';
-- EXEC ERP9AddLanguage @ModuleID, 'SOR3009.FromAccountName' , @FormID, @LanguageValue, @Language;

-- SET @FormID = 'SOR3009'
-- SET @LanguageValue = N'Đến khách hàng';
-- EXEC ERP9AddLanguage @ModuleID, 'SOR3009.ToAccountName', @FormID, @LanguageValue, @Language;

-- SET @FormID = 'SOR3009'
-- SET @LanguageValue = N'Từ nhân viên';
-- EXEC ERP9AddLanguage @ModuleID, 'SOR3009.FromSalesManName' , @FormID, @LanguageValue, @Language;

-- SET @FormID = 'SOR3009'
-- SET @LanguageValue = N'Đến nhân viên';
-- EXEC ERP9AddLanguage @ModuleID, 'SOR3009.ToSalesManName' , @FormID, @LanguageValue, @Language;

-- SET @FormID = 'SOR3009'
-- SET @LanguageValue = N'Từ mặt hàng';
-- EXEC ERP9AddLanguage @ModuleID, 'SOR3009.FromInventoryName' , @FormID, @LanguageValue, @Language;

-- SET @FormID = 'SOR3009'
-- SET @LanguageValue = N'Đến mặt hàng';
-- EXEC ERP9AddLanguage @ModuleID, 'SOR3009.ToInventoryName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3009'
SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3009.AccountName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3009'
SET @LanguageValue = N'Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3009.InventoryName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3009'
SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOR3009.SalesManName' , @FormID, @LanguageValue, @Language;
