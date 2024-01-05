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
SET @Language = 'vi-VN' 
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF2044';

SET @LanguageValue = N'Theo kỳ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2044.CheckListPeriodControl', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin kỳ lương';
EXEC ERP9AddLanguage @ModuleID, 'KPIT2044.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2044.PeriodControl', @FormID, @LanguageValue, @Language;