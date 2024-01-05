DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1302'
---------------------------------------------------------------

SET @LanguageValue  = N'View inventory norms in detail'
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Norm ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.NormID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Normed type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Min Quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.MinQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Max Quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.MaxQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ReOrder Quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.ReOrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'CreateUser ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last Modify Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last Modify UserID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Norm code information';
EXEC ERP9AddLanguage @ModuleID, 'CIF1302.ThongTinMaDinhMuc',  @FormID, @LanguageValue, @Language;