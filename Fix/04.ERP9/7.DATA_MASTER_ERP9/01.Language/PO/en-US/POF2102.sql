-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2102- PO
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
SET @FormID = 'POF2102';

SET @LanguageValue = N'Receipt schedule view';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.ROrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase order';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.POrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.ReceivedAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Describe';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchaser order';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.POrderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Editor';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Transport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.ShipDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.ContractDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.DueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.VoucherTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.PaymentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.OrderStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.InheritPurchareOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.LinkPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.RequestID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.RequestName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.OpportunityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.OldTaskID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.FormToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.OrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity (Standard unit)';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.ConvertedQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivered';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.ShippedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Remained';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.RemainedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 1';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 2';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 3';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 4';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 5';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 6';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 7';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 8';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 9';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 10';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 11';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity11', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 12';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity12', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 13';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity13', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 14';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity14', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 15';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity15', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 15';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity16', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 17';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity17', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 18';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity18', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 19';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity19', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 20';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity20', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 21';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity21', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 22';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity22', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 23';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity23', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 24';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity24', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 25';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity25', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 26';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity26', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 27';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity27', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 28';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity28', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 29';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity29', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 30';
EXEC ERP9AddLanguage @ModuleID, 'POF2102.Quantity30', @FormID, @LanguageValue, @Language;