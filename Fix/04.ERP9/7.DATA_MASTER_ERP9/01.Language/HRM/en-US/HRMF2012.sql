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

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Require ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.RecruitRequireID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Require name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.RecruitRequireName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duty ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duty name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sex';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Gender', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From age';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.FromAge', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To age';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.ToAge', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Education level';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.EducationLevelID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Appearance';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Appearance', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Experience';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Experience', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From salary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.FromSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To salary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.ToSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Job requirement description';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.WorkDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language 1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Language1ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language 2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Language2ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language 3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Language3ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language level 1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.LanguageLevel1ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language level 2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.LanguageLevel2ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language level 3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.LanguageLevel3ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Informatics level';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.IsInformatics', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creativity';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.IsCreativeness', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Problem solving';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.IsProblemSolving', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Prsentation';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.IsPrsentation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Communication skill';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.IsCommunication', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.InformaticsLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Creativeness', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.ProblemSolving', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Prsentation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Communication', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Height';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Weight';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Weight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Health status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.HealthStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2011.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'General Information'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.TabInfo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attachment'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.StatusID',  @FormID, @LanguageValue, @Language;
