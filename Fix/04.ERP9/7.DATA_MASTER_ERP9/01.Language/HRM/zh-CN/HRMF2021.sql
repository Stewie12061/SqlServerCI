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
SET @Language = 'zh-CN' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2021';

SET @LanguageValue = N'更新招聘批次';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APK';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘批次代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘批次名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招募計劃';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitPlanName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘崗位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'履行日期自';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.PeriodFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'迄今';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.PeriodToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'接收檔案的日期自';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ReceiveFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'迄今';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ReceiveToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'數量';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職場';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作形式';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.WorkType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'需要人事的時間';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RequireDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預計費用';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Costs', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試輪數';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.TotalLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'InheritRecruitPeriodID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.InheritRecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'變更人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'變更日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘崗位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘計劃代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitPlanID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用（越南盾）';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Cost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'現有費用（越南盾）';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ActualCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'計劃成本（越南盾）';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.CostBoundary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'按批次劃分的計劃數量';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'計劃數量';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.QuantityBoundary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'附';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試輪數';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.NumberInterviews_HRMT2021', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘要求';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitRequirement_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性別';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Gender_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'是的_';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.FromAge_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到達';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ToAge_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外貌';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Appearance_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作經驗';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Experience_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文化水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.EducationLevelID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'是的_';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.FromSalary_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到達';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ToSalary_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作要求描述';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.WorkDescription_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外語1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Language1ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外語2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Language2ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外語3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Language3ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外語水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.LanguageLevel1ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外語水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.LanguageLevel2ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外語水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.LanguageLevel3ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電腦水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.IsInformatics_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電腦水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.InformaticsLevel_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創造力';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.IsCreativeness_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創造力';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Creativeness_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'解決工作的能力';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.IsProblemSolving_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ProblemSolving_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'陳述和說服能力';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.IsPrsentation_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Prsentation_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'溝通能力';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.IsCommunication_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'溝通能力';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Communication_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'高度';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Height_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'重量';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Weight_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'健康狀況';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.HealthStatus_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Notes_HRMT2024', @FormID, @LanguageValue, @Language;

