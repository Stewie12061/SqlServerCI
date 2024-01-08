DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1161'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật tài khoản'
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.AccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.AccountName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tài khoản (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.AccountNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm tài khoản ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.GroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.Notes1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.Notes2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không định khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.IsNotShow',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quản lý theo đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.IsObject',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhóm tài khoản ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.GroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhóm tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1161.GroupName.CB',  @FormID, @LanguageValue, @Language;


