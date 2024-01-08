declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'vi-VN'

SET @FormID = 'CRMR3010'
SET @LanguageValue = N'Phễu bán hàng theo nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3010'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3010'
SET @LanguageValue = N'Từ nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.FromSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3010'
SET @LanguageValue = N'Đến nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.ToSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3010'
SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.SalemanName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3010'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3010'
SET @LanguageValue = N'Số đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.TotalLead' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3010'
SET @LanguageValue = N'Số cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.TotalOpportunity' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3010'
SET @LanguageValue = N'Số khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.TotalCustomer' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3010'
SET @LanguageValue = N'Tỷ lệ chuyển đổi đầu mối => cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.LeadToOpportunity' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3010'
SET @LanguageValue = N'Tỷ lệ chuyển đổi đầu mối => khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.LeadToCustomer' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3010'
SET @LanguageValue = N'Tỷ lệ chuyển đổi cơ hội => khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.OpportunityToCustomer' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3010'
SET @LanguageValue = N'Tổng cộng';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.Sum' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3010'
SET @LanguageValue = N'Số cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.TotalOpportunity' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3010'
SET @LanguageValue = N'Số khách hàng từ đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.TotalCustomerFromLead' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3010'
SET @LanguageValue = N'Số khách hàng từ cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.TotalCustomerFromOpportunity' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3010'
SET @LanguageValue = N'Số liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.TotalContact' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3010'
SET @LanguageValue = N'Số khách hàng từ liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.TotalCustomerFromContact' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3010'
SET @LanguageValue = N'Tỷ lệ chuyển đổi liên hệ => khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.ContactToCustomer' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3010'
SET @LanguageValue = N'Số cơ hội từ đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.TotalOpportunityFromLead' , @FormID, @LanguageValue, @Language;
