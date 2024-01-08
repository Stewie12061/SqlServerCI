-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2022- CRM
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
SET @FormID = 'CRMF2022';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'憑證日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'憑證號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.VATObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.RouteID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.DeliveryEmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'解釋';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.BacodeWareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.BacodeWareHouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.BacodeCashierID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.BacodeCashierName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'修理人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更正日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.VoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.APK', @FormID, @LanguageValue, @Language;

