DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1180'
---------------------------------------------------------------

SET @LanguageValue  = N'Category KIT'
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'KIT code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.KITID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'KIT name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.KITName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.EmployeeID.CB',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.EmployeeName.CB',  @FormID, @LanguageValue, @Language;



