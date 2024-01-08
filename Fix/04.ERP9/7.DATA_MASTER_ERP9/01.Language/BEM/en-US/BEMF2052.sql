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

SET @Language = 'en-US'
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2052';

SET @LanguageValue = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 01';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.ApprovePerson01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 02';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.ApprovePerson02Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.ContentCostID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content cost';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.ContentCostName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.ContentCostName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create userID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date checkin';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.DateCheckIn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date checkout';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.DateCheckOut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Info';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Journeys';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Journeys', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify userID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other content';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.OtherContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other content costs';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.OtherContentCosts', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Release place';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.ReleasePlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update translate voucher';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work proposal';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.WorkProposal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2052.Description', @FormID, @LanguageValue, @Language;

