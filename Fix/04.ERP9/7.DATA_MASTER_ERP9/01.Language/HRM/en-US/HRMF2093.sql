-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2093- HRM
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
SET @FormID = 'HRMF2093';

SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2093.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'All the people in company';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2093.IsAll', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2093.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2093.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training field';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2093.TrainingFieldName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Since';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2093.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2093.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2093.Description', @FormID, @LanguageValue, @Language;

