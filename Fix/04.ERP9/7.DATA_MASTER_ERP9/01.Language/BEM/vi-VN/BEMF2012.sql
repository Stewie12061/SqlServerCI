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

SET @Language = 'vi-VN' 
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2012';

SET @LanguageValue = N'Nơi ở';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Accommodation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.AdvanceCurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.AdvanceCurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền dự kiến tạm ứng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.AdvanceEstimate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng tạm ứng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.AdvancePaymentUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng tạm ứng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.AdvancePaymentUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APK';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ApprovePersonName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên file';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.AttachName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.AttachUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công tác phí theo ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.BusinessFeePerDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành phố';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành phố';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công ty';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CountryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tháng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cờ xóa';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận chịu phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DepartmentCharged', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận chịu phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DepartmentChargedName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.NumberOfDateStay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.OtherFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mục đích công tác - nghỉ phép';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Purpose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lí do';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ReasonOtherFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TeamName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đi cùng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TheOthers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin báo cáo công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ThongTinBaoCaoCongTac', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Thongtinchiphi', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin hành trình';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ThongTinChiTiet', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin Đơn xin duyệt công tác - nghỉ phép về nước';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ThongTinMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin phần dịch nội dung chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ThongTinPhanDichNoiDungChungTu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin phiếu ghi thời gian công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ThongTinPhieuThoiGianCT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin thanh toán phí đi lại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ThongTinThanhToanPhieuDiLai', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vé';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TicketFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết Đơn xin duyệt công tác - nghỉ phép về nước';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức danh';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức danh';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa điểm đến';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Destination', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi đến';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DestinationDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lý do xin gấp';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.EmergencyReason', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hành trình';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Journeys', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'LastModifyDate';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'LastModifyUserID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ở';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.LivingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiếp khách';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.MeetingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ý kiến người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số (ngày)';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TotalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đi lại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TravellingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TypeBSTripID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TypeBSTripName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hình';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hình';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phiếu';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.VoucherType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mục đích công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.MucDichCongTac', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách Phiếu đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DanhSachPhieuDeNghi', @FormID, @LanguageValue, @Language;