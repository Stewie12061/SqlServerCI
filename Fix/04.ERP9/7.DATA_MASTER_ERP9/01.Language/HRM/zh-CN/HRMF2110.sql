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
SET @Language = 'zh-CN' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2110';

SET @LanguageValue = N'D.I.S.C性格清單';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職稱/崗位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職稱代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.TitleID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.TitleName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工程式碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'位置';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職稱/崗位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'評估日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.EvaluationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Nature_D', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Nature_I', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Nature_S', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Nature_C', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'自然性格';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Nature', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Adaptive_D', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Adaptive_I', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Adaptive_S', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Adaptive_C', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'適應';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Adaptive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.Descriptions', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2110.DeleteFlg', @FormID, @LanguageValue, @Language;

