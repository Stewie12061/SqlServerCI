DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1200'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục nhóm thuế'
EXEC ERP9AddLanguage @ModuleID, 'CIF1200.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1200.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1200.VATGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1200.VATGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ lệ thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1200.VATRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1200.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1200.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1200.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1200.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1200.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1200.LastModifyUserID',  @FormID, @LanguageValue, @Language;


