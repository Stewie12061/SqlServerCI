-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF0001- PO
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
SET @ModuleID = 'PO';
SET @FormID = 'POF0001';

SET @LanguageValue  = N'Set up purchase orders'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.CurencyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF0001.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'POF0001.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classify';
EXEC ERP9AddLanguage @ModuleID, 'POF0001.ClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Followers';
EXEC ERP9AddLanguage @ModuleID, 'POF0001.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment methods';
EXEC ERP9AddLanguage @ModuleID, 'POF0001.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item type';
EXEC ERP9AddLanguage @ModuleID, 'POF0001.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reservation warehouse';
EXEC ERP9AddLanguage @ModuleID, 'POF0001.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'POF0001.DeReAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'POF0001.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'POF0001.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency ID'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency name'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'POF0001.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POF0001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'POF0001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'POF0001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'POF0001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'POF0001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF0001.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classify ID'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.ClassifyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classify name'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.ClassifyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment ID'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.PaymentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment name'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.PaymentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory type ID'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.InventoryID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory type name'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.InventoryName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ware house ID'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.WareHouseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ware house name'
EXEC ERP9AddLanguage @ModuleID, 'POF0001.WareHouseName.CB',  @FormID, @LanguageValue, @Language;