-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1262- CI
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
SET @Language = 'en-US';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1262';
SET @LanguageValue = N'Details';
EXEC ERP9AddLanguage @ModuleID, 'TabAT0109', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Promotional information by order';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.ThongTinKhuyenMaiTheoDonHang', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'View promotion by bill';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Promotional code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.PromoteID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From value';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.FromValues', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To value';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.ToValues', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.DiscountPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.DiscountAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.PromoteQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Promotion name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.PromoteName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Since';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name items';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.PromotionTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Text';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.Text', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.OrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Detail';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.APKDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1262.ObjectTypeID', @FormID, @LanguageValue, @Language;

