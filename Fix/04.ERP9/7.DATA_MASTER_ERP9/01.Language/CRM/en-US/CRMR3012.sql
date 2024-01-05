-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMR3012- CRM
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
SET @FormID = 'CRMR3012';

------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Actual indicators against the expected of the campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3012.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3012.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3012.FromCampaignID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3012.ToCampaignID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3012.FromCampaignName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3012.ToCampaignName' , @FormID, @LanguageValue, @Language;


