-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2110- OO
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
SET @FormID = 'OOF2110';

SET @LanguageValue = N'List of tasks';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.TaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.TaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parent Task';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ParentTaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Previous Task';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.PreviousTaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Support User';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.SupportUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Supervisor';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ReviewerUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percent Progress';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Orders';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repeat';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.IsRepeat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Planned Start Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Planned End Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.PlanTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual Start Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ActualStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual End Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ActualEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual Time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ActualTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project/Task group';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Step';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.StepID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.TaskTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets Type ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.TargetTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Support User';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.SupportUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Supervisor';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ReviewerUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.APKSettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project/Task group';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Step Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.StepName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parent Task';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ParentTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Previous Task';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.PreviousTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Willful violation';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.IsViolated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mark';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.Mark', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.APKRel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.TypeRel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.LastStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assessment status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.StatusAssessor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task closing';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.IsClosedTask', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'New task ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.TaskIDNew', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.NodeLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.NodeOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.NodeParent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.LastPriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Completion rejection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.Reject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.LastAssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.LastSupportUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.LastReviewerUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.TargetsGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.IsAssessor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.IsCycle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task sample ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.TaskSampleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task Sample';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.TaskSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.APKViolated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.IsContactPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.OriginalTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sale Order';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.SaleOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.APKSaleOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.NextPlanDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ProjectID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ProjectName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ProcessID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ProcessName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Step ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.StepID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Step Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.StepName.CB', @FormID, @LanguageValue, @Language;
