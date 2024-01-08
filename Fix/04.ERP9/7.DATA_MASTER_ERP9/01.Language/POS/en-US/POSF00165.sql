
------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF00165 - CRM 
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
SET @FormID = 'POSF00165';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Quick view inventory';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00165.Title' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Inventory code';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00165.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory name';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00165.InventoryName' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Ware house code';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00165.WareHouseID' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Ware house name';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00165.WareHouseName' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Number of inventory';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00165.EndQuantity' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Traveling goods (to)';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00165.PQuantity' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Hàng đi đường (go)';
 EXEC ERP9AddLanguage @ModuleID, 'POSF00165.SQuantity' , @FormID, @LanguageValue, @Language;

