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
SET @Language = 'zh-CN' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF0010';

SET @LanguageValue = N'設置模塊自增代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'候選人簡介';
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.CandidateVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招募計劃';
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.RecruitPlanVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作要求';
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.RecruitPeriodVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招募';
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.RecruitRequireVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試行程';
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.InterviewScheduleVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘決定';
EXEC ERP9AddLanguage @ModuleID, 'HRMF0010.RecDecisionVoucher', @FormID, @LanguageValue, @Language;

