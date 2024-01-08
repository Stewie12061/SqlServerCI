DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF2011'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật tính thưởng'
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.EvaluationPhaseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng tiền thưởng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.TotalBonusAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.EvaluationPhaseName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng đánh giá KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.EvaluationSetID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng đánh giá KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.EvaluationSetName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.TitleName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng điểm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.TotalUnifiedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xếp loại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.ClassificationUnifiedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức thưởng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.Revenue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ lệ thưởng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.BonusRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiến thưởng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.BonusAmount',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Mã đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.DepartmentName.CB',  @FormID, @LanguageValue, @Language;


