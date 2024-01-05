
------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF00166 - CRM 
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000)
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thuc thi truy van
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @Language = 'en-US';
SET @ModuleID = 'POS';
SET @FormID = 'POSF00166';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Choose promotional goods by invoice';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00166.Title' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Inventory code';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00166.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory name';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00166.InventoryName' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Unit';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00166.UnitName' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Gift';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00166.IsGift' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Quantity';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00166.Quantity' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Promotional items by default';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00166.RefInventoryID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Choose alternative promotions';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00166.Order' , @FormID, @LanguageValue, @Language;
