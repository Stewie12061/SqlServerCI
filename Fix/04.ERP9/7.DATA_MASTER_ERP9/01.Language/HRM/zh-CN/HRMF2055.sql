-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2055- HRM
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
SET @FormID = 'HRMF2055';

SET @LanguageValue = N'確認招聘應聘人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APK';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招募';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.RecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘崗位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘情況';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.RecruitStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應聘人代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.CandidateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'決定編號';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.RecDecisionNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應聘人姓名';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.CandidateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招募';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.RecruitPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘崗位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘情況';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.RecruitStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'決定日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.DecisionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建議的工資';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.RequireSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'協議的工資';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.DealSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'可以開始接受工作的時間';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'試用期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.TrialTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'自從';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.TrialFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'迄今';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.TrialToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2055.APKCandidateID', @FormID, @LanguageValue, @Language;

