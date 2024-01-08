-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2009- PO
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
SET @FormID = 'POF2009';

SET @LanguageValue = N'運輸信息';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單據號碼';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'增加了自动序列号，发票号';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.InvoiceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'提單代碼';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.BillOfLadingNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'集裝箱數量';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.QuantityContainer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'報關到期日';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.ClearanceExpirationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'火車出發日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.DepartureDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'船舶到達日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.ArrivalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'集裝箱存放免費時間';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.DateFreeCont', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'倉儲免費時間';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.DateFreePlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'貨款支付日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.PaymentDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'專業注冊檔案代碼';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.CRMajorsID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'專業注冊證書編號';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.CRMajorsNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'證書編號';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.CertificateNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'專項抽樣檢查日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.InspectionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合規數';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.LegalNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合規證書編號';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.CertificateLegalNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'貨幣類型';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'海關挂牌彙率';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.ExchangeRateCustoms', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'拖拉集裝箱的日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.TowingDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.TransactionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.POrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'裝貨日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.ShipDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生産完成日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.FinishedProductionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'進口港';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.ImportPort', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到達港口的日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.ImportPortDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交货地址';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預計入庫日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.DeliveryAddressDate', @FormID, @LanguageValue, @Language;

