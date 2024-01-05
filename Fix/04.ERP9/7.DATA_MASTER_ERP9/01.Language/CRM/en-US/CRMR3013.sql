-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMR3013- CRM
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
SET @FormID = 'CRMR3013';

------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Daily Warranty Report';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3013.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3013.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Export Voucher No';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3013.ExportVoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3013.FromMemberName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sale Voucher No';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3013.SaleVoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Serial number';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3013.SerialNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shop';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3013.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3013.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3013.ToMemberName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warranty card No';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3013.WarrantyCard' , @FormID, @LanguageValue, @Language;


