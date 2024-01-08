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

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment period ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment period name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment plan';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitPlanName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.PeriodFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.PeriodToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ReceiveFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ReceiveToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workplace';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work type';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.WorkType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RequireDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Costs';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Costs', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of interview rounds';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.TotalLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.InheritRecruitPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment plan ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitPlanID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Cost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Available cost (VND)';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ActualCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fixing recruitment cost';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.CostBoundary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Available quantity';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fixed number of employees';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.QuantityBoundary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Attach', @FormID, @LanguageValue, @Language;

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