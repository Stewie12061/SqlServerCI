DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF1070'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục ngành nghề kinh doanh'
EXEC ERP9AddLanguage @ModuleID, 'CRMF1070.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1070.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ngành nghề kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1070.BusinessLinesID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ngành nghề kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1070.BusinessLinesName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1070.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1070.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1070.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1070.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1070.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1070.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1070.LastModifyDate',  @FormID, @LanguageValue, @Language;


