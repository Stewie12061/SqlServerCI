-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMR3008- CRM
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
SET @FormID = 'CRMR3008';

------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Analysis of customers from opportunity sources';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3008.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3008.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From lead source';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3008.FromLeadTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To lead source';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3008.ToLeadTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From stage';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3008.FromStageID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To stage';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3008.ToStageID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From employee';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3008.FromemployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To employee';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3008.ToemployeeName' , @FormID, @LanguageValue, @Language;

