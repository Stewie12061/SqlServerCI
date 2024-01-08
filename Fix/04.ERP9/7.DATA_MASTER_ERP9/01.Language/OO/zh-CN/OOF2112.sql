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
SET @Language = 'zh-CN' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF2112';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.TaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.TaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ParentTaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.PreviousTaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優先';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'執行者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支持者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.SupportUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'監督人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ReviewerUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'進步 （％）';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'順序';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'重複';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.IsRepeat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開始日期（計劃）';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結束日期（計劃）';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'小時（計劃）';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.PlanTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開始日期（實際）';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ActualStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結束日期（實際）';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ActualEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'小時（實際）';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ActualTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目/工作組';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'程序';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.StepID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'描述';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.TaskTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.TargetTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'執行者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支持者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.SupportUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'監督人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ReviewerUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.APKSettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目/工作組';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'程序';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.StepName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'母工作';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.ParentTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'之前的工作';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.PreviousTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'故意違反';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.IsViolated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分數';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.Mark', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備註';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.APKRel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.TypeRel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.LastStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.StatusAssessor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.IsClosedTask', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
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

SET @LanguageValue = N'';
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

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.TaskSampleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.TaskSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.APKViolated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.IsContactPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.OriginalTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訂單';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.SaleOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.APKSaleOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.APKParent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.BusinessParent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2112.TableBusinessParent', @FormID, @LanguageValue, @Language;

