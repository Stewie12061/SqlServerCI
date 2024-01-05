------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF0138 - CRM 
-- [Đình Hòa] [26/02/2021] - Bổ sung ngôn ngữ
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000)
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thuc thi truy van
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @Language = 'en-US';
SET @ModuleID = 'SO';
SET @FormID = 'SOF0138';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Inheriting purchase orders';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher No';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.VoucherNo' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Order Date';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.OrderDate' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Voucher Type';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.VoucherTypeID' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'ObjectID';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object Name';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.ObjectName' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Currency';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.CurrencyID' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Exchange Rate';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.ExchangeRate' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Inventory Type';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.InventoryTypeID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Order Status';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.OrderStatus' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Contrac No';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.ContracNo' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Contract Date';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.ContractDate' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Description';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.Description' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'InventoryID';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.InventoryID' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Inventory Name';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.InventoryName' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Unit';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.UnitID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Quantity';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.ConvertedQuantity' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'SalePrice';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.ConvertedSalePrice' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Inherit Quantity (Unit Standard)';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.InheritQuantity' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Remain Quantity (Unit Standard)';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.RemainQuantity' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Unit Price (Unit Standard)';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.PurchasePrice' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Original Amount';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.OriginalAmount' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Converted Amount';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.ConvertedAmount' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'VAT Percent';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.VATPercent' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'VAT Original Amount';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.VATOriginalAmount' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'VAT Converted Amount';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.VATConvertedAmount' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Notes 1';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.Notes' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Notes 2';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.Notes01' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Notes 3';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.Notes02' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Notes 4';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.Notes03' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Notes 5';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.Notes04' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Notes 6';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.Notes05' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Notes 7';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.Notes06' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Notes 8';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.Notes07' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Notes 9';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.Notes08' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Notes 10';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.Notes09' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'ID';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.ObjectID.CB' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Name';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.ObjectName.CB' , @FormID, @LanguageValue, @Language;

     SET @LanguageValue = N'ID';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.CurrencyID.CB' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Name';
 EXEC ERP9AddLanguage @ModuleID, 'SOF0138.CurrencyName.CB' , @FormID, @LanguageValue, @Language;