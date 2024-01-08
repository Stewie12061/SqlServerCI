-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2020- CRM
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
SET @FormID = 'CRMF2020';

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'憑證日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'憑證號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶姓名';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.VATObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.RouteID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.DeliveryEmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備註';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'倉庫員狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.BacodeWareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'倉庫員狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.BacodeWareHouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出納員狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.BacodeCashierID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出納員狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.BacodeCashierName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.VoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2020.APK', @FormID, @LanguageValue, @Language;

