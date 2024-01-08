DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1212'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết quốc gia'
EXEC ERP9AddLanguage @ModuleID, 'CIF1212.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1212.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'CIF1212.CountryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'CIF1212.CountryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1212.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1212.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1212.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1212.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1212.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1212.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'CIF1212.ThongTinQuocGia',  @FormID, @LanguageValue, @Language;


