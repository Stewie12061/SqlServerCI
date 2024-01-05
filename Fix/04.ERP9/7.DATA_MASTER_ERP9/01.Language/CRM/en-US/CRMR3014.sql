-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMR3014- CRM
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
SET @FormID = 'CRMR3014';

------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Summary of opportunity non-creation customers';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3014.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3014.DivisionID' , @FormID, @LanguageValue, @Language;
