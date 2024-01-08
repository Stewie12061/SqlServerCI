-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2055- OO
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
SET @FormID = 'HRMF2055'
---------------------------------------------------------------

SET @LanguageValue  = N'Xác nhận tuyển dụng ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'APK'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.APK',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.CandidateID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.CandidateName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức lương thảo thuận'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.DealSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày quyết định'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.DecisionDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số quyết định'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.RecDecisionNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.RecruitPeriodID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.RecruitPeriodName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.RecruitStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.RecruitStatusName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức lương thỏa thuận'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.RequireSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian có thể bắt đầu nhận việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.StartDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.TrialFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian thử việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.TrialTime',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.TrialToDate',  @FormID, @LanguageValue, @Language;

