DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2112'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết tính cách D.I.S.C'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức danh/vị trí';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.TitleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.EvaluationDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách D';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Nature_D',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách I';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Nature_I',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách S';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Nature_S',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách C';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Nature_C',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Nature',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách D';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Adaptive_D',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách I';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Adaptive_I',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách S';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Adaptive_S',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách C';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Adaptive_C',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Adaptive',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả tính cách';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Descriptions',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin tính cách cá nhân';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.NhomTinhCachCaNhan',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin tính cách tự nhiên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.NhomTinhCachTuNhien',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin tính cách thích ứng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.NhomTinhCachThichUng',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách tự nhiên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.GroupA',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách thích ứng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.GroupB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.TabCRMT00001',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Description',  @FormID, @LanguageValue, @Language;


