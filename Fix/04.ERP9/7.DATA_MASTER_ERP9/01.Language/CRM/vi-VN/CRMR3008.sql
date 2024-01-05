DECLARE @FormID VARCHAR(50)
DECLARE @ModuleID VARCHAR(50)
DECLARE @Language VARCHAR(50)
DECLARE @LanguageValue NVARCHAR(500)
SET @ModuleID = 'CRM'
SET @Language = 'vi-VN'

SET @FormID = 'CRMR3008'
SET @LanguageValue = N'Phân tích khách hàng từ nguồn cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3008.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3008'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3008.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3008'
SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3008.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3008'
SET @LanguageValue = N'Nguồn đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3008.LeadTypeName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3008'
SET @LanguageValue = N'Giai đoạn bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3008.StageID' , @FormID, @LanguageValue, @Language;