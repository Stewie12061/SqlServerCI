-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2020- HRM
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
SET @FormID = 'HRMF2020';

SET @LanguageValue = N'招聘批次清單';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APK';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘批次代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.RecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘批次名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.RecruitPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘計劃名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.RecruitPlanName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘崗位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'履行自';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.PeriodFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'履行到';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.PeriodToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ReceiveFromDate';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.ReceiveFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'接收到日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.ReceiveToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'數量';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.RecruitQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作場所';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作類型';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.WorkType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'要求日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.RequireDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.Costs', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TotalLevel';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.TotalLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'InheritRecruitPeriodID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.InheritRecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'變更人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'變更日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘崗位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘計劃代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.RecruitPlanID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.Cost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.ActualCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.CostBoundary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.QuantityBoundary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.NumberInterviews_HRMT2021', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.RecruitRequirement_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.Gender_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.FromAge_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.ToAge_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.Appearance_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.Experience_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.EducationLevelID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.FromSalary_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.ToSalary_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.WorkDescription_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.Language1ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.Language2ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.Language3ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.LanguageLevel1ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.LanguageLevel2ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.LanguageLevel3ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.IsInformatics_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.InformaticsLevel_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.IsCreativeness_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.Creativeness_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.IsProblemSolving_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.ProblemSolving_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.IsPrsentation_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.Prsentation_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.IsCommunication_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.Communication_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.Height_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.Weight_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.HealthStatus_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.Notes_HRMT2024', @FormID, @LanguageValue, @Language;

