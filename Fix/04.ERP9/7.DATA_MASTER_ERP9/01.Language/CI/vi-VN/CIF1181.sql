DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1181'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật bộ định mức KIT'
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bộ định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.KITID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bộ định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.KITName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người thiết lập';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.EmployeeID',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Mã người thiết lập';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.EmployeeID.CB',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Tên người thiết lập';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.EmployeeName.CB',  @FormID, @LanguageValue, @Language;



