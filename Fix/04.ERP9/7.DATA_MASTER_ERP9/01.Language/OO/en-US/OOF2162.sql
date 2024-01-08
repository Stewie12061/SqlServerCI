-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2162- OO
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
SET @FormID = 'OOF2162';

SET @LanguageValue = N'Issue view';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Issues ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.IssuesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Issues Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.IssuesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time request';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request deadline';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.TaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.RequestID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Release Version';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.ReleaseVerion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.TaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.RequestName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type Of Issues';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.TypeOfIssues', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request support';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.SupportRequiredID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Support request';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.SupportRequiredName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.LastAssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.LastPriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.LastStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.LastStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.CreateUserID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.CreateDate2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.MilestoneID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time to confirm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.TimeConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.ActualStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.ActualEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.ActualTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quality';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.StatusQualityOfWork', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Issue details';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.ThongTinChiTietQuanLyVanDe', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.LichSu', @FormID, @LanguageValue, @Language;


