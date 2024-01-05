DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1160'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục tài khoản'
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.AccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.AccountName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tài khoản (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.AccountNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm tài khoản ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.GroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.Notes1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.Notes2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không định khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.IsNotShow',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quản lý theo đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.IsObject',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.CreateUserID',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Mã nhóm tài khoản ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.GroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhóm tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1160.GroupName.CB',  @FormID, @LanguageValue, @Language;



