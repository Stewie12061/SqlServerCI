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
SET @Language = 'zh-CN' 
SET @ModuleID = 'SO';
SET @FormID = 'SOF2141';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'會計日期';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.CuratorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.CuratorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.InvestorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'投資者';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.InvestorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.GeneralContractorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'總承包商';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.GeneralContractorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合約';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.AppendixContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'PL合同';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.AppendixContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銷售員';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ProjectManagementID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'專案管理';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ProjectManagementName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ClerkID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'施工監理';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ClerkName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不含增值稅的銷售收入';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.RevenueExcludingVAT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'收入';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.Revenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銷售商品的總成本';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.TotalCostOfGoodsSold', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稅前利潤';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ProfitBeforeTax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'利潤率';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ProfitMargin', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'審核人意見';
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

SET @LanguageValue = N'地位';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'技術報價單的繼承';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.IsInheritKT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銷售報價的繼承';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.IsInheritSale', @FormID, @LanguageValue, @Language;

