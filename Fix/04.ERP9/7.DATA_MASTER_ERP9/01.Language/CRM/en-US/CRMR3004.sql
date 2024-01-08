----------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMR3004 - CRM

------------------------------------------------------------------------------------------------------


DECLARE @ModuleID varchar(10),
		@FormID varchar(200),
		@Language varchar(10),
		@LanguageValue NVARCHAR(4000)

------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CRMR3004'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 

set @ModuleID = N'CRM'
set @FormID = N'CRMR3004';
set @Language = N'en-US';

-------------------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Opportunity value summary by employee';
Exec ERP9AddLanguage @ModuleID, N'CRMR3004.Title', @FormID, @LanguageValue , @Language;

SET @LanguageValue =  N'From date';
Exec ERP9AddLanguage @ModuleID, N'CRMR3004.FromDate', @FormID,@LanguageValue, @Language; 

SET @LanguageValue =  N'To date';
Exec ERP9AddLanguage @ModuleID, N'CRMR3004.ToDate', @FormID, @LanguageValue , @Language; 

SET @LanguageValue =  N'From period';
Exec ERP9AddLanguage @ModuleID, N'CRMR3004.PeriodList', @FormID, @LanguageValue , @Language; 

SET @LanguageValue =  N'Division';
Exec ERP9AddLanguage @ModuleID, N'CRMR3004.DivisionID', @FormID, @LanguageValue , @Language;

SET @LanguageValue =  N'From stage';
Exec ERP9AddLanguage @ModuleID, N'CRMR3004.FromStageID', @FormID, @LanguageValue , @Language; 

SET @LanguageValue = N'To stage';
Exec ERP9AddLanguage @ModuleID, N'CRMR3004.ToStageID', @FormID, @LanguageValue , @Language;

SET @LanguageValue = N'From employee';
Exec ERP9AddLanguage @ModuleID, N'CRMR3004.FromEmployeeID', @FormID, @LanguageValue , @Language; 

SET @LanguageValue = N'To employee';
Exec ERP9AddLanguage @ModuleID, N'CRMR3004.ToEmployeeID', @FormID, @LanguageValue , @Language;

SET @LanguageValue =  N'From employee';
Exec ERP9AddLanguage @ModuleID, N'CRMR3004.FromEmployeeName', @FormID, @LanguageValue , @Language; 

SET @LanguageValue = N'To employee';
Exec ERP9AddLanguage @ModuleID, N'CRMR3004.ToEmployeeName', @FormID, @LanguageValue , @Language;