DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1310'
---------------------------------------------------------------

SET @LanguageValue  = N'List of analyst'
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.GroupIDName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Analyst type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.AnaTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Analyst ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.AnaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Analyst name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.AnaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Analyst name (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.AnaNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Reference date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.RefDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount 6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount06',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note 6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note06',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount 7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount07',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note 7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note07',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount 8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount08',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note 8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note08',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount 9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount09',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note 9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note09',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount10',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note10',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'IsCommon';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Type ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.AnaTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.AnaTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.GroupID',  @FormID, @LanguageValue, @Language;




