-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2111- HRM
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
SET @FormID = 'HRMF2111';

SET @LanguageValue = N'Update D.I.S.C Personality Trait';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Staff';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title / position';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.EvaluationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Personality D';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Nature_D', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Personality I';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Nature_I', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'S is personality';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Nature_S', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Personality C';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Nature_C', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Character';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Nature', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Personality D';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Adaptive_D', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Personality I';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Adaptive_I', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'S is personality';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Adaptive_S', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Personality C';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Adaptive_C', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Character';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Adaptive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Personality description';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Descriptions', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nature';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.GroupA',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Adaptive';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.GroupB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.EmployeeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.EmployeeName.CB',  @FormID, @LanguageValue, @Language;