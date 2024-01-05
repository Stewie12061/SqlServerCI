declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOR3005'
SET @LanguageValue = N'Báo cáo doanh số bán hàng theo khu vực';
EXEC ERP9AddLanguage @ModuleID, 'SOR3005.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3005'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOR3005.DivisionID' , @FormID, @LanguageValue, @Language;

-- SET @FormID = 'SOR3005'
-- SET @LanguageValue = N'Từ khách hàng';
-- EXEC ERP9AddLanguage @ModuleID, 'SOR3005.FromAccountName' , @FormID, @LanguageValue, @Language;

-- SET @FormID = 'SOR3005'
-- SET @LanguageValue = N'Đến khách hàng';
-- EXEC ERP9AddLanguage @ModuleID, 'SOR3005.ToAccountName', @FormID, @LanguageValue, @Language;

-- SET @FormID = 'SOR3005'
-- SET @LanguageValue = N'Từ nhân viên';
-- EXEC ERP9AddLanguage @ModuleID, 'SOR3005.FromSalesManName' , @FormID, @LanguageValue, @Language;

-- SET @FormID = 'SOR3005'
-- SET @LanguageValue = N'Đến nhân viên';
-- EXEC ERP9AddLanguage @ModuleID, 'SOR3005.ToSalesManName' , @FormID, @LanguageValue, @Language;

-- SET @FormID = 'SOR3005'
-- SET @LanguageValue = N'Từ khu vực';
-- EXEC ERP9AddLanguage @ModuleID, 'SOR3005.FromAreaID' , @FormID, @LanguageValue, @Language;

-- SET @FormID = 'SOR3005'
-- SET @LanguageValue = N'Đến khu vực';
-- EXEC ERP9AddLanguage @ModuleID, 'SOR3005.ToAreaID' , @FormID, @LanguageValue, @Language;

-- SET @FormID = 'SOR3005'
-- SET @LanguageValue = N'Chọn kỳ';
-- EXEC ERP9AddLanguage @ModuleID, 'SOR3005.CheckListPeriodControl' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3005'
SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR3005.AccountName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3005'
SET @LanguageValue = N'Khu vực';
EXEC ERP9AddLanguage @ModuleID, 'SOR3005.AreaID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'SOR3005'
SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOR3005.SalesManName' , @FormID, @LanguageValue, @Language;
