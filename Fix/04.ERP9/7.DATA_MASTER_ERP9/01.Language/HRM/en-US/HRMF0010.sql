-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF0010- HRM
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
SET @Language = 'en-US'; 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF0010';

SET @LanguageValue  = N'Set up auto increasing code module'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Candidate profile';
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.CandidateVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment plan';
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.RecruitPlanVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Job requirements';
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.RecruitPeriodVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.RecruitRequireVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview schedule';
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.InterviewScheduleVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiring decisions';
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.RecDecisionVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher Name'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;
