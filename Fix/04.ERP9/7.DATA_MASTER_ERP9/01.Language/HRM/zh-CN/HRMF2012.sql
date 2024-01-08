-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2012- HRM
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
SET @FormID = 'HRMF2012';

SET @LanguageValue = N'查看工作要求明細';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作要求代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.RecruitRequireID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作要求名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.RecruitRequireName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'&A 建立结转';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'位置名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性別';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Gender', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'是的_';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.FromAge', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到達';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.ToAge', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文化水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.EducationLevelID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外貌';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Appearance', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'經驗';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Experience', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'是的_';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.FromSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到達';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.ToSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作要求描述';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.WorkDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外語1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Language1ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外語2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Language2ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外語3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Language3ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'1級外語水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.LanguageLevel1ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'2級外語水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.LanguageLevel2ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'3級外語水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.LanguageLevel3ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電腦水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.IsInformatics', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創造力';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.IsCreativeness', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'解決工作的能力';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.IsProblemSolving', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'陳述和說服能力';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.IsPrsentation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'溝通能力';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.IsCommunication', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'內容';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.InformaticsLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'內容';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Creativeness', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'內容';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.ProblemSolving', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'內容';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Prsentation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'內容';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Communication', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'高度';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'重量';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Weight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'健康狀況';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.HealthStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.APK', @FormID, @LanguageValue, @Language;

