DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1312'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết nhóm hàng'
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.GroupIDName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.AnaTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhóm hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.AnaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhóm hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.AnaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhóm hàng (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.AnaNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công thức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.RefDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount06',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note06',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount07',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note07',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount08',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note08',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount09',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note09',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount10',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note10',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.IsCommon',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Thông tin nhóm hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.ThongTinMaPhanTich',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã PT Phụ thuộc';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.ReAnaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã PT phụ thuộc';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.ReAnaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng Thái';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Description',  @FormID, @LanguageValue, @Language;



