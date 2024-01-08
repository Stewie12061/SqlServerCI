DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1161'
---------------------------------------------------------------

SET @LanguageValue  = N'Update account'
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.AccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.AccountName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account name (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.AccountNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.GroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.Notes1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.Notes2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Indeterminate';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.IsNotShow',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Managed by object';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.IsObject',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account group code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.GroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account group name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.GroupName.CB',  @FormID, @LanguageValue, @Language;

