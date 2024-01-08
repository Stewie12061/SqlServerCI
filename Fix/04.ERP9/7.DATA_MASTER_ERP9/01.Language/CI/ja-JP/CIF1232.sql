-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1232- CI
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
SET @Language = 'ja-JP' 
SET @ModuleID = 'CI';
SET @FormID = 'CIF1232';

SET @LanguageValue = N'単位';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'品目コード';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'品目名';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'倉庫コード';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'定格型コード';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.NormID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'説明する';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最低限';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.MinQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最大';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.MaxQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'行リセットレベル';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.ReOrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'在庫基準に関する情報';
EXEC ERP9AddLanguage @ModuleID, 'CIF1232.ThongTinDinhMucTonKhoHangHoa', @FormID, @LanguageValue, @Language;