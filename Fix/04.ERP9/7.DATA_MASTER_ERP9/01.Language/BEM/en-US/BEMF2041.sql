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

SET @Language = 'en-US'
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2041';

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.WorkDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work place';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work proposal';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.WorkProposal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work results';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.WorkResults', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content details';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.ContentDetails', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date report';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.DateReport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purpose';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.Purpose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.StatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.StatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update trip reports';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2041.Title', @FormID, @LanguageValue, @Language;

