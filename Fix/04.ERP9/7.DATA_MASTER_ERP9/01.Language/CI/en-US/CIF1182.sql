DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1182'
---------------------------------------------------------------

SET @LanguageValue  = N'Detail KIT'
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'KIT code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.KITID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'KIT name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.KITName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.EmployeeID.CB',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.EmployeeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Information KIT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.ThongTinDieuKhoanThanhToan',  @FormID, @LanguageValue, @Language;


