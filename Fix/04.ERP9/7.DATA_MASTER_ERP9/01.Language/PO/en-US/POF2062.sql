-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2062- PO
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
SET @FormID = 'POF2062';

SET @LanguageValue = N'View container booking for export order';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher No';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loading';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.PackedTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Departure date';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.DepartureDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Arrival date';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.ArrivalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Port';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.PortName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Closing time';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.ClosingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Consignee';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.Forwarder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Carrier';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.ShipBrand', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Container quantity';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.ContQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.DatePeriodPOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.DivisionIDPOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Carrier';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.ShipBrandPOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Port';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.PortNamePOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher No';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.VoucherNoPOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.DeleteFlag', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order No';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.SOrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.SOVoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'General information';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Export order details';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attacthment';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.Attacth.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.Notes.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.History.GR', @FormID, @LanguageValue, @Language;
