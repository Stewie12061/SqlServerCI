-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMR3017- CRM
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
SET @FormID = 'CRMR3017';

------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Campaign report';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3017.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3017.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3017.CampaignID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3017.StatusID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3017.AssignedToUserID' , @FormID, @LanguageValue, @Language;

