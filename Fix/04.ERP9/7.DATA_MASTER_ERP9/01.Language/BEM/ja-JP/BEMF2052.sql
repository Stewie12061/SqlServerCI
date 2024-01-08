-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2052 - BEM
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
SET @FormID = 'BEMF2052';

SET @LanguageValue = N'金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者01';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.ApprovePerson01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者02';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.ApprovePerson02Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'添付';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.ContentCostID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用内容';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.ContentCostName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.ContentCostName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用内容';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.ContentCosts', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'年月日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'チェックイン日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.DateCheckIn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'チェックアウト日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.DateCheckOut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'注釈';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'会社／業者ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'明細情報';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日程';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Journeys', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編集日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編集者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備考';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'その他の内容';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.OtherContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'その他の費用内容';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.OtherContentCosts', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票発行場所';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.ReleasePlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'翻訳されたドキュメントのコンテンツを更新する';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票の翻訳票';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張申請';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.WorkProposal', @FormID, @LanguageValue, @Language;

------------------------------------ Modified by Tấn Thành on 27/10/2020 ----------------------------------

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Description', @FormID, @LanguageValue, @Language;