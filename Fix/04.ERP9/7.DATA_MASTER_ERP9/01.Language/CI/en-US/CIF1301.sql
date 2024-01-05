DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1301'
---------------------------------------------------------------

SET @LanguageValue  = N'Update inventory norms'
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Norm ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.NormID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Normed type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Min Quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.MinQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Max Quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.MaxQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ReOrder Quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.ReOrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'CreateUser ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last Modify Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last Modify UserID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1301.LastModifyUserID',  @FormID, @LanguageValue, @Language;