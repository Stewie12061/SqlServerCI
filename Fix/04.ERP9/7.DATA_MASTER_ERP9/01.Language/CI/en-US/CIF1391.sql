DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1391'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật thiết lập công thức quy đổi'
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã công thức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.FormulaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên công thức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.FormulaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.FormulaDes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khai báo tham số';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.KhaiBaoThamSo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thiết lập công thức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.ThietLapCongThuc',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên gốc';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.SystemName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Định nghĩa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.UserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Định nghĩa tiếng Anh';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.UserNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1391.IsUsed',  @FormID, @LanguageValue, @Language;