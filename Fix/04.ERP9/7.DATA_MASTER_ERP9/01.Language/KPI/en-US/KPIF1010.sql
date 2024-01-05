-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF1010- KPI
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
SET @FormID = 'KPIF1010';

SET @LanguageValue = N'List of Targets group';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1010.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets group ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1010.TargetsGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets group name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1010.TargetsGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets type';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1010.TargetsTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets type';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1010.TargetsTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1010.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1010.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1010.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1010.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1010.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1010.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1010.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1010.OrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1010.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1010.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1010.EvaluationPhaseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1010.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1010.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;