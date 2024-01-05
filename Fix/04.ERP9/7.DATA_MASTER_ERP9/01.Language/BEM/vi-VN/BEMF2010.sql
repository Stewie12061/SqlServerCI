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

SET @Language = 'vi-VN' 
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2010';

SET @LanguageValue = N'Nơi ở';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Accommodation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.AdvanceCurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.AdvanceCurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền dự kiến tạm ứng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.AdvanceEstimate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng tạm ứng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.AdvancePaymentUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng tạm ứng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.AdvancePaymentUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APK';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công tác phí theo ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.BusinessFeePerDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành phố';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành phố';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công ty';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CountryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CreateDate';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CreateUserID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cờ xóa';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DepartmentAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DepartmentAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận chịu phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DepartmentCharged', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận chịu phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DepartmentChargedName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Destination';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Destination', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TeamName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đi cùng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TheOthers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vé';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TicketFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh mục Đơn xin duyệt công tác - nghỉ phép về nước';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức danh';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức danh';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số (ngày)';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TotalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đi lại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TravellingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TypeBSTripID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TypeBSTripID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TypeBSTripName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TypeBSTripName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hình';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hình';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TypePriorityID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hình';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TypePriorityName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DestinationDetail';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DestinationDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lý do xin gấp';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.EmergencyReason', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hành trình';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Journeys', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'LastModifyDate';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'LastModifyUserID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ở';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.LivingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiếp khách';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.MeetingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Comment Approver';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.NumberOfDateStay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.OtherFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mục đích công tác nghỉ phép';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Purpose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lí do';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.ReasonOtherFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.StatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.StatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.SubsectionAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.SubsectionAnaName.CB', @FormID, @LanguageValue, @Language;

