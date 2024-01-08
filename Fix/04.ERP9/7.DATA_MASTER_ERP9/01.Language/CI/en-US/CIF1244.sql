-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1244- CI
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
SET @FormID = 'CIF1244';

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Promotion';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.PromoteID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.VoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name items';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Promotion type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.Text', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Promotion type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.PromoteTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1244.IsDiscount', @FormID, @LanguageValue, @Language;

