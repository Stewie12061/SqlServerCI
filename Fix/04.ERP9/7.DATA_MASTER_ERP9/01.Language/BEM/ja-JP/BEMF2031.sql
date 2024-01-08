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

SET @Language = 'ja-JP'
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2031';

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'パートナー会社';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票作成日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.DateDefine', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'目的地';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.Destination', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日まで';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日から';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者の意見';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'パートナー会社';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.PartnerCompanies', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日から';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータスコード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.StatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.StatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張時間記載票の更新';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日まで';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.TypeBSTripID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'種類コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.TypeBSTripID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.TypeBSTripName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'種類名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.TypeBSTripName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'仕事内容';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.WorkContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張地';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張申請';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2031.WorkProposal', @FormID, @LanguageValue, @Language;
