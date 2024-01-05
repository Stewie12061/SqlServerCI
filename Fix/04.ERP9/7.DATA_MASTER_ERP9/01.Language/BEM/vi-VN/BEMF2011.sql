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

SET @Language = 'vi-VN' 
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2011';

SET @LanguageValue = N'Nơi ở';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Accommodation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.AdvanceCurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.AdvanceCurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền dự kiến tạm ứng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.AdvanceEstimate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng tạm ứng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.AdvancePaymentUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng tạm ứng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.AdvancePaymentUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APK';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công tác phí theo ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.BusinessFeePerDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành phố';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thành phố';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CityID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành phố';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thành phố';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CityName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công ty';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CountryID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CountryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CountryName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CreateDate';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CreateUserID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày Tháng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DepartmentAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DepartmentAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TypePriorityID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hình';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TypePriorityName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa điểm đến';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Destination', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi đến';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DestinationDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DivisionID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DutyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DutyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lý do xin gấp';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.EmergencyReason', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hành trình';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Journeys', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'LastModifyDate';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'LastModifyUserID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ở';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.LivingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiếp khách';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.MeetingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ý kiến người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.NumberOfDateStay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.OtherFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.ProcessID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.ProcessName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mục đích công tác nghỉ phép';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Purpose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lí do';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.ReasonOtherFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SectionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SectionName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.StatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.StatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SubsectionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SubsectionName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhóm';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TeamID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TeamName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhóm';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TeamName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đi cùng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TheOthers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vé';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TicketFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật Đơn xin duyệt công tác - nghỉ phép về nước';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức danh';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chức danh';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TitleID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức danh';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức danh';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TitleName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số (ngày)';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TotalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đi lại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TravellingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TypeBSTripID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TypeBSTripID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TypeBSTripName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TypeBSTripName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hình';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hình';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận chịu phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DepartmentCharged', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận chịu phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DepartmentChargedName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DepartmentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SubsectionAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SubsectionAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.VoucherInformationTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.ObjectTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời hạn công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DurationTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.WorkPlaceTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mục đích';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.PurposeTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tóm tắt chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CostSummaryTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.AdvanceCurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.AdvanceCurrencyName.CB', @FormID, @LanguageValue, @Language;
