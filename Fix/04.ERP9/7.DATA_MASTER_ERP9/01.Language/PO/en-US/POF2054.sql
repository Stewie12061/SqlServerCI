-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2054- P
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
SET @FormID = 'POF2054';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.POrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order date';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order number';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer name';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.ReceivedAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales order type';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.ClassifyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Follower name';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.FullName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Followers';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Some contracts';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract signing date';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.ContractDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Natural currency';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.OriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.Notes', @FormID, @LanguageValue, @Language;

