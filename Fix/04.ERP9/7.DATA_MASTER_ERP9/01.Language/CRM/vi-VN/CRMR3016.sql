DECLARE @FormID VARCHAR(50)
DECLARE @ModuleID VARCHAR(50)
DECLARE @Language VARCHAR(50)
DECLARE @LanguageValue NVARCHAR(500)
SET @ModuleID = 'CRM'
SET @Language = 'vi-VN'
SET @FormID = 'CRMR3016'

SET @LanguageValue = N'Tổng hợp nguồn đầu mối không tương tác';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3016.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3016.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3016.EmployeeID' , @FormID, @LanguageValue, @Language;