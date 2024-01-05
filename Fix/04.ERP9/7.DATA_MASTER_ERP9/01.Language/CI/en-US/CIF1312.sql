DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1312'
---------------------------------------------------------------

SET @LanguageValue  = N'View detail analyst'
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.GroupIDName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Analyst type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.AnaTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Analyst ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.AnaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Analyst name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.AnaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Analyst name (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.AnaNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Reference date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.RefDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount 6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount06',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note 6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note06',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount 7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount07',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note 7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note07',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount 8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount08',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note 8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note08',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount 9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount09',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note 9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note09',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Amount 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount10',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note10',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'IsCommon';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Analyst infomation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.ThongTinMaPhanTich',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Reference analyst';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.ReAnaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Reference analyst';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.ReAnaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Description',  @FormID, @LanguageValue, @Language;



