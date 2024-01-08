DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PA';
SET @FormID = 'PAF1011'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật năng lực'
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.AppraisalID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.AppraisalName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thứ tự năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.OrderNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.AppraisalGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.AppraisalGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức độ quan trọng';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.LevelCritical',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số mức độ năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.LevelStandardNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức độ';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.LevelStandardID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức độ năng lực tiêu chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.LevelStandardIDPAT10103',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiêu chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.LevelStandardName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thêm vào từ điển năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.IsAddAppraisalDictionaryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.TargetsGroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.TargetsGroupName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thêm vào từ điển năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.IsAddAppraisalDictionaryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.EvaluationPhaseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.DivisionID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.DivisionName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.Percentage.CB',  @FormID, @LanguageValue, @Language;

