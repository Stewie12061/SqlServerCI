-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2161- OO
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
SET @FormID = 'OOF2161';

SET @LanguageValue = N'Update Issue';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Issues ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.IssuesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Issues Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.IssuesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time request';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request deadline';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.TaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.RequestID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Release Version';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.ReleaseVerion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.TaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.RequestName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type Of Issues';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.TypeOfIssues', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request support';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.SupportRequiredID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Support request';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.SupportRequiredName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.LastAssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.LastPriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.LastStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.LastStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.CreateUserID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.CreateDate2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.MilestoneID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time to confirm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.TimeConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.ActualStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.ActualEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.ActualTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quality';
EXEC ERP9AddLanguage @ModuleID, 'OOF2161.StatusQualityOfWork', @FormID, @LanguageValue, @Language;

