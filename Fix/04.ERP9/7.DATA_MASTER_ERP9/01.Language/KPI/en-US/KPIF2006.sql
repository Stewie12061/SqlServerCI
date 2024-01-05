-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2006- KPI
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
SET @FormID = 'KPIF2006';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2006.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2006.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2006.APKDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameter id';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2006.ParameterID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parameter name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2006.ParameterName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Value';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2006.Value', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2006.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2006.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2006.TargetsName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Formula';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2006.FormulaDes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2006.ResultValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Calculating results of KPI performance';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2006.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Calculate the performance';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2006.CalculatorKPI', @FormID, @LanguageValue, @Language;

