-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF0000 - BEM
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
SET @FormID = 'BEMF0000';

SET @LanguageValue = N'申請書';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.BSTripProposalVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張報告';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.BSTripReportVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張時間記入票';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.BSTripTimeVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.CostAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類のコード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.DepartmentAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'単位';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最終更新日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最終更新者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請書';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.ProposalVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.ReportCurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.SubsectionAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共通設定';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ドキュメントコンテンツの翻訳';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.TranslateDocVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'旅費支払い';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.TravelExpensesVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'クーポンコード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF0000.AnaName.CB', @FormID, @LanguageValue, @Language;
