-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2111- OO
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
SET @FormID = 'OOF2111';

SET @LanguageValue = N'Update task';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parent Task';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ParentTaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Previous Task';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.PreviousTaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Support User';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.SupportUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Supervisor';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ReviewerUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percent Progress';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Orders';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repeat';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.IsRepeat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Planned Start Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Planned End Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.PlanTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual Start Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ActualStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual End Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ActualEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual Time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ActualTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project/Task group';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Step';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.StepID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TaskTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets Type ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TargetTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Support User';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.SupportUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Supervisor';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ReviewerUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.APKSettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project/Task group';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Step Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.StepName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parent Task';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ParentTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Previous Task';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.PreviousTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Willful violation';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.IsViolated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mark';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.Mark', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.APKRel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TypeRel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.LastStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assessment status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.StatusAssessor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task closing';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.IsClosedTask', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'New task ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TaskIDNew', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.NodeLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.NodeOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.NodeParent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.LastPriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Completion rejection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.Reject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.LastAssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.LastSupportUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.LastReviewerUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TargetsGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.IsAssessor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.IsCycle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task sample ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TaskSampleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task Sample';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TaskSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.APKViolated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.IsContactPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.OriginalTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sale Order';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.SaleOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.APKSaleOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.NextPlanDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target type ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TargetTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target type name';						   
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TargetTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assess User Name1';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.AssessUserName1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assess User Name2';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.AssessUserName2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assess User Name3';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.AssessUserName3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assess {0}';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.AssessUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work Update';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task ID new';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TaskIDNew', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Close task';								 
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.IsClosedTask', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Template ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ProjectID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Template name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ProjectName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ProcessID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ProcessName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Step ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.StepID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Step name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.StepName.CB', @FormID, @LanguageValue, @Language;
