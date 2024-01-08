-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2011- HRM
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
SET @FormID = 'HRMF2011';

SET @LanguageValue = N'更新工作要求';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作要求代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.RecruitRequireID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作要求名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.RecruitRequireName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'&A 建立结转';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'位置名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性別';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Gender', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'是的_';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.FromAge', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到達';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.ToAge', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文化水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.EducationLevelID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外貌';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Appearance', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'經驗';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Experience', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'是的_';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.FromSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到達';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.ToSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作要求描述';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.WorkDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外語1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Language1ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外語2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Language2ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外語3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Language3ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'1級外語水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.LanguageLevel1ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'2級外語水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.LanguageLevel2ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'3級外語水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.LanguageLevel3ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電腦水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.IsInformatics', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創造力';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.IsCreativeness', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'解決工作的能力';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.IsProblemSolving', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'陳述和說服能力';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.IsPrsentation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'溝通能力';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.IsCommunication', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'內容';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.InformaticsLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'內容';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Creativeness', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'內容';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.ProblemSolving', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'內容';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Prsentation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'內容';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Communication', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'高度';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'重量';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Weight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'健康狀況';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.HealthStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.APK', @FormID, @LanguageValue, @Language;

