DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PA';
SET @FormID = 'PAF1020'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục thiết lập bảng đánh giá năng lực'
EXEC ERP9AddLanguage @ModuleID, 'PAF1020.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'PAF1020.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bảng đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF1020.EvaluationKitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bảng đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF1020.EvaluationKitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'PAF1020.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'PAF1020.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'PAF1020.TitleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'PAF1020.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'PAF1020.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'PAF1020.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'PAF1020.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'PAF1020.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'PAF1020.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'PAF1020.LastModifyDate',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'PAF1020.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'PAF1020.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'PAF1020.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'PAF1020.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'PAF1020.TitleID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'PAF1020.TitleName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF1020.EvaluationPhaseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF1020.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'PAF1020.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;


