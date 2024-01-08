-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1250- CI
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
SET @FormID = 'CIF1250';

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price list code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price list name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Since';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Branch';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.OID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Calculate the price according to the exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.IsConvertedPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price list after tax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.IsTaxIncluded', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Set employee commission rates';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.IsSetBonus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.btnEdit_TabInventory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price list name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.PriceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.MasterDiscountPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.IsTaxIncludedTemp', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Legacy price list code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.InheritID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Plan price list';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.IsPlanPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price list';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.IsPurchasePrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Browsing status';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.StatusSS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reviewer opinion';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approver level';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Level number';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.Levels', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit the expected price calculation table';
EXEC ERP9AddLanguage @ModuleID, 'CIF1250.IsInheritCost', @FormID, @LanguageValue, @Language;

