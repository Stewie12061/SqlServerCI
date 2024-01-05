declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'vi-VN'

SET @FormID = 'CRMR3011'
SET @LanguageValue = N'Phễu bán hàng theo công ty';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3011'
SET @LanguageValue = N'Từng đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.IsDivision' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3011'
SET @LanguageValue = N'Tất cả đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.AllDivision' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3011'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3011'
SET @LanguageValue = N'Số đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.TotalLead' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3011'
SET @LanguageValue = N'Số cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.TotalOpportunity' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3011'
SET @LanguageValue = N'Số khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.TotalCustomer' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3011'
SET @LanguageValue = N'Tỷ lệ chuyển đổi đầu mối => cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.LeadToOpportunity' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3011'
SET @LanguageValue = N'Tỷ lệ chuyển đổi đầu mối => khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.LeadToCustomer' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3011'
SET @LanguageValue = N'Tỷ lệ chuyển đổi cơ hội => khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.OpportunityToCustomer' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3011'
SET @LanguageValue = N'Tổng cộng';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.Sum' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3011'
SET @LanguageValue = N'Địa chỉ:';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.Address' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3011'
SET @LanguageValue = N'Số điện thoại:';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.Tel' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3011'
SET @LanguageValue = N'Số fax:';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.Fax' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3011'
SET @LanguageValue = N'Email:';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.Email' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3011'
SET @LanguageValue = N'Số liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.TotalContact' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3011'
SET @LanguageValue = N'Số cơ hội từ đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.TotalOpportunityFromLead' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3011'
SET @LanguageValue = N'Tỷ lệ chuyển đổi liên hệ => khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.ContactToCustomer' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3011'
SET @LanguageValue = N'Số khách hàng từ đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.TotalCustomerFromLead' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3011'
SET @LanguageValue = N'Số khách hàng từ cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.TotalCustomerFromOpportunity' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3011'
SET @LanguageValue = N'Số khách hàng từ liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.TotalCustomerFromContact' , @FormID, @LanguageValue, @Language;