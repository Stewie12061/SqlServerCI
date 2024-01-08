-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1473- CI
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
SET @FormID = 'CIF1473';

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price list code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price list name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Branch';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.OID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Calculate the price according to the converted currency';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.IsConvertedPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price list after tax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.IsTaxIncluded', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Set employee commission rates';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.IsSetBonus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.btnEdit_TabInventory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price list name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.PriceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.MasterDiscountPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.IsTaxIncludedTemp', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Legacy price list code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.InheritID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Plan price list';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.IsPlanPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price list';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.IsPurchasePrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Browsing status';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.StatusSS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reviewer''s comments';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approver level';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approver level';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Levels';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.Levels', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit the expected price calculation table';
EXEC ERP9AddLanguage @ModuleID, 'CIF1473.IsInheritCost', @FormID, @LanguageValue, @Language;

