-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2050 - BEM
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
SET @FormID = 'BEMF2050';

SET @LanguageValue = N'金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.ContentCostID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.ContentCostName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用内容';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.ContentCosts', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類のコード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'年月日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'チェックイン日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.DateCheckIn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'チェックアウト日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.DateCheckOut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日程';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.Journeys', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'その他の内容';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.OtherContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'その他の費用内容';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.OtherContentCosts', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票発行場所';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.ReleasePlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票内容翻訳のカテゴリー';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票の翻訳票';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張申請';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.WorkProposal', @FormID, @LanguageValue, @Language;
