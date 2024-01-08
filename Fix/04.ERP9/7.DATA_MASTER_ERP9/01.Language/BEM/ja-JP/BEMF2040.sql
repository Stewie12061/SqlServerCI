-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2040 - BEM
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
SET @FormID = 'BEMF2040';

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'詳細内容';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.ContentDetails', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'報告日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.DateReport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張目的';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.Purpose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.WorkDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張地';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張申請';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.WorkProposal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張結果';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.WorkResults', @FormID, @LanguageValue, @Language;
