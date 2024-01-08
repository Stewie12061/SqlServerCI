-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ TF2001- CI
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
SET @FormID = 'TF2001';

SET @LanguageValue = N'Budget update';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Budget type';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.BudgetType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Budget period';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Month', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Year', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department/School';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.VoucherTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach file';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approval date';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.ApprovalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Original amount';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.OriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Converted amount';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 01';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales agent';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 02';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sectors';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana02Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 03';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expenses';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana03Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 04';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expenses';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana04Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 05';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Items';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana05Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 06';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Branch';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana06Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 07';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana07Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 08';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana08Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 09';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Goods';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana09Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code 10';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana10ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Goods details';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana10Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approval original amount';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.ApprovalOriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approval converted amount';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.ApprovalConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approval account notes';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.ApprovalAccountNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Budget type name';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.BudgetTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approval Date';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.ApprovalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve Person 01';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.ApprovePerson01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve Person 02';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.ApprovePerson02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type id';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type name';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency id';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency name';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ana id';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ana name';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.AnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department id';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.DepartmentName.CB', @FormID, @LanguageValue, @Language;