-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2132- HRM
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
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2132';

SET @LanguageValue  = N'Cost recording view';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Forms of training';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TrainingType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training field code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TrainingFieldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expense recording code/Phone schedule';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.SearchTxt', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Row date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.RowDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.AssignedToUser', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training schedule';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TrainingSchedule', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expense';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.CostAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TrainingCourseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training partner';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost recording code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TrainingCostID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Since';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TrainingFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TrainingToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training schedule';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TrainingScheduleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Editor';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cost recording information';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.Info',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'List of employees';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.Employee',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';;
EXEC ERP9AddLanguage @ModuleID, 'HRMF2132.StatusID', @FormID, @LanguageValue, @Language;