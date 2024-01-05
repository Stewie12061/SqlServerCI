----------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMR3007 - CRM
----------------------------------------------------------------------------------------------------------

declare @FormID varchar(200),
		@ModuleID varchar(10),
		@Language varchar(10),
		@LanguageValue nvarchar(4000)

------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: en-US 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 

SET @Language = 'en-US'
SET @FormID = 'CRMR3007';
SET @ModuleID = 'CRM';

------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Opportunity summary by lines';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3007.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3007.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From business lines';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3007.FromBusinessLinesID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To business lines';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3007.ToBusinessLinesID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From employee';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3007.FromSalesManName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To employee';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3007.ToSalesManName' , @FormID, @LanguageValue, @Language;

