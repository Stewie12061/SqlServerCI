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

SET @Language = 'ja-JP'
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2004';

SET @LanguageValue = N'立替対象';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.AdvanceUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.CostAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.DepartmentAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'注釈';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'為替レート';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'請求日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.InvoiceDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'請求番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.InvoiceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支払方法';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.MethodPay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'対象';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支払方法';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'メソッドコード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.PaymentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'メソッド名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.PaymentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'残りの金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.RemainingAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'請求金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.RequestAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稟議番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.RingiNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'立替申請継承画面';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'請求金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.AdvancePayment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'注釈';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2004.DescriptionMaster', @FormID, @LanguageValue, @Language;