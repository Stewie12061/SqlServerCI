-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF0000- M
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
SET @ModuleID = 'M';
SET @FormID = 'MF0000';

SET @LanguageValue = N'系統設定';
EXEC ERP9AddLanguage @ModuleID, 'MF0000.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF0000.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'集裝箱安排的憑證類型';
EXEC ERP9AddLanguage @ModuleID, 'MF0000.VoucherSortCont', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'包裝箱計算的憑證類型';
EXEC ERP9AddLanguage @ModuleID, 'MF0000.VoucherParking', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交付給客戶包裝的憑證類型';
EXEC ERP9AddLanguage @ModuleID, 'MF0000.VoucherParkingRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生產計劃的憑證類型';
EXEC ERP9AddLanguage @ModuleID, 'MF0000.VoucherManufacturingPlan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生產估計的憑證類型';
EXEC ERP9AddLanguage @ModuleID, 'MF0000.VoucherEstimate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生產結果統計表的的憑證類型';
EXEC ERP9AddLanguage @ModuleID, 'MF0000.VoucherProductionResult', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生產指令的憑證類型';
EXEC ERP9AddLanguage @ModuleID, 'MF0000.VoucherProductOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生產訂單的憑證類型';
EXEC ERP9AddLanguage @ModuleID, 'MF0000.VoucherManufacturingOrder', @FormID, @LanguageValue, @Language;

