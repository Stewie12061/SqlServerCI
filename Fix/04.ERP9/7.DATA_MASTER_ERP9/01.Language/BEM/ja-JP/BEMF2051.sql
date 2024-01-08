-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2051 - BEM
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
SET @FormID = 'BEMF2051';

SET @LanguageValue = N'金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.ContentCostID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.ContentCostName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用内容';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.ContentCosts', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類のコード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'年月日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'チェックイン日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.DateCheckIn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'チェックアウト日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.DateCheckOut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日程';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.Journeys', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者の意見';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'その他の内容';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.OtherContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'その他の費用内容';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.OtherContentCosts', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票発行場所';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.ReleasePlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータスコード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.StatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.StatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'翻訳されたドキュメントのコンテンツを更新する';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票の翻訳票';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張申請';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.WorkProposal', @FormID, @LanguageValue, @Language;
