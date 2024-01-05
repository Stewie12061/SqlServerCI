-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMR3009- CRM
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
SET @FormID = 'CRMR3009';

------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Summary of customer quantity of employee';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3009.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3009.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3009.FromAccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3009.ToAccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From employee';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3009.FromSalesManName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To employee';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3009.ToSalesManName' , @FormID, @LanguageValue, @Language;



