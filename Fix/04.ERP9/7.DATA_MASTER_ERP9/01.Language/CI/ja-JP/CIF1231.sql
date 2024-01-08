-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1231- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1231';

SET @LanguageValue = N'単位';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'品目から';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.FromInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'アイテムへ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.ToInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'品目コード';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'品目名';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'倉庫コード';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'定格型コード';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.NormID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'説明する';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最低限';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.MinQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最大';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.MaxQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'行リセットレベル';
EXEC ERP9AddLanguage @ModuleID, 'CIF1231.ReOrderQuantity', @FormID, @LanguageValue, @Language;