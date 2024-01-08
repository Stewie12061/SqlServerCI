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
SET @Language = 'en-US' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2011';

SET @LanguageValue  = N'Job Requirement Update'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Job request code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.RecruitRequireID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Job request name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.RecruitRequireName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Location code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Location name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sex';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Gender', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From age';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.FromAge', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Arrive';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.ToAge', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Academic level';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.EducationLevelID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Appearance';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Appearance', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Experience';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Experience', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From salary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.FromSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To salary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.ToSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Describe job requirements';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.WorkDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language 1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Language1ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language 2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Language2ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language 3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Language3ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language level 1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.LanguageLevel1ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language level 2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.LanguageLevel2ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language level';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.LanguageLevel3ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Computer skill';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.IsInformatics', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creativity';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.IsCreativeness', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ability to solve problems';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.IsProblemSolving', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Presentation and persuasion skills';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.IsPrsentation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Communication skill';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.IsCommunication', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.InformaticsLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Creativeness', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ability to solve problems';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.ProblemSolving', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Presentation and persuasion skills';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Prsentation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Communication skill';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Communication', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Height';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Weight';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Weight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Health status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.HealthStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty name'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Description.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.EducationLevelID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Education Level'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.EducationLevelName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.LanguageID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Language'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.LanguageName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.LanguageLevelID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Language Level'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.LanguageLevelName.CB',  @FormID, @LanguageValue, @Language;
