-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2025- SO
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
SET @ModuleID = 'SO';
SET @FormID = 'SOF2025';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2025.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2025.APKOT2102', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2025.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'命名項目';
EXEC ERP9AddLanguage @ModuleID, 'SOF2025.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'從月份開始';
EXEC ERP9AddLanguage @ModuleID, 'SOF2025.FromMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'來月';
EXEC ERP9AddLanguage @ModuleID, 'SOF2025.ToMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'命名項目';
EXEC ERP9AddLanguage @ModuleID, 'SOF2025.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'保修月數';
EXEC ERP9AddLanguage @ModuleID, 'SOF2025.GuaranteeNumber', @FormID, @LanguageValue, @Language;

