-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2022- WM
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
SET @FormID = 'WMF2022';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher No';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher Date';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher Type';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.KindVoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.Warehouse01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.Warehouse02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory Type';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create User';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create User';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create Date';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modify User';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modify User';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.LastModifyUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modify Date';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.ExWarehouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.ExWarehouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Import Warehouse';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.ImWarehouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.ImWarehouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object Name';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee Name';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.IsLocation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ref 01';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.Ref01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ref 02';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.Ref02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.CheckPurchase', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.CheckTransport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.CheckOutput', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.IsTransferDivision', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.ImDivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.ImDivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory Type Name';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.VoucherGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange Rate';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.ExchangeRate1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.IsConsignment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Invoice No';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.InvoiceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Invoice Date';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.InvoiceDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Confirm Date';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.ConfirmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is Apple Consignment';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.IsConsignmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.ContactPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.InheritSaleOrders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.VoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.VoucherTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2022.StatusName', @FormID, @LanguageValue, @Language;

