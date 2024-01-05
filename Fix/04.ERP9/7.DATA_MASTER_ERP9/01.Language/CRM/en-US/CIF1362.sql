-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1362- CRM
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
SET @FormID = 'CIF1362';

SET @LanguageValue = N'Contract view';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract No';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Ana09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
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

SET @LanguageValue = N'Currency Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange Rate';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Original Currency Value';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Converted Value of contract';
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

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher Type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
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

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract package';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ContractPackageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ConRefName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ConRef';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ConRef', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Step';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.StepID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment Content';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.StepName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Pay later (Date)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.StepDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'%';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.PaymentPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.PaymentAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.StepStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Complete Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.CompleteDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.PaymentDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Correct Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.CorrectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment Status';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.PaymentStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Paymented';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Paymented', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'InventoryID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.OrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Price';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.SalePrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Original';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.OriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Converted';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT Group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.VATGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% VAT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.VATPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT Original Amount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.VATOriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT Converted Amount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.VATConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VAT Group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.VATGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total Amount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.TotalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract InFomation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ThongTinHopDong' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment Infomation'
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ThongTinThanhToan' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Additional Infomation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ThongTinBoSung' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Commodity Information';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.ThongTinHangHoa' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.TabCRMT00003' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.TabCRMT00002' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'CIF1362.TabCRMT90031' , @FormID, @LanguageValue, @Language;

