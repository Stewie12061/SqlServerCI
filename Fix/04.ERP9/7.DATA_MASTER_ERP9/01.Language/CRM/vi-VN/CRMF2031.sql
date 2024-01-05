DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2031'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật đầu mối'
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.CampaignID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xưng hô';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.Prefix',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LeadID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LeadName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ĐT công ty';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LeadTel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.Email',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nghề nghiệp';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.JobID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công ty';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.CompanyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.TitleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LeadStatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LeadStatusName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LeadSourceID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LeadTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LeadTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.AssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.AssignedToUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giới tính';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.GenderID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.BirthDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình trạng hôn nhân ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.MaritalStatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.BankAccountNo01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mở tại Ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.BankIssueName01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.NotesPrivate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sở thích';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.Hobbies',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.BusinessFax',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.BusinessEmail',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày thành lập';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.CompanyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.Website',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngành nghề kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.EnterpriseDefinedID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.NotesCompany',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã số thuế';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.VATCode',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.BusinessAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LeadMobile',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.TabCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chọn người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.btnChooseAssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xóa người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.btnDeleteAssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nơi sinh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.PlaceOfDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.BusinessTel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.NumOfEmployee',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.BusinessMobile',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nơi sinh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.PlaceOfBirth',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.ThongTinChung',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin công ty';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.ThongTinCongTy',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin cá nhân';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.ThongTinCaNhan',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nguồn đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LeadTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nguồn đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LeadTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.CountryID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.CountryName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.StageID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.StageName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã NNKD';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.BusinessLinesID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên NNKD';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.BusinessLinesName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.CampaignID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.CampaignName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thương hiệu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.TradeMarkID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mục tiêu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.ConversionTargetID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.CampaignDetailName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.StatusDetailName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hội thảo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.SerminarName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chuyên đề';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.ThematicName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Định vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.Dinhvi',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.CampaignID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2031.CampaignName.CB',  @FormID, @LanguageValue, @Language;


