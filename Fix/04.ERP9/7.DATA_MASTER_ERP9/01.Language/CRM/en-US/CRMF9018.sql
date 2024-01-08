DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9018';
---------------------------------------------------------------

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Feedback Description';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.FeedbackDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is Common';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kind of Support Ticket';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.KindID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kind of Support Ticket';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.KindName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request Description';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.RequestDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Support Dictionary ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.SupportDictionaryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Support Dictionary Subject';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.SupportDictionarySubject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time Feedback';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.TimeFeedback', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time Feedback';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.TimeFeedbackName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Choose Support Dictionary';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9018.Title', @FormID, @LanguageValue, @Language;
