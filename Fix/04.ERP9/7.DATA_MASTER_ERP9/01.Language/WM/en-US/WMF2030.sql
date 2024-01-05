-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2030- WM
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
SET @FormID = 'WMF2030';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher No';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher Date';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher Type';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.KindVoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.Warehouse01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.Warehouse02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory Type';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.LastModifyUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Export Warehouse Name';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.ExWarehouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Export Warehouse';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.ExWarehouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.ImWarehouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Import Warehouse';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.ImWarehouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object Name';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee Name';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.IsLocation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.Ref01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.Ref02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.CheckPurchase', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.CheckTransport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.CheckOutput', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.IsTransferDivision', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.ImDivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.ImDivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.VoucherGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.ExchangeRate1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.IsConsignment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.InvoiceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.InvoiceDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.ConfirmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.IsConsignmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.ContactPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.InheritSaleOrders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.VoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.VoucherTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2030.StatusName', @FormID, @LanguageValue, @Language;

