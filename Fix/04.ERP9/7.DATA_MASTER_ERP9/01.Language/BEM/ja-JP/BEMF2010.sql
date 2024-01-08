-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2010 - BEM
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
SET @FormID = 'BEMF2010';

SET @LanguageValue = N'住所';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Accommodation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.AdvanceCurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.AdvanceCurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'立替予定金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.AdvanceEstimate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'立替対象';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.AdvancePaymentUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'立替対象';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.AdvancePaymentUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日別出張料';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.BusinessFeePerDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'市';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'市';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'会社名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'国';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'国';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CountryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DepartmentAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門名前';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DepartmentAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金負担部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DepartmentCharged', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金負担部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DepartmentChargedName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到着先';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Destination', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到着先の詳細';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DestinationDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'非表示';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'会社／業者ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'役職';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'役職';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'緊急申請の理由';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.EmergencyReason', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日まで';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日程';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Journeys', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最終更新日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最終更新者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'宿泊費';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.LivingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'接待費';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.MeetingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備考';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日数';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.NumberOfDateStay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'その他';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.OtherFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'休暇出張目的';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Purpose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'理由';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.ReasonOtherFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日から';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.StatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.StatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.SubsectionAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門名前';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.SubsectionAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'チーム';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'チーム';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TeamName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'同行';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TheOthers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'チケット';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TicketFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張・帰国休暇承認申請書カテゴリー';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'役職';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'役職';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'数合計（日）';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TotalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金合計';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'旅費';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TravellingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TypeBSTripID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TypeBSTripID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TypeBSTripName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TypeBSTripName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'類型';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'類型';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'コード';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TypePriorityID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'類型';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TypePriorityName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.VoucherNo', @FormID, @LanguageValue, @Language;
