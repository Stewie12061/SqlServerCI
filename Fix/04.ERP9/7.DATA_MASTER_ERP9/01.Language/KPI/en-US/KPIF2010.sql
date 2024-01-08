-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2010- KPI
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
SET @FormID = 'KPIF2010';

SET @LanguageValue = N'List of bonus calculations';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2010.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2010.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2010.EvaluationPhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deparment';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2010.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2010.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2010.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total bonus amount';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2010.TotalBonusAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2010.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2010.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2010.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2010.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2010.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2010.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2010.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2010.EvaluationPhaseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2010.EvaluationPhaseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2010.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2010.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Creator ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2010.EmployeeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2010.EmployeeName.CB',  @FormID, @LanguageValue, @Language
