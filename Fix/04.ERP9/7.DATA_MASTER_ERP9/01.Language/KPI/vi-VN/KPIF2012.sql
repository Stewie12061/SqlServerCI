DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF2012'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết tính thưởng'
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.EvaluationPhaseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng tiền thưởng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.TotalBonusAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.EvaluationPhaseName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin tính thưởng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.ThongTinTinhThuong',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chi tiết tính thưởng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.ThongTinChiTietTinhThuong',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng đánh giá KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.EvaluationSetID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bảng đánh giá KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.EvaluationSetName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.TitleName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng điểm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.TotalUnifiedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xếp loại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.ClassificationUnifiedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức thưởng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.Revenue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ lệ thưởng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.BonusRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiến thưởng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.BonusAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.TabCRMT00003',  @FormID, @LanguageValue, @Language;


