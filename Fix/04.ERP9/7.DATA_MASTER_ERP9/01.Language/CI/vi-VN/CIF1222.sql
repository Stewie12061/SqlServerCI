DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1222'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết vùng khu vực'
EXEC ERP9AddLanguage @ModuleID, 'CIF1222.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1222.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vùng - khu vực';
EXEC ERP9AddLanguage @ModuleID, 'CIF1222.AreaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên vùng - khu vực';
EXEC ERP9AddLanguage @ModuleID, 'CIF1222.AreaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1222.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1222.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1222.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1222.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1222.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1222.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin khu vực';
EXEC ERP9AddLanguage @ModuleID, 'CIF1222.ThongTinKhuVuc',  @FormID, @LanguageValue, @Language;


