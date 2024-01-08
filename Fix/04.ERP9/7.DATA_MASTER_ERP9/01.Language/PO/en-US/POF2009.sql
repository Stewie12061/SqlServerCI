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
SET @Language = 'en-US' 
SET @ModuleID = 'PO';
SET @FormID = 'POF2009';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Some bills';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.InvoiceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bill of lading code';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.BillOfLadingNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of containers';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.QuantityContainer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customs clearance expiration date';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.ClearanceExpirationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Train departure date';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.DepartureDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The day the train arrives';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.ArrivalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Free time to save cont';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.DateFreeCont', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Free storage time';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.DateFreePlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment date';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.PaymentDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Specialized registration application code';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.CRMajorsID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of specialized registration papers';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.CRMajorsNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Certificate number';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.CertificateNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of sampling for specialized inspection';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.InspectionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Compliance number';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.LegalNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Certificate of conformity number';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.CertificateLegalNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customs listed exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.ExchangeRateCustoms', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of pulling cont';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.TowingDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.TransactionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.POrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Line up day';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.ShipDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production date completed';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.FinishedProductionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Port of entry';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.ImportPort', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Arrival date';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.ImportPortDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected warehouse receipt date';
EXEC ERP9AddLanguage @ModuleID, 'POF2009.DeliveryAddressDate', @FormID, @LanguageValue, @Language;

