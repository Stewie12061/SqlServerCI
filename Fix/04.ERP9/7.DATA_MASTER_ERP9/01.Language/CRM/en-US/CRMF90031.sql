-- [Đình Hòa] [26/02/2021] - Bổ sung ngôn ngữ

declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'en-US'


SET @FormID = 'CRMF90031'
SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CRMF90031.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'CRMF90031.TypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF90031.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Event Subject';
EXEC ERP9AddLanguage @ModuleID, 'CRMF90031.EventSubject' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Location';
EXEC ERP9AddLanguage @ModuleID, 'CRMF90031.Location' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Event StartDate';
EXEC ERP9AddLanguage @ModuleID, 'CRMF90031.EventStartDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF90031.EventStatus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'CRMF90031.PriorityID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Event EndDate';
EXEC ERP9AddLanguage @ModuleID, 'CRMF90031.EventEndDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type Active';
EXEC ERP9AddLanguage @ModuleID, 'CRMF90031.TypeActive' , @FormID, @LanguageValue, @Language;



