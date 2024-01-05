DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9008'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn chiến dịch'
EXEC ERP9AddLanguage @ModuleID, 'CRMF9008.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9008.CampaignID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9008.CampaignName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9008.ExpectCloseDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9008.CampaignStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Doanh số kỳ vọng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9008.ExpectedRevenue',  @FormID, @LanguageValue, @Language;
