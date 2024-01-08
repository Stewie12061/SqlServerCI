-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2041 - BEM
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
SET @FormID = 'BEMF2041';

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'詳細内容';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.ContentDetails', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'報告日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.DateReport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者の意見';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張目的';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.Purpose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータスコード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.StatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.StatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張報告更新';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.WorkDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張地';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張申請';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.WorkProposal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張結果';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.WorkResults', @FormID, @LanguageValue, @Language;
