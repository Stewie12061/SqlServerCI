DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1390'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục thiết lập công thức quy đổi'
EXEC ERP9AddLanguage @ModuleID, 'CIF1390.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1390.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1390.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã công thức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1390.FormulaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên công thức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1390.FormulaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1390.FormulaDes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1390.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1390.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1390.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1390.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1390.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CIF1390.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'CIF1390.Description',  @FormID, @LanguageValue, @Language;