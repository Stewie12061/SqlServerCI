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

SET @Language = 'ja-JP'
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2032';

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者01';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.ApprovePerson01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者02';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.ApprovePerson02Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'添付';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'パートナー会社';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票作成日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.DateDefine', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'注釈';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'目的地';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.Destination', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張時間記載票の詳細情報';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'会社／業者ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日まで';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日から';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'歴史';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.History', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張時間記載票の情報';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編集日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編集者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備考';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'パートナー会社';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.PartnerCompanies', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日から';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張時間記載票の情報';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日まで';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.TypeBSTripID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.TypeBSTripName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'仕事内容';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.WorkContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張地';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張申請';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.WorkProposal', @FormID, @LanguageValue, @Language;

------------------------------------ Modified by Tấn Thành on 27/10/2020 ----------------------------------

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2032.Description', @FormID, @LanguageValue, @Language;
