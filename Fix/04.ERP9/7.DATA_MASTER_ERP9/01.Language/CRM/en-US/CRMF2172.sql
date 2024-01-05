-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2172- CRM
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
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2172';

SET @LanguageValue = N'View request voucher';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Service date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warranty receiver ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.WarrantyRecipientID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.MemberID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.MemberName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.IsInheritVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Service request voucher';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.InheritVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'  Serial No/ IMEL1 No/ IMEL2 No';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.SerialNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.WarrantyCard', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Export voucher';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.ExportVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.PurchaseDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.MachineStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Failure status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.FailureStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Guarantee';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.IsGuarantee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.IsAtStore', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of export voucher';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.btnInheritedExport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine delivery date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.DeliveryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.APKMInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.APKDInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warranty receiver ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.WarrantyRecipientName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Guarantee employee';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.GuaranteeEmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Maintenance employee ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.RepairEmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery employee';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.DeliveryEmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total amount';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.TotalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual quantity'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.ActualQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual amount'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.Amount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Guarantee'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.IsWarranty' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quotation amount'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.QuotationAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quotation quantity'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.QuotationQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Return quantity'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.ReturnQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accessories/Service'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.ServiceName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Advance quantity'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.SuggestQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.UnitName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit price'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.UnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'General information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.TabInfo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.TabInfo1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accessories/Service information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.TabInfo2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.TabCRMT00002' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.TabCRMT90031' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.TabCRMT00003' , @FormID, @LanguageValue, @Language;
