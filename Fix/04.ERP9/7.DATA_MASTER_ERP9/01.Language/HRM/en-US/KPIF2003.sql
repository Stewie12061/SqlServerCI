-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2003- KPI
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
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF2003';

SET @LanguageValue = N'List of KPI results';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KPI evaluation set';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.EvaluationSetID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KPI evaluation set';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.EvaluationSetName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.EvaluationPhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.EvaluationPhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assessor';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.ConfirmUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assessor';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.ConfirmUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.ConfirmDutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total perform point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.TotalPerformPoint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total perform percent (%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.TotalPerformPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.DepartmentID.Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.DutyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.DutyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.TitleID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.TitleName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation set KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.EvaluationSetID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation set KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.EvaluationSetName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.EvaluationPhaseID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.EvaluationPhaseName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.EmployeeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2003.EmployeeName.CB', @FormID, @LanguageValue, @Language;





