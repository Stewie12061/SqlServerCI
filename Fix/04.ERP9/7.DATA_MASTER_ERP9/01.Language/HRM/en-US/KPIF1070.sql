-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF1070- KPI
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
SET @FormID = 'KPIF1070';

SET @LanguageValue = N'List of setting up KPI evaluation';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KPI evaluation set ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.EvaluationSetID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KPI evaluation set';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.EvaluationSetName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duty';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Title ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.TitleID.CB',  @FormID, @LanguageValue, @Language;
	
SET @LanguageValue  = N'Title name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.TitleName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.EvaluationPhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.EvaluationPhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1070.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;