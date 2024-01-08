-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2054- HRM
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
SET @FormID = 'HRMF2054';

SET @LanguageValue = N'招募確認';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APK';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘批次代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.RecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘崗位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.RecruitStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應聘人代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.CandidateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'決定編號';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.RecDecisionNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應聘人姓名';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.CandidateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招募';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.RecruitPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘崗位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.RecruitStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'描述';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'決定日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.DecisionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'要求薪水';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.RequireSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DealSalary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.DealSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開始日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TrailTime';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.TrialTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TrialFromDate';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.TrialFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TrialToDate';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.TrialToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2054.APKCandidateID', @FormID, @LanguageValue, @Language;

