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

SET @Language = 'en-US'
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2050';

SET @LanguageValue = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.ContentCostID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.ContentCostName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content costs';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.ContentCosts', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date checkin';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.DateCheckIn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date checkout';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.DateCheckOut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Journeys';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.Journeys', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other content';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.OtherContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other content costs';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.OtherContentCosts', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Release place';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.ReleasePlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Translate voucher directory';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work proposal';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2050.WorkProposal', @FormID, @LanguageValue, @Language;

