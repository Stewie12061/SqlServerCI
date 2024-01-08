-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2050- HRM
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
SET @FormID = 'HRMF2050';

SET @LanguageValue = N'招聘決定清單';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.RecDecisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'決定編號';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.RecDecisionNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'決定日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.DecisionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.FromToDate', @FormID, @LanguageValue, @Language;

