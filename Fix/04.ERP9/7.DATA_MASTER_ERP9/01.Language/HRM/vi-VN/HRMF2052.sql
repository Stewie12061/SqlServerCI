-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1032- OO
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT


------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
------------------------------------------------------------------------------------------------------
/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/


SET @Language = 'vi-VN';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2052'

SET @LanguageValue  = N'Quyết định tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số quyết định'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.RecDecisionNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.CandidateID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.RecruitPeriodID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.Department',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã người đề nghị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.UserID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên người đề nghị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.UserName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người đề nghị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày quyết định'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.DecisionDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin quyết định tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.TabThongTinQuyetDinhTuyenDung',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chi tiết'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.TabThongTinChiTiet',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.TabCMNT90051',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.CandidateName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.TabCRMT00001',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.StatusName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức lương yêu cầu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.RequireSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lương thoả thuận'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.DealSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thử việc từ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.TrialFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thử việc đến'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.TrialToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức làm việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.WorkTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giới tính'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.GenderName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sinh'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.Birthday',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng hôn nhân'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2052.MaterialStatus',  @FormID, @LanguageValue, @Language;