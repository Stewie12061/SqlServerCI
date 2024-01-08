-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2022 - BEM
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
SET @FormID = 'BEMF2022';

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.AdvanceCurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'立替金額種';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.AdvanceCurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'立替金額合計';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.AdvanceTotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者01';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.ApprovePerson01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.ApprovePerson01Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者02';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.ApprovePerson02Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張申請';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.BSTripProposalVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'市';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'市';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'内容';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Contents', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交換金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CostAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'国';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'国';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CountryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨1';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CurrencyName1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨2';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CurrencyName2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨3';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CurrencyName3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨4';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CurrencyName4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨5';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CurrencyName5', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日付';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署分析コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.DepartmentAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'注釈';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'添付';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'会社／業者ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日まで';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'為替レート';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日から';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備考';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編集日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編集者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'注釈';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.NoteFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'注釈';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'休暇出張目的';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Purpose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ランク';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Rank', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ランク';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.RankName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日から';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'チーム';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'チーム';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TeamName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'同行';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TheOthers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'明細情報';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.ThongTinChiTiet', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'旅費支払情報';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.ThongTinMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'旅費支払票の詳細閲覧';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'役職';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'役職';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日まで';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'金額合計';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合計1';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TotalFee1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合計2';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TotalFee2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合計3';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TotalFee3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合計4';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TotalFee4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合計5';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TotalFee5', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TypeBSTripID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TypeBSTripName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'旅費合計の備考';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.NoteTotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張目的';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.PurposeWork', @FormID, @LanguageValue, @Language;

------------------------------------ Modified by Tấn Thành on 27/10/2020 ----------------------------------
SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CreateDate';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CreateUserID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'LastModifyDate';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'LastModifyUserID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.LastModifyUserID', @FormID, @LanguageValue, @Language;