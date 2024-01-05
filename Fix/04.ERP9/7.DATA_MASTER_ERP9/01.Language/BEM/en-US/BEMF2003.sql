-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2003 - BEM
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
SET @FormID = 'BEMF2003';

SET @LanguageValue = N'Invoice no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.InvoiceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Original amount';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.OriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Remaining amount';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.RemainingAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'RingiNo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.Serial', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherited coupon / general entries';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'PO no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.OrderID', @FormID, @LanguageValue, @Language;

