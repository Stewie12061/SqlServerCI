-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2011- KPI
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
SET @FormID = 'KPIF2011';

SET @LanguageValue = N'Update bonus';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.EvaluationPhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deparment';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total bonus amount';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.TotalBonusAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Deparment';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'KPI evaluation set';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.EvaluationSetID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'KPI evaluation set';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.EvaluationSetName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.TitleName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Total unified point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.TotalUnifiedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classification';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.ClassificationUnifiedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Revenue';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.Revenue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bonus rate';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.BonusRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bonus amount';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.BonusAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2011.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

