-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF9005- P
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
SET @ModuleID = 'P';
SET @FormID = 'POF9005';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Some bills';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.InvoiceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bill of lading code';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.BillOfLadingNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of containers';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.QuantityContainer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customs clearance expiration date';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.ClearanceExpirationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Train departure date';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.DepartureDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The day the train arrives';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.ArrivalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Free time to save cont';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.DateFreeCont', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Free storage time';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.DateFreePlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment date';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.PaymentDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Specialized registration application code';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.CRMajorsID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of specialized registration papers';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.CRMajorsNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Certificate number';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.CertificateNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of sampling for specialized inspection';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.InspectionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Compliance number';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.LegalNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Certificate of conformity number';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.CertificateLegalNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF9005.ExchangeRateCustoms', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of pulling cont';
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

