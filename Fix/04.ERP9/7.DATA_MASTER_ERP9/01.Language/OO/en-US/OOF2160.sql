-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2160- OO
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
SET @FormID = 'OOF2160';

SET @LanguageValue = N'List of issues';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Issues ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.IssuesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Issues Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.IssuesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time request';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request deadline';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.TaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.RequestID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Release Version';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.ReleaseVerion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.TaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.RequestName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type Of Issues';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.TypeOfIssues', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request support';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.SupportRequiredID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Support request';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.SupportRequiredName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.LastAssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.LastPriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.LastStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.LastStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.CreateUserID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.CreateDate2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.MilestoneID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time to confirm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.TimeConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.ActualStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.ActualEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.ActualTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quality';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.StatusQualityOfWork', @FormID, @LanguageValue, @Language;

