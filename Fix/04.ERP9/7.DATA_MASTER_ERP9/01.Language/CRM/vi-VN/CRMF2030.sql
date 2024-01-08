DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2030'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục đầu mối'
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ĐT công ty';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadTel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.Email',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nghề nghiệp';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.JobID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công ty';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.CompanyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.TitleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadStatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadStatusName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadSourceID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadSourceName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.AssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giới tính';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.GenderID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.BirthDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình trạng hôn nhân ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.MaritalStatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.BankAccountNo01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mở tại Ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.BankIssueName01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.NotesPrivate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sở thích';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.Hobbies',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Fax CT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.BusinessFax',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email CT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.BusinessEmail',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày thành lập';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.CompanyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.Website',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hình doanh nghiệp';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.EnterpriseDefinedID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú CT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.NotesCompany',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã số thuế';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.VATCode',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ CT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.BusinessAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadMobile',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.TabCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chọn người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.btnChooseAssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xóa người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.btnDeleteAssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nơi sinh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.PlaceOfDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại CT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.BusinessTel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.NumOfEmployee',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chuyển đổi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.IsConvert',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.InheritAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nguồn đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nguồn đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.StageID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.StageName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.CampaignID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.CampaignName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.CampaignID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.CampaignName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.AssignedToUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nguồn đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.LeadTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.CampaignDetailID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.CampaignDetailName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã trình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.StatusDetailID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.StatusDetailName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hội thảo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.SerminarID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hội thảo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.SerminarName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chuyên đề';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.ThematicID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chuyên đề';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2030.ThematicName',  @FormID, @LanguageValue, @Language;