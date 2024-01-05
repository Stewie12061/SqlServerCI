------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CMNF9001 - CRM 
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
SET @ModuleID = '00';
SET @FormID = 'CMNF9001';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Choose Inventory';
 EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
 EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'InventoryID';
 EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.InventoryID' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'UnitID';
 EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.UnitID' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Inventory Name';
 EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.InventoryName' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Unit Name';
 EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.UnitName' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Disabled';
 EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.Disabled' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'IsCommon';
 EXEC ERP9AddLanguage @ModuleID, 'CMNF9001.IsCommon' , @FormID, @LanguageValue, @Language;








