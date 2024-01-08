-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1252- CI
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
SET @FormID = 'CIF1252';

EXEC ERP9AddLanguage N'CI', N'TabOT1302', N'CIF1252', N'Details', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1252.ToDate', N'CIF1252', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1252.OID', N'CIF1252', N'Branch', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1252.ThongTinBangGiaBan', N'CIF1252', N'Price list table info', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1252.IsConvertedPrice', N'CIF1252', N'Calculate the price according to money rules', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1252.Title', N'CIF1252', N'View price list table sell', N'en-US', NULL

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price list code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Describe';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Since';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.OID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Calculate the price according to the exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.IsConvertedPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price list after tax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.IsTaxIncluded', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Set employee commission rates';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.IsSetBonus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.btnEdit_TabInventory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price list name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.PriceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.MasterDiscountPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.IsTaxIncludedTemp', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Legacy price list code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.InheritID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Plan price list';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.IsPlanPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase price list';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.IsPurchasePrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Browsing status';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.StatusSS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reviewer''s comments';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approver level';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approver level';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Levels';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.Levels', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit the expected price calculation table';
EXEC ERP9AddLanguage @ModuleID, 'CIF1252.IsInheritCost', @FormID, @LanguageValue, @Language;

