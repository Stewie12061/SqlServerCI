DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1272'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết loại đối tượng'
EXEC ERP9AddLanguage @ModuleID, 'CIF1272.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1272.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1272.ObjectTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1272.ObjectTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1272.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1272.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1272.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1272.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1272.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1272.LastModifyUserID',  @FormID, @LanguageValue, @Language;


    SET @LanguageValue = N'Thông tin loại đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1272.ThongTinLoaiDoiTuong' , @FormID, @LanguageValue, @Language;


