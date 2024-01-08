-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2044- KPI
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
SET @FormID = 'KPIF2044';

SET @LanguageValue = N'Select period';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2044.CheckListPeriodControl', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Period Information';
EXEC ERP9AddLanguage @ModuleID, 'KPIT2044.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report of period';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2044.PeriodControl', @FormID, @LanguageValue, @Language;
