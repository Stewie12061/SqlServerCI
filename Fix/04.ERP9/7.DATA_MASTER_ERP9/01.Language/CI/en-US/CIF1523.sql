-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1523- CI
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
SET @FormID = 'CIF1523';

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Condition code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.ConditionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Promotion';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.PromoteID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Condition name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.ConditionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tools';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.ToolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.DiscountUnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment conditions';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other specified objects';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.ObjectCustomID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Anchor code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.AnchorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.Disabled', @FormID, @LanguageValue, @Language;

