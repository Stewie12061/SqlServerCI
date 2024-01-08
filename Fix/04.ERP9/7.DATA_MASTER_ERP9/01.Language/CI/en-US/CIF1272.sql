DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1272'
---------------------------------------------------------------

SET @LanguageValue  = N'Detail object type'
EXEC ERP9AddLanguage @ModuleID, 'CIF1272.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1272.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1272.ObjectTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Object type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1272.ObjectTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1272.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1272.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1272.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1272.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1272.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1272.CreateUserID',  @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Information object type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1272.ThongTinLoaiDoiTuong' , @FormID, @LanguageValue, @Language;


