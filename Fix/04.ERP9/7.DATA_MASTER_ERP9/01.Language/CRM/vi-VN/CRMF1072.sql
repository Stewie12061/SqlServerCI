DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF1072'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết nghành nghề kinh doanh'
EXEC ERP9AddLanguage @ModuleID, 'CRMF1072.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1072.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ngành nghề kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1072.BusinessLinesID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ngành nghề kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1072.BusinessLinesName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1072.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1072.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1072.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1072.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1072.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1072.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1072.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin ngành nghề kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1072.ThongTinLinhVucKinhDoanh',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1072.TabCRMT00003',  @FormID, @LanguageValue, @Language;


