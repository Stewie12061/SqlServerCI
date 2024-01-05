declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'vi-VN'

SET @FormID = 'CRMF3050'
SET @LanguageValue = N'Số lượng đơn hàng theo nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3050.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3050'
SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3050.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3050'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3050.DivisionID' , @FormID, @LanguageValue, @Language;