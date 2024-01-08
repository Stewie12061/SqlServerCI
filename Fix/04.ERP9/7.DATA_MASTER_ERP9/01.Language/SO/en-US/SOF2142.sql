-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2142- SO
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
SET @ModuleID = 'SO';
SET @FormID = 'SOF2142';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day vouchers';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.CuratorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.CuratorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.InvestorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Investor';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.InvestorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.GeneralContractorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'General Contractor';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.GeneralContractorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.ContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.AppendixContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract Addendum';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.AppendixContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales agent';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.ProjectManagementID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project management';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.ProjectManagementName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.ClerkID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Prof. Construction';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.ClerkName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales revenue without VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.RevenueExcludingVAT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Revenue';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.Revenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total cost of goods sold';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.TotalCostOfGoodsSold', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Profit before tax';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.ProfitBeforeTax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Profit margin';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.ProfitMargin', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.IsInheritKT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.IsInheritSale', @FormID, @LanguageValue, @Language;

