DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1310'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục nhóm hàng'
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.GroupIDName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.AnaTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhóm hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.AnaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhóm hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.AnaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhóm hàng (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.AnaNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công thức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.RefDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount06',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note06',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount07',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note07',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount08',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note08',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount09',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note09',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount10',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note10',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngươi tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.AnaTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.AnaTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.GroupID',  @FormID, @LanguageValue, @Language;




