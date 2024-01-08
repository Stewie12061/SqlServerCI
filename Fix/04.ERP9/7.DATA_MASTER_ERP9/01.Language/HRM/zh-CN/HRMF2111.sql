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
SET @Language = 'zh-CN' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2111';

SET @LanguageValue = N'更新D.I.S.C性格';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職稱/崗位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職員';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'位置';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職稱/崗位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'評估日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.EvaluationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性格D';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Nature_D', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性格I';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Nature_I', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性格S';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Nature_S', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性格C';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Nature_C', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性格';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Nature', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性格D';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Adaptive_D', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性格I';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Adaptive_I', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性格S';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Adaptive_S', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性格C';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Adaptive_C', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性格';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2111.Adaptive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性格描述';
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

