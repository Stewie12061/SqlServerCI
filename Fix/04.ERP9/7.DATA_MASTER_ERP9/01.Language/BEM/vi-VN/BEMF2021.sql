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

SET @Language = 'vi-VN' 
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2021';

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.AdvanceCurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.AdvanceCurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.AdvanceTotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đề nghị công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.BSTripProposalVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành phố';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thành phố';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CityID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thành phố';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CityName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Contents', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CostAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CostAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đất nước';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đất nước';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CountryID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đất nước';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CountryName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyName1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyName2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyName3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyName4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CurrencyName5', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tháng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.DepartmentAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.DepartmentAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.FeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hành trình';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Journeys', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chú thích';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.NoteFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mục đích công tác nghỉ phép';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Purpose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cấp bậc';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Rank', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cấp bậc';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.RankName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền còn lại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.RemainingAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TeamName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đi cùng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TheOthers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật phiếu thanh toán đi lại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức danh';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức danh';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TotalFee1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TotalFee2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TotalFee3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TotalFee4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TotalFee5', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TypeBSTripID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại CT';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TypeBSTripID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại CT';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TypeBSTripName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ý kiến người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.FeeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.FeeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền quy đổi (VNĐ)';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.ConvertedAmount2012', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã PT';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.DepartmentAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên MPT phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.DepartmentAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã PT';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CostAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên MPT chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.CostAnaName.CB', @FormID, @LanguageValue, @Language;

------------------------ Modified by Tấn Thành on 09/09/2020 ---------------------------------------

SET @LanguageValue = N'Thời hạn công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.DurationTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.ObjectTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.WorkPlaceTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tạm ứng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.AdvancePaymentTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.TotalCostTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mục đích';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.PurposeTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.VoucherInformationTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin duyệt';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.ApprovalInformationTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.AdvanceCurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2021.AdvanceCurrencyName.CB', @FormID, @LanguageValue, @Language;

