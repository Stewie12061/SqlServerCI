-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2101- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF2101';

SET @LanguageValue = N'Update project/task group';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.Tilte', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ProjectType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project sample';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ProjectSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Checking date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.CheckingDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leader';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.LeaderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Related type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.FromDateToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leader';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.LeaderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ProjectDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mark';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.Mark', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes by assessor ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reject';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.Reject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount Factor KHCU';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.DiscountFactorKHCU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount Factor NC';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.DiscountFactorNC', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount Factor KHCU service';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.DiscountFactorKHCUService', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.NodeOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.TaskTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.TargetTypeName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Percent Progress (%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'StatusID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ObjectTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ActualStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ActualEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sample ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ProjectSampleID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sample name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ProjectSampleName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.AssignedToUserID.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.AssignedToUserName.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ReviewerUserID.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ReviewerUserName.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.SupportUserID.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.SupportUserName.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.AssessUserID1.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.AssessUserName1.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.AssessUserID2.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.AssessUserName2.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.AssessUserID3.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.AssessUserName3.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Access User Name1';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.AssessUserName1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assess User Name2';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.AssessUserName2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Access User Name3';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.AssessUserName3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.PlanTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.Update', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Net sales';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.NetSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Commission cost';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.CommissionCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Guest cost';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.GuestCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bonus sales';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.BonusSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'No.';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.RowNumColumn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Previous task';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.PreviousTaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parent task';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ParentTaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create process';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.CreateProcess', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Calculate deadline';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.CalculateDeadline', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mark';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.Mark', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reject';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.Reject', @FormID, @LanguageValue, @Language;											 

