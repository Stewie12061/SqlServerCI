declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'vi-VN'

SET @FormID = 'CRMF3010'
SET @LanguageValue = N'Khách hàng mới theo nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3010.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3010'
SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3010.FromDate' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3010'
SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3010.ToDate', @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3010'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3010.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3010'
SET @LanguageValue = N'Từ khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3010.FromAccountID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3010'
SET @LanguageValue = N'Đến khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3010.ToAccountID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3010'
SET @LanguageValue = N'Từ nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3010.FromEmployeeID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3010'
SET @LanguageValue = N'Đến nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3010.ToEmployeeID' , @FormID, @LanguageValue, @Language;
