DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF1020'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục từ điển chỉ tiêu'
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.TargetsDictionaryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.TargetsDictionaryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.ClassificationID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.TargetsGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.UnitKpiID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công thức tính';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.FormulaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tần suất đo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.FrequencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn đo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.SourceID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.Categorize',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ trọng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.Percentage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.Revenue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngưỡng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.GoalLimit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin từ điển chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.ThongTinTuDienChiTieu',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nguồn';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.SourceID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nguồn';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.SourceName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.UnitKpiID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.UnitKpiName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.TargetsGroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.TargetsGroupName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ trọng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1020.Percentage.CB',  @FormID, @LanguageValue, @Language;

