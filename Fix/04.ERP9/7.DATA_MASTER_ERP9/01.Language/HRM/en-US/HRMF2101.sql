-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2101- HRM
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
SET @FormID = 'HRMF2101';

SET @LanguageValue = N'Update training schedules';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training schedule/course ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.SearchTxt', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training field';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingFieldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training field';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingFieldName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Forms of training';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training schedule code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingScheduleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingCourseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training course';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingCourseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Estimated phone costs';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.ScheduleAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposed telephone costs';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.ProposeAmount_MT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.Description1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.Description2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.Description3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training partner';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Location';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Estimated training time is from';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Arrive';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Company-wide training';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.IsAll', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Forms of training';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingProposeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.SpecificHours', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training cost estimate';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.ScheduleAmount_DT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Proposed budget';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.ProposeAmount_DT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training field ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingFieldID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training field';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingFieldName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training course ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingCourseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training course';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingCourseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'From date'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.FromDate_DT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'To date'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.ToDate_DT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee name'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training proposal ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.InheritID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Number of training sessions';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.Sessions',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Number of hours/session';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.HoursPerSession',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.DutyName',  @FormID, @LanguageValue, @Language;