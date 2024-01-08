-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2042- HRM
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
SET @FormID = 'HRMF2042';

SET @LanguageValue = N'查看面試結果明細';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應聘人代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.CandidateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘批次代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.RecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建議的工資';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.RequireSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應聘信息';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.GroupInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'月';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Month', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'協議的工資';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.DealSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'可以接受工作的時間';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Startdate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'試用期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.TrialTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'自從';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.TrialFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'迄今';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.TrialToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應聘崗位名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘批次名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.RecruitPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應聘人姓名';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.CandidateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應聘崗位代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.ResultDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'自從';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'迄今';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.RecruitStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試時間';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewDate01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試時間';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewDate02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試時間';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewDate03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試時間';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewDate04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試時間';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewDate05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地點';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewAddress01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地點';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewAddress02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地點';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewAddress03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地點';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewAddress04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地點';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewAddress05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試批次代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeID01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試批次代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeID02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試批次代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeID03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試批次代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeID04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試批次代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeID05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試內容';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeName01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試內容';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeName02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試內容';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeName03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試內容';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeName04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試內容';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeName05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結果';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewStatus01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結果';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewStatus02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結果';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewStatus03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結果';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewStatus04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結果';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewStatus05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'評價';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Comment01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'評價';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Comment02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'評價';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Comment03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'評價';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Comment04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'評價';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Comment05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Attach', @FormID, @LanguageValue, @Language;

