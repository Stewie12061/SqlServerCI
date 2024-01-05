-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2030 - BEM
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
SET @FormID = 'BEMF2030';

SET @LanguageValue = N'Applicant ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date define';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.DateDefine', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Working time record voucher directory';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type bs trip ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.TypeBSTripID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type bs trip ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.TypeBSTripID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type bs trip';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.TypeBSTripName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work place';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work proposal';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2030.WorkProposal', @FormID, @LanguageValue, @Language;

