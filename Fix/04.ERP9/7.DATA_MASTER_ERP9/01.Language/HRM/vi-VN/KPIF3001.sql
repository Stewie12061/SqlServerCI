-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF3001- KPI
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
SET @FormID = 'KPIF3001';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF3001.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Báo cáo danh sách chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF3001.Title', @FormID, @LanguageValue, @Language;

