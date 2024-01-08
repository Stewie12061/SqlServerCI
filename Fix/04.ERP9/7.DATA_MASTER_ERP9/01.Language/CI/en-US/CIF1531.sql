-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1531- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1531';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1531.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1531.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1531.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1531.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1531.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total available value discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1531.SumDiscountValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total discount rate available';
EXEC ERP9AddLanguage @ModuleID, 'CIF1531.SumDiscountRate', @FormID, @LanguageValue, @Language;

