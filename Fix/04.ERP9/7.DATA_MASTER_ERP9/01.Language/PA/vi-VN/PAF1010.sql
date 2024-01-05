DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PA';
SET @FormID = 'PAF1010'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục năng lực'
EXEC ERP9AddLanguage @ModuleID, 'PAF1010.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'PAF1010.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1010.AppraisalID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1010.AppraisalName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1010.AppraisalGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'PAF1010.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'PAF1010.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'PAF1010.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức độ năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1010.LevelCritical',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số mức độ năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1010.LevelStandardNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1010.TargetsGroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1010.AppraisalGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1010.TargetsGroupName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'PAF1010.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF1010.EvaluationPhaseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF1010.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF1010.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'PAF1010.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'PAF1010.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'PAF1010.DepartmentName.CB',  @FormID, @LanguageValue, @Language;
