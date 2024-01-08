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

SET @Language = 'en-US'
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2040';

SET @LanguageValue = N'Applicant ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content details';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.ContentDetails', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date report';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.DateReport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purpose';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.Purpose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.WorkDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work place';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work proposal';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.WorkProposal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work results';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2040.WorkResults', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trip reports directory';
EXEC ERP9AddLanguage @ModuleID, 'BEMT2040.Title', @FormID, @LanguageValue, @Language;

