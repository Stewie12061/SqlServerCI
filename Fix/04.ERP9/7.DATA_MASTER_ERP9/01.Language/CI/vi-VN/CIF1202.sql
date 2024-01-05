DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1202'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết nhóm thuế'
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.VATGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.VATGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ lệ thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.VATRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1202.ThongTinNhomThue',  @FormID, @LanguageValue, @Language;


