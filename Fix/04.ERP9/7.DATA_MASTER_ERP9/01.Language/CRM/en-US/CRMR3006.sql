----------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMR3006 - CRM
----------------------------------------------------------------------------------------------------------

DECLARE @ModuleID varchar(10),
		@FormID varchar(200),
		@Language varchar(10),
		@LanguageValue nvarchar(4000)

------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CRMR3006'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: en-US 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 

set @Language = N'en-US'
set @ModuleID = N'CRM';
set @FormID = N'CRMR3006';

-------------------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Opportunity summary by zones';
Exec ERP9AddLanguage @ModuleID, N'CRMR3006.Title', @FormID, @LanguageValue , @Language;

SET @LanguageValue =  N'From date';
Exec ERP9AddLanguage @ModuleID, N'CRMR3006.FromDate', @FormID,@LanguageValue, @Language; 

SET @LanguageValue =  N'To date';
Exec ERP9AddLanguage @ModuleID, N'CRMR3006.ToDate', @FormID, @LanguageValue , @Language; 

SET @LanguageValue =  N'From period';
Exec ERP9AddLanguage @ModuleID, N'CRMR3006.PeriodList', @FormID, @LanguageValue , @Language; 

SET @LanguageValue =  N'Division';
Exec ERP9AddLanguage @ModuleID, N'CRMR3006.DivisionID', @FormID, @LanguageValue , @Language;

SET @LanguageValue =  N'From stage';
Exec ERP9AddLanguage @ModuleID, N'CRMR3006.FromStageID', @FormID, @LanguageValue , @Language; 

SET @LanguageValue = N'To stage';
Exec ERP9AddLanguage @ModuleID, N'CRMR3006.ToStageID', @FormID, @LanguageValue , @Language;

SET @LanguageValue = N'From employee';
Exec ERP9AddLanguage @ModuleID, N'CRMR3006.FromEmployeeID', @FormID, @LanguageValue , @Language; 

SET @LanguageValue = N'To employee';
Exec ERP9AddLanguage @ModuleID, N'CRMR3006.ToEmployeeID', @FormID, @LanguageValue , @Language;

SET @LanguageValue =  N'From employee';
Exec ERP9AddLanguage @ModuleID, N'CRMR3006.FromEmployeeName', @FormID, @LanguageValue , @Language; 

SET @LanguageValue = N'To employee';
Exec ERP9AddLanguage @ModuleID, N'CRMR3006.ToEmployeeName', @FormID, @LanguageValue , @Language;

SET @LanguageValue =  N'From zone';
Exec ERP9AddLanguage @ModuleID, N'CRMR3006.FromAreaID', @FormID, @LanguageValue , @Language; 

SET @LanguageValue = N'To zone';
Exec ERP9AddLanguage @ModuleID, N'CRMR3006.ToAreaID', @FormID, @LanguageValue , @Language;