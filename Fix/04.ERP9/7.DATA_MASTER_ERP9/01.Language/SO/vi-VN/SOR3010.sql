declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOR3010'
SET @LanguageValue = N'Báo cáo tổng doanh số bán hàng của nhân viên theo tháng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3010.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3010'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOR3010.DivisionID' , @FormID, @LanguageValue, @Language;

-- SET @FormID = 'SOR3010'
-- SET @LanguageValue = N'Từ khách hàng';
-- EXEC ERP9AddLanguage @ModuleID, 'SOR3010.FromAccountName' , @FormID, @LanguageValue, @Language;

-- SET @FormID = 'SOR3010'
-- SET @LanguageValue = N'Đến khách hàng';
-- EXEC ERP9AddLanguage @ModuleID, 'SOR3010.ToAccountName', @FormID, @LanguageValue, @Language;

-- SET @FormID = 'SOR3010'
-- SET @LanguageValue = N'Từ nhân viên';
-- EXEC ERP9AddLanguage @ModuleID, 'SOR3010.FromSalesManName' , @FormID, @LanguageValue, @Language;

-- SET @FormID = 'SOR3010'
-- SET @LanguageValue = N'Đến nhân viên';
-- EXEC ERP9AddLanguage @ModuleID, 'SOR3010.ToSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3010'
SET @LanguageValue = N'Chọn kỳ';
EXEC ERP9AddLanguage @ModuleID, 'SOR3010.CheckListPeriodControl' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3010'
SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOR3010.SalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3010'
SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3010.AccountName' , @FormID, @LanguageValue, @Language;
