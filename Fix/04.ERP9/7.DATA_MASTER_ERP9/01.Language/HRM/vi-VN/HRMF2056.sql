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
SET @FormID = 'HRMF2056'

SET @LanguageValue  = N'Duyệt quyết định tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số quyết định'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.RecDecisionNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã quyết định'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.RecDecisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.CandidateID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.RecruitPeriodID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã người đề nghị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.UserID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên người đề nghị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.UserName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người đề nghị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.CandidateName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.StatusName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức lương yêu cầu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.RequireSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lương thỏa thuận'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.DealSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thử việc từ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.TrialFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thử việc đến'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.TrialToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức làm việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.WorkTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giới tính'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.GenderName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng hôn nhân'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.MaterialStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sinh'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.Birthday',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày quyết định'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.DecisionDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2056.StatusOOT9001',  @FormID, @LanguageValue, @Language;