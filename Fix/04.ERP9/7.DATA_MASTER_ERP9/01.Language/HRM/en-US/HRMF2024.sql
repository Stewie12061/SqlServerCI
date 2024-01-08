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
SET @Language = 'en-US' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2024';

SET @LanguageValue = N'Android Package Kit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2024.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2024.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2024.RecruitRequireID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2024.RecruitRequireName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancies';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2024.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'RowNum';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2024.RowNum', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TotalRow';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2024.TotalRow', @FormID, @LanguageValue, @Language;

