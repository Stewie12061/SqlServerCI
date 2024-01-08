-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2121- HRM
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
SET @FormID = 'HRMF2121';

SET @LanguageValue  = N'Update result recording ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.TrainingCourseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Forms of training';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.TrainingTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Forms of training';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.TrainingType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training field';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.TrainingFieldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training field';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.TrainingFieldName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training result/schedule recording ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.SearchTxt', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training schedule';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.TrainingScheduleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Location';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Propose recommendations';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.Description1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.Description2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training partner';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training schedule';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.TrainingScheduleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'General assessment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.ResultTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'General assessment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.ResultTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.ResultTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Describe';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.ResultTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code to record results';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.TrainingResultID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.StatusTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Result';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.ResultName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.Notes',  @FormID, @LanguageValue, @Language;