-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2022- HRM
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
SET @FormID = 'HRMF2022';

SET @LanguageValue = N'Recruitment view';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Android Package Kit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of recruitment period';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RecruitPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of recruitment plan';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RecruitPlanName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancies';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Implementation time from date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.PeriodFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.PeriodToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time to receive applications from date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ReceiveFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ReceiveToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RecruitQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workplace';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Working time';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.WorkType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time needed for personnel';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RequireDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected cost';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Costs', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of interview rounds';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.TotalLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.InheritRecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'People change';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date changes';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancies';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment plan code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RecruitPlanID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost (VND)';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Cost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Existing costs (VND)';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ActualCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fixed costs (VND)';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.CostBoundary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Serving customers in batches';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Boundary quantity';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.QuantityBoundary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.NumberInterviews_HRMT2021', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RecruitRequirement_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sex';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Gender_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.FromAge_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruit requirement';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.TabRecruitRequirement', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interview';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.TabInterviewTurn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.TabCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Arrive';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ToAge_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Appearance';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Appearance_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work experience';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Experience_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Academic level';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.EducationLevelID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.FromSalary_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Arrive';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ToSalary_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Describe job requirements';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.WorkDescription_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language 1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Language1ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language 2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Language2ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language 3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Language3ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language level';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.LanguageLevel1ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language level';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.LanguageLevel2ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language level';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.LanguageLevel3ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Computer skill';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.IsInformatics_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Computer skill';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.InformaticsLevel_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creativity';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.IsCreativeness_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creativity';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Creativeness_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ability to solve tasks';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.IsProblemSolving_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ability to solve tasks';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ProblemSolving_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Presentation and persuasion skills';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.IsPrsentation_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Prsentation_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Communication skill';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.IsCommunication_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Communication skill';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Communication_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Height';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Height_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Weight';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Weight_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Health condition';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.HealthStatus_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Notes_HRMT2024', @FormID, @LanguageValue, @Language;

