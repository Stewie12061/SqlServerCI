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
SET @Language = 'zh-CN' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2022';

SET @LanguageValue = N'查看招聘批次明細';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APK';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘批次代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘批次名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RecruitPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘計劃名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RecruitPlanName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘崗位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'履行日期自';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.PeriodFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'迄今';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.PeriodToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'接收檔案的日期自';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ReceiveFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'迄今';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ReceiveToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'數量';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RecruitQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職場';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作時間';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.WorkType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'需要人事的時間';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RequireDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預計費用';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Costs', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試輪數';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.TotalLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'InheritRecruitPeriodID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.InheritRecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'變更人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'變更日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘崗位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘計劃代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RecruitPlanID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用（越南盾）';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Cost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'現有費用（越南盾）';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ActualCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'計劃成本（越南盾）';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.CostBoundary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'按批次劃分的計劃數量';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'計劃數量';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.QuantityBoundary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.NumberInterviews_HRMT2021', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RecruitRequirement_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性別';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Gender_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'是的_';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.FromAge_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到達';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ToAge_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外貌';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Appearance_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作經驗';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Experience_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文化水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.EducationLevelID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'是的_';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.FromSalary_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到達';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ToSalary_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作要求描述';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.WorkDescription_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外語1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Language1ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外語2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Language2ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外語3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Language3ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外語水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.LanguageLevel1ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外語水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.LanguageLevel2ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外語水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.LanguageLevel3ID_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電腦水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.IsInformatics_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電腦水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.InformaticsLevel_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創造力';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.IsCreativeness_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創造力';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Creativeness_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'解決工作的能力';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.IsProblemSolving_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'解決工作的能力';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ProblemSolving_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'陳述和說服能力';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.IsPrsentation_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Prsentation_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'溝通能力';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.IsCommunication_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'溝通能力';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Communication_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'高度';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Height_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'重量';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Weight_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'健康狀況';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.HealthStatus_HRMT2024', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Notes_HRMT2024', @FormID, @LanguageValue, @Language;

