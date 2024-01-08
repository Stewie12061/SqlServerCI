----------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMR3003 - CRM
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CRMR3003'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
-- Thêm ngôn ngữ bảng ERP9

DECLARE @ModuleID varchar(10),
		@FormID varchar(200),
		@Language varchar(10),
		@LanguageValue NVARCHAR(4000)

set @Language = N'en-US'
set @ModuleID = N'CRM';
set @FormID = N'CRMR3003';

-------------------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Opportunity summary by stages';
Exec ERP9AddLanguage @ModuleID, N'CRMR3003.Title', @FormID, @LanguageValue , @Language;

SET @LanguageValue =  N'From date';
Exec ERP9AddLanguage @ModuleID, N'CRMR3003.FromDate', @FormID,@LanguageValue, @Language; 

SET @LanguageValue =  N'To date';
Exec ERP9AddLanguage @ModuleID, N'CRMR3003.ToDate', @FormID, @LanguageValue , @Language; 

SET @LanguageValue =  N'From period';
Exec ERP9AddLanguage @ModuleID, N'CRMR3003.PeriodList', @FormID, @LanguageValue , @Language; 

SET @LanguageValue =  N'Division';
Exec ERP9AddLanguage @ModuleID, N'CRMR3003.DivisionID', @FormID, @LanguageValue , @Language;

SET @LanguageValue =  N'From stage';
Exec ERP9AddLanguage @ModuleID, N'CRMR3003.FromStageID', @FormID, @LanguageValue , @Language; 

SET @LanguageValue = N'To stage';
Exec ERP9AddLanguage @ModuleID, N'CRMR3003.ToStageID', @FormID, @LanguageValue , @Language;

SET @LanguageValue = N'From employee';
Exec ERP9AddLanguage @ModuleID, N'CRMR3003.FromEmployeeID', @FormID, @LanguageValue , @Language; 

SET @LanguageValue = N'To employee';
Exec ERP9AddLanguage @ModuleID, N'CRMR3003.ToEmployeeID', @FormID, @LanguageValue , @Language;

SET @LanguageValue =  N'From employee';
Exec ERP9AddLanguage @ModuleID, N'CRMR3003.FromEmployeeName', @FormID, @LanguageValue , @Language; 

SET @LanguageValue = N'To employee';
Exec ERP9AddLanguage @ModuleID, N'CRMR3003.ToEmployeeName', @FormID, @LanguageValue , @Language;