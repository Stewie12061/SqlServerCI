-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2042 - BEM
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
SET @FormID = 'BEMF2042';

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者01';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.ApprovePerson01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者02';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.ApprovePerson02Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'添付';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'内容';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.ContentArea', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'詳細内容';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.ContentDetails', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'報告日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.DateReport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'注釈';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'会社／業者ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'明細情報';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編集日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編集者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備考';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張目的';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.Purpose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張報告詳細の閲覧';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.WorkDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張地';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張申請';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.WorkProposal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張結果';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.WorkResults', @FormID, @LanguageValue, @Language;

------------------------------------ Modified by Tấn Thành on 27/10/2020 ----------------------------------

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.Description', @FormID, @LanguageValue, @Language;