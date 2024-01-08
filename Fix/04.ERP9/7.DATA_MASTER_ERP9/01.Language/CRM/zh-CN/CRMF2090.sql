-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2090- CRM
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
SET @FormID = 'CRMF2090';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.Tranmonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.Tranyear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'服務日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'服務號碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'接受的保修人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.WarrantyRecipientID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'搬到地點';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.FromShopID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.Descriptions', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'制票人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'自從';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶姓名';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商品代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'保修編號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.WarrantyCard', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'序列號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.SerialNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銷售單';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.SaleVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出庫單';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.ExportVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'保修人員';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.WarrantyStaffID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'保修總費';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2090.WarrantyExpenses', @FormID, @LanguageValue, @Language;

