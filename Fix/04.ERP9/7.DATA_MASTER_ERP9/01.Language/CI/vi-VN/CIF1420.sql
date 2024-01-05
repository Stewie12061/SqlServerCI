DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1420'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục quy cách hàng hóa'
EXEC ERP9AddLanguage @ModuleID, 'CIF1420.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1420.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1420.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1420.StandardID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1420.StandardName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại quy cách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1420.StandardTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1420.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin thiết lập quy cách hàng hóa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1420.QuyCachHangHoa',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1420.StandardTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1420.StandardTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1420.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1420.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1420.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1420.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CIF1420.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'CIF1420.Description',  @FormID, @LanguageValue, @Language;