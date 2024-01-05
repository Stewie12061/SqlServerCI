DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2032'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết đầu mối'
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ĐT công ty';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadTel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.Email',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nghề nghiệp';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.JobID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công ty';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.CompanyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TitleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadStatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadStatusName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.AssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giới tính';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.GenderID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.BirthDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình trạng hôn nhân ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.MaritalStatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.BankAccountNo01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mở tại Ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.BankIssueName01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.NotesPrivate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sở thích';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.Hobbies',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.BusinessFax',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.BusinessEmail',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày thành lập';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.CompanyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.Website',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngành nghề kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.EnterpriseDefinedID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.NotesCompany',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã số thuế';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.VATCode',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.BusinessAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LeadMobile',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TabCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chọn người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.btnChooseAssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xóa người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.btnDeleteAssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nơi sinh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.PlaceOfDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.BusinessTel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.NumOfEmployee',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.BusinessMobile',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TabCMNT90051',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TabCRMT10001',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TabCRMT20401',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TabCRMT20501',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhiệm vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TabCRMT90041',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sự kiện';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TabCRMT90051',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nơi sinh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.PlaceOfBirth',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.ThongTinChung',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin công ty';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.ThongTinCongTy',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin cá nhân';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.ThongTinCaNhan',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.CampaignID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.CampaignName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TabOOT2110' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công việc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TaskID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công việc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TaskName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.AssignedToUserName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.StatusName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.PlanStartDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.PlanEndDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quy trình';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.ProcessName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bước';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.StepName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thương hiệu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TradeMarkID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mục tiêu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.ConversionTargetID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.CampaignDetailName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.StatusDetailName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hội thảo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.SerminarName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chuyên đề';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.ThematicName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Định vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TabCRMT20302',  @FormID, @LanguageValue, @Language;

-- [Hoài Bảo] [Ngày cập nhật: 30/08/2021] [Thêm ngôn ngữ cho Tab lịch sử cuộc gọi]
SET @LanguageValue  = N'Lịch sử cuộc gọi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2032.TabOOT2180',  @FormID, @LanguageValue, @Language;