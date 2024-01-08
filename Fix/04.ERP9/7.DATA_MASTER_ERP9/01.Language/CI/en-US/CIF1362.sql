-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1362- CI
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
SET @FormID = 'CIF1362';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract No';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 02';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 03';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 04';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 05';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 06';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 07';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 08';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 09';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana10ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract signing date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.SignDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Begin Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.BeginDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract Type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ContractType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange Rate';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Original Currency Value';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Converted';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact person';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Contactor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Addendum';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.IsAppendixContract', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher Type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Addendum';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.InheritContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance Of quotation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.IsInheritSOF2021', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of purchase order';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.IsInheritPOF2031', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance Of Supplier quotation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.IsInheritPOF2041', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price list';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.PriceListID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract package';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ContractPackageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contactor code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ContactorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery time';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT Original Amount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.VATOriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT Converted Amount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.VATConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.AssignedToUserName', @FormID, @LanguageValue, @Language;

