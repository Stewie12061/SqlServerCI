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
SET @FormID = 'HRMF2051'

SET @LanguageValue  = N'Quyết định tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số quyết định'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.RecDecisionNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã quyết định'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.RecDecisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.CandidateID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.RecruitPeriodID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã người đề nghị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.UserID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên người đề nghị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.UserName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người đề nghị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.CandidateName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.StatusName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức lương yêu cầu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.RequireSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lương thỏa thuận'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.DealSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thử việc từ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.TrialFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thử việc đến'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.TrialToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức làm việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.WorkTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giới tính'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.GenderName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng hôn nhân'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.MaterialStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sinh'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.Birthday',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.Attach',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày quyết định'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.DecisionDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế thừa đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.btnInherit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người duyệt'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.ApprovePerson',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2051.DepartmentID_Master',  @FormID, @LanguageValue, @Language;
