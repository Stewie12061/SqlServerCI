DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1162'
---------------------------------------------------------------

SET @LanguageValue  = N'View account details'
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.AccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.AccountName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account name (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.AccountNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.GroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.Notes1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.Notes2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Indeterminate';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.IsNotShow',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Managed by object';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.IsObject',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account information';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.ThongTinTaiKhoan',  @FormID, @LanguageValue, @Language;



