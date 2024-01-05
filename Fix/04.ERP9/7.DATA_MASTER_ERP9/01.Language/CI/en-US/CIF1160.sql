DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1160'
---------------------------------------------------------------

SET @LanguageValue  = N'Account categories'
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.AccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.AccountName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account name (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.AccountNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.GroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.Notes1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.Notes2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Indeterminate';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.IsNotShow',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Managed by object';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.IsObject',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account group code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.GroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account group name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.GroupName.CB',  @FormID, @LanguageValue, @Language;



