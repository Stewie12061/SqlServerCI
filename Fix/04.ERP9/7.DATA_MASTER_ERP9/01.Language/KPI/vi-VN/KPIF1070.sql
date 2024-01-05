DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF1070'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục thiết lập bảng đánh giá KPI'
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.EvaluationSetID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bảng đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.EvaluationSetName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.TitleID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.TitleName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.TitleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.EvaluationPhaseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bảng đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sao chép';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.SaveCopy',  @FormID, @LanguageValue, @Language;


