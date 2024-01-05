DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF1050'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục chỉ tiêu'
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.TargetsID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.TargetsName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.ClassificationID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.TargetsGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.UnitKpiID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải cách tính';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.FormulaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tần suất đo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.FrequencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn đo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.SourceID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.Categorize',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ trọng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.Percentage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.Revenue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngưỡng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.GoalLimit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nguồn';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.SourceID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nguồn';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.SourceName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.UnitKpiID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.UnitKpiName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.TargetsGroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.TargetsGroupName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ trọng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.Percentage.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thêm vào từ điển chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.IsAddTargetsDictionaryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.Benchmark',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu phòng ban/công ty';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.MainTargetID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.EvaluationPhaseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.DivisionID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1050.DivisionName.CB',  @FormID, @LanguageValue, @Language;


