DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PA';
SET @FormID = 'PAF2002'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết đánh giá năng lực'
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.EvaluationPhaseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng đánh giá năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.EvaluationKitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng đánh giá năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.EvaluationKitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.TitleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.ConfirmUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ý kiến người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.ConfirmComments',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin đánh giá năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.DanhGiaNangLuc',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chi tiết đánh giá năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.ChiTietDanhGiaNangLuc',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.AppraisalGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.AppraisalName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức độ quan trọng';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.LevelCritical',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức năng lực tiêu chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.LevelStandardID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.Benchmark',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức năng lực đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.Perform',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức năng lực đánh giá lại';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.Reevaluated',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.PerformPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm đánh giá lại';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.ReevaluatedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm thống nhất';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.UnifiedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bằng chứng cụ thể';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.EvidenceNote',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.TotalPerformPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm đánh giá lại';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.TotalReevaluatedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm thống nhất';
EXEC ERP9AddLanguage @ModuleID, 'PAF2002.TotalUnifiedPoint',  @FormID, @LanguageValue, @Language;

