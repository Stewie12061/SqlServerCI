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

SET @Language = 'vi-VN' 
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2022';

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.AdvanceCurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền tạm ứng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.AdvanceCurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng tiền tạm ứng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.AdvanceTotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 01';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.ApprovePerson01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.ApprovePerson01Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 02';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.ApprovePerson02Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đề nghị công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.BSTripProposalVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành phố';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành phố';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Contents', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CostAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đất nước';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đất nước';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CountryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền 1';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CurrencyName1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền 2';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CurrencyName2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền 3';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CurrencyName3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền 4';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CurrencyName4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền 5';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CurrencyName5', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tháng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.DepartmentAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chú thích';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.NoteFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mục đích công tác - nghỉ phép';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Purpose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cấp bậc';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Rank', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cấp bậc';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.RankName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TeamName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đi cùng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TheOthers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.ThongTinChiTiet', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin thanh toán phí đi lại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.ThongTinMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết phiếu thanh toán đi lại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức danh';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức danh';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng tiền 1';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TotalFee1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng tiền 2';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TotalFee2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng tiền 3';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TotalFee3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng tiền 4';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TotalFee4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng tiền 5';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TotalFee5', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TypeBSTripID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.TypeBSTripName', @FormID, @LanguageValue, @Language;

------------------------ Modified by Tấn Thành on 09/09/2020 ---------------------------------------

SET @LanguageValue = N'Mục đích công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.PurposeWork', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chú thích tổng phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.NoteTotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2022.LastModifyUserID', @FormID, @LanguageValue, @Language;
