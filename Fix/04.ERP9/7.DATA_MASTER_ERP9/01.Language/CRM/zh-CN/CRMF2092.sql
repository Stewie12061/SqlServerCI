-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2092- CRM
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
SET @FormID = 'CRMF2092';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.Tranmonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.Tranyear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'採購日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'服務號碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'接受的保修人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.WarrantyRecipientID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'搬到地點';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.FromShopID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'解釋';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.Descriptions', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'制票人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'修理人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更正日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶姓名';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商品代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'保修卡號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.WarrantyCard', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'序列號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.SerialNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'購物票';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.SaleVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出庫單';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.ExportVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'保修人員';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.WarrantyStaffID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'保修費用';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2092.WarrantyExpenses', @FormID, @LanguageValue, @Language;

