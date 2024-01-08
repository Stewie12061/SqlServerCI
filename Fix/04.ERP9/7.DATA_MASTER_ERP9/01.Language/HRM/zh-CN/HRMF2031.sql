-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2031- HRM
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
SET @FormID = 'HRMF2031';

SET @LanguageValue = N'更新面試時間表';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試時間表代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.InterviewScheduleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試輪';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.InterviewLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘批次代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.RecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招募';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.RecruitPeriodName', @FormID, @LanguageValue, @Language;

