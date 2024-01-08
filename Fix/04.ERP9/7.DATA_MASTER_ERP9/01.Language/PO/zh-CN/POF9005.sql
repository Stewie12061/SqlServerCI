-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF9005- PO
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
SET @ModuleID = 'PO';
SET @FormID = 'POF9005';

SET @LanguageValue = N'選擇運送信息';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'增加了自动序列号，发票号';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.InvoiceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'提單代碼';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.BillOfLadingNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'集裝箱數量';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.QuantityContainer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'報關到期日';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.ClearanceExpirationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'火車出發日期';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.DepartureDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'船舶到達日期';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.ArrivalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'集裝箱存放免費時間';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.DateFreeCont', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'倉儲免費時間';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.DateFreePlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'貨款支付日期';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.PaymentDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'專業注冊檔案代碼';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.CRMajorsID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'專業注冊證書編號';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.CRMajorsNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'證書編號';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.CertificateNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'專項抽樣檢查日期';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.InspectionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合規數';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.LegalNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合規證書編號';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.CertificateLegalNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.ExchangeRateCustoms', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'拖拉集裝箱的日期';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.TowingDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.TransactionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.POrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.ShipDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.FinishedProductionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.ImportPort', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.ImportPortDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.DeliveryAddressDate', @FormID, @LanguageValue, @Language;

