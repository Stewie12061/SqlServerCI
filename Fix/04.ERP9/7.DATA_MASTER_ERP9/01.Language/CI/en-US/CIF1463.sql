-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1463- CI
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
SET @FormID = 'CIF1463';

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price list code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price list name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.OID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Calculate the price according to the exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.IsConvertedPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price list after tax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.IsTaxIncluded', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.IsSetBonus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.btnEdit_TabInventory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.PriceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.MasterDiscountPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.IsTaxIncludedTemp', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.InheritID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.IsPlanPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.IsPurchasePrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.StatusSS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.Levels', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1463.IsInheritCost', @FormID, @LanguageValue, @Language;

