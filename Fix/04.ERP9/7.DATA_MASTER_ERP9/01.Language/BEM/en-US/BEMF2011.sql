-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2011- BEM
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
SET @FormID = 'BEMF2011';

SET @LanguageValue = N'Update applications for outbound business-annual leave';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accommodation';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Accommodation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency  ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.AdvanceCurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Advance estimate';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.AdvanceEstimate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Advance payment user';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.AdvancePaymentUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APK';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business fee per day';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.BusinessFeePerDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'City';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Company name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department charged';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DepartmentCharged', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Emergency reason';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.EmergencyReason', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Journeys';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Journeys', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accommodation fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.LivingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Guest fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.MeetingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of stay days';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.NumberOfDateStay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.OtherFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purpose for business trip-annual leave';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Purpose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.ReasonOtherFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Team  ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The others';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TheOthers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ticket  ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TicketFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total days';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TotalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of business';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TypeBSTripID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delete Flag';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Travelling fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TravellingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Advance payment user';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.AdvancePaymentUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of business';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TypeBSTripName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department charged';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DepartmentChargedName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency  ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.AdvanceCurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CountryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'City';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Levels', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note of approver';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approver name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.ApprovePersonName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.ParentForm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CurrentLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Destination';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.Destination', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Destination detail';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DestinationDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SectionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SectionName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.StatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.StatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SubsectionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SubsectionName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TeamID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TeamName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TitleID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TitleName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DepartmentAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DepartmentAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DepartmentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DutyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.DutyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TypeBSTripID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.TypeBSTripName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CityID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CityName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CountryID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.CountryName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.ProcessID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.ProcessName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SubsectionID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SubsectionAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SubsectionName';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.SubsectionAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.AdvanceCurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2011.AdvanceCurrencyName.CB', @FormID, @LanguageValue, @Language;