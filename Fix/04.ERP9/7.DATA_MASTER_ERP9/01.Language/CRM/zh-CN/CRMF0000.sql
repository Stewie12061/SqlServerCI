-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF0000- CRM
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
SET @FormID = 'CRMF0000';

SET @LanguageValue = N'保修單';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherType06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'所需 CT 類型';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherRequestCustomer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'簽發許可申請的憑證類型';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherRequestLicense', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件活動 CT 類型';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherCampaignEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支持請求的憑證類型';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherSupportRequired', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'服務要求的憑證類型';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherRequestService', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'短信戰略的憑證類型';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherCampaignSMS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'在線源數據的憑證類型';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0000.VoucherSourceDataOnline', @FormID, @LanguageValue, @Language;

