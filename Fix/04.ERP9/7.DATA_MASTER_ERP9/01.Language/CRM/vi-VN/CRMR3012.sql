declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'vi-VN'

SET @FormID = 'CRMR3012'
SET @LanguageValue = N'Kết quả chiến dịch marketing (kế hoạch và thực tế)';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3012.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3012'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3012.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3012'
SET @LanguageValue = N'Từ chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3012.FromCampaignID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3012'
SET @LanguageValue = N'Đến chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3012.ToCampaignID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3012'
SET @LanguageValue = N'Từ chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3012.FromCampaignName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3012'
SET @LanguageValue = N'Đến chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3012.ToCampaignName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3012'
SET @LanguageValue = N'Chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3012.CampaignName' , @FormID, @LanguageValue, @Language;


