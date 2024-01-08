declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'vi-VN'

SET @FormID = 'CRMF3040'
SET @LanguageValue = N'Khách hàng không phát sinh đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3040.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3040'
SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3040.FromDate' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3040'
SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3040.ToDate', @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3040'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3040.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3040'
SET @LanguageValue = N'Từ khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3040.FromAccountID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3040'
SET @LanguageValue = N'Đến khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3040.ToAccountID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3040'
SET @LanguageValue = N'Từ nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3040.FromEmployeeID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3040'
SET @LanguageValue = N'Đến nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3040.ToEmployeeID' , @FormID, @LanguageValue, @Language;
