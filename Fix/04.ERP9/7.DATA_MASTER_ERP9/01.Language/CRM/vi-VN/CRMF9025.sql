declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'Vi-VN'


SET @FormID = 'CRMF9025'
SET @LanguageValue = N'Chọn liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9025.Title' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9025.DivisionID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9025.ContactID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9025.ContactName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9025.HomeAddress' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Di động';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9025.HomeMobile' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9025.HomeTel' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9025.HomeEmail' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9025.IsCommon' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9025.Disabled' , @FormID, @LanguageValue, @Language;