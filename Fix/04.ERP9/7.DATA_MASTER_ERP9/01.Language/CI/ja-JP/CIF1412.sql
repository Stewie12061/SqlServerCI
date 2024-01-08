DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'ja-JP';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1412'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục thiết lập quy cách hàng hóa'
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.IsUsed',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên gốc';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.SystemName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại quy cách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.TypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại quy cách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.UserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại quy cách (tiếng Anh)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.UserNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phụ phí';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.IsExtraFee',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin thiết lập quy cách hàng hóa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.ThongTinThietLapQCHH',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'CIF1412.Description',  @FormID, @LanguageValue, @Language;