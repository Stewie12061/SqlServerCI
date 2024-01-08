-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2007- WM
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
SET @ModuleID = 'WM';
SET @FormID = 'WMF2007';

SET @LanguageValue = N'Update output request information';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.WMF2007Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.VoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.VoucherTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.WarehouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.InputDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Planning day';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchanged money';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ImWareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ImWareHouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Export warehouse';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ExWareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ExWareHouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Output warehouse';
EXEC ERP9AddLanguage @ModuleID, 'WMF2006.ExWareHouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reference code 1';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.RefNo01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reference code 2';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.RefNo02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voting maker';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sectors';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact person';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ContactPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.RDAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voting maker';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.CheckPurchase', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.LastModifyUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit sales orders';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.InheritSaleOrders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reviewer status';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ApprovePersonStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Browsing status';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.StatusMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reviewer notes';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ApprovingLevel', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Warehouse ID';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.WareHouseID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse name';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.WareHouseName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory type ID';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.InventoryTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory type name';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.InventoryTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.EmployeeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.EmployeeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type ID';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type name';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.InventoryID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.InventoryName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account ID';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.AccountID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account name';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.AcccountName.CB', @FormID, @LanguageValue, @Language;