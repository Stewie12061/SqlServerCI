DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1201'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật nhóm thuế'
EXEC ERP9AddLanguage @ModuleID, 'CIF1201.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1201.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1201.VATGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1201.VATGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ lệ thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1201.VATRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1201.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1201.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1201.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1201.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1201.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1201.LastModifyUserID',  @FormID, @LanguageValue, @Language;


