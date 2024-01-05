declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'vi-VN'
SET @FormID = 'CRMR3019'

SET @LanguageValue = N'Báo cáo tổng marketing và sales';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3019.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3019.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3019.CampaignID' , @FormID, @LanguageValue, @Language;
