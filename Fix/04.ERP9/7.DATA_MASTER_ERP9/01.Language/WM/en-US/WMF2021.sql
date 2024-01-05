-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2021- WM
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
SET @Language = 'vi-VN' 
SET @ModuleID = 'WM';
SET @FormID = 'WMF2021';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher No';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher Date';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher Type';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.KindVoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.Warehouse01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.Warehouse02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory Type ID';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object ID';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.LastModifyUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.ExWarehouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.ExWarehouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.ImWarehouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Import Warehouse';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.ImWarehouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object Name';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee Name';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.IsLocation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ref 01';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.Ref01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ref 02';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.Ref02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit Purchase';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.CheckPurchase', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit Input';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.CheckTransport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit Dismount';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.CheckOutput', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.IsTransferDivision', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.ImDivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.ImDivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory Type Name';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.VoucherGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange Rate';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.ExchangeRate1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is Apple Consignment';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.IsConsignment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Invoice No';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.InvoiceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Invoice Date';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.InvoiceDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Confirm Date';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.ConfirmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.IsConsignmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.ContactPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'InheritSaleOrders';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.InheritSaleOrders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.VoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.VoucherTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2021.StatusName', @FormID, @LanguageValue, @Language;

