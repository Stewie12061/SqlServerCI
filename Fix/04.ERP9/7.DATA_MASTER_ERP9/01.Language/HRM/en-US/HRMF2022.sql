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

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment period ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment period name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RecruitPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment plan';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RecruitPlanName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.PeriodFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.PeriodToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ReceiveFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ReceiveToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RecruitQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workplace';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work type';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.WorkType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RequireDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Costs';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Costs', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of interview rounds';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.TotalLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.InheritRecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment plan ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RecruitPlanID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Cost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Available cost (VND)';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ActualCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fixing recruitment cost';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.CostBoundary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Available quantity';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fixed number of employees';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.QuantityBoundary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Attach', @FormID, @LanguageValue, @Language;

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