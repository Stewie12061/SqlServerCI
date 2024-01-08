-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2102- OO
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
SET @FormID = 'OOF2102';

SET @LanguageValue = N'Project/task group view';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ProjectType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project sample';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ProjectSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Checking date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.CheckingDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leader';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.LeaderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Related type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.FromDateToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leader';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.LeaderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object Id';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ProjectDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mark';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.Mark', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes by assessor ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reject';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.Reject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount Factor KHCU';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.DiscountFactorKHCU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.TaskTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.TargetTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Support user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.SupportUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reviewer user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ReviewerUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percent Progress (%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'StatusID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date work';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date work';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ObjectTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date (actual)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ActualStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date (actual)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ActualEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project/Group task details';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ChiTietDuAn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.ThongTinMoTa', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'List task of Project';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.CongViecDuAn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assess User Name2';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.AssessUserName2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Access User Name3';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.AssessUserName3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Access User Name1';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.AssessUserName1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.PlanTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gantt Chart';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.GanttChart', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Export to PDF';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.GanttChartPDF', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.TitleObject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Week';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.Week', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Month';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.Month', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount Factor NC';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.DiscountFactorNC', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount Factor KHCU';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.DiscountFactorKHCU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount Factor KHCU service';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.DiscountFactorKHCUService', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.RequestCustomerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subject';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.RequestSubject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.TypeOfRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.RequestStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time request';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deadline request';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Issue management';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.QuanLyVanDe', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leads';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.TabCRMT20301', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contacts';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.TabCRMT10001', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Requests';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.TabCRMT20801', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.DinhKem', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2102.EmployeeName', @FormID, @LanguageValue, @Language;

