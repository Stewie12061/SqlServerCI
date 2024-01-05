DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PA';
SET @FormID = 'PAF1012'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết năng lực'
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.AppraisalID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.AppraisalName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thứ tự năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.OrderNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.AppraisalGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.AppraisalGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thêm vào từ điển năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.IsAddAppraisalDictionaryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức độ quan trọng';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.LevelCritical',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số mức độ năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.LevelStandardNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức độ';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.LevelStandardID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức độ năng lực tiêu chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.LevelStandardIDPAT10103',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiêu chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.LevelStandardName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.TargetsGroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.TargetsGroupName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.TabThongTinNangLuc',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chi tiết năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.ThongTinChiTietNangLuc',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin mực độ năng lực tiêu chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.TabThongTinMucDoNangLucTieuChuan',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.TabCRMT00002',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.TabCRMT90031',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF1012.EvaluationPhaseID',  @FormID, @LanguageValue, @Language;