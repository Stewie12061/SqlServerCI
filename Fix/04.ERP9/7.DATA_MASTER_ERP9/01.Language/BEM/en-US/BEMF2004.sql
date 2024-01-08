-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2004 - BEM
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),

------------------------------------------------------------------------------------------------------
-- Tham số gen tự động
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT

------------------------------------------------------------------------------------------------------
-- Gán giá trị tham số và thực thi truy vấn
------------------------------------------------------------------------------------------------------
/*
    - Tiếng Việt: vi-VN 
    - Tiếng Anh: en-US 
    - Tiếng Nhật: ja-JP
    - Tiếng Trung: zh-CN
*/

SET @Language = 'en-US'
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2004';

SET @LanguageValue = N'Advance nsername';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.AdvanceUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost analys';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.CostAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department analys';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.DepartmentAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Invoice date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.InvoiceDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Invoice no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.InvoiceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MethodPay';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.MethodPay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.PaymentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.PaymentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Remaining amount';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.RemainingAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request amount';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.RequestAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'RingiNo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.RingiNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit the advance request';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request amount';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.AdvancePayment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.DescriptionMaster', @FormID, @LanguageValue, @Language;