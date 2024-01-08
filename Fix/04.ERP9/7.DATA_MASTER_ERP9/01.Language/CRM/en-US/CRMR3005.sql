-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMR3005- CRM
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
SET @FormID = 'CRMR3005';

-------------------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Summary of conversion rate from opportunity';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3005.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3005.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From stage';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3005.FromStageID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To stage';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3005.ToStageID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From employee';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3005.FromSalesManName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To employee';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3005.ToSalesManName' , @FormID, @LanguageValue, @Language;

