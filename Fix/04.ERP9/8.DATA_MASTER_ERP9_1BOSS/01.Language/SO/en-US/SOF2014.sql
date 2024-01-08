
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2014- OO
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
SET @ModuleID = 'SO';
SET @FormID = 'SOF2014';

SET @LanguageValue = N'Inventory information';
EXEC ERP9AddLanguage @ModuleID, 'SOF2014.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2014.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory Name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2014.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2014.UnitID' , @FormID, @LanguageValue, @Language;