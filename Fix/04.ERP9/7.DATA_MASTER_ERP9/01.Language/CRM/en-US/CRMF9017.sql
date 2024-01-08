DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9017'
---------------------------------------------------------------

SET @LanguageValue  = N'Choose group receiver'
EXEC ERP9AddLanguage @ModuleID, 'CRMF9017.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Group receiver ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9017.GroupReceiverID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'TGroup receiver name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9017.GroupReceiverName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9017.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9017.IsCommon',  @FormID, @LanguageValue, @Language;

