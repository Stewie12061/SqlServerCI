-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2141- SO
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
SET @FormID = 'SOF2141';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day vouchers';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.CuratorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.CuratorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.InvestorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Investor';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.InvestorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.GeneralContractorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'General Contractor';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.GeneralContractorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.AppendixContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract Addendum';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.AppendixContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales agent';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ProjectManagementID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project management';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ProjectManagementName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ClerkID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Prof. Construction';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ClerkName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales revenue without VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.RevenueExcludingVAT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Revenue';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.Revenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total cost of goods sold';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.TotalCostOfGoodsSold', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Profit before tax';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ProfitBeforeTax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Profit margin';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ProfitMargin', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reviewer comments';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of technical quotation';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.IsInheritKT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of Sale quote';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.IsInheritSale', @FormID, @LanguageValue, @Language;

