-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2091- CRM
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
SET @FormID = 'CRMF2091';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.Tranmonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.Tranyear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'採購日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'服務號碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'接受的保修人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.WarrantyRecipientID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'搬到地點';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.FromShopID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'解釋';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.Descriptions', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'制票人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶姓名';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商品代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'保修卡號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.WarrantyCard', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'序列號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.SerialNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'購物票';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.SaleVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出庫單';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.ExportVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'保修人員';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.WarrantyStaffID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'保修費用';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2091.WarrantyExpenses', @FormID, @LanguageValue, @Language;

