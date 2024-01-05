
DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1311'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật nhóm hàng'
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.GroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.AnaTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhóm hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.AnaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhóm hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.AnaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhóm hàng (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.AnaNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công thức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.RefDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Amount01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Note01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Amount02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Note02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Amount03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Note03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Amount04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Note04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Amount05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Note05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Amount06',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Note06',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Amount07',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Note07',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Amount08',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Note08',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Amount09',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Note09',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Amount10',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Note10',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngươi tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.AnaTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.AnaTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã PT phụ thuộc';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.ReAnaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.ReAnaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.ReAnaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.GroupID',  @FormID, @LanguageValue, @Language;

