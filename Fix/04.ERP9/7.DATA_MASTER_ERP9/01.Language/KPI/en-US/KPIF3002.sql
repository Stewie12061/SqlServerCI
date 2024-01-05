-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF3002- KPI
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
SET @FormID = 'KPIF3002';

SET @LanguageValue = N'Report Evaluation KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF3002.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Period';
EXEC ERP9AddLanguage @ModuleID, 'KPIF3002.Period', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF3002.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'EmployeeName';
EXEC ERP9AddLanguage @ModuleID, 'KPIF3002.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DivisionID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF3002.DivisionID', @FormID, @LanguageValue, @Language;

