-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2011 - BEM
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
SET @FormID = 'BEMF2011';

SET @LanguageValue = N'住所';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Accommodation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.AdvanceCurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.AdvanceCurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'立替予定金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.AdvanceEstimate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'立替対象';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.AdvancePaymentUser', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'立替対象';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.AdvancePaymentUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'立替対象';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.AdvancePaymentUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日別出張料';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.BusinessFeePerDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'市';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'市コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CityID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'市';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'市の名前';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CityName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'会社名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'国';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'国コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CountryID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'国';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CountryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'国';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CountryName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'種類コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日付';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DepartmentAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門名前';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DepartmentAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金負担部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DepartmentCharged', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金負担部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DepartmentChargedName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門名前';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DepartmentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'目的地';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Destination', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到着先';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DestinationDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'非表示';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'会社／業者ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最終更新日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最終更新者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DutyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'役職';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'役職';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DutyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'緊急申請の理由';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.EmergencyReason', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日まで';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日程';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Journeys', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最終更新日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最終更新者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'宿泊費';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.LivingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'接待費';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.MeetingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者の意見';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日数';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.NumberOfDateStay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'その他';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.OtherFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工程';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工程コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.ProcessID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工程名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.ProcessName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'休暇出張目的';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Purpose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'理由';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.ReasonOtherFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SectionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SectionName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日から';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータスコード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.StatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.StatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SubsectionAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門名前';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SubsectionAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SubsectionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門名前';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SubsectionName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'チーム';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'チームコード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TeamID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'チーム';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TeamName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'チーム名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TeamName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'同行';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TheOthers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'チケット';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TicketFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張・帰国休暇承認申請書の更新';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'役職';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'役職コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TitleID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'役職';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'役職';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TitleName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'数合計（日）';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TotalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金合計';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'旅費';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TravellingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TypeBSTripID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'種類コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TypeBSTripID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TypeBSTripName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TypeBSTripName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'類型';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'類型';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'種類コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TypePriorityID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'類型';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TypePriorityName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'旅費の仕訳';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CostSummaryTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張期間';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DurationTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.ObjectTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'目的';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.PurposeTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文書の情報';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.VoucherInformationTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張先';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.WorkPlaceTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'種類コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.AdvanceCurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.AdvanceCurrencyName.CB', @FormID, @LanguageValue, @Language;
