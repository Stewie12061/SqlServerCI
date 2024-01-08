DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PA';
SET @FormID = 'PAF1002'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết từ điển năng lực'
EXEC ERP9AddLanguage @ModuleID, 'PAF1002.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'PAF1002.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1002.AppraisalDictionaryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1002.AppraisalDictionaryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1002.AppraisalGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1002.AppraisalGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'PAF1002.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'PAF1002.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'PAF1002.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức độ năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1002.LevelCritical',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số mức độ năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1002.LevelStandardNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức độ';
EXEC ERP9AddLanguage @ModuleID, 'PAF1002.LevelStandardID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiêu chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'PAF1002.LevelStandardName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1002.TargetsGroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1002.TargetsGroupName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'PAF1002.TabCRMT00003',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'PAF1002.TabCRMT90031',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'PAF1002.TabCRMT00002',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Thông tin từ điển năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1002.TabThongTinTuDienNangLuc',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin mức độ năng lực tiêu chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'PAF1002.TabThongTinMucDoNangLucTieuChuan',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'PAF1002.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'PAF1002.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'PAF1002.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'PAF1002.LastModifyUserID',  @FormID, @LanguageValue, @Language;