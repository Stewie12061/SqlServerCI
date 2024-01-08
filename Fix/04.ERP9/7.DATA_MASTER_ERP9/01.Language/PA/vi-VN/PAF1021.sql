DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PA';
SET @FormID = 'PAF1021'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật thiết lập bảng đánh giá năng lực'
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.EvaluationKitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bảng đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.EvaluationKitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.TitleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.AppraisalID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.AppraisalName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.AppraisalGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm điểm';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.AppraisalGroupGoal',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức độ quan trọng';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.LevelCritical',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức năng lực tiêu chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.LevelStandardID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú mức năng lực tiêu chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.LevelStandardName',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.TitleID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.TitleName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.AppraisalID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.AppraisalName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhóm năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.TargetsGroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhóm năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.TargetsGroupName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.Percentage.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mực năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.LevelStandardID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú mức năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.LevelStandardName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.EvaluationPhaseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.DivisionID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'PAF1021.DivisionName.CB',  @FormID, @LanguageValue, @Language;


