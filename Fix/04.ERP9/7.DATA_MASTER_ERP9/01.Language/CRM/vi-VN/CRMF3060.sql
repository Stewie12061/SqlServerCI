declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'vi-VN'

SET @FormID = 'CRMF3060'
SET @LanguageValue = N'Thống kê chu kỳ đặt nước theo khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3060.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3060'
SET @LanguageValue = N'Từ khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3060.FromAccountID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3060'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3060.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3060'
SET @LanguageValue = N'Đến khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3060.ToAccountID' , @FormID, @LanguageValue, @Language;