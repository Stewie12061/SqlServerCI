-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2093- OO
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
SET @FormID = 'OOF0000';

SET @LanguageValue = N'Dashboard';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group task today';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.GroupTaskToday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group task not handle';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.GroupTaskNotHandle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group notification';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.GroupNotification', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group chart';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.GroupChart', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.Time', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.btnUpdateLabel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project chart name';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.ProjectChartName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percent progress (hours)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Plan percent progress (hours)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.PlanPercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Read more';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.ReadMore', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group KPI';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.GroupKPI', @FormID, @LanguageValue, @Language;
---
SET @LanguageValue = N'Task KPI';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.TaskKPI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sale net KPI';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.SaleNetKPI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Violated';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.Violated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Percent complete task:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.PercentCompleteTask', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Bonus KPI task:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.BonusKPITask', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Total sale Net:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.TotalSaleNet', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Bonus sale Net:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.BonusSaleNet', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Percent complete task:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.PercentCompleteTask', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Base salary:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.BaseSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Violated percent:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.ViolatedPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Violated salary:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.ViolatedSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Insurrance';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.TitleInsurrance', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Insurrance money:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.InsurranceMoney', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Insurrance percent:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.InsurrancePercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Personal income:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.PersonalIncome', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Total insurrance:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.TotalInsurrance', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Incurred';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.TitleIncurred', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Incurred salary:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.IncurredSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Real salary:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.RealSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'- Incurred salary last month:';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.IncurredSalaryLastMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Filter';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.btnFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percent progress completed (%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.PercentProgressCompleted', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assigned To UserID';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Period';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.Period', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hot chart';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.GroupWarm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'General';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.General', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Detail';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rate';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.Rate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mass';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.Mass', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Un processed(%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.UnProcessed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.Request', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Milestone';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.Milestone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.Task', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Issue';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.Issue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Late(%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.Late', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request: ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.YC', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N' - Milestone: ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.MS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N' - Task: ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.T', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N' - Issue: ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.VD', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.RQDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Milestone';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.MSDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.TDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Issue';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.IDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Company';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.Company', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'No record';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.NoRecord', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assigned Job';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.GroupAssignedJob', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tracking word';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.GroupTrackingWord', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Happy birthday';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.BirthToDayNotify', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Up comming birthdate';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.BirthDayNotify', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Happy Pride Day!';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.HappyPrideDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Require to be supported';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.RequireSupport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Complete(%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.Complete', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Require to be supported';
EXEC ERP9AddLanguage @ModuleID, 'OOF0000.SRDetail', @FormID, @LanguageValue, @Language;
---------------------------------------------------Ngôn ngữ màn hình phân quyền Dashboard OO-------------------------------------------------------
SET @LanguageValue = N'Hotspots chart';
EXEC ERP9AddLanguage @ModuleID, 'OOD0005.Title', 'OOD0005', @LanguageValue, @Language;

SET @LanguageValue = N'Notification';
EXEC ERP9AddLanguage @ModuleID, 'OOD0008.Title', 'OOD0008', @LanguageValue, @Language;

SET @LanguageValue = N'Assigned Job';
EXEC ERP9AddLanguage @ModuleID, 'OOD0009.Title', 'OOD0009', @LanguageValue, @Language;

SET @LanguageValue = N'Tracking Work';
EXEC ERP9AddLanguage @ModuleID, 'OOD0010.Title', 'OOD0010', @LanguageValue, @Language;