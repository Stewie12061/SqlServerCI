-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1539- CI
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
SET @FormID = 'CIF1539';

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1539.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'UNit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1539.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'CIF1539.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1539.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total available value discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1539.SumDiscountValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total discount rate available';
EXEC ERP9AddLanguage @ModuleID, 'CIF1539.SumDiscountRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gift code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1539.InventoryGiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gift name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1539.InventoryGiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of gifts';
EXEC ERP9AddLanguage @ModuleID, 'CIF1539.GiftQuantity', @FormID, @LanguageValue, @Language;

