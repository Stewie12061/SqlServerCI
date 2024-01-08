DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1180'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục bộ định mức KIT'
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bộ định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.KITID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bộ định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.KITName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người thiết lập';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã người thiết lập';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.EmployeeID.CB',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Tên người thiết lập';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.EmployeeName.CB',  @FormID, @LanguageValue, @Language;



