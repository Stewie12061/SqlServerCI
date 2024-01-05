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

SET @Language = 'ja-JP'
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2003';

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'種類コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'種類名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'注釈';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'請求番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.InvoiceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'対象';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.OriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'残りの金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.RemainingAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稟議番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.Serial', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'買物バウチャーの継承/合計計上';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'クーポンコード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'PO 番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2003.OrderID', @FormID, @LanguageValue, @Language;