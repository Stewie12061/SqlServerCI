-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1360- CRM
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
SET @ModuleID = 'CRM';
SET @FormID = 'CIF1360';

SET @LanguageValue = N'Contract information';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract No';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expenses';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana03Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expenses details';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana04Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Items';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana05Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Branch';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana06Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana07Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana08Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Goods';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana09Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Goods details';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.Ana10Name', @FormID, @LanguageValue, @Language;

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

SET @LanguageValue = N'Contract Type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.ContractTypeName', @FormID, @LanguageValue, @Language;

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

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher Type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.ContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
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

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.PriceListID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract package';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.ContractPackageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'AnaID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ana Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1360.AnaName.CB', @FormID, @LanguageValue, @Language;

