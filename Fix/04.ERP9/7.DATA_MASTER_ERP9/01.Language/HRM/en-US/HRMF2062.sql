-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2062- HRM
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
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2062';

SET @LanguageValue  = N'Training budget view';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Budget code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.BudgetID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'All the people in company';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.IsAllName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Budget according to';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.IsBugetYearName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Precious';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.TranQuarter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'All the people in company';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.IsAll', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quarterly/Yearly Budget';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.TranQuarterYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount of money';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.BudgetAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The remaining amount';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.RemainBudgetAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.IsQuarterYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Budget accordingly';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.IsBugetYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training budget information';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.SubTitle1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2062.StatusID',  @FormID, @LanguageValue, @Language;