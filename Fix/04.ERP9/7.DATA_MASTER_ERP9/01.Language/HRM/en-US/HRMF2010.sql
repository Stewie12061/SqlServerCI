-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2010- HRM
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
SET @Language = 'en-US' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2010';

SET @LanguageValue  = N'Job Requirements'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Job request code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.RecruitRequireID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Job request name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.RecruitRequireName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancies';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancies';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sex';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.Gender', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.FromAge', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.ToAge', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.EducationLevelID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Appearance';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.Appearance', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Experience';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.Experience', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'FromSalary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.FromSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Arrive';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.ToSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Describe job requirements';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.WorkDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language 1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.Language1ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language 2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.Language2ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language 3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.Language3ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language level 1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.LanguageLevel1ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language level 2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.LanguageLevel2ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language level 3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.LanguageLevel3ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Computer skill';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.IsInformatics', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creativity';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.IsCreativeness', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Presentation and persuasion skills';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.IsProblemSolving', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Presentation and persuasion skills';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.IsPrsentation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Communication skill';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.IsCommunication', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.InformaticsLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creativity';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.Creativeness', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Problem solving';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.ProblemSolving', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Prsentation';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.Prsentation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Communication';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.Communication', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Height';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Weight';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.Weight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Health status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.HealthStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From {0} to {1}';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty name'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.DutyName.CB',  @FormID, @LanguageValue, @Language;