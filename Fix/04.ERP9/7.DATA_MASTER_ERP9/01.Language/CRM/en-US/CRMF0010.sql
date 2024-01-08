-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF0010- CRM
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT


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
SET @FormID = 'CRMF0010';

SET @LanguageValue = N'Dashboard';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales funnels and statistics';
EXEC ERP9AddLanguage @ModuleID, 'CRMD0001.Title', 'CRMD0001', @LanguageValue, @Language;

SET @LanguageValue = N'List of Opportunities';
EXEC ERP9AddLanguage @ModuleID, 'CRMD0003.Title', 'CRMD0003', @LanguageValue, @Language;

SET @LanguageValue = N'List of Clues';
EXEC ERP9AddLanguage @ModuleID, 'CRMD0004.Title', 'CRMD0004', @LanguageValue, @Language;

SET @LanguageValue = N'Sales funnels and statistics';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.SalesFunnelChart', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Filter data';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.btnFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales funnel by employee';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.FunnelEmployee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.Lead', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Opportunity';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.Opportunity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.Customer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'New Lead: ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.newLead', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total Lead: ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.totalLead', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total Opportunity: ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.totalOpportunity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Win: ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.newOpportityWin', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lose: ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.newOpportityLost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.Request', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'New Request: ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.newRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total Request: ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.totalRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'New Customer: ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.newCustomer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total Customer: ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.totalCustomer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.Contact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'New Contact: ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.newContact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total Contact: ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.totalContact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.sales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'List of Opportunities';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.GridOpportunity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'List of Clues';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.GridLead', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Period';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.Period', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Happy birthday';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.BirthToDayNotify', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Up comming Birthdate';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.BirthDayNotify', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Happy Pride Day!';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.HappyPrideDay', @FormID, @LanguageValue, @Language;