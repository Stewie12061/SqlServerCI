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
SET @Language = 'zh-CN' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF2111';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'母工作';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ParentTaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'之前的工作';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.PreviousTaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優先';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'執行者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支持者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.SupportUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'監督人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ReviewerUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'進步 （％）';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'順序';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'重複';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.IsRepeat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開始日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結束日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'執行時間';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.PlanTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開始日期（實際）';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ActualStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結束日期（實際）';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ActualEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'小時（實際）';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ActualTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目/工作組';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'程序';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.StepID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'描述';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TaskTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'目標類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TargetTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'執行者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支持者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.SupportUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'監督人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ReviewerUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.APKSettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目/工作組';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'流程名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'步驟名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.StepName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'母工作';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.ParentTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'之前的工作';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.PreviousTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'故意違反';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.IsViolated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分數';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.Mark', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'審批人意見';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.APKRel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TypeRel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.LastStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'評級狀態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.StatusAssessor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'關閉工作';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.IsClosedTask', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'新工作代碼';
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

SET @LanguageValue = N'拒絕完成';
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

SET @LanguageValue = N'工作樣本';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TaskSampleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作表(ID)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TaskSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.APKViolated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.IsContactPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.OriginalTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訂單';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.SaleOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.APKSaleOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.APKParent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.BusinessParent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2111.TableBusinessParent', @FormID, @LanguageValue, @Language;

