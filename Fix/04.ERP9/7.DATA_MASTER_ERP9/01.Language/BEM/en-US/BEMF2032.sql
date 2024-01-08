-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2032 - BEM
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
SET @FormID = 'BEMF2032';

SET @LanguageValue = N'Applicant ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 01';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.ApprovePerson01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approve person 02';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.ApprovePerson02Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Company';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create userID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date define';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.DateDefine', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Destination';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.Destination', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Detail';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.History', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Info';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify userID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Working time record voucher infomation';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type bs trip';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.TypeBSTripName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work content';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.WorkContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work place';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work proposal';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.WorkProposal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.Description', @FormID, @LanguageValue, @Language;

