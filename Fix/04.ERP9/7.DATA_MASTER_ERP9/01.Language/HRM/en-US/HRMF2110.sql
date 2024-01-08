-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2110- HRM
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
SET @FormID = 'HRMF2110';

SET @LanguageValue = N'D.I.S.C Personality Trait';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title / position';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.EvaluationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Nature_D', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Nature_I', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Nature_S', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Nature_C', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Natural personality';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Nature', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Adaptive_D', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Adaptive_I', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Adaptive_S', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Adaptive_C', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Adapt';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Adaptive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Descriptions', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'From D';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.FromD',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'To D';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.ToD',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'From I';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.FromI',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'To I';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.ToI',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'From S';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.FromS',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'To S';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.ToS',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'From C';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.FromC',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'To C';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.ToC',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Character';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.CharacterTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Title ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.TitleID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.TitleName.CB',  @FormID, @LanguageValue, @Language;
