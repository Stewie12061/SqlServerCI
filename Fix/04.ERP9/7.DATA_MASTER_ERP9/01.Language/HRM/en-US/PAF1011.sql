-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ PAF1011- PA
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
SET @ModuleID = 'PA';
SET @FormID = 'PAF1011';

SET @LanguageValue = N'Appraisal Update';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Appraisal ID';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.AppraisalID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Appraisal Name';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.AppraisalName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order Appraisal';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.OrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.LastModifyUserID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Level Standard';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.TabPAT10102', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation Phase';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.TabPAT10103', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Level';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.LevelStandardID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Standard';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.LevelStandardName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation Phase';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.EvaluationPhaseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation Phase ID';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation Phase';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.DivisionID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.DivisionName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Level Critical';
EXEC ERP9AddLanguage @ModuleID, 'PAF1011.LevelCritical',  @FormID, @LanguageValue, @Language;
