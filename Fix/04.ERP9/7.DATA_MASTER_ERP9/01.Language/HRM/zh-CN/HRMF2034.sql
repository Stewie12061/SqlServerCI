-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2034- HRM
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
SET @FormID = 'HRMF2034';

SET @LanguageValue = N'選擇招聘批次';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'行数';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.RowNum', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TotalRow';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.TotalRow', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘批次代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.RecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘批次名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.RecruitPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘崗位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘崗位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試輪';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.InterviewLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地點';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.InterviewAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招募計劃';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.RecruitPlanID', @FormID, @LanguageValue, @Language;

