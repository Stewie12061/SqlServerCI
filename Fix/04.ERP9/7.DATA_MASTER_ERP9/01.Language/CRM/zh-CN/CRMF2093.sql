-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2093- CRM
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
SET @FormID = 'CRMF2093';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.Tranmonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.Tranyear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銷售/交換日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'貨物銷售/交換號碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.WarrantyRecipientID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'搬到地點';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.FromShopID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.Descriptions', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶姓名';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商品代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'保修編號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.WarrantyCard', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'序列號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.SerialNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銷售編號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.SaleVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'發行票數';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.ExportVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.WarrantyStaffID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2093.WarrantyExpenses', @FormID, @LanguageValue, @Language;

