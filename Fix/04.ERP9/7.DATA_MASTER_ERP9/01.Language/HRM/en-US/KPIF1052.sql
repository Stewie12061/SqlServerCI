-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF1052- KPI
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
SET @FormID = 'KPIF1052';

SET @LanguageValue = N'Targets View';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.TargetsID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.TargetsName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.UnitKpiID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Formulas';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.FormulaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order targets';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.OrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Frequency';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.FrequencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Source';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.SourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Categorize';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.Categorize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Source ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.SourceID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Source name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.SourceName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit KPI ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.UnitKpiID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit KPI name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.UnitKpiName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Formula';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.FormulaID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Formula ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.FormulaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Formula';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.FormulaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.DivisionName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.DivisionID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.DivisionName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.EvaluationPhaseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.EvaluationPhaseName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets group';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.TargetsGroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets group ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.TargetsGroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets group name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.TargetsGroupName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Percentage';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.Percentage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Revenue';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.Revenue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Goal limit';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.GoalLimit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets details ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.ChiTietThongTinChiTieu',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Targets Information';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.ThongTinChiTieu',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1052.StatusID',  @FormID, @LanguageValue, @Language;