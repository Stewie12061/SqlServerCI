-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2012 - BEM
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
SET @FormID = 'BEMF2012';

SET @LanguageValue = N'住所';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Accommodation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.AdvanceCurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.AdvanceCurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'立替予定金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.AdvanceEstimate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'立替対象';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.AdvancePaymentUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'立替対象';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.AdvancePaymentUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ApprovePersonName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ファイル名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.AttachName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.AttachUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日別出張料';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.BusinessFeePerDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'市';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'市';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'会社名';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交換金額';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'国';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'国';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CountryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'作成者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通貨種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請書リスト';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DanhSachPhieuDeNghi', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日付';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金負担部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DepartmentCharged', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金負担部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DepartmentChargedName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編集内容';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'目的地';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Destination', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到着先';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DestinationDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'添付';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'非表示';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'会社／業者ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'役職';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'役職';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'緊急申請の理由';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.EmergencyReason', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日まで';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備考';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日程';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Journeys', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最終更新日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最終更新者';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'宿泊費';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.LivingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'接待費';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.MeetingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張目的';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.MucDichCongTac', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者の意見';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日数';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.NumberOfDateStay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'その他';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.OtherFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工程';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'休暇出張目的';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Purpose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'理由';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ReasonOtherFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日から';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ステータス';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'チーム';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'チーム';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TeamName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'同行';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TheOthers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張報告情報';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ThongTinBaoCaoCongTac', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用情報';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Thongtinchiphi', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日程情報';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ThongTinChiTiet', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張・帰国休暇承認申請書の情報';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ThongTinMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票内容翻訳情報';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ThongTinPhanDichNoiDungChungTu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張時間記載票の情報';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ThongTinPhieuThoiGianCT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'旅費支払情報';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ThongTinThanhToanPhieuDiLai', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'チケット';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TicketFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張・帰国休暇承認申請書の詳細閲覧';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'役職';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'役職';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'数合計（日）';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TotalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'料金合計';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'旅費';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TravellingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TypeBSTripID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TypeBSTripName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'類型';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'類型';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票日';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票番号';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'伝票種類';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.VoucherType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出張地';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ファイルが添付された';
EXEC ERP9AddLanguage @ModuleID, 'BEMP2012.AttachName', @FormID, @LanguageValue, @Language;
