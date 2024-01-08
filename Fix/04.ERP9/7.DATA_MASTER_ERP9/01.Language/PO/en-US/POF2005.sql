-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2005- PO
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
SET @FormID = 'POF2005';
SET @LanguageValue  = N'Inheritance purchase requirements'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.Title',  @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2005.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'POF2005.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order date';
EXEC ERP9AddLanguage @ModuleID, 'POF2005.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery date';
EXEC ERP9AddLanguage @ModuleID, 'POF2005.ShipDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority level';
EXEC ERP9AddLanguage @ModuleID, 'POF2005.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'POF2005.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2005.Mode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2005.ScreenID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2005.PriceListID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2005.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2005.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2005.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2005.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2005.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2005.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2005.ReceivedAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2005.Transport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2005.DueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'InventoryID'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Inventory Name'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit Name'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Order Quantity'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.OrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Price'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.RequestPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Original Amount'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.OriginalAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Converted Amount'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.ConvertedAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'PriorityID'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.PriorityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Name'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.Description.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.AnaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Name'
EXEC ERP9AddLanguage @ModuleID, 'POF2005.AnaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request ID';
EXEC ERP9AddLanguage @ModuleID, 'POF2005.RequestID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request name';
EXEC ERP9AddLanguage @ModuleID, 'POF2005.RequestName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee code';
EXEC ERP9AddLanguage @ModuleID, 'POF2005.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'POF2005.EmployeeName', @FormID, @LanguageValue, @Language;

