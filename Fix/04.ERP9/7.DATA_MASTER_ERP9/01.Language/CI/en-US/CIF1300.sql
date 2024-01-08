DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1300'
---------------------------------------------------------------

SET @LanguageValue  = N'List of inventory norm types'
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Norm ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.NormID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Normed type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Min Quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.MinQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Max Quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.MaxQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ReOrder Quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.ReOrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'CreateUser ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last Modify Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last Modify UserID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1300.LastModifyUserID',  @FormID, @LanguageValue, @Language;