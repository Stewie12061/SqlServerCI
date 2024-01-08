-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2192- OO
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
SET @FormID = 'OOF2192';

SET @LanguageValue = N'Milestone view';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Milestone ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.MilestoneID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Milestone Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.MilestoneName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deadline';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assigned To UserID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Release version';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.ReleaseVerion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Milestone description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type Of Milestone';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.TypeOfMilestone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Issue management';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.QuanLyVanDe', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request From Customers';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.TabCRMT20801', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.RequestCustomerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.RequestSubject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2192.RequestStatus', @FormID, @LanguageValue, @Language;
