DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1162'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết tài khoản'
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.AccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.AccountName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tài khoản (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.AccountNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm tài khoản ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.GroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.Notes1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.Notes2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không định khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.IsNotShow',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quản lý theo đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.IsObject',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1162.ThongTinTaiKhoan',  @FormID, @LanguageValue, @Language;



