-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2101- PO
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
SET @FormID = 'POF2101';

SET @LanguageValue = N'Update receipt schedule';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.ROrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase order';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.POrderID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Item type';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.ReceivedAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Transport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.ShipDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.ContractDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.DueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.VoucherTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.PaymentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.OrderStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.InheritPurchareOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.LinkPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.RequestID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.RequestName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.OpportunityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.OldTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchaser order';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.POrderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.FormToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.OrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity (Standard unit)';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.ConvertedQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivered';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.ShippedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Remained';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.RemainedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 1';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 2';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 3';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 4';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 5';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 6';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 7';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 8';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 9';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 10';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 11';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity11', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 12';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity12', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 13';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity13', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 14';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity14', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 15';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity15', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 15';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity16', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 17';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity17', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 18';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity18', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 19';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity19', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 20';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity20', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 21';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity21', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 22';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity22', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 23';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity23', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 24';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity24', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 25';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity25', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 26';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity26', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 27';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity27', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 28';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity28', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 29';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity29', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 30';
EXEC ERP9AddLanguage @ModuleID, 'POF2101.Quantity30', @FormID, @LanguageValue, @Language;