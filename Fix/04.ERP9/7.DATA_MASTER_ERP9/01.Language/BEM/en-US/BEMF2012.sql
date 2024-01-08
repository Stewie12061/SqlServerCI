-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2012- BEM
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT


------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
------------------------------------------------------------------------------------------------------
/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'en-US' 
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2012';

SET @LanguageValue = N'View application for outbound business-annual leave';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accommodation';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Accommodation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency  ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.AdvanceCurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Advance estimate';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.AdvanceEstimate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Advance payment user';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.AdvancePaymentUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APK';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business fee per day';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.BusinessFeePerDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'City';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Company name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department charged';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DepartmentCharged', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Emergency reason';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.EmergencyReason', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Journeys';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Journeys', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accommodation fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.LivingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Guest fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.MeetingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of stay days';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.NumberOfDateStay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.OtherFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purpose for business trip-annual leave';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Purpose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ReasonOtherFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Team  ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The others';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TheOthers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ticket  ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TicketFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total days';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TotalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of business';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TypeBSTripID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delete Flag';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Travelling fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TravellingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Advance payment user';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.AdvancePaymentUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of business';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TypeBSTripName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department charged';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DepartmentChargedName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency  ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.AdvanceCurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CountryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'City';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Levels', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note of approver';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approver name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ApprovePersonName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ParentForm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.CurrentLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Destination';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Destination', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Destination detail';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DestinationDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Information of report proposal';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ThongTinBaoCaoCongTac', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost information';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.Thongtinchiphi', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Details';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ThongTinChiTiet', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Information work confirmation letter';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ThongTinMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Information Translate contents voucher';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ThongTinPhanDichNoiDungChungTu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Information write time proposal voucher';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ThongTinPhieuThoiGianCT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Information travel voucher';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.ThongTinThanhToanPhieuDiLai', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purpose';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.MucDichCongTac', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposals Voucher ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2012.DanhSachPhieuDeNghi', @FormID, @LanguageValue, @Language;