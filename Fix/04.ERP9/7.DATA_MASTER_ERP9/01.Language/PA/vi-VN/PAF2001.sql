DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PA';
SET @FormID = 'PAF2001'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật đánh giá năng lực'
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp trên đánh giá lại'
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.Title2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.EvaluationPhaseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng đánh giá năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.EvaluationKitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng đánh giá năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.EvaluationKitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.TitleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.ConfirmUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ý kiến người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.ConfirmComments',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.AppraisalGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.AppraisalID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.AppraisalName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức độ quan trọng';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.LevelCritical',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức năng lực tiêu chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.LevelStandardID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.Benchmark',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức năng lực đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.Perform',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức năng lực đánh giá lại';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.Reevaluated',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.PerformPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm đánh giá lại';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.ReevaluatedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm thống nhất';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.UnifiedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bằng chứng cụ thể';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.EvidenceNote',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng điểm';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.LanguageTD',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.TitleID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.TitleName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.EmployeeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.EmployeeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.EvaluationKitID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bảng đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.EvaluationKitName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.TotalPerformPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm đánh giá lại';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.TotalReevaluatedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm thống nhất';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.TotalUnifiedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đánh giá tái tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.IsRecruitment',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức độ';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.LevelStandardID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiêu chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.LevelStandardName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng đánh giá năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.RecruitEvaluationKitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF2001.RecruitEvaluationPhaseID',  @FormID, @LanguageValue, @Language;