-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2112- OO
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
SET @FormID = 'OOF2112';

SET @LanguageValue = N'Task view';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.Tilte', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.TaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.TaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parent Task';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ParentTaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Previous Task';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.PreviousTaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Support User';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.SupportUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Supervisor';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ReviewerUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percent Progress';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Orders';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repeat';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.IsRepeat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Planned Start Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Planned End Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.PlanTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual Start Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ActualStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual End Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ActualEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual Time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ActualTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project/Task group';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Step';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.StepID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.TaskTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets Type ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.TargetTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Support User';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.SupportUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Supervisor';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ReviewerUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.APKSettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Step Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.StepName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parent Task';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ParentTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Previous Task';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.PreviousTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Willful violation';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.IsViolated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mark';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.Mark', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.APKRel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.TypeRel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.LastStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assessment status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.StatusAssessor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task closing';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.IsClosedTask', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'New task ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.TaskIDNew', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.NodeLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.NodeOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.NodeParent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.LastPriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Completion rejection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.Reject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.LastAssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.LastSupportUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.LastReviewerUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.TargetsGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.IsAssessor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.IsCycle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task sample ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.TaskSampleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task Sample';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.TaskSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.APKViolated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.IsContactPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.OriginalTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sale Order';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.SaleOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.APKSaleOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.NextPlanDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Issue management';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.QuanLyVanDe', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'List of followers';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.DanhSachNguoiTheoDoi', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task view';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.XemChiTietCongViec', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Checklist Information';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ThongTinChecklist', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Descriptive information';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ThongTinMoTa', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assess task';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.DanhGiaCongViec', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Low';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.low', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Normal';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.normal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'High';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.high', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Veryhigh';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.veryhigh', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets group';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.TargetsGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percentage';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.Percentage', @FormID, @LanguageValue, @Language;

