DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF1012'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết nhóm chỉ tiêu'
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.TargetsGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.TargetsGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thứ tự nhóm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.OrderNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.TargetsTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ trọng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.Percentage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.Goal',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.ThongTinNhomChiTieu',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đánh giá KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.RatedKPI',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đánh giá năng lực';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.RatedCapacity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.EvaluationPhaseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chi tiết nhóm chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.ChiTietThongTinNhomChiTieu',  @FormID, @LanguageValue, @Language;




