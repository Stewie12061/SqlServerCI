-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2171- CRM
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
SET @FormID = 'CRMF2171';

SET @LanguageValue = N'Service request voucher Update
';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Service date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warranty receiver ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.WarrantyRecipientID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.MemberID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.MemberName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.IsInheritVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Service request voucher';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.InheritVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Serial No/ IMEL1 No/ IMEL2 No';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.SerialNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.WarrantyCard', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Export voucher';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.ExportVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.PurchaseDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.MachineStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Failure status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.FailureStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Guarantee';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.IsGuarantee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.IsAtStore', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of export voucher';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.btnInheritedExport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.StatusID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.StatusName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine delivery date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.DeliveryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.APKMInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.APKDInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warranty receiver ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.WarrantyRecipientName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Guarantee employee';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.GuaranteeEmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Maintenance employee ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.RepairEmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery employee';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.DeliveryEmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total amount';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.TotalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual quantity'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.ActualQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual amount'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.Amount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Guarantee'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.IsWarranty' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quotation amount'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.QuotationAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quotation quantity'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.QuotationQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Return quantity'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.ReturnQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accessories/Service'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.ServiceName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Advance quantity'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.SuggestQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.UnitName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit price'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.UnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.WarrantyRecipientID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warranty receiver';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.WarrantyRecipientName.CB' , @FormID, @LanguageValue, @Language;



