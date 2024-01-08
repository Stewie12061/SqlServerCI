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
SET @Language = 'en-US' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2012';

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Job request code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.RecruitRequireID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Job request name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.RecruitRequireName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Location code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Location name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sex';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Gender', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.FromAge', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Arrive';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.ToAge', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Academic level';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.EducationLevelID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Appearance';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Appearance', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Experience';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Experience', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.FromSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Arrive';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.ToSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Describe job requirements';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.WorkDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language 1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Language1ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language 2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Language2ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language 3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Language3ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language level 1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.LanguageLevel1ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language level 2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.LanguageLevel2ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language level 3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.LanguageLevel3ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Computer skill';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.IsInformatics', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creativity';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.IsCreativeness', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ability to solve tasks';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.IsProblemSolving', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Presentation and persuasion skills';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.IsPrsentation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Communication skill';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.IsCommunication', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.InformaticsLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Creativeness', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.ProblemSolving', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Prsentation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Communication', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Height';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Weight';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Weight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Health condition';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.HealthStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'General Information'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.TabInfo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attachment'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.StatusID',  @FormID, @LanguageValue, @Language;
