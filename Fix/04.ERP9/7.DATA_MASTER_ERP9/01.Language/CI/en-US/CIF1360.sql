-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1360- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1360';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract No';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code  1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana10ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract signing date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.SignDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.BeginDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract Type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.ContractType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange Rate';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Original Currency Value';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Converted Value of contract';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact person';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Contactor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Addendum';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.IsAppendixContract', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher Type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.ContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Addendum';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.InheritContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance Of quotation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.IsInheritSOF2021', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of purchase order';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.IsInheritPOF2031', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance Of Supplier quotation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.IsInheritPOF2041', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price list';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.PriceListID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract package';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.ContractPackageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.ContactorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Location';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.VATOriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Converted VAT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.VATConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.AssignedToUserName', @FormID, @LanguageValue, @Language;

