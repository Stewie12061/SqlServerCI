-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1263- CI
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
SET @FormID = 'CIF1263';
SET @LanguageValue = N'Update details discount by bill';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Promotional code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.PromoteID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From value';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.FromValues', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To value';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.ToValues', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.DiscountPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.DiscountAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue =N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.PromoteQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Promotion name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.PromoteName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Describe';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name items';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.PromotionTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Text';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.Text', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.OrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Detail';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.APKDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1263.ObjectTypeID', @FormID, @LanguageValue, @Language;

