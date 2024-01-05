-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2021 - BEM
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
SET @FormID = 'BEMF2021';

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.AdvanceCurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.AdvanceCurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'金額合計';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.AdvanceTotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張申請';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.BSTripProposalVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'市';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'市コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CityID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'市の名前';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CityName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'内容';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Contents', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交換金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交換金額（VND）';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.ConvertedAmount2012', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CostAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CostAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CostAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用分析コード名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CostAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'国';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'国コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CountryID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'国名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CountryName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類のコード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyName1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyName2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyName3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyName4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyName5', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日付';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.DepartmentAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.DepartmentAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.DepartmentAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署分析コード名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.DepartmentAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日まで';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'為替レート';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.FeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.FeeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用種名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.FeeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日から';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日程';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Journeys', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者の意見';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'注釈';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.NoteFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'休暇出張目的';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Purpose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ランク';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Rank', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ランク';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.RankName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'残りの金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.RemainingAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日から';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'チーム';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'チーム';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TeamName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'同行';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TheOthers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'旅費支払票の更新';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'役職';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'役職';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日まで';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'金額合計';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'金額合計';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TotalFee1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'金額合計';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TotalFee2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'金額合計';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TotalFee3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'金額合計';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TotalFee4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'金額合計';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TotalFee5', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TypeBSTripID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票種類コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TypeBSTripID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票種名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TypeBSTripName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張地';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'前払金';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.AdvancePaymentTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認情報';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.ApprovalInformationTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張期間';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.DurationTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.ObjectTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'目的';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.PurposeTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'旅費合計';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TotalCostTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文書の情報';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.VoucherInformationTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張先';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.WorkPlaceTitle', @FormID, @LanguageValue, @Language;
