declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'vi-VN'
SET @FormID = 'CRMR3021'

SET @LanguageValue = N'Báo cáo marketing và sales theo năm';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3021.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3021.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3021.CampaignTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm(Số)';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3021.Year' , @FormID, @LanguageValue, @Language;
