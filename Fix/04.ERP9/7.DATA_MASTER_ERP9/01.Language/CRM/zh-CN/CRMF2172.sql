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
SET @Language = 'zh-CN'  
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2172';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'服務號碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'服務日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'接受的保修人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.WarrantyRecipientID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.MemberID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶姓名';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.MemberName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'服務請求單';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.IsInheritVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'服務請求單';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.InheritVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商品代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商品名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'序列號/ IMEI 號碼 1/ IMEI 號碼 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.SerialNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'保修卡號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.WarrantyCard', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出庫單編號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.ExportVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機器購買日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.PurchaseDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機器狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.MachineStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'損壞現象';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.FailureStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.IsGuarantee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.IsAtStore', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出庫單的繼承';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.btnInheritedExport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機器交貨日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.DeliveryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.APKMInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.APKDInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.WarrantyRecipientName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.GuaranteeEmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.RepairEmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.DeliveryEmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.TotalAmount', @FormID, @LanguageValue, @Language;

