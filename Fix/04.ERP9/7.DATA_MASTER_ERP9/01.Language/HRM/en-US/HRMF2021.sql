-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2021- HRM
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
SET @FormID = 'HRMF2021';

SET @LanguageValue = N'Update recruitment ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Android Package Kit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of recruitment period';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment plan';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitPlanName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancies';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Implementation time from date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.PeriodFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.PeriodToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time to receive applications from date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ReceiveFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ReceiveToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workplace';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Form of work';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.WorkType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time needed for personnel';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RequireDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected cost';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Costs', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of interview rounds';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.TotalLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.InheritRecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'People change';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date changes';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancies';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment plan code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitPlanID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost (VND)';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Cost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Existing costs (VND)';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ActualCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fixed costs (VND)';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.CostBoundary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Serving customers in batches';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Boundary quantity';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.QuantityBoundary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of interview rounds';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.NumberInterviews_HRMT2021', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment requirements';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitRequirement_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sex';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Gender_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.FromAge_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Arrive';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ToAge_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Work type';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.WorkType.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vacancy ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vacancy name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Appearance';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Appearance_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work experience';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Experience_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Academic level';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.EducationLevelID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.FromSalary_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Arrive';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ToSalary_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Describe job requirements';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.WorkDescription_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language 1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Language1ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language 2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Language2ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language 3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Language3ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language level';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.LanguageLevel1ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language level';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.LanguageLevel2ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language level';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.LanguageLevel3ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Computer skill';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.IsInformatics_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Computer skill';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.InformaticsLevel_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creativity';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.IsCreativeness_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creativity';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Creativeness_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ability to solve tasks';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.IsProblemSolving_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ProblemSolving_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Presentation and persuasion skills';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.IsPrsentation_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Prsentation_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Communication skill';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.IsCommunication_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Communication skill';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Communication_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Height';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Height_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Weight';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Weight_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Health condition';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.HealthStatus_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Notes_HRMT2024', @FormID, @LanguageValue, @Language;

