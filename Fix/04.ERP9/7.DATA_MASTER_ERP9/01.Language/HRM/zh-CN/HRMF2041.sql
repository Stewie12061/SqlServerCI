-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2041- HRM
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
SET @FormID = 'HRMF2041';

SET @LanguageValue = N'更新面試結果';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應聘人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.CandidateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招募';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.RecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建議的工資';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.RequireSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應聘信息';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.GroupInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'月';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Month', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'協議的工資';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.DealSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'可以接受工作的時間';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Startdate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'試用期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.TrialTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'自從';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.TrialFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'迄今';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.TrialToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應聘崗位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘批次名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.RecruitPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應聘人姓名';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.CandidateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應聘崗位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.ResultDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'自從';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'迄今';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.RecruitStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試時間';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewDate01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試時間';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewDate02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試時間';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewDate03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試時間';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewDate04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試時間';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewDate05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地點';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewAddress01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地點';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewAddress02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地點';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewAddress03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地點';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewAddress04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地點';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewAddress05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試批次代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeID01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試批次代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeID02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試批次代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeID03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試批次代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeID04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試批次代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeID05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試內容';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeName01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試內容';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeName02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試內容';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeName03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試內容';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeName04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試內容';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeName05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結果';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewStatus01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結果';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewStatus02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結果';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewStatus03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結果';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewStatus04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結果';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewStatus05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'評價';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Comment01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'評價';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Comment02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'評價';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Comment03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'評價';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Comment04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'評價';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Comment05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'附';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Attach', @FormID, @LanguageValue, @Language;

