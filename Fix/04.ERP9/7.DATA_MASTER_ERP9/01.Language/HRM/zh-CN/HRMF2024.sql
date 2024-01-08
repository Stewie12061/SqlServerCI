-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2024- HRM
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
SET @FormID = 'HRMF2024';

SET @LanguageValue = N'選擇工作要求';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2024.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APK';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2024.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2024.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'要求代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2024.RecruitRequireID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'要求名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2024.RecruitRequireName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘崗位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2024.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'行数';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2024.RowNum', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TotalRow';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2024.TotalRow', @FormID, @LanguageValue, @Language;

