-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2024- PO
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
SET @ModuleID = 'PO';
SET @FormID = 'POF2024';

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'POF2024.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order date';
EXEC ERP9AddLanguage @ModuleID, 'POF2024.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer code';
EXEC ERP9AddLanguage @ModuleID, 'POF2024.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer name';
EXEC ERP9AddLanguage @ModuleID, 'POF2024.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'PLU';
EXEC ERP9AddLanguage @ModuleID, 'POF2024.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product name';
EXEC ERP9AddLanguage @ModuleID, 'POF2024.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POF2024.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of orders';
EXEC ERP9AddLanguage @ModuleID, 'POF2024.OrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery request date';
EXEC ERP9AddLanguage @ModuleID, 'POF2024.RequireDate', @FormID, @LanguageValue, @Language;

