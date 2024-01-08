-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2170- CRM
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
SET @FormID = 'CRMF2170';

SET @LanguageValue = N'Service request voucher';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Service number';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Service date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warranty receiver ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.WarrantyRecipientID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.MemberID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.MemberName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.IsInheritVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Service request voucher';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.InheritVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Serial No/ IMEL1 No/ IMEL2 No';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.SerialNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warranty card No';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.WarrantyCard', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Export voucher';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.ExportVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.PurchaseDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.MachineStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Failure status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.FailureStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Guarantee';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.IsGuarantee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.IsAtStore', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of export voucher';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.btnInheritedExport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.StatusID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.StatusName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine delivery date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.DeliveryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.APKMInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.APKDInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warranty receiver ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.WarrantyRecipientName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Guarantee employee';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.GuaranteeEmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Maintenance employee ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.RepairEmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery employee';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.DeliveryEmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total amount';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.TotalAmount', @FormID, @LanguageValue, @Language;

