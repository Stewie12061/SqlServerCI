-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2010- BEM
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
SET @FormID = 'BEMF2010';

SET @LanguageValue = N'Application for outbound business-annual leave';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accommodation';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Accommodation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency  ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.AdvanceCurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Advance estimate';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.AdvanceEstimate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Advance payment user';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.AdvancePaymentUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'APK';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Applicant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business fee per day';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.BusinessFeePerDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'City';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Company name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department charged';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DepartmentCharged', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Emergency reason';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.EmergencyReason', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Journeys';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Journeys', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accommodation fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.LivingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Guest fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.MeetingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of stay days';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.NumberOfDateStay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.OtherFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purpose for business trip-annual leave';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Purpose', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.ReasonOtherFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Team  ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The others';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TheOthers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ticket  ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TicketFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total days';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TotalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of business';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TypeBSTripID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delete Flag';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Travelling fee';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TravellingFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Advance payment user';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.AdvancePaymentUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Applicant';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.ApplicantName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of business';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TypeBSTripName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department charged';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DepartmentChargedName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.AdvanceCurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CountryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'City';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Levels', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note of approver';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approver name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.ApprovePersonName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.ParentForm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.CurrentLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.StatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.StatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DepartmentAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.DepartmentAnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TypeBSTripID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TypeBSTripName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TypePriorityID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type priority';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.TypePriorityName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.SubsectionAnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2010.SubsectionAnaName.CB', @FormID, @LanguageValue, @Language;