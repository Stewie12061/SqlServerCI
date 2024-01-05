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

SET @Language = 'en-US'
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2042';

SET @LanguageValue = N'Applicant ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 01';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.ApprovePerson01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 02';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.ApprovePerson02Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content area';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.ContentArea', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content details';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.ContentDetails', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create userID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date report';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.DateReport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Info';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify userID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purpose';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.Purpose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trip reports details';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.WorkDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work place';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work proposal';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.WorkProposal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work results';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.WorkResults', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2042.Description', @FormID, @LanguageValue, @Language;

