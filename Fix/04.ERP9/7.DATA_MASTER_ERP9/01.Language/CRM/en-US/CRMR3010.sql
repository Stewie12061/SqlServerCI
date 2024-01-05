-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMR3010- CRM
------------------------------------------------------------------------------------------------------

declare @FormID varchar(200),
		@ModuleID varchar(10),
		@Language varchar(10),
		@LanguageValue nvarchar(4000)
	
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
------------------------------------------------------------------------------------------------------
/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/	

SET @Language = 'en-US'	
SET @ModuleID = 'CRM';
SET @FormID = 'CRMR3010';

------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Sales funnel by employees';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From employee';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.FromSalesManName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employees';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.SalemanName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To employee';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.ToSalesManName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total lead';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.TotalLead' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total opportunity';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.TotalOpportunity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total customers';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.TotalCustomer' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion rate of lead=>opportunity';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.LeadToOpportunity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion rate of lead => customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.LeadToCustomer' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion rate of opportunity=>customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.OpportunityToCustomer' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3010.Sum' , @FormID, @LanguageValue, @Language;