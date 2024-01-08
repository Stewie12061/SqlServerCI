-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMR3011- CRM
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
SET @FormID = 'CRMR3011';

------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Sales funnel by company';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Each division';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.IsDivision' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'All division';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.AllDivision' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total lead';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.TotalLead' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total opportunity';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.TotalOpportunity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total customers';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.TotalCustomer' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion rate of lead=>opportunity';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.LeadToOpportunity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion rate of lead => customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.LeadToCustomer' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion rate of opportunity=>customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.OpportunityToCustomer' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3011.Sum' , @FormID, @LanguageValue, @Language;