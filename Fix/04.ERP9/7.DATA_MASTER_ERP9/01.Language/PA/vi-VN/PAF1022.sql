DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PA';
SET @FormID = 'PAF1022'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết thiết lập bảng đánh giá năng lực'
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.EvaluationKitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bảng đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.EvaluationKitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.TitleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.AppraisalID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.AppraisalName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.AppraisalGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm điểm';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.AppraisalGroupGoal',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức độ quan trọng';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.LevelCritical',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức năng lực tiêu chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.LevelStandardID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú mức năng lực tiêu chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.LevelStandardName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin thiết lập bảng đánh giá năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.ThietLapBangDanhGiaNangLuc',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chi tiết thiết lập bảng đánh giá năng lực';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.ChiTietThietLapBangDanhGiaNangLuc',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.EvaluationPhaseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'PAF1022.ToDate',  @FormID, @LanguageValue, @Language;