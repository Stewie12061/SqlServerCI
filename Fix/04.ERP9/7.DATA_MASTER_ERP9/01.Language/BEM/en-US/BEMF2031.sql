-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2031 - BEM
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
SET @FormID = 'BEMF2031';

SET @LanguageValue = N'Applicant ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Company';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date define';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.DateDefine', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Destination';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.Destination', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Working time record voucher update';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type bs trip ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.TypeBSTripID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type bs trip';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.TypeBSTripName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type bs trip';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.TypeBSTripName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work content';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.WorkContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work place';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work proposal';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.WorkProposal', @FormID, @LanguageValue, @Language;

