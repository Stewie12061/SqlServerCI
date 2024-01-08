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

SET @Language = 'en-US'
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2051';

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.StatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.StatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update translate voucher';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work proposal';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.WorkProposal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.ContentCostID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.ContentCostName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content costs';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.ContentCosts', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date checkin';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.DateCheckIn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date checkout';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.DateCheckOut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Journeys';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.Journeys', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other content';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.OtherContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other content costs';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.OtherContentCosts', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Release place';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2051.ReleasePlace', @FormID, @LanguageValue, @Language;

