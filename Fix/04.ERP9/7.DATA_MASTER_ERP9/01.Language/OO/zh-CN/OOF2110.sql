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
SET @Language = 'zh-CN' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF2110';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.TaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.TaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'母工作';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ParentTaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'之前的工作';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.PreviousTaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優先';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'執行者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支持者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.SupportUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'監督人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ReviewerUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'完成百分比';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'順序';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'重複';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.IsRepeat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開始日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結束日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.PlanTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開始日期（實際）';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ActualStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結束日期（實際）';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ActualEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'小時（實際）';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ActualTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目/工作組';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'程序';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'實施步驟';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.StepID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'解釋';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.TaskTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作目標';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.TargetTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'執行者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支持者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.SupportUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'監督人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ReviewerUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.APKSettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目/工作組';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'程序';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.StepName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'母工作';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.ParentTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'之前的工作';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.PreviousTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.IsViolated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.Mark', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.APKRel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.TypeRel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.LastStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.StatusAssessor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.IsClosedTask', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
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

SET @LanguageValue = N'';
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

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.TaskSampleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.TaskSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.APKViolated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.IsContactPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.OriginalTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.SaleOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.APKSaleOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.APKParent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.BusinessParent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2110.TableBusinessParent', @FormID, @LanguageValue, @Language;

