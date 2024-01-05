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
SET @FormID = 'HRMF0010'

SET @LanguageValue  = N'Thiết lập mã tăng tự động module'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hồ sơ ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.CandidateVoucher',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế hoạch tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.RecruitPlanVoucher',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.RecruitPeriodVoucher',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.RecruitRequireVoucher',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.InterviewScheduleVoucher',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quyết định tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.RecDecisionVoucher',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;