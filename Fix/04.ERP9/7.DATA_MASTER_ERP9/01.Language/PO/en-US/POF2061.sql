-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2061- PO
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
SET @FormID = 'POF2061';

SET @LanguageValue = N'Update container booking for export order';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher No';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loading';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.PackedTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Departure date';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.DepartureDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Arrival date';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.ArrivalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Port';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.PortName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Closing time';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.ClosingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Consignee';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.Forwarder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Carrier';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.ShipBrand', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Container quantity';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.ContQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.DatePeriodPOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.DivisionIDPOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Carrier';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.ShipBrandPOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Port';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.PortNamePOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher No';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.VoucherNoPOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.DeleteFlag', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order No';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.SOrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.SOVoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.Quantity', @FormID, @LanguageValue, @Language;