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
SET @Language = 'zh-CN' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2170';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'服務號碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'服務日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'接受的保修人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.WarrantyRecipientID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.MemberID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶姓名';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.MemberName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'服務請求單';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.IsInheritVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'服務請求單';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.InheritVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商品代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商品名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'序列號/ IMEI 號碼 1/ IMEI 號碼 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.SerialNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'保修卡號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.WarrantyCard', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出庫單編號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.ExportVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機器購買日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.PurchaseDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機器狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.MachineStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'損壞現象';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.FailureStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'保修';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.IsGuarantee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.IsAtStore', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出庫單的繼承';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.btnInheritedExport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機器交貨日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.DeliveryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.APKMInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.APKDInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.WarrantyRecipientName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'保修人員';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.GuaranteeEmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'維修員工';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.RepairEmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交貨人員';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.DeliveryEmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'總金額';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.TotalAmount', @FormID, @LanguageValue, @Language;

