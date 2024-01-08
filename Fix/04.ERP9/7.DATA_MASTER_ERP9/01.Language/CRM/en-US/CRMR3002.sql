----------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMR3002 - CRM

------------------------------------------------------------------------------------------------------

DECLARE @ModuleID varchar(10),
		@FormID varchar(200),
		@Language varchar(10),
		@LanguageValue NVARCHAR(4000)

------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CRMR3002'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 

set @Language = N'en-US'
set @ModuleID = N'CRM';
set @FormID = N'CRMR3002';


-------------------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Opportunity summary from sources';
Exec ERP9AddLanguage @ModuleID, N'CRMR3002.Title', @FormID, @LanguageValue , @Language;

SET @LanguageValue =  N'From date';
Exec ERP9AddLanguage @ModuleID, N'CRMR3002.FromDate', @FormID,@LanguageValue, @Language; 

SET @LanguageValue =  N'To date';
Exec ERP9AddLanguage @ModuleID, N'CRMR3002.ToDate', @FormID, @LanguageValue , @Language; 

SET @LanguageValue =  N'From period';
Exec ERP9AddLanguage @ModuleID, N'CRMR3002.PeriodList', @FormID, @LanguageValue , @Language; 

SET @LanguageValue =  N'Division';
Exec ERP9AddLanguage @ModuleID, N'CRMR3002.DivisionID', @FormID, @LanguageValue , @Language;

SET @LanguageValue =  N'From lead source';
Exec ERP9AddLanguage @ModuleID, N'CRMR3002.FromLeadTypeID', @FormID, @LanguageValue , @Language; 

SET @LanguageValue = N'To lead source';
Exec ERP9AddLanguage @ModuleID, N'CRMR3002.ToLeadTypeID', @FormID, @LanguageValue , @Language;

SET @LanguageValue = N'From employee';
Exec ERP9AddLanguage @ModuleID, N'CRMR3002.FromEmployeeID', @FormID, @LanguageValue , @Language; 

SET @LanguageValue = N'To employee';
Exec ERP9AddLanguage @ModuleID, N'CRMR3002.ToEmployeeID', @FormID, @LanguageValue , @Language;

SET @LanguageValue =  N'From employee';
Exec ERP9AddLanguage @ModuleID, N'CRMR3002.FromEmployeeName', @FormID, @LanguageValue , @Language; 

SET @LanguageValue = N'To employee';
Exec ERP9AddLanguage @ModuleID, N'CRMR3002.ToEmployeeName', @FormID, @LanguageValue , @Language;