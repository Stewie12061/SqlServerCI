------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0001 - POS
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
 - Tieng Viet: en-US 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'en-US' 
SET @ModuleID = 'POS';
SET @FormID = 'POSF3019';
------------------------------------------------------------------------------------------------------
-- Title
------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Warehouse exist by shop report';
EXEC ERP9AddLanguage @ModuleID, 'POSF3019.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POSF3019.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shop/Event';
EXEC ERP9AddLanguage @ModuleID, 'POSF3019.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From warehouse';
EXEC ERP9AddLanguage @ModuleID, 'POSF3019.FromWareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To warehouse';
EXEC ERP9AddLanguage @ModuleID, 'POSF3019.ToWareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From Inventory';
EXEC ERP9AddLanguage @ModuleID, 'POSF3019.FromInventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To Inventory';
EXEC ERP9AddLanguage @ModuleID, 'POSF3019.ToInventoryID' , @FormID, @LanguageValue, @Language;