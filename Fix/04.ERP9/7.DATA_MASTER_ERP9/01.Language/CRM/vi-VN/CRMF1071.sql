DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF1071'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật ngành nghề kinh doanh'
EXEC ERP9AddLanguage @ModuleID, 'CRMF1071.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1071.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ngành nghề kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1071.BusinessLinesID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ngành nghề kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1071.BusinessLinesName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1071.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1071.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1071.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1071.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1071.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1071.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1071.LastModifyDate',  @FormID, @LanguageValue, @Language;


