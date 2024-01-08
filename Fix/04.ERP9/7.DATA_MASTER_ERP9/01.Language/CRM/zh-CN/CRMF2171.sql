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
SET @Language = 'zh-CN' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2171';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'服務號碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'服務日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'接受的保修人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.WarrantyRecipientID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.MemberID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶姓名';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.MemberName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'繼承';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.IsInheritVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'服務請求單';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.InheritVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商品代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商品名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'序列號/ IMEI 號碼 1/ IMEI 號碼 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.SerialNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'保修卡號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.WarrantyCard', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出庫單編號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.ExportVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機器購買日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.PurchaseDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機器狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.MachineStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'損壞現象';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.FailureStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.IsGuarantee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.IsAtStore', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出庫單的繼承';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.btnInheritedExport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機器交貨日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.DeliveryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.APKMInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.APKDInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'接受的保修人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.WarrantyRecipientName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.GuaranteeEmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.RepairEmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.DeliveryEmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.TotalAmount', @FormID, @LanguageValue, @Language;

