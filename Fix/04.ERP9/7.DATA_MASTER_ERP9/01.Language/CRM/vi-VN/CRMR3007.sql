declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'vi-VN'

SET @FormID = 'CRMR3007'
SET @LanguageValue = N'Thống kê cơ hội theo ngành nghề';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3007.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3007'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3007.DivisionID' , @FormID, @LanguageValue, @Language;

-- SET @FormID = 'CRMR3007'
-- SET @LanguageValue = N'Từ lĩnh vực';
-- EXEC ERP9AddLanguage @ModuleID, 'CRMR3007.FromBusinessLinesID' , @FormID, @LanguageValue, @Language;

-- SET @FormID = 'CRMR3007'
-- SET @LanguageValue = N'Đến lĩnh vực';
-- EXEC ERP9AddLanguage @ModuleID, 'CRMR3007.ToBusinessLinesID' , @FormID, @LanguageValue, @Language;

-- SET @FormID = 'CRMR3007'
-- SET @LanguageValue = N'Từ nhân viên';
-- EXEC ERP9AddLanguage @ModuleID, 'CRMR3007.FromSalesManName' , @FormID, @LanguageValue, @Language;

-- SET @FormID = 'CRMR3007'
-- SET @LanguageValue = N'Đến nhân viên';
-- EXEC ERP9AddLanguage @ModuleID, 'CRMR3007.ToSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3007'
SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3007.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3007'
SET @LanguageValue = N'Lĩnh vực';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3007.BusinessLinesID' , @FormID, @LanguageValue, @Language;
